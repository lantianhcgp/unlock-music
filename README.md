# Unlock Music CLI - Agent Edition

基于 [unlock-music/cli](https://git.um-react.app/um/cli) v0.2.19 的 AI Agent 集成版本。

## 功能

在命令行解密中国各大音乐平台的加密音乐文件，支持 50+ 种格式：

| 平台 | 格式 |
|---|---|
| QQ音乐 | qmc0/2/3/4/6/8, qmcflac, mflac, mflac0/1, mgg, mgg0/1, tkm, tm0/2/3/6 等 |
| 网易云音乐 | ncm |
| 酷狗音乐 | kgm, kgg, kgma, vpr |
| 酷我音乐 | kwm |
| 虾米音乐 | xm |
| 喜马拉雅 | x2m, x3m |
| 百度音乐 | bkcmp3, bkcm4a, bkcflac 等 |
| 咪咕 | mmp4 |

## 快速开始

### 编译安装

```bash
# 需要 Go 1.23+
go build -o um ./cmd/um

# 或直接 go install
go install ./cmd/um
```

### 使用

```bash
# 单文件解密
um -o 输出目录 输入文件.qmcflac

# 批量解密整个目录
um -o /path/to/output /path/to/input_dir/

# 显示支持的格式
um --supported-ext
```

## Agent 集成

本仓库包含 Hermes Agent skill，可直接被 AI agent 调用：

```
skills/
└── music-unlock/
    └── SKILL.md    # Hermes skill 定义
```

### Agent 调用示例

```bash
# agent 可以直接执行
um -o /storage/emulated/0/Music/unlocked /storage/emulated/0/Music/locked/ --overwrite
```

### 常用选项

| 选项 | 说明 |
|---|---|
| `-o DIR` | 输出目录（必须） |
| `-i PATH` | 输入文件或目录 |
| `--remove-source` | 转换后删除源文件 |
| `--overwrite` | 覆盖已有文件不询问 |
| `--update-metadata` | 从网络获取元数据和封面 |
| `-V` | 详细日志 |
| `--watch` | 监听目录自动处理新文件 |

## 注意事项

- Web 版解不了的 mflach 格式，CLI 版可以处理
- 输出格式自动检测，无需手动指定
- 部分新版 QQ 音乐需要 ekey（从 QQMusic MMKV 数据库获取），用 `--qmc-mmkv-key` 传入
- 原仓库因 DMCA 在 GitHub 不可用，本仓库从 Gitea 源码构建

## 许可证

MIT License - Copyright (c) 2020-2026 Unlock Music
