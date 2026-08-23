#!/usr/bin/env bash
#
# install.sh - bootstrap this Neovim configuration on a (new) machine.
#
# Keep this script inside the config repository so it travels with the config.
# Running it will:
#
#   1. Install the system packages this config depends on
#      (git, build tools, ripgrep, fd, tree-sitter CLI, clipboard,
#       node/npm, python, and Neovim itself).
#   2. Make sure Neovim >= 0.12 is available (this config requires it).
#      If the distro ships an older version, the latest official release
#      is downloaded into ~/.local.
#   3. Place this config at ~/.config/nvim if it isn't already there.
#   4. Install every plugin pinned in nvim-pack-lock.json (headless).
#   5. Install the LSP servers and formatters listed in init.lua via Mason
#      (clangd, pyright, lua_ls, stylua, clang-format, black, isort).
#
# Usage:
#   ./install.sh [--latest-nvim] [--skip-nvim-upgrade] [--no-mason]
#                [--skip-packages] [--force] [--help]
#
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
PACK_DIR="$DATA_DIR/site/pack/core"
LOCKFILE="$REPO_DIR/nvim-pack-lock.json"

FORCE_COPY=0
INSTALL_LATEST_NVIM=0
SKIP_NVIM_UPGRADE=0
SKIP_PACKAGES=0
RUN_MASON=1

# If a previous run of this script installed nvim into ~/.local/bin, prefer it.
export PATH="$HOME/.local/bin:$PATH"

say() { printf '\033[1;32m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33mWARN:\033[0m %s\n' "$*"; }
die() {
  printf '\033[1;31mERROR:\033[0m %s\n' "$*" >&2
  exit 1
}

usage() {
  sed -n '2,21p' "$0" | sed 's/^# \{0,1\}//'
}

for arg in "$@"; do
  case "$arg" in
    --latest-nvim) INSTALL_LATEST_NVIM=1 ;;
    --skip-nvim-upgrade) SKIP_NVIM_UPGRADE=1 ;;
    --no-mason) RUN_MASON=0 ;;
    --skip-packages) SKIP_PACKAGES=1 ;;
    --force) FORCE_COPY=1 ;;
    -h | --help) usage; exit 0 ;;
    *) die "Unknown option: $arg (run $0 --help)" ;;
  esac
done

# Run a command as root when we are not root already.
run_priv() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    die "Need root for: $* (run as root or install sudo)."
  fi
}

install_system_packages() {
  if command -v pacman >/dev/null 2>&1; then
    # Arch / EndeavourOS / Manjaro
    run_priv pacman -S --noconfirm --needed \
      git make gcc unzip ripgrep fd tree-sitter-cli xclip curl \
      nodejs npm python python-pip neovim
  elif command -v apt-get >/dev/null 2>&1; then
    # Debian / Ubuntu / Mint
    run_priv apt-get update -qq
    run_priv apt-get install -y \
      git make gcc unzip ripgrep fd-find tree-sitter-cli xclip curl \
      nodejs npm python3 python3-pip neovim
    # Debian/Ubuntu ship fd as "fdfind"; telescope looks for "fd".
    if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
      say "Symlinking fdfind -> fd"
      run_priv ln -sf "$(command -v fdfind)" /usr/local/bin/fd
    fi
  elif command -v dnf >/dev/null 2>&1; then
    # Fedora / RHEL / Rocky
    run_priv dnf install -y \
      git make gcc unzip ripgrep fd-find tree-sitter-cli xclip curl \
      nodejs npm python3 python3-pip neovim
  elif command -v zypper >/dev/null 2>&1; then
    # openSUSE
    run_priv zypper --non-interactive install \
      git make gcc unzip ripgrep fd tree-sitter xclip curl \
      nodejs npm python3 python3-pip neovim
  elif command -v apk >/dev/null 2>&1; then
    # Alpine
    run_priv apk add --no-cache \
      git make gcc unzip ripgrep fd tree-sitter xclip curl \
      nodejs npm python3 py3-pip neovim
  elif command -v brew >/dev/null 2>&1; then
    # macOS (or Linux with Homebrew)
    local extra=()
    [ "$(uname -s)" = "Linux" ] && extra+=(xclip)
    brew install \
      git make gcc unzip ripgrep fd tree-sitter curl node npm python neovim \
      "${extra[@]}"
  else
    die "No supported package manager found (pacman/apt/dnf/zypper/apk/brew)."
  fi
}

nvim_version_ok() {
  local ver major minor
  ver="$(nvim --version 2>/dev/null | head -n1 | sed -nE 's/.*NVIM v([0-9]+)\.([0-9]+).*/\1.\2/p')"
  [ -n "$ver" ] || return 1
  major="${ver%%.*}"
  minor="${ver##*.}"
  [ "$major" -gt 0 ] || { [ "$major" -eq 0 ] && [ "$minor" -ge 12 ]; }
}

install_latest_nvim() {
  local os arch tarball url dest tmp
  case "$(uname -s)" in
    Linux) os=linux ;;
    Darwin) os=macos ;;
    *) die "Unsupported OS for the official nvim tarball; install Neovim >= 0.12 manually." ;;
  esac
  case "$(uname -m)" in
    x86_64 | amd64) arch=x86_64 ;;
    aarch64 | arm64) arch=arm64 ;;
    *) die "Unsupported architecture for the official nvim tarball: $(uname -m)" ;;
  esac

  tarball="nvim-${os}-${arch}.tar.gz"
  url="https://github.com/neovim/neovim/releases/latest/download/${tarball}"
  dest="$HOME/.local/nvim-${os}-${arch}"
  tmp="/tmp/${tarball}"

  say "Installing latest Neovim from $url"
  command -v curl >/dev/null 2>&1 || die "curl is required to download Neovim."
  curl -fL --retry 3 -o "$tmp" "$url"
  rm -rf "$dest"
  mkdir -p "$dest"
  tar -xzf "$tmp" -C "$dest" --strip-components=1
  rm -f "$tmp"

  mkdir -p "$HOME/.local/bin"
  ln -sf "$dest/bin/nvim" "$HOME/.local/bin/nvim"
  export PATH="$HOME/.local/bin:$PATH"
  say "Neovim installed to ~/.local (nvim --version: $(nvim --version | head -n1))"
}

