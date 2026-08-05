#!/usr/bin/env bash
# arsenal installer — symlinks bin/arsenal onto your PATH.
# Usage: ./install.sh [DEST_DIR]   (default: ~/.local/bin)
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
SRC="$REPO/bin/arsenal"
DEST="${1:-$HOME/.local/bin}"

[[ -f "$SRC" ]] || { echo "error: $SRC not found" >&2; exit 1; }
chmod +x "$SRC"
mkdir -p "$DEST"
ln -sfn "$SRC" "$DEST/arsenal"
echo "✓ linked $DEST/arsenal → $SRC"

# --- dependency checks (non-fatal) ----------------------------------------------
if ! command -v fzf >/dev/null 2>&1; then
  echo "⚠  fzf not found — arsenal requires it."
  echo "   Arch/CachyOS: sudo pacman -S fzf   ·   Debian/Kali: sudo apt install fzf"
fi

if ! { command -v wl-copy >/dev/null 2>&1 || command -v xclip >/dev/null 2>&1 \
    || command -v xsel >/dev/null 2>&1; }; then
  echo "ℹ  No clipboard tool found — the 'copy to clipboard' action needs one:"
  echo "   Wayland: wl-clipboard   ·   X11: xclip or xsel"
fi

# --- PATH check -----------------------------------------------------------------
case ":$PATH:" in
  *":$DEST:"*) ;;
  *) echo "⚠  $DEST is not on your PATH. Add it, e.g.:"
     echo "     export PATH=\"$DEST:\$PATH\"   (bash/zsh)"
     echo "     fish_add_path $DEST            (fish)" ;;
esac

echo
echo "Done. Run:  arsenal"
