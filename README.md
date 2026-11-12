# arsenal

A fast, categorized **fzf launcher for a penetration-testing toolkit**. Browse 70
common security tools grouped by use case, read a short "good for" summary of each,
and launch them the way you want: into their help output, a ready-to-edit example
command, a blank custom command, or copied to the clipboard.

It is aimed at security professionals, students and CTF players doing **authorized
testing**, and is useful as a memory aid for a large toolkit. Built for a
Kali-equivalent kit on Arch/CachyOS, it is a single Bash + fzf script and works
anywhere those tools are installed (Kali and Debian included).

arsenal does not bundle, install or modify any security tool. It is a menu over
whatever is already on your `PATH`.

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
- **Missing-tool check** — the preview shows `(not found)` for tools that are not
  installed, and arsenal refuses to launch them rather than failing obscurely.

## Requirements

- **bash** and **[fzf](https://github.com/junegunn/fzf)** (required).
- A clipboard tool for the copy action (optional): **wl-clipboard** (Wayland),
  or **xclip** / **xsel** (X11).
- **less** and **man** for the help and man-page views (present on most systems).
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
git clone https://github.com/Neuron89/arsenal.git ~/arsenal
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

## Authorized use only

The tools arsenal launches can disrupt systems and networks, and using them against
targets you do not own or have explicit written permission to test is illegal in
most jurisdictions. Use arsenal only for authorized penetration tests, lab and CTF
environments, and your own equipment. Example commands use placeholders such as
`TARGET` and `example.com` and must be edited to an in-scope target before running.

## License

MIT — see [LICENSE](LICENSE).