ensure_nvim() {
  if command -v nvim >/dev/null 2>&1 && nvim_version_ok; then
    say "Neovim $(nvim --version | head -n1 | sed -E 's/.*(NVIM v[^ ]+).*/\1/') found"
    return 0
  fi
  if [ "$INSTALL_LATEST_NVIM" = 1 ]; then
    install_latest_nvim
    return 0
  fi
  if [ "$SKIP_NVIM_UPGRADE" = 1 ]; then
    if command -v nvim >/dev/null 2>&1; then
      warn "Neovim is older than 0.12 (required); skipping upgrade per --skip-nvim-upgrade."
    else
      die "Neovim is not installed and --skip-nvim-upgrade is set."
    fi
    return 0
  fi
  if command -v nvim >/dev/null 2>&1; then
    warn "Neovim is older than 0.12; downloading the latest release."
  else
    say "Neovim not found; downloading the latest release."
  fi
  install_latest_nvim
}

ensure_config_in_place() {
  if [ "$REPO_DIR" = "$CONFIG_DIR" ]; then
    say "Config already lives at $CONFIG_DIR"
    return 0
  fi
  if [ -f "$CONFIG_DIR/init.lua" ] && [ "$FORCE_COPY" != 1 ]; then
    warn "Existing config found at $CONFIG_DIR - keeping it (use --force to replace)."
    return 0
  fi
  if [ -e "$CONFIG_DIR" ]; then
    local backup="$CONFIG_DIR.bak.$(date +%Y%m%d-%H%M%S)"
    warn "Moving existing $CONFIG_DIR to $backup"
    mv "$CONFIG_DIR" "$backup"
  fi
  mkdir -p "$(dirname "$CONFIG_DIR")"
  cp -a "$REPO_DIR" "$CONFIG_DIR"
  say "Config copied to $CONFIG_DIR"
}

install_plugins() {
  local expected installed log lock_backup
  expected="$(grep -c '"src"' "$LOCKFILE" 2>/dev/null || true)"
  if [ -z "${expected:-}" ] || [ "$expected" -eq 0 ] 2>/dev/null; then
    warn "Could not read plugin list from $LOCKFILE; plugins will install on first nvim launch instead."
    return 0
  fi

  log="$(mktemp)"
  # nvim rewrites the lockfile it works with; keep a copy so a failed install
  # cannot wipe the pinned plugin revisions in the copied config.
  lock_backup="$(mktemp)"
  cp "$LOCKFILE" "$lock_backup"
  say "Installing $expected plugins from nvim-pack-lock.json (first run can take a while)..."
  nvim --headless +qa >"$log" 2>&1 || true

  installed="$(find "$PACK_DIR" -mindepth 2 -maxdepth 2 -type d 2>/dev/null | wc -l | tr -d ' ')"
  if [ "${installed:-0}" -ge "$expected" ]; then
    say "Plugins installed ($installed plugin directories under $PACK_DIR)"
    rm -f "$log"
  else
    cp "$lock_backup" "$CONFIG_DIR/nvim-pack-lock.json"
    warn "Only $installed/$expected plugin directories found. Last nvim output:"
    tail -n 25 "$log" >&2 || true
    rm -f "$log"
    rm -f "$lock_backup"
    die "Plugin installation did not complete - check the output above (network, git, or build tools)."
  fi
  rm -f "$lock_backup"
}

MASON_TOOLS=(clangd pyright stylua lua-language-server clang-format black isort)

install_mason_tools() {
  say "Installing LSP servers / formatters via Mason: ${MASON_TOOLS[*]}"
  warn "This downloads clangd, pyright, lua_ls and friends - can take a few minutes."
  nvim --headless "+MasonToolsInstallSync" +qa >/dev/null 2>&1 || true

  local missing=()
  for tool in "${MASON_TOOLS[@]}"; do
    [ -d "$DATA_DIR/mason/packages/$tool" ] || missing+=("$tool")
  done
  if [ "${#missing[@]}" -gt 0 ]; then
    warn "Not found in Mason yet: ${missing[*]}"
    warn "Open nvim once - mason-tool-installer will finish them, or run :Mason."
  else
    say "All Mason tools installed: ${MASON_TOOLS[*]}"
  fi
}

# ---------------------------------------------------------------------------

say "Bootstrap script for the nvim config in $REPO_DIR"

if [ "$SKIP_PACKAGES" = 1 ]; then
  say "Skipping system package install (--skip-packages)"
else
  install_system_packages
fi

ensure_nvim
ensure_config_in_place
install_plugins

if [ "$RUN_MASON" = 1 ]; then
  install_mason_tools
else
  say "Skipping Mason tools (--no-mason)"
fi

say "Done!"
printf '%s\n' \
  "" \
  "Next steps:" \
  "  1. Start nvim; tree-sitter parsers install on demand as you open files." \
  "  2. Install a Nerd Font if icons look wrong, and set vim.g.have_nerd_font = true in init.lua." \
  "  3. Run :checkhealth for a full status report."
if [ -e "$HOME/.local/bin/nvim" ]; then
  printf '%s\n' \
    "" \
    "Note: nvim was installed to ~/.local. Add this to your shell rc file so it is found:" \
    '    export PATH="$HOME/.local/bin:$PATH"'
fi
