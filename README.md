# arsenal

A fast, categorized **fzf launcher for a pentest toolkit**. Browse ~70 common
security tools grouped by use case, read a "good for…" blurb for each, and launch
them the way you want — straight into their help, a ready-to-edit example command,
a blank custom command, or copied to your clipboard.

Built for a Kali-equivalent kit on Arch/CachyOS, but it's just a Bash + fzf script
and works anywhere those tools live (Kali/Debian included).

```
  arsenal ❯ hashcat                              │ hashcat
> hashcat      Cracking     GPU password crack…  │ ──────────────────────────
  hcxdumptool  Wireless     Capture PMKIDs/han…  │ Good for
                                                 │ GPU password cracker — the
                                                 │ fastest way through captured
                                                 │ hashes. -m sets the type.
                                                 │
                                                 │ Binary
                                                 │ /usr/bin/hashcat
                                                 │ ...
  ↑↓ browse · type to filter · ENTER = launch options · ESC quit
```

## What it does

- **Categorized browser** — Recon/OSINT, Web, Wireless, Cracking, Exploitation,
  AD/Internal, RE/Forensics, Sniff/MITM, Utility.
- **Live preview pane** — each tool's purpose, binary path, and an example command.
- **A "how to launch" menu** on ENTER, so you choose the mode per tool:
  - **Show help / usage** — the default for terminal tools; opens the tool's own
    `--help`/`-h` output (or man page) in a pager.
  - **Run the example** — a sensible example command, prefilled and editable.
  - **Type a custom command** — a blank line starting with the tool name.
  - **Copy a command to clipboard** — build a command and copy it (wl-copy / xclip
    / xsel) instead of running it.
  - **Open the man page.**
  - GUI tools (Burp, ZAP, Ghidra, Wireshark) default to **Launch** (detached).
- **Persistent** — after each action you return to the menu; **ESC** exits.

## Requirements

- **bash** and **[fzf](https://github.com/junegunn/fzf)** (required).
- A clipboard tool for the copy action (optional): **wl-clipboard** (Wayland),
  or **xclip** / **xsel** (X11).
- The security tools themselves (optional — arsenal flags any that aren't on PATH).

Install fzf:

```bash
# Arch / CachyOS
sudo pacman -S fzf
# Debian / Kali / Ubuntu
sudo apt install fzf
```

## Install

```bash
git clone <this-repo-url> ~/arsenal
cd ~/arsenal
./install.sh            # symlinks bin/arsenal into ~/.local/bin
arsenal
```

`install.sh` just creates a symlink, so `git pull` keeps you up to date with no
reinstall. To install elsewhere: `./install.sh /usr/local/bin` (may need sudo).

You can also run it in place without installing: `./bin/arsenal`.

## Optional: niri hotkey

If you use [niri](https://github.com/YaLTeR/niri), bind a key to open arsenal in a
terminal. Example for ghostty (adjust for your terminal):

```kdl
Mod+A hotkey-overlay-title="Open Arsenal: pentest launcher" { spawn "ghostty" "--title=arsenal" "-e" "arsenal"; }
```

For other compositors, bind your terminal to run `arsenal`, e.g.
`kitty -e arsenal`, `alacritty -e arsenal`, `wezterm start -- arsenal`.

## Customizing the tool list

Everything lives in one file: `bin/arsenal`. The tool table is a plain
pipe-delimited block near the top — one line per tool:

```
category | name | command | kind | blurb | example
```

- **kind** is `cli`, `tui`, or `gui`.
  - `cli` / `tui` → terminal tools (help-first launch menu).
  - `gui` → launched detached, no help-probe.
- **example** is the prefilled command for the "run example" / "copy" actions.
  Leave it empty for GUI apps.

Add, remove, or reword a line and it shows up immediately — no other changes needed.

## Notes

- **Wordlist paths** in the examples assume [SecLists](https://github.com/danielmiessler/SecLists)
  at `/usr/share/seclists`. On some distros it's `/usr/share/wordlists/seclists` —
  adjust the examples in `bin/arsenal` to match your box.
- **Interface / target placeholders** (`TARGET`, `wlan1`, `eth0`, `wlan1mon`) are
  starting points — edit them for your engagement before running.
- Examples are just that. arsenal hands off to the real tool; all its normal flags
  and man pages apply.

## License

MIT — see [LICENSE](LICENSE).
