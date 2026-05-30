# 一键成片 · 成果物管理

## 2026-05-30

| # | 成果物 | 类型 | 路径/URL |
|---|--------|------|----------|
| 1 | 品类路由目录 | 页面 | `skill/yijian-chengpian/templates/template-catalog.html` |
| 2 | 模板配置数据 | JSON | `skill/yijian-chengpian/templates/template-catalog-data.json` |
| 3 | Swiss 预览 | 页面 | `skill/yijian-chengpian/templates/preview-swiss-ai-tool.html` |
| 4 | Editorial 预览 | 页面 | `skill/yijian-chengpian/templates/preview-editorial-business.html` |
| 5 | M01 封面预览 | 页面 | `skill/yijian-chengpian/templates/preview-m01-cover.html` |
| 6 | S04 浏览器预览 | 页面 | `skill/yijian-chengpian/templates/preview-s04-browser.html` |
| 7 | 子Skill依赖清单 | 文档 | `skill/yijian-chengpian/references/DEPENDENCIES.md` |
| 8 | Agent Harness 寓言视频 | 视频 | `projects/2026-05-30/agent-harness/output/agent-harness.mp4` |
| 9 | Agent Harness 配音 | 音频 | `projects/2026-05-30/agent-harness/voiceover.mp3` |
| 10 | 生产管线规则 | 文档 | `skill/yijian-chengpian/references/production.md`（大幅度扩充） |
| 11 | SKILL.md 执行协议 | 文档 | `skill/yijian-chengpian/SKILL.md`（铁律+执行协议加固） |

## Known Issues

- Agent Harness 视频音画不同步，需按配音时间轴重算场景时长
- Hyperframes 渲染管线沙箱无中文字体，当前用 Playwright 替代
- Edge-TTS 单文件 4000 字符限制，长脚本需分段

## 2026-05-29

| # | 成果物 | 类型 | 路径/URL |
|---|--------|------|----------|
| 1 | GitHub 遠程倉庫 | Repo | https://github.com/yoko-naora/yijian-chengpian |
| 2 | PROJECT.md | 文档 | `C:\Users\jding\Projects\yijian-chengpian\PROJECT.md` |
| 3 | Step 6 CLI 命令文檔 | 文档 | `skill/yijian-chengpian/references/production.md` |
| 4 | social-auto-upload 安裝 | 工具 | `C:\Users\jding\social-auto-upload\` |
| 5 | Chrome Headless Shell 修復 | 環境 | `.cache\hyperframes\chrome\chrome-headless-shell\` |
| 6 | uv パッケージマネージャ | 工具 | `~/.local/bin/uv` |

## Known Issues (今日発見・解決済)

- Hyperframes Chrome render 環境：zip 解压不完全 → robocopy 修复 ✅
- Git remote なし → `yoko-naora/yijian-chengpian` 创建 ✅
- social-auto-upload 未安装 → `~/social-auto-upload` + sau CLI 可用 ✅
- playwright 导入未迁移 → 6 文件 patchright 迁移 ✅
- f-string backslash bug → xiaohongshu_uploader 修复 ✅
