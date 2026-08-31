---
name: music-unlock
description: "Decrypt encrypted music (qmc/ncm/kgm/kwm) to mp3/flac."
version: 1.1
author: lantianhcgp
license: MIT
metadata:
  hermes:
    tags: [music, decrypt, audio, qmc, ncm, kgm]
    related_skills: [youtube-content, gif-search]
---

# Unlock Music CLI

Decrypt encrypted music files from Chinese music platforms into standard formats.

## When to Use

- User has `.qmc`, `.ncm`, `.kgm`, `.kwm`, `.mflac`, `.mgg` or similar encrypted music files
- User wants to convert protected music to standard mp3/flac/ogg
- User needs batch decryption of music files from QQ Music, NetEase Cloud, Kugou, Kuwo, etc.

## Installation

```bash
# Option 1: go install (recommended, needs Go 1.23+)
GOPROXY=https://goproxy.io,direct go install git.um-react.app/um/cli/cmd/um@main
cp ~/go/bin/um ~/.local/bin/um

# Option 2: build from this repo
cd unlock-music && go build -o um ./cmd/um
mv um ~/.local/bin/um
```

## Binary

- Location: `~/.local/bin/um`
- Version: v0.2.19 (Go, android/arm64)
- Add to PATH: `export PATH="$HOME/.local/bin:$PATH"`

## Usage

```bash
# Decrypt a single file
um -o /path/to/output /path/to/input.qmcflac

# Decrypt a whole directory
um -o /storage/emulated/0/Music/unlocked /storage/emulated/0/Music/locked/

# With verbose output
um -V -o /path/to/output /path/to/input.ncm

# Overwrite existing files
um --overwrite -o /path/to/output /path/to/input.kgm

# Show supported extensions
um --supported-ext
```

## Supported Formats

| Platform | Extensions |
|---|---|
| QQ音乐 | qmc0, qmc2, qmc3, qmc4, qmc6, qmc8, qmcflac, qmcogg, mflac, mflac0, mflac1, mflach, mgg, mgg0, mgg1, mggh, mggl, tkm, tm0, tm2, tm3, tm6 |
| 网易云音乐 | ncm |
| 酷狗音乐 | kgm, kgg, kgma, vpr |
| 酷我音乐 | kwm |
| 虾米音乐 | xm |
| 喜马拉雅 | x2m, x3m |
| 百度音乐 | bkcmp3, bkcm4a, bkcflac, bkcwav, bkcape, bkcogg, bkcwma |
| 咪咕 | mmp4 |

## Key Options

| Option | Description |
|---|---|
| `-o DIR` | Output directory (required) |
| `-i PATH` | Input file or directory |
| `--remove-source` | Delete source file after conversion |
| `--overwrite` | Overwrite without asking |
| `--update-metadata` | Fetch metadata & album art from network |
| `-V` | Verbose logging |
| `--watch` | Watch directory for new files |

## Pitfalls

1. **Rebuild after system update**: `GOPROXY=https://goproxy.io,direct go install git.um-react.app/um/cli/cmd/um@main`
2. **Download site blocked**: `git.um-react.app` is behind Cloudflare; always use `go install`, never curl release tarballs.
3. **mflach format**: Web version can't handle it, but CLI version works fine.
4. **Output format auto-detected**: No need to specify mp3/flac/ogg manually.
5. **QQ Music ekey**: Some newer formats need `--qmc-mmkv-key` (from QQMusic MMKV database).
6. **Go module proxy**: Use `goproxy.io` if `goproxy.cn` doesn't have the package.

## Agent Workflow

When user asks to decrypt music:

1. Check if `um` binary exists: `command -v um || ls ~/.local/bin/um`
2. If not found, run installation steps above
3. Run: `um -o <output_dir> <input_path> --overwrite`
4. Report results: number of files converted, output location
