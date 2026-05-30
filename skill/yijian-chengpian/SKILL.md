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

**🔴 执行协议：每进入一个 Step，第一步是 Read `references/production.md` 该 Step 的完整内容。读完之前，不准调用任何 Skill、不准写任何代码、不准生成任何文件。**

完整流水线，详见 `references/production.md`：

```
Step 1     Step 1.5   Step 1.6   Step 1.7   Step 1.8        ──────── 三条生产路线 ────────              Step 6
输入选题 → 内容质检 → AI检测   → 内容类型 → 模板选择 ─┬→ A 图文 → 文案+卡片 ────────────────────→ 分发
                              闭环      分支        │
                                                   ├→ B 口播 → 剪辑→字幕+配乐→封面 ────────→ 分发
                                                   │
                                                   └→ C 教学 → 脚本→钩子(dbs-hook)→配音→
                                                               模板→字幕+配乐→导出→封面 → 分发
```

> **关键变化（v2）**：dbs-hook 放在写脚本之后。先有脚本，再优化开头。

### Step 1.5 质检说明

在生产前调用现有 skill 做内容把关：

| 质检项 | 调用 Skill | 时机 | 适用 |
|--------|-----------|------|------|
| 选题质量 | `dbs-content` | 写稿前 | 全平台 |
| 标题优化 | `dbs-xhs-title` | 写稿前 | 小红书/图文 |
| ~~前3秒钩子~~ | ~~dbs-hook~~ | **移到 Step 2.5** | 视频类 |

质检结果分三档：**Go** / **Fix** / **Kill**

### Step 2.5：钩子优化（视频路线，脚本写完后）

**脚本写完后**，调 `dbs-hook` 优化前 3-5 秒开头。脚本 + 质检结论一起提交。

- 路径 A（图文）→ 跳过，文案本身不需要口播钩子
- 路径 B（口播）→ 剪辑前调，优化开场白
- 路径 C（教学）→ 配音前调，优化配音第一句

详见 `references/production.md` 各路径的 Step 2.5。

```
📺 这条内容做什么形式？

A. 图文 — 小红书图文 / 公众号封面（不用拍视频）
B. 口播 — 对着镜头讲，需要 video-use 剪辑
C. 教学 — AI 自动生成画面 + 配音的教学视频
```

| 分支 | 生产工具 | 成品 | 跳转 |
|------|---------|------|------|
| **A 图文** | dbs-content 扩写 → guizang-social-card-skill 做卡片 | 小红书轮播图 / 公众号封面 | → 路径A |
| **B 口播** | video-use（剪辑+字幕+配乐）→ guizang-social-card-skill（封面） | 口播短视频 + 封面 | → 路径B |
| **C 教学** | Edge-TTS配音 → Hyperframes（画面+字幕+配乐）→ FFmpeg导出 → guizang-social-card-skill（封面） | AI教学视频 + 封面 | → 路径C |

用户也可能直接指定：
- 「做一期小红书图文」→ 自动走路径 A
- 「录个口播讲这个话题」→ 自动走路径 B
- 「做一个教学视频」→ 自动走路径 C
- 没说 → 弹出 A/B/C 选择

### Step 2-5：教学路线（路径 C）

仅当 Step 1.6 选择「C 教学」时执行。详见 `references/production.md`。

### Step 4：风格选择 + 组装画面（教学路线必须交互）

脚本 + 配音完成后，**问 2 个问题自动推荐风格**，不要求用户说风格名：

```
Q1: 内容类型？ A教程 B测评 C观点 D故事
Q2: 什么感觉？ A干净专业 B温暖亲切 C高级冷淡 D帮我推荐
```

→ 根据回答自动匹配 9 种风格之一 → 用户确认 → Claude 写 Hyperframes HTML → 自动拼入社区组件（grain+vignette+字幕+转场+outro）→ 渲染

默认风格：**Swiss Tech**（黑底+橙强调+无衬线，百搭安全）。

详见 `references/production.md` Step 4（4.0-4.4）。

### 平台适配

同一选题，不同平台有对应的风格、节奏、画幅：

| 维度 | 抖音/TikTok | 小红书 | 公众号 | X/Twitter |
|------|------------|--------|--------|-----------|
| 节奏 | 极快，1s 抓注意力 | 中等，适合阅读 | 中等，适合深度阅读 | 快，文字为主 |
| 画面 | 9:16 竖版 | 3:4 或 1:1 | 21:9+1:1 / 小绿书 3:4 | 16:9 或 1:1 |
| 标题 | 口语+emoji | 公式化（75 模板） | 信息量+专业感 | 极简观点 |
| 后端 | `sau douyin` | `sau xiaohongshu` | `wewrite` | 未接入 |

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
