# 一键成片 — Project Master

## Overview

AI自動教學影片生產工作流。選題→質檢→脚本→配音→模板→匯出→分發。

- **Repo:** `yoko-naora/yijian-chengpian` (master)
- **Local dir:** `C:\Users\jding\Projects\yijian-chengpian`
- **Main index:** `C:\Users\jding\PROJECTS.md`

## Architecture

```
选题输入 → 内容质检(dbs-content/dbs-hook/dbs-xhs-title)
              ↓
         内容类型分支
         ├─ A 图文 → dbs-content + guizang-social-card-skill
         ├─ B 口播 → video-use + guizang-social-card-skill
         └─ C 教学 → Edge-TTS + Hyperframes + FFmpeg → guizang-social-card-skill
              ↓
         Step 6: social-media-auto-publish 多平台分发
```

## Completed

- [x] Skill 架構（SKILL.md + references/setup.md + references/production.md）
- [x] 3 条生产路线（图文/口播/教学）
- [x] 2 问风格推荐系统（9 种风格自动匹配）
- [x] dbs-hook 从 Step 1.5 移到 Step 2.5
- [x] Phase 1/3 补了 hyperframes browser ensure
- [x] guizang-social-card-skill 安装完毕
- [x] Hyperframes Chrome Headless Shell 修復（2026-05-29）
- [x] GitHub 遠程倉庫創建 + push（2026-05-29）
- [x] Step 1.6 AI 寫作檢測閉環（dbs-ai-check → fix → re-check）
- [x] A.1.5 文章配圖流程（截圖/AI生成/Pixabay+Unsplash+Pexels）
- [x] B.1.5 / C.1.4 口播 & 教學素材準備
- [x] 輸出自錄規範（一個任務一個文件夾）
- [x] A.3 HTML 預覽必出（雙擊瀏覽器即看）
- [x] 子 Skill 引用硬約束（必須全讀 reference 再寫代碼）
- [x] 首次端到端 Path A 生產測試 — NotebookLM 錯題本公眾號文章（2026-05-29）
- [x] wewrite 集成 — 公眾號草稿箱發布（preview + publish + image-post），Step 6 公眾號後端就位（2026-05-30）
- [x] 公眾號封面對比測試 — Claude (guizang-social-card-skill) vs GPT，Swiss IKB Blue 風格確認可行（2026-05-30）
- [x] 執行規則加固 — SKILL.md 鐵律 + production.md 硬性檢查點表 + Step 4.4 渲染前阻斷（2026-05-30）
- [x] Path C 視頻生產 — ElevenLabs 配音 + Hyperframes 畫面 + FFmpeg 合軌，流程走通但畫面效果待打磨（2026-05-30）

## Dependencies

| 组件 | 版本 | 状态 |
|------|------|:--:|
| wewrite | main | ✅ |

| 组件 | 版本 | 状态 |
|------|------|:--:|
| FFmpeg | 2026-01-14 | ✅ |
| Hyperframes | 0.6.52 | ✅ |
| Chrome Headless | 131.0.6778.85 | ✅ |
| ElevenLabs | Python SDK | ✅ |
| Node.js | ≥22 | ✅ |
| Python | ≥3.10 | ✅ |
| Git | — | ✅ |

## Known Issues

| # | Issue | Priority | Status |
|---|-------|----------|--------|
| 1 | TikTok/X/YouTube 平台未接入 sau CLI | Medium | 待接入 |
| 2 | Path C 視頻生產畫面待打磨 — 純文字版視頻效果未達預期，Hyperframes 動畫方案需重新評估 | High | 待處理 |
| 3 | 合集封面未完成 — AI第一單 | Medium | 待處理 |

## Next Actions (優先順)

1. **路徑 C 視頻質量修復** — ✅ 配音已換 Edge-TTS（免費中文原生）+ Hyperframes 真動畫（非靜態幀）
2. **TikTok 平台接入 sau** — 按 skill pattern 加入 TikTok CLI

## Key Links

| Service | URL |
|---------|-----|
| GitHub Repo | https://github.com/yoko-naora/yijian-chengpian |
