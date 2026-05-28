---
name: yijian-chengpian
description: 一键成片——AI自动教学视频生产工作流。完整6步：选题→内容质检(dbs-content+dbs-hook+dbs-xhs-title)→脚本扩写→配音→模板→多平台分发(social-media-auto-publish)。两种模式：首次搭建和日常生产。触发词：一键成片、自动做视频、批量生产视频、做一期教学视频、生成教学视频、视频工厂、教学片坊、只做质检、发到全平台。支持抖音/TikTok/小红书/X/B站多平台风格适配+中日双语输出。
---

# 一键成片 · AI自动教学视频生产工作流

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
3. **ElevenLabs API 密钥** — 已有直接输入，没有就去 https://elevenlabs.io/app/settings/api-keys 获取

确认后按 `references/setup.md` 执行 6 阶段搭建：

| Phase | 内容 |
|-------|------|
| 1 | 系统依赖检查（FFmpeg、Python、Node.js、Git、yt-dlp） |
| 2 | 克隆 video-use |
| 3 | 初始化 Hyperframes 模板 |
| 4 | 配置 ElevenLabs（`.env` + `.gitignore`） |
| 5 | 创建项目目录树 |
| 6 | 生成工作区 CLAUDE.md |

搭建完成后：
> 以后说「一键成片：<选题>」就能直接生产。试一个？

---

## 模式二：日常生产

6 步完整流水线，详见 `references/production.md`：

```
Step 1        Step 1.5        Step 2        Step 3        Step 4           Step 5-6
输入选题  →   内容质检    →   AI扩写脚本  →  ElevenLabs  →  模板选择+渲染  →  导出+分发
               ├ dbs-content                   配音          ├ 内置5模板
               ├ dbs-hook                                   ├ 社区45+组件
               ├ dbs-xhs-title                              └ 现场生成
               └ 平台风格适配
```

### Step 4：模板选择（必须交互）

脚本 + 配音完成后，**必须让用户选模板**，不能跳过：

```
📺 选视频画面模板：

A. 教程步骤  B. 概念讲解  C. 工具对比  D. 清单技巧
E. 查看社区模板（45+）  F. 描述风格，现场生成  G. 帮我自动选
```

- A-D → 内置品牌模板，填入内容，末尾加 outro
- E → `npx hyperframes catalog` → 用户挑 → `npx hyperframes add <name>`
- F → 根据用户描述当场写 Hyperframes HTML
- G → 根据内容类型自动匹配

详见 `references/production.md` Step 4（4.0-4.5）。

### Step 1.5 质检说明

在生产前调用你的现有 skill 做内容把关：

| 质检项 | 调用 Skill | 适用平台 |
|--------|-----------|---------|
| 选题质量 | `dbs-content` | 全平台 |
| 前 3 秒钩子 | `dbs-hook` | 抖音/TikTok/小红书 |
| 标题优化 | `dbs-xhs-title` | 小红书 |
| 策略对齐 | `dashen-x-battle-plan` | X/Twitter |

质检结果分三档：**Go**（直接生产）/ **Fix**（改后生产）/ **Kill**（换选题）

### 平台适配

同一选题，不同平台有对应的风格、节奏、画幅：

| 维度 | 抖音/TikTok | 小红书 | X/Twitter |
|------|------------|--------|-----------|
| 节奏 | 极快，1s 抓注意力 | 中等，适合阅读 | 快，文字为主 |
| 画面 | 9:16 竖版 | 3:4 或 1:1 | 16:9 或 1:1 |
| 标题 | 口语+emoji | 公式化（75 模板） | 极简观点 |

### 用户输入形式

- 选题：「一键成片：ChatGPT 注册教程」
- 选题+平台：「做一期 Midjourney 技巧，发小红书」
- 完整脚本：跳过 Step 1.5+2，直接进生产
- 只质检：「只做质检，选题是 xxx」

### 完成后

输出视频路径、时长、语言。提示可选：日文版、全平台分发。

### 扩展指令

| 指令 | 效果 |
|------|------|
| 「只做质检」 | 只跑 Step 1.5，不生产视频 |
| 「出双语版」 | 额外生成日文配音版 |
| 「发到全平台」 | Step 6：social-media-auto-publish 多平台一键发布 |
| 「发到抖音+小红书」 | 选择特定平台分发 |
| 「批量生产」 | 选题列表依次执行全流程 |

---

## 安全规则

- ElevenLabs API 密钥**只能**写入 `.env`，绝不进入仓库
- `.env` 必须在 `.gitignore` 中
- 生成脚本时不写入任何真实凭证
