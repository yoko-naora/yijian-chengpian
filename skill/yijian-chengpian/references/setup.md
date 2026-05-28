# 6阶段搭建详解（Windows）

> 执行前先用 `scripts/check-deps.ps1` 一键检查依赖，避免逐项手动跑。

## Phase 1 — 系统依赖检查

逐项执行检查，报告 ✓/✗ 状态。缺失项提供安装命令，等用户确认后逐个安装。

### 检查矩阵

| 工具 | 检查命令 | 最低版本 | 安装命令 |
|------|---------|---------|---------|
| FFmpeg | `ffmpeg -version` | 任意 | `winget install FFmpeg` |
| ffprobe | `ffprobe -version` | 任意 | 随 FFmpeg 一起安装 |
| yt-dlp | `yt-dlp --version` | 任意 | `pip install yt-dlp` |
| Node.js | `node --version` | ≥ 22 | `winget install OpenJS.NodeJS.LTS` |
| Python | `python --version` | ≥ 3.10 | `winget install Python.Python.3.12` |
| Git | `git --version` | 任意 | `winget install Git.Git` |

### Winget 不可用时的备用方案

```powershell
# winget 一般 Win11 自带。如果没有：
# 以管理员身份运行 PowerShell，然后：
Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
```

## Phase 2 — 克隆 video-use

### 方式 A（全局 symlink，需管理员权限）

```powershell
cd ~
git clone https://github.com/browser-use/video-use
cd video-use
pip install -e .
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\skills"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.claude\skills\video-use" -Target (Get-Location).Path
```

### 方式 B（项目内克隆，推荐，无需管理员）

```powershell
cd <工作区路径>
New-Item -ItemType Directory -Force -Path skills
cd skills
git clone https://github.com/browser-use/video-use
cd video-use
pip install -e .
```

### 符号链接失败的备用方案（Windows 常见）

如果 `New-Item -ItemType SymbolicLink` 报权限错误：
1. 方式 B 不需要符号链接，直接用项目内路径引用
2. 或开启 Windows 开发者模式：设置 → 隐私和安全性 → 开发者选项 → 开发人员模式

## Phase 3 — 初始化 Hyperframes

```powershell
cd <工作区路径>
npx hyperframes init hyperframes-templates
cd hyperframes-templates
npx hyperframes skills --claude
```

如果 `npx hyperframes` 报 "command not found"：
```powershell
npm install -g hyperframes
# 然后重试
```

## Phase 4 — 配置 ElevenLabs

```powershell
cd <工作区路径>

# 写入 .env
@"
ELEVENLABS_API_KEY=<用户提供的密钥>
"@ | Out-File -FilePath .env -Encoding UTF8

# 确保 .gitignore 包含 .env
if (!(Test-Path .gitignore)) {
    New-Item -ItemType File .gitignore
}
$gitignore = Get-Content .gitignore -ErrorAction SilentlyContinue
if ($gitignore -notcontains ".env") {
    Add-Content -Path .gitignore -Value ".env"
}
```

## Phase 5 — 创建项目结构

```powershell
cd <工作区路径>

# 创建所有目录
$dirs = @(
    "hyperframes-templates",
    "projects",
    "templates"
)
foreach ($d in $dirs) {
    New-Item -ItemType Directory -Force -Path $d
}
```

### 最终目录树确认

```
<工作区路径>/
├── .env
├── .gitignore
├── CLAUDE.md
├── hyperframes-templates/
├── projects/
└── templates/
```

## Phase 6 — 生成 CLAUDE.md

在工作区根目录生成 `CLAUDE.md`，内容包含：

- 项目名称与定位：一键成片 · AI教学视频生产线
- 技术栈：video-use / Hyperframes / ElevenLabs / FFmpeg
- 常用命令速查
- 品牌规范：字体/配色来源于 kb.snsaladdin.com 设计系统
- 生产默认值：中文、2-5 分钟、16:9、1080p
- 安全：`.env` 不入库，密钥不硬编码

---

## 搭建完成检查清单

- [ ] `ffmpeg -version` 正常
- [ ] `python -c "import video_use"` 不报错
- [ ] `npx hyperframes --version` 正常
- [ ] `.env` 包含 `ELEVENLABS_API_KEY`
- [ ] `.gitignore` 包含 `.env`
- [ ] 目录树完整
- [ ] `CLAUDE.md` 已生成
