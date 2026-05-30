---
name: yijian-chengpian
description: 一键成片——AI自动教学视频生产工作流。选题→质检(dbs-content+dbs-xhs-title)→分支(图文/口播/教学)→脚本→钩子(dbs-hook)→配音→模板→封面→分发(social-media-auto-publish+wewrite公众号)。两种模式：首次搭建和日常生产。触发词：一键成片、自动做视频、批量生产视频、做一期教学视频、生成教学视频、视频工厂、教学片坊、只做质检、发到全平台、发公众号、做小绿书。支持抖音/TikTok/小红书/公众号/X/B站多平台风格适配+中日双语输出。
---

# 一键成片 · AI自动教学视频生产工作流

## 🔴 铁律（违反即跳步骤——今天犯了 3 次）

**在执行任何生产动作之前，先用 Read 工具读 `references/production.md` 中对应 Step 的完整内容。**

禁止凭记忆执行。禁止「我知道下一步是什么」——读，然后做。

每当你即将做以下动作之一，**先读 production.md 对应章节**：

| 即将做 | 先读 |
|--------|------|
| 质检 / 调用 dbs-content | `production.md` Step 1.5 |
| 检测 AI 写作 | `production.md` Step 1.6 |
| 让用户选 A/B/C | `production.md` Step 1.7 |
| 选模板 | `production.md` Step 1.8 |
| 写脚本 / 扩写文案 | `production.md` 对应路径 C.1 / A.1 / B.1 |
| 找图 / 搜素材 | `production.md` 素材管线 |
| 生成卡片 / 调用 guizang-social-card-skill | `production.md` A.2（含硬约束：拷种子→只改POSTERS_HERE） |
| 配音 / Edge-TTS | `production.md` C.2 |
| 做 Hyperframes 画面 | `production.md` C.3 + C.4 |
| 导出视频 | `production.md` C.5 |
| 做封面 | `production.md` C.5 / B.4 |
| 分发 | `production.md` Step 6 |

**不读 = 跳步骤。跳步骤 = 用户白等。**

---

## 模式检测

第一步判断工作区是否已搭建。如果用户未指定路径，默认工作区为 `~/Projects/yijian-chengpian`。

```powershell
Test-Path "$env:USERPROFILE\Projects\yijian-chengpian"
```

- 目录**不存在** → 进入「模式一：首次搭建」
- 目录**存在** → 进入「模式二：日常生产」

---

## 模式一：首次搭建

### 确认变量

分步询问，不要一次全问：

1. **工作区路径** — 默认 `C:\Users\<用户名>\Projects\yijian-chengpian`，用默认还是自定义？
2. **安装方式** — A（全局 symlink，需管理员）还是 B（项目内自包含，推荐）？
3. **TTS 配音** — Edge-TTS（免费，`pip install edge-tts`，无需 API Key）

确认后按 `references/setup.md` 执行 6 阶段搭建：

| Phase | 内容 |
|-------|------|
| 1 | 系统依赖检查（FFmpeg、Python、Node.js、Git、yt-dlp） |
| 2 | 克隆 video-use |
| 3 | 初始化 Hyperframes 模板 |
| 4 | 安装 Edge-TTS（`pip install edge-tts`，免费无需 Key） |
| 5 | 创建项目目录树 |
| 6 | 生成工作区 CLAUDE.md |

搭建完成后：
> 以后说「一键成片：<选题>」就能直接生产。试一个？

---

## 模式二：日常生产

> **全部细节在 `references/production.md`。本文件不写摘要——摘要 = 跳步骤的根源。**

流水线：

```
输入选题 → 质检 → AI检测 → 分支 → 模板 → 生产 → 分发
```

每步的完整规则、检查清单、硬约束，**必须 Read `references/production.md` 对应章节后才能执行**。铁律表见上。

### 扩展指令

| 指令 | 效果 |
|------|------|
| 「只做质检」 | 只跑 Step 1.5，不生产视频 |
| 「出双语版」 | 额外生成日文配音版 |
| 「发到全平台」 | Step 6：sau 短视频 + wewrite 公众号一键分发 |
| 「发到抖音+小红书」 | 选择特定平台分发 |
| 「发公众号」 / 「发到草稿箱」 | wewrite publish → 微信草稿箱 |
| 「做小绿书」 | wewrite image-post → 公众号图片轮播帖 |
| 「只要预览」 | wewrite preview → 微信公众号 HTML 本地预览 |
| 「批量生产」 | 选题列表依次执行全流程 |
| 「浏览模板」 / 「打开模板目录」 | 打开 template-catalog.html 选视觉模板 |
| 「换风格」 / 「换配色」 / 「换版式」 | 修改当前模板的 style / accent / recipes |
| 「保存模板」 | 生产完成后保存当前模板配置供下次使用 |
| 「旅行攻略」/「职场干货」/「产品测评」... | 按品类自动路由风格+配色+版式+图源 |
| 「打开品类目录」 | 打开 template-catalog.html 看 12 个品类路由 |

---

## 安全规则

- Edge-TTS 完全免费，无需 API Key。如后续接入付费 TTS，密钥**只能**写入 `.env`
- `.env` 必须在 `.gitignore` 中
- 生成脚本时不写入任何真实凭证
