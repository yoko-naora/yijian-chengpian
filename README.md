# yijian-chengpian · 一键成片

AI 自動教學影片生產工作流。從選題到多平台發布，一條指令完成。

AI-powered educational video production pipeline. From topic selection to multi-platform publishing, one command does it all.

AI自動教学視頻生産線。選題→脚本→配音→模板→匯出→分發、1コマンドで完結。

## Quick Start

```powershell
# Install for Claude Code
.\install\install-claude.ps1
```

Then say: 「一键成片：<你的选题>」

## 工作流 / Workflow / ワークフロー

```
Step 1        Step 1.5        Step 2        Step 3-5        Step 6
選題輸入  →   內容質檢    →   AI擴寫腳本  →  配音+模板+匯出  →  多平台分發
               ├ dbs-content (選題診斷)
               ├ dbs-hook (鈎子優化)
               ├ dbs-xhs-title (標題優化)
               └ 平台風格適配
```

## 支援平台 / Platforms

- 抖音 / TikTok / 小紅書 / X(Twitter) / Bilibili / 快手 / YouTube Shorts
- 中日雙語輸出

## 依賴 / Dependencies

- FFmpeg + ffprobe
- Python >= 3.10
- Node.js >= 22
- Git
- yt-dlp (可選)
- ElevenLabs API (配音)

## 環境變數 / Environment Variables

Copy `.env.example` to `.env` and fill in:

```
ELEVENLABS_API_KEY=
```

## 安裝 / Installation

### Claude Code

```powershell
.\install\install-claude.ps1
```

### Codex

```powershell
.\install\install-codex.ps1
```

### Hermes

```powershell
.\install\install-hermes.ps1
```

## License

MIT
