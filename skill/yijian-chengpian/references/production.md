# 日常生产工作流

> 🔴 **通用铁律：调用任何子 Skill 前，必须读完该 Skill 要求的所有 reference 文件，再动手写代码。**
> 
> 违规信号：用户说「你读 skill 了吗」「你没按流程」「这不像 skill 的产出」。

## 🔴 硬性检查点

每完成一个 Step，对照此表逐项确认，全部 ✅ 才能进入下一步。

| Step | 检查项 | 确认方式 |
|------|--------|---------|
| 1.5 | 选题质检已完成 | 对话中出现 Go / Fix / Kill 结论 |
| 1.6 | AI 检测闭环完成 | 命中 ≤1 且全为 💡 |
| 1.7 | 内容类型分支已确认 | 用户选了 A / B / C |
| A.1 / B.1 / C.1 | 文案/脚本已写出 | article.md 文件存在 |
| C.1.4 | 素材已问用户 | 对话中出现「你有没有现成素材？」 |
| C.1.5 | dbs-hook 已调用 | 对话中出现 Hook 优化方案 |
| C.2 | 配音已生成 | voiceover.mp3 文件存在 |
| C.4.3 | 5 个社区组件已安装 | `npx hyperframes add` 全部执行 |
| C.4.4 | lint + validate 通过 | `npm run check` 0 errors |
| C.4.4 | 组件已嵌入 composition | composition HTML 中包含 grain/vignette/caption/wipe/outro |
| C.4 | 素材（截图/照片）已嵌入 | composition HTML 中对应场景有 `<img>` |
| C.5 | FFmpeg 合轨完成 | output/*.mp4 文件存在 |
| 6 | 封面已生成 | wechat-21x9-cover.png 等文件存在 |
| 6 | 分发已执行 | publish 或 upload 命令已跑 |
| **A.2 / B.4 / C.5** | **种子模板已拷 + 主题已设** | index.html 第一行是种子模板内容，`data-accent` 或 `data-theme` 已改 |
| **A.2 / B.4 / C.5** | **只改了 POSTERS_HERE** | 模板 CSS 区域未被修改，无手写 `.poster` class 或自定义 font-size |
| **A.2 / B.4 / C.5** | **每页用了指定 recipe** | 每个 `<section class="poster">` 内是 layout-recipes.md 的完整 HTML 骨架 |
> 正确做法：子 Skill 加载后，先扫一遍它列出的 `references/` 清单，全部 Read 完，脑子里的方案能通过该 Skill 的身份测试（如 Swiss 4 条 / Editorial 3 条），再写第一行 HTML。

## 完整流水线

```
Step 1       Step 1.5      Step 1.6         Step 1.7         ──────── 三条生产路线 ────────               Step 6
输入选题  →  内容质检  →  AI检测闭环  →  内容类型分支  ─┬─ A 图文 → 文案→配图→卡片 ──────────→ 多平台分发
                                                       ├─ B 口播 → 稿子→素材→剪辑→字幕→封面 ──→ 多平台分发
                                                       └─ C 教学 → 脚本→素材→配音→模板→导出 ──→ 多平台分发
```

---

## 输出目录规范

> 每个生产任务一个独立子文件夹，禁止所有文件摊在日期根目录。

### 结构

```
projects/YYYY-MM-DD/
├── 📁 <项目名>/                  ← 每个任务一个文件夹，用英文短名
│   ├── article.md                ← 文案/脚本
│   ├── screenshots/              ← 配图（如有）
│   │   ├── 01-xxx.png
│   │   ├── 02-xxx.png
│   │   ├── prompts-generate.md   ← AI 生成图片的提示词
│   │   └── prompts-annotate.md   ← 图片标注提示词
│   ├── assets/                   ← 用户提供的素材（如有）
│   ├── clips/                    ← 视频片段（如有）
│   ├── output/                   ← 最终成品（mp4/png）
│   └── voiceover.mp3             ← 配音（如有）
```

### 命名规则

| 规则 | 示例 |
|------|------|
| 文件夹用英文短名，小写+连字符 | `notebooklm-article` `rain-video` `ai-xhs-titles` |
| 配图 01- 前缀，描述内容 | `01-home.png` 不是 `图1.png` |
| 提示词文件 `prompts-` 前缀 | `prompts-generate.md` `prompts-annotate.md` |
| 按产出类型分子文件夹 | `screenshots/` `clips/` `output/` `assets/` |

### 一眼能找到

- 打开日期目录 → 看到 3 个文件夹 → 点进去 → `article.md` 就是正文
- 不用在 20 个平铺文件里翻

---

## Step 1：输入解析

### 用户输入类型识别

| 输入形式 | 示例 | 处理方式 |
|---------|------|---------|
| 纯选题 | 「ChatGPT 注册教程」 | 质检 → 分支选择 → 生产 |
| 选题+形式 | 「做一期小红书图文，讲Notion AI」 | 质检 → 自动走路径 A |
| 选题+形式 | 「录个口播，聊AI焦虑」 | 质检 → 自动走路径 B |
| 选题+形式 | 「做一期教学视频，Midjourney技巧」 | 质检 → 自动走路径 C |
| 完整脚本 | 直接粘贴文案 | 跳过质检，选路径后直接生产 |
| 只质检 | 「只做质检，选题是 xxx」 | 只跑 Step 1.5，不生产 |

### 能力边界检查

> 归藏原话：「能力边界比能力本身更能定义一个产品。一个什么都能做的 Skill 最后通常什么都做不好。」

在进入生产流程之前，检查用户选题是否在能力圈内。**踩线时主动告知，不硬做。**

**明确支持**（7 个品类，端到端质量最好）：

| 品类 | 关键词 | 自动路由 |
|------|--------|---------|
| 旅行 / 生活方式 | 旅行、攻略、户外、探店 | Editorial 杂志风 |
| 职场 / 干货 / 商业 | 职场、效率、管理、商业思考、AI工具 | Swiss 网格风 |
| 产品测评 / 数码 | 测评、对比、推荐、开箱 | Swiss 网格风 |
| 读书 / 笔记 | 读书、书单、阅读笔记 | Editorial 杂志风 |
| 美食 / 食谱 | 食谱、做菜、烘焙 | Editorial 杂志风 |
| 影视 / 文化 | 影评、剧评、文化评论 | Editorial 杂志风 |
| 教程 / How-to | 教程、步骤、指南 | Swiss 或 Editorial 均可 |
| 个人故事 / 经历 | 创业、经历、品牌故事 | Editorial 杂志风 |

**可以接但要告知限制**（需要用户提供图片）：

| 品类 | 限制 | 告知用户 |
|------|------|---------|
| 游戏 | 版权图风险 | 「游戏主视觉图有版权风险，是否接受？推荐用 Wallhaven 取图后你判断」 |
| 彩妆 | 需要产品/试色照片 | 「你需要提供产品图或试色照片，我们不出人像」 |
| 健身 | 需要动作/进度照片 | 「需要你提供训练照片或数据截图」 |
| 家居 | 需要实拍照片 | 「最好有你家的实拍图，Pinterest 搜图版权风险高」 |
| 穿搭 | 需要穿搭照片 | 「出 OOTD 照片不是我们的能力，但可以做单品推荐清单」 |

**明确不接**（告知用户，建议用其他工具）：

| 类型 | 原因 |
|------|------|
| 追星 / 粉丝向 | 视觉语言完全不同，需要饭圈美学 |
| 纯促销硬广 | 违背内容性设计哲学，出不来好效果 |
| OOTD 日常穿搭全身照 | 无法生成人像照片 |
| 梦核 / 氛围感 / Y2K / 千禧辣妹 | 和 Swiss/Editorial 两套系统正面冲突 |
| 超 12 屏长教程 | 图文形态不是长教程的最优载体，考虑做视频 |
| 菜品大片摆盘 | 无法替代专业美食摄影 |

**告知话术 + 兜底方案**：

品类不在支持列表时，不直接拒绝。先告知，再给基础版：

```
这个内容类型目前没有专门优化的模板。

但有两个通用基础版可以用：

① Swiss 通用版 — IKB Blue，干净利落，适合偏理性/工具/数据类内容
② Editorial 通用版 — Ink Classic，杂志感，适合偏人文/叙事/生活类内容

选一个先做，不满意再调配色和版式。
```

> **为什么不拒绝？** 用户已经带着选题来了，直接说「不适合」是把人往外推。给基础版让用户有个起点，用着不满意自然会调整。
> 
> 仅 6 类「不适合」场景（追星/OOTD/梦核/纯促销/超12屏/菜品大片）仍然如实告知，因为这 6 类确实做不好。

### 目标时长对应字数（路径 C 用）

| 时长 | 中文字数 | 日文字数 |
|------|---------|---------|
| 1 分钟 | ~250 字 | ~300 字 |
| 2 分钟 | ~500 字 | ~600 字 |
| 3 分钟 | ~750 字 | ~900 字 |
| 5 分钟 | ~1250 字 | ~1500 字 |

---

## Step 1.5：内容质检

> 生产前先确保选题、钩子、标题都过关。这是核心差异化。

### 质检流程

```
选题诊断 (dbs-content)
    ↓ 选题过关？
钩子优化 (dbs-hook)
    ↓ 前3秒抓得住？
标题优化 (dbs-xhs-title)  ← 仅小红书/图文平台
    ↓
平台风格适配
    ↓ 进入 Step 1.6
```

### 质检项与对应 Skill

| 质检项 | Skill | 检查什么 | 适用 |
|--------|-------|---------|------|
| 选题质量 | `dbs-content` | 值不值得做？能不能做成好内容？ | 全平台 |
| 前3秒钩子 | `dbs-hook` | 叙事钩/数据钩/悬念钩/情绪钩？ | 视频类 |
| 标题优化 | `dbs-xhs-title` | 75公式匹配最佳标题 | 小红书/图文 |
| X 策略 | `dashen-x-battle-plan` | 选题是否符合账号阶段策略？ | X/Twitter |

### 质检输出格式

```
选题：[用户输入]
目标平台：[抖音 / 小红书 / X / TikTok]
质检结果：
  ✓/⚠/✗ 选题质量 — {一句话}
  ✓/⚠/✗ 钩子 — {一句话，附带优化版钩子}
  ✓/⚠/✗ 标题 — {一句话，附带公式编号和建议标题}
  ──
  综合：{Go / Fix / Kill}
```

**Go** → 进入 Step 1.6  
**Fix** → 按建议修改后进入 Step 1.6  
**Kill** → 换选题

---

## Step 1.6：AI 写作检测闭环

> **适用：所有路径中产生文字内容的环节（路径 A 文案、路径 B 口播稿、路径 C 脚本）。**
> **原则：检测 → 修改 → 复检 → 再改，直到通过。全程自动，不打断用户。**

### 流程

```
文字初稿完成
     ↓
dbs-ai-check（检测 AI 写作特征）
     ↓
命中 ≥ 1 处？──Yes──→ 逐条自动修改
     ↓                    ↓
    No              dbs-ai-check（复检）
     ↓                    ↓
    通过              命中 = 0？
                        ↓
                    Yes──→ 通过
                        ↓
                    No──→ 继续修改 → 复检（最多 3 轮）
     ↓
进入下一步（生成卡片 / 配音 / 剪辑）
```

### 判定标准

| 严重度 | 处理方式 |
|--------|---------|
| 🔴 强信号（如 #16 开头三件套） | 必须修改，0 容忍 |
| ⚠️ 中信号（如 #8 不是X是Y、#3 排比、#13 段段金句） | 修改到 ≤1 处残留 |
| 💡 弱信号（如 #22 过拟合、#14 节奏） | 尽量改，改完有明显改善即可 |

### 修改原则

- **不逐条问用户**。检测完直接改，改完直接复检。
- 改的是表达方式，不改事实内容和结构框架。
- 修改方向：打破光滑感 → 加短句打断节奏 → 删多余的收束金句 → 降结尾升华。
- 3 轮还不过 → 把剩余命中和修改建议呈现给用户，让用户决定。

### 复检通过标准

```
命中 0 处 → 直接进入下一步
命中 1-2 处且全为 💡 弱信号 → 视情况再改一轮或放行
命中 ≥1 处含 🔴/⚠️ → 继续修改
```

---
	
## Step 1.7：内容类型分支

> **必须交互，不能跳过。** 质检通过后根据内容特征推荐最佳路径。

### 路径推荐（根据内容类型自动匹配）

| 你的内容属于 | 推荐路径 | 为什么 |
|------------|:------:|------|
| 教程/操作步骤/工具教学 | **C 教学** | 需要画面展示步骤，AI 配音+画面最合适 |
| 观点/认知/商业思考 | **B 口播** | 靠表达力撑，镜头前的真实感最重要 |
| 产品测评/对比/排行 | **A 图文** | 对比矩阵、数据图、参数卡片——图文最优 |
| 个人故事/经历 | **B 口播** | 故事需要人的温度和语气，口播比文字更打动人 |
| 数据报告/周报 | **A 图文** | KPI 塔、柱状图——一张图胜过 30 秒口播 |
| 避坑/经验分享 | **A 或 B** | 图文适合清单式避坑，口播适合「我踩过的坑」叙事 |
| 读书笔记/影评 | **A 图文** | 引文居中、留白——杂志风天生为这个做的 |

### 但如果选错了……

系统会给出提醒，不阻止，但告知风险：

| 你选了 | 但这个内容 | 提醒 |
|-------|----------|------|
| B 口播 | 软件操作教程 | 「观众需要看屏幕，对着镜头讲步骤效果不好。建议走 C 教学视频。」 |
| B 口播 | 数据密集内容 | 「口播报数字观众记不住。建议走 A 图文，KPI 塔一张图说清楚。」 |
| B 口播 | 无出镜意愿 | 「口播需要你露脸或录音。如果不想，走 A 图文更合适。」 |
| C 教学 | 纯观点/评论 | 「观点类不需要画面，口播的真实感更强。建议走 B 口播。」 |
| C 教学 | 深度长文 | 「视频承载不了太密的逻辑。建议走 A 图文。」 |
| A 图文 | 强故事性内容 | 「图文也能讲故事，但口播的『真人在讲』感更强。要不要试试 B？」 |

### 分支详情

| 分支 | 调用的 Skill | 成品 | 跳转 |
|------|-------------|------|------|
| **A 图文** | dbs-content → guizang-social-card-skill | 小红书图文 / 公众号 21:9+1:1 | ↓ 路径 A |
| **B 口播** | video-use（剪辑+字幕+配乐）→ guizang-social-card-skill（封面） | 口播短视频 + 封面 | ↓ 路径 B |
| **C 教学** | Edge-TTS → Hyperframes → FFmpeg → guizang-social-card-skill（封面） | AI 教学视频 + 封面 | ↓ 路径 C |

用户如果已经说了形式（如「做一期小红书图文」），自动跳过此步直接进入对应路径。

---

## Step 1.8：模板选择

> 在进入生产路径之前，选择社交卡片的视觉模板。**路径 A 必须选，路径 B/C 只用模板的封面 recipe。**

### 三种选择方式

```
本次使用什么模板？

① 浏览模板目录 — 打开 template-catalog.html 挑选（推荐，有预览图）
② 自动推荐 — 告诉我内容类型，我匹配最合适的
③ 使用已保存模板 — 从 user-templates.json 加载上次保存的配置
```

### 选项 ①：浏览模板目录

打开 `templates/template-catalog.html`（可直接用浏览器打开）。
8 套模板：4 套 Swiss + 4 套 Editorial，每套含 4-5 张卡片的 recipe 序列。
点击「选择此模板」→「确认使用」→ 看到 JSON 配置。
把 JSON 内容告诉 Claude，或直接说模板 ID（如 `ai-tool-tutorial`）。

### 选项 ②：自动推荐

用户描述内容类型，Claude 自动匹配：

| 内容类型 | 推荐模板 ID | 风格 + 配色 |
|---------|------------|------------|
| AI 工具/软件教学 | `ai-tool-tutorial` | Swiss + IKB Blue |
| 产品对比/测评 | `product-review` | Swiss + IKB Blue |
| 数据/报告/周报 | `data-report` | Swiss + Lemon Green |
| 避坑/反模式/警告 | `avoid-pitfalls` | Swiss + Safety Orange |
| 商业思考/认知输出 | `business-insight` | Editorial + Ink Classic |
| 个人经历/品牌故事 | `personal-story` | Editorial + Kraft Paper |
| 分步骤教程/食谱 | `tutorial-steps` | Editorial + Indigo Porcelain |
| 公众号封面 | `wechat-cover-pair` | Swiss + IKB Blue |

### 选项 ③：已保存模板

从前次生产保存的 `user-templates.json` 读取。列出模板名、保存日期。

### 不满意当前模板？

告诉 Claude 要改什么，三个维度可独立修改：

- **换风格**：`"style": "swiss"` ↔ `"editorial"`
- **换配色**：Swiss 可用 `ikb` / `lemon-yellow` / `lemon-green` / `safety-orange`；Editorial 可用 `ink-classic` / `indigo-porcelain` / `forest-ink` / `kraft-paper` / `dune` / `midnight-ink`
- **换版式**：修改 `"recipes"` 数组。Swiss 可用 S01-S12，Editorial 可用 M01-M16。完整列表见 guizang-social-card-skill 的 `references/layout-recipes.md`

### 满意 → 进入对应生产路径

A.2 / B.4 / C.5 按模板 config 的 `style` + `accent`/`theme` + `recipes` 生成卡片。

### 生产完成后：保存模板

```
是否保存本次模板配置？[是] [否]
```

选「是」→ 存到 `user-templates.json`，下次从 ③ 调入。
选「否」→ 直接结束。

保存格式：
```json
{
  "version": 1,
  "templates": [
    {
      "id": "user-1717000000000",
      "name": "用户起的名字",
      "savedAt": "2026-05-30T...",
      "sourceTemplateId": "ai-tool-tutorial",
      "overrides": { "accent": "safety-orange" }
    }
  ]
}
```

---

## 素材管线（全路径通用）

> 图文（Path A）和视频（Path C）共用搜图管线。视频额外多一个「视频素材」来源。
>
> 归藏原话：「绝大多数 AI 图文工具让你自己上传图，或者用 emoji 顶替。这个 Skill 默认接入三个免费图库，根据正文语义自动派发搜索词、拿回图、按版式裁切到位。」

### 图源优先级

```
用户提供（截图/照片）→ Pexels（中文搜索）→ Unsplash（摄影质感）→ Wallhaven（游戏/壁纸）→ AI 生图（最后兜底）
```

| 优先级 | 来源 | 特点 | 适用 |
|:--:|------|------|------|
| 1 | **用户提供** | 最真实，不 AI 感 | 截图、产品照、现场照片 |
| 2 | **Pexels** | 支持中文搜索，大众化场景 | 国内场景、中式内容、通用配图 |
| 3 | **Unsplash** | 摄影质感最强 | 人物、生活、空间、科技、户外 |
| 4 | **Wallhaven** | 游戏/动漫/壁纸，版权混乱 | 游戏内容、暗色主题背景 |
| 5 | **AI 生图** | 最后手段，带风格约束词 | 前三者全无合适素材时 |

### 自动搜图流程

```
正文段落 → 提取语义关键词 → 按优先级依次搜索
  → 找到合适图 → 下载到 assets/ → 记录到 assets/SOURCES.md
  → 找不到 → 下一优先级
  → 全部找不到 → AI 生图（带风格约束词）
```

**搜索关键词提取规则**：
- 每 2-3 个段落提取 1 组关键词
- 封面用标题核心词
- 正文页用该页主题词
- 优先英文关键词（Unsplash 英文搜更准），国内场景用中文（Pexels 中文支持好）

**来源记录**：每张图写入 `assets/SOURCES.md`：
```
hero-mountain.jpg ← https://unsplash.com/photos/xxxxx
ui-screenshot.png ← user-provided
ai-hero.png ← AI Generated (Gemini Imagen, prompt: "Swiss style conceptual...")
```

### 版权策略

- 先取图，后告知，由用户判断是否可用
- Unsplash / Pexels 可商用免版权
- Wallhaven 版权混乱，必须告知用户风险
- 用户决定是否在图上标注来源（Swiss: `.t-meta` 角标，Editorial: `.img-cap` 说明行）
- 不管标不标，`SOURCES.md` 始终留痕

### 文字压图 3 步法

> 归藏原话：「文字压图是最容易暴露 AI 感的地方。压不好三种翻车：文字盖在人脸或产品中心上、白字压浅色背景读不清、文字横跨整张图毁掉构图。」

当文字需要压在照片上时（封面、大图位），执行以下三步：

**Step 1 — 识别主体，版式避开**：
- 用 Read 工具读图，描述主体位置（人脸/产品/文字密集区）
- 在 HTML 中写注释记录主体映射：`<!-- subject: face at 40%x 30%y, safe zone: bottom 60% -->`
- 选版式时标题放在 safe zone

**Step 2 — 算落点区域色和明度**：
- 观察标题落点区域的背景色和亮度
- 浅色背景 → 深色字（`var(--ink)`）
- 深色背景 → 浅色字（`var(--paper)` 或 `#f5f1e8`）
- 复杂背景 → 加局部 image-toned tint（峰值 α ≤ 0.30，只用在该区域）
- 禁止全幅 black/white falloff 遮罩

**Step 3 — 字号和断行自适应**：
- 不写死字号，用种子模板的 typed class（`.h-statement` / `.h-xl`）
- 标题 2 行以内，每行 ≤ 8 个汉字（3:4 板）
- 太长先压缩文案，不缩小字号
- 渲染后做 360px 缩略图测试：标题可读 → 通过

### 截图美化四件套

> 归藏原话：「你随手截的图，过它一道，看上去就像产品官方做的宣传图。」

当内容需要软件截图、聊天记录、产品界面时：

| 处理 | Swiss | Editorial |
|------|-------|-----------|
| 设备外框 | `.device-browser`（macOS 风格）或 `.device-phone` | 同左 |
| 材质背景 | `.frame-shot.bg-grey-1` / `.bg-grid` / `.bg-dot` / `.bg-asset-ikb-dot` | `.frame-shot.bg-paper-2` / `.bg-grid` / `.bg-asset-*` |
| 阴影 | `shadow-none` 默认（Swiss 直角无边）| `shadow-soft` 默认（杂志感浅影）|
| 圆角 | `corners-sq` 默认（Swiss 直角）| `corners-sm` 默认（6px 微圆）|

用法：
```html
<figure class="frame-shot r-16x10 bg-grey-1 inset-sub corners-sq">
  <img src="assets/screenshot.png" alt="界面截图">
</figure>
```

### AI 生图策略

> 归藏原话：「只有前面所有找图渠道都拿不到合适素材时，才会调用 AI 生图。生图时强制带上风格约束词。」

**触发条件**（全部满足才用）：
1. 用户没有提供图片
2. Pexels / Unsplash / Wallhaven 搜不到合适素材
3. 该页确实需要图片（非纯文字页）

**风格约束词**（必须带）：
- Swiss 模式：`Swiss style conceptual product image, clean off-white background, one accent color, no text, no logo, 3:4`
- Editorial 模式：`Editorial documentary photo, natural sunlight, clean composition, no text, no logo, 3:4`

**水印警告**：AI 生成的图可能带隐形水印，被平台检测后限流。优先用真照片。

### 视频素材（Path C 专用）

Path C 教学视频除静帧图片外，还可能需要视频片段作为背景或 B-roll。

**视频素材来源**（与图片管线共用搜索关键词）：

| 优先级 | 来源 | 适用 |
|:--:|------|------|
| 1 | **用户录屏/拍摄** | 工具操作、界面演示（最真实） |
| 2 | **Pexels Videos** | 免费可商用视频素材，中文搜索 |
| 3 | **Pixabay Videos** | 免费可商用，量最大 |
| 4 | **yt-dlp 下载** | YouTube 等平台的 CC 许可内容 |

**视频素材搜索关键词**：与图片关键词一致，加 `-videos` 后缀区分存储路径。

```bash
# Pexels Videos 示例（通过 API 或网页搜索）
# 关键词：{从正文提取} + "background" / "technology" / "nature"
```

### 素材管线的执行规则

**不管 Path A 还是 Path C，进入生产前必须确认**：

1. 需要的图片/素材清单已列出（每 2-3 段 1 张图，或每个视频场景 1 个素材）
2. 优先问用户：「你有没有现成的素材？」
3. 按优先级依次搜索，搜到即停
4. 每张图/每个素材记录到 `assets/SOURCES.md`
5. AI 生图只在前 4 级全空时触发

---

## 路径 A：图文生产

> 适用：小红书轮播图 / 公众号文章 / X 图文。不出视频。最终输出 HTML 预览 + Markdown。

### A.1 文案扩写（dbs-content）

把质检后的选题交给 `dbs-content` 扩写成完整文案：

```
调用 dbs-content：
  「基于以下选题和质检结论，扩写一篇小红书/公众号文案」
  选题：{Step 1 的选题}
  钩子：{Step 1.5 优化后的钩子}
  标题：{Step 1.5 优化后的标题}
  平台：{小红书 / 公众号}
```

输出：标题 + 正文 + 分页逻辑（轮播图需要分页）

> ⚠️ 文案完成后，必须跑 **Step 1.6 AI 写作检测闭环**（dbs-ai-check → 修改 → 复检 → 通过），再进入 A.1.5 配图。

### A.1.5 文章配图

> 文字配图，打破纯阅读疲劳。至少每 300-400 字插入一张图。

#### 配图获取流程

```
文案定稿 + AI 检测通过
        ↓
确定配图位置和数量（一般 5-7 张）
        ↓
问用户：配图怎么来？
        ├─ A. 用户自己提供（截图/照片）→ 给出截图清单，等用户交付
        └─ B. AI 生成 → 为每张图写提示词，用户喂给 Gemini/DALL·E 生成
                ↓
        用户说「需要搜免费图片」
                ↓
        ⚠️ 提醒：搜图会大量烧 Token，确认要继续？
                ↓ 用户说「没事儿」
        搜索以下 3 个无版权图库：
          1. https://pixabay.com/
          2. https://unsplash.com/
          3. https://www.pexels.com/
```

#### 两种配图方式

**方式一：用户提供截图（优先）**

给出精确的截图清单：
- 每张截什么界面、什么操作步骤
- 保存路径和文件名（如 `screenshots/01-xxx.png`）
- 图片插入位置已在文章中标注

**方式二：AI 生成界面图**

为每张图写英文提示词，保存到 `screenshots/图片生成提示词.md`：
- 描述界面布局、文字内容、配色风格
- 目标工具：Gemini（gemini.google.com，图片生成模式）
- 用户逐条粘贴生成，保存到对应文件路径

#### 免费图库搜索（备选）

仅当用户明确需要搜索配图且确认烧 Token 后才执行：

| 网站 | URL | 特点 |
|------|-----|------|
| Pixabay | https://pixabay.com/ | 量最大，插画和矢量图多 |
| Unsplash | https://unsplash.com/ | 质最高，摄影风格，适合背景 |
| Pexels | https://www.pexels.com/ | 视频+图片都有，商务场景多 |

搜索方式：用关键词在上述网站搜索 → 筛选 → 下载 → 保存到 `screenshots/` 目录。

### A.2 生成卡片（guizang-social-card-skill）

> 🔴 **硬约束：调用此 skill 前，必须读完以下全部引用文件再写代码。**
>
> 已知失败模式 A：Agent 读 2-3 个引用就动手写 HTML，跳过 layout-recipes / components / style-system，产出无意义的装饰色块而非系统图。用户一眼看出「没读 skill」。
>
> 已知失败模式 B（更常见）：Agent 读完了引用，但**没有拷种子模板**，自己从零写了 HTML 和 CSS。模板自带的全部 class（`.h-statement` / `.card-ink` / `.chrome-min` / `.frame-shot` / `.kpi-tower-row` 等）被丢掉，换成手写的 inline style 和自定义 CSS。结果看起来像「被 Swiss 启发过的普通卡片」，不像 skill 的产出。用户一眼看出「你没用模板」。
>
> **必须读完（缺一不可）：**
> - `references/platform-specs.md` — 尺寸、命名
> - `references/theme-presets.md` — 配色 token
> - `references/title-shortener.md` — 1:1 短标题提取
> - `references/layout-recipes.md` — 布局配方，**决定用什么结构**
> - `references/components.md` — 字体栈、字重映射、Swiss card-fill 互斥规则
> - `references/style-system.md` — Swiss/Editorial 身份测试、反模式清单
>
> **读完后自检：** 能否说出用的是哪个 recipe（如 S01/S08）？右边放的图形是在解释内容还是纯装饰？标题 font-weight 是否 ≤300？
>
> 三个答案都过关，才开始写 HTML。

#### 🔴 执行步骤（逐条照做，不准跳）

**Step A.2.1 — 拷种子模板**
- Swiss → 拷 `assets/template-swiss-card.html` 到任务文件夹，改名为 `index.html`
- Editorial → 拷 `assets/template-editorial-card.html` 到任务文件夹，改名为 `index.html`
- 种子模板路径在 guizang-social-card-skill 目录下：`~/.claude/skills/guizang-social-card-skill/assets/`
- 🚫 **绝对禁止从零写 HTML 或自己写 CSS。** 种子模板已包含全部 class 定义、字体加载、spacing token、card fill 规则。手写 CSS = 违规。

**Step A.2.2 — 设主题**
- Swiss：改 `<html data-accent="ikb | lemon-yellow | lemon-green | safety-orange">`
- Editorial：改 `<html data-theme="ink-classic | indigo-porcelain | forest-ink | kraft-paper | dune | midnight-ink">`

**Step A.2.3 — 填 poster**
- **只动 `<!-- POSTERS_HERE -->` 区域**，不动模板 CSS
- 每个页面一个 `<section class="poster xhs|square|wide" id="...">` 
- 每个 section 内部粘贴 `layout-recipes.md` 中对应 recipe 的 **HTML 骨架**（每个 recipe 都有完整代码块，直接拷）
- 把骨架中的占位文字替换为实际内容
- 如果某一页需要模板没有的组件，在文件末尾加一个 `/* task: <slug> — <reason> */` 注释块，不要改模板核心 class

**Step A.2.4 — 渲染**
- 用 Playwright screenshot 每个 `.poster` 节点
- 输出到 `output/`，命名按 `platform-specs.md` 规范

**Step A.2.5 — 验证（按需）**
- 用户要求核查时跑 `node validate-social-deck.mjs <task-dir>`
- FAIL 必修，WARN 告知用户
- 默认先给用户看图，问「先你自己看还是我自动核查？」

#### 调用格式

```
把文案交给 guizang-social-card-skill：
  小红书：.poster.xhs（1080×1440，3-8 张轮播）
  公众号：.poster.wide（2100×900 头图）+ .poster.square（1080×1080 分享卡）
  X/Twitter：.poster.square（1080×1080）或 .poster.wide（1920×1080，手动设置）
  
  风格：{瑞士国际主义 / 电子杂志风，默认瑞士}
  主题：{让用户选，默认 IKB Klein Blue}
```

### A.3 输出

图文内容完成后，**必须生成 HTML 预览文件**，用户双击即可在浏览器中查看文章 + 配图的完整效果。

#### A.3.1 HTML 预览（必出）

```
article.html                ← 自包含 HTML，同级目录双击打开
  包含：
  - 完整文章（与 Markdown 一致）
  - 所有配图（相对路径，同级打开即可显示）
  - 公众号风格排版（居中 680px、字体 PingFang/雅黑、图带圆角边框）
  - 图片下方灰色 ▲ 标注
```

**HTML 自动打开**：生成后用 `Start-Process` 在默认浏览器打开，用户立即看到成品。

#### A.3.2 其他产出

→ Markdown 原文（`article.md`）  
→ 图片文件（`screenshots/`）  
→ 跳转 Step 6 多平台分发

---

## 路径 B：口播生产

> 适用：对着镜头讲的短视频。用户自己录制画面，AI 负责剪辑和封面。

### B.1 优化口播稿（dbs-hook）

录制前，先把口播稿提交给 `dbs-hook` 优化开场：

```
调用 dbs-hook：
  「优化这段口播的开场白」
  目标：视频号，90s，家长人群
```

### B.1.5 素材准备

口播视频可能需要插入画面素材（产品截图、数据图表、场景空镜等）。

**先问用户**：「你有没有现成的素材？比如产品截图、操作录屏、照片？」

- **有** → 用户提供，直接进入 B.2
- **没有** → 走配图流程（同 A.1.5）：
  - AI 生成：写提示词 → 用户喂 Gemini/DALL·E
  - 搜免费图库：⚠️ 提醒烧 Token → Pixabay / Unsplash / Pexels

素材到位后进入 B.2。

### B.2 口播剪辑（video-use）

> ⚠️ 口播稿完成后，必须跑 **Step 1.6 AI 写作检测闭环**，再进入 B.2 剪辑。

```
调用 video-use：
  「剪辑这段口播视频」
  素材：{用户提供的视频文件 / 刚录制的}
  要求：
  - 去掉空白和口误
  - 开场用 B.1 的优化版钩子
  - 节奏：视频号中速 / 抖音版剪快 20%
  - 时长：{根据目标平台建议}
```

输出：剪辑后的视频（无字幕、无配乐）

### B.3 字幕 + 配乐（video-use）

```
调用 video-use：
  「给这段视频加字幕和背景音乐」
  视频：{B.1 的输出}
  字幕：
  - 自动转写，居中大字
  - 字体 Noto Sans SC（中文）/ Noto Sans JP（日文）
  - 关键字高亮（橙色 #FF6B35）
  配乐：
  - 默认：轻快电子 / Lo-fi（适合教学/知识类口播）
  - 用户指定：{让用户选风格}
  - 音量：-18dB，不盖过人声
  - 片尾 2 秒 fade out
```

> 配乐来源：video-use 内置曲库 / 用户提供 / 推荐 Epidemic Sound / Artlist 等免版税平台

### B.3.5 调色与转场

口播视频加上调色和转场，提升质感。video-use 内置 `grade.py` 工具。

**调色（grade.py）**：

```bash
# 内置预设
python helpers/grade.py <input> -o <output> --preset warm     # 温暖色调，适合个人故事
python helpers/grade.py <input> -o <output> --preset cool     # 冷色调，适合商业/科技
python helpers/grade.py <input> -o <output> --preset film     # 胶片感，适合叙事/生活方式

# 自定义滤镜
python helpers/grade.py <input> -o <output> --filter "eq=brightness=0.02:contrast=1.1:saturation=1.05"
```

**调色推荐**：

| 内容类型 | 推荐预设 | 说明 |
|---------|---------|------|
| 个人故事/经历 | `warm` | 温暖亲近感 |
| 商业/科技/干货 | `cool` | 冷静专业感 |
| 教程/教学 | 不加调色 | 保持自然，不分散注意力 |

**转场**：

video-use 支持标准转场效果。在 B.2 剪辑指令中说明：

```
调用 video-use：
  「剪辑这段口播视频，段落间用 crossfade 转场（0.3s）」


  转场选项：
  - crossfade：段落间淡入淡出，默认 0.3s
  - hard cut：直接切，适合快节奏/抖音版
  - fade to black：段落结束淡黑，适合情绪转折
```

### B.4 生成封面（guizang-social-card-skill）

> ⚠️ 执行规则同 A.2（拷种子→设主题→填 POSTERS_HERE→渲染→验证），不准手写 HTML/CSS。

```
调用 guizang-social-card-skill：
  「给这条口播视频做封面」
  标题：{Step 1.5 优化后的标题}
  风格：瑞士国际主义
  输出：.poster.xhs（1080×1440）或 .poster.square（1080×1080）
```

### B.5 输出

→ 剪辑后的 MP4（含字幕+配乐）+ 封面 PNG  
→ 跳转 Step 6 多平台分发

---

## 路径 C：教学视频生产

> 适用：不需要真人出镜的 AI 教学视频。脚本→配音→画面→导出。

### C.1 Step 2：AI 扩写脚本

#### 前置输入

脚本扩写前必须有 Step 1.5 的质检结论：
- 目标平台 → 决定节奏、画面、字幕风格
- 优化后钩子 → 作为脚本第一句
- 建议标题 → 作为视频封面标题

#### 脚本结构模板

**视频号版**
```
[0-3s 钩子] {Step 2.5 优化后的钩子} + 建立可信度
[3-15s] 痛点共鸣——让目标用户觉得「说的就是我」
[15-75s] 正文——是什么→怎么用→效果，节奏偏慢，说话像在聊天
[75-85s] 总结——一句话说清楚价值
[最后5s CTA]「点赞转发给需要的朋友」
```
> 视频号受众 30+，耐心比抖音高。开头 3s 建立信任比冲击力重要。

**抖音/TikTok 版**
```
[0-1s 视觉钩子] 配合画面冲击
[1-3s 文案钩子] {Step 2.5 优化后的钩子}
[3-40s 正文] 快节奏步骤
[最后3s CTA] "关注我，每天一个AI技巧"
```

**小红书版**
```
[封面标题] {dbs-xhs-title 优化后的标题}
[0-3s] 痛点代入 + {Step 2.5 优化后的钩子}
[3-60s] 清单式讲解，加停顿方便阅读
[最后5s] "点赞收藏，下次好找"
```

**X/Twitter 版**
```
[推文标题] 极简观点
[视频 0-3s] 直接进入核心
[3-30s] 展开论证
[最后] 引导转发
```

#### 素材优先规则

1. kb.snsaladdin.com 已发布的教程/提示词
2. 用户已发布的 X/Twitter 热门推文
3. AI 新生成（仅当前两点无覆盖时）

#### 日文版生成（可选）

- 不是逐字翻译，日语母语者口吻重写
- Hook 本地化（中文梗换日本语境）
- 示例截图用日文版工具界面

> ⚠️ 脚本完成后，必须跑 **Step 1.6 AI 写作检测闭环**，再进入 C.1.4 素材准备。

---

### C.1.4 素材准备

教学视频的画面来源。**先问用户**：

```
你有没有现成的素材？
比如：产品截图、操作录屏、数据图表、现场照片
```

- **有素材** → 用户提交，整理到 `projects/YYYY-MM-DD/assets/`，进入 C.1.5
- **没有素材** → 走配图流程（同 A.1.5）：
  - AI 生成画面提示词 → 用户喂 Gemini/DALL·E
  - 搜免费图库：⚠️ 提醒烧 Token → Pixabay / Unsplash / Pexels
  - 教学视频额外推荐：用 NotebookLM / ChatGPT 生成示意图和流程图

素材就位后进入 C.1.5 钩子优化。

---

### C.1.5 Step 2.5：钩子优化（dbs-hook）

脚本写完后，提交给 `dbs-hook` 优化前 3-5 秒开头：

```
调用 dbs-hook：
  把脚本发给它
  「优化这条视频的开头钩子，平台：视频号/抖音/小红书」
```

dbs-hook 基于脚本内容生成 10-15 条优化方案 → 让用户选最佳的 → 替换脚本开头。

> 为什么不放在 Step 1.5？因为开头必须基于已写好的脚本内容。没有脚本，优化开头是没有意义的。

---

### C.2 Step 3：Edge-TTS 配音

> 2026-05-30 从 ElevenLabs 切换。ElevenLabs 中文质量差（像老外说中文），Edge-TTS 完全免费、50+ 中文音色、MOS 4.2/5。

**安装**：
```bash
pip install edge-tts
```

**配音代码**：
```python
import asyncio
from edge_tts import Communicate

async def generate_voiceover(script_text, output_path, voice="zh-CN-XiaoxiaoNeural", rate="-10%"):
    """生成中文配音。默认用 Xiaoxiao（女声·自然），教学场景语速 -10%。"""
    communicate = Communicate(
        text=script_text,
        voice=voice
    )
    await communicate.save(output_path)

# 使用
asyncio.run(generate_voiceover(script_text, "output/voiceover.mp3"))
```

**音色选择**：

| 场景 | 音色 ID | 性别 | 风格 |
|------|---------|:--:|------|
| 教学视频（默认） | `zh-CN-XiaoxiaoNeural` | 女 | 标准自然，不抢戏 |
| 口播/短视频 | `zh-CN-XiaoyiNeural` | 女 | 年轻活泼 |
| 商业/正式 | `zh-CN-YunyangNeural` | 男 | 新闻播音 |
| 有声读物 | `zh-CN-YunyeNeural` | 男 | 温柔叙事 |

**高级控制（可选）**：

Edge-TTS 支持 SSML 精细控制：语速、音调、情感、停顿。

```python
ssml = '''
<speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis">
    <voice name="zh-CN-XiaoxiaoNeural">
        <prosody rate="-10%" pitch="+0%">
            这里是配音正文。
        </prosody>
        <break time="500ms"/>
        <prosody rate="+10%">
            这是加快的句子。
        </prosody>
    </voice>
</speak>
'''
communicate = Communicate(text=ssml, voice="zh-CN-XiaoxiaoNeural")
await communicate.save("output/voiceover.mp3")
```

支持的情感风格：`cheerful` / `sad` / `angry` / `excited` / `friendly` / `hopeful` / `terrified` / `whispering`

**注意事项**：
- 单次请求约 4000 字符上限，长脚本分段处理
- 需要联网（调用微软 Edge 语音服务）
- 完全免费，无需 API Key
- 语速默认 1.0，教学视频建议 rate="-10%"
- 脚本中 `[pause]` 标记处用 `<break time="500ms"/>` 替换

---

### C.3 Step 4：风格选择 + 组装 Hyperframes 画面

#### 4.0 风格推荐（必须交互）

脚本 + 配音完成后，**问 2 个问题**，然后自动推荐风格：

**问题 1：你的内容是什么类型？**
```
A. 教程/操作演示 — 分步骤教别人做一件事
B. 产品测评/对比 — A vs B，哪个好
C. 观点/认知输出 — 讲一个道理或方法
D. 故事/案例讲述 — 讲一个人或一件事的经历
```

**问题 2：想要什么感觉？**
```
A. 干净专业 — 科技公司发布会感，简洁利落
B. 温暖亲切 — 朋友聊天感，不冷冰冰
C. 高级冷淡 — 杂志大片感，有距离感的审美
D. 我不知道 / 你帮我推荐
```

#### 4.1 风格匹配表

根据回答自动匹配：

| 内容 | 感觉 | → 风格名 | 配色 | 字体 | 适合 |
|------|------|---------|------|------|------|
| 教程 | 干净 | **Swiss Tech** | 黑底 `#0a0a0b` + 橙强调 `#FF6B35` | 无衬线 | 软件教学、AI工具 |
| 教程 | 温暖 | **Warm Guide** | 米白底 `#faf7f2` + 暖赭 `#C7512E` | 衬线 | 生活技巧、亲子教育 |
| 教程 | 高级 | **Swiss Grid** | 白底 + 黑 + IKB蓝 `#002FA7` | 无衬线 | 专业课程、企业培训 |
| 测评 | 干净 | **Swiss Grid** | 白底 + 黑 + IKB蓝 | 无衬线 | 工具测评、数码产品 |
| 测评 | 温暖 | **Warm Compare** | 奶油底 + 深棕 + 金 | 衬线 | 生活方式、美食 |
| 测评 | 高级 | **Editorial Dark** | 深底 `#1c1c2e` + 金 `#d4a04a` | 衬线 | 高端产品、奢侈品 |
| 观点 | — | **Editorial Dark** | 深底 + 金 + 白 | 衬线 | 商业思考、认知输出 |
| 故事 | — | **Kraft Paper** | 牛皮纸 `#eedfc7` + 深棕 | 衬线 | 人物故事、品牌叙事 |
| 不确定 | — | **Swiss Tech**（默认） | 黑底 + 橙 | 无衬线 | 百搭安全 |

> 用户说「我不知道」→ 默认 **Swiss Tech**，解释：「黑底+橙色强调+无衬线，最百搭的组合。Apple 发布会也是这个路子。先用这个做，不满意再换。」

#### 4.2 风格确认后的操作

Claude 按匹配的风格写 **一个** Hyperframes composition HTML（单文件，包含所有场景段落），遵循：

| 要素 | 规范 |
|------|------|
| 字体 | Chinese: `Noto Sans SC` / Japanese: `Noto Sans JP` + `Noto Serif JP` |
| 配色 | 按匹配的风格表 |
| 尺寸 | 抖音 1080×1920 / 小红书 1080×1440 / 视频号 1080×1920 / X 1920×1080 |
| 品牌栏 | 每段底部 60px「SNS Aladdin | kb.snsaladdin.com」 |
| 动画 | GSAP `from()` 入场，段落间淡入淡出 |

#### 4.3 自动拼入社区组件

写完主 composition 后，**自动安装并嵌入以下基础组件**（不需要用户选）：

```bash
npx hyperframes add grain-overlay      # 胶片质感
npx hyperframes add vignette           # 暗角聚焦
npx hyperframes add caption-pill-karaoke  # 卡拉OK字幕
npx hyperframes add grid-pixelate-wipe    # 段落转场
npx hyperframes add logo-outro            # 片尾
```

嵌入方式：
- `grain-overlay` + `vignette` → 全局 CSS overlay
- `caption-pill-karaoke` → 粘贴到需要字幕的段落
- `grid-pixelate-wipe` → 段落之间切换时触发
- `logo-outro` → 最后一个段落，**替换文字为品牌信息**（AI知識庫 / SNS Aladdin / kb.snsaladdin.com）

#### 4.4 构建与渲染

1. 写 composition HTML（单文件含全部场景）
2. 嵌入社区组件
3. `npm run check` → 验证

> ✋ **阻断检查**：以下 **6 条全部为「是」** 才能执行 `npm run render`。
>
> | # | 检查项 | 确认 |
> |---|--------|:--:|
> | 1 | Step 4.3 五个组件已安装（grain / vignette / caption-pill-karaoke / grid-pixelate-wipe / logo-outro） | ⬜ |
> | 2 | composition HTML 中已嵌入上述组件 | ⬜ |
> | 3 | 素材（截图/照片）已复制到 hyperframes 项目目录 | ⬜ |
> | 4 | 素材已在 composition 对应场景中以 `<img>` 引用 | ⬜ |
> | 5 | `npm run check` 0 errors | ⬜ |
> | 6 | 配音文件 voiceover.mp3 已存在于项目 output 目录 | ⬜ |
> | 7 | GSAP 动画已验证：每个 composition 模板的 `<script>` 块中 `window.__timelines` 已注册，`data-start` / `data-duration` 属性已设置 | ⬜ |
>
> 任何一条为「否」→ **停止，补上后再渲染。**
>
> **GSAP 动画关键**（Hyperframes 渲染时动画正确播放的必要条件）：
> - 每个动画元素必须有 `data-start`（秒）和 `data-duration`（秒）属性
> - 所有 GSAP timeline 必须注册到 `window.__timelines` 数组
> - 模板内置的 `tutorial-step.html` 等 composition 已包含正确的 GSAP 入场动画（`paused: true`，渲染引擎自动播放）
> - 🚫 **禁止用静态 `<img>` 替代 composition 模板**——那是假动画。必须用 Hyperframes composition HTML + GSAP

4. `npm run render` → MP4 输出

> 参考：`templates/hyperframes/brand-guide.md`（品牌规范细节）、Hyperframes 官方文档 https://hyperframes.heygen.com/introduction

---

### C.4 Step 5：导出

```powershell
ffmpeg -i video_render.mp4 -i voiceover.mp3 `
  -c:v libx264 -preset medium -crf 23 `
  -c:a aac -b:a 128k -shortest `
  "projects/$(Get-Date -Format 'yyyy-MM-dd')/<文件名>.mp4"
```

| 参数 | 值 |
|------|-----|
| 分辨率 | 1920×1080（竖版 1080×1920） |
| 编码 | H.264, 30fps |
| 音频 | AAC 128kbps |
| 输出 | `projects/YYYY-MM-DD/` |

### C.5 生成封面（guizang-social-card-skill）

> ⚠️ 执行规则同 A.2（拷种子→设主题→填 POSTERS_HERE→渲染→验证），不准手写 HTML/CSS。

导出视频后，生成各平台封面图：

```
调用 guizang-social-card-skill：
  「给这条教学视频做封面」
  标题：{Step 1.5 优化后的标题 / 脚本大标题}
  视觉：{从视频中截取代表画面 或 AI 生成}
  输出：
  - .poster.xhs（1080×1440，小红书封面）
  - .poster.square（1080×1080，X/B站/YouTube 封面）
  风格：瑞士国际主义 / 电子杂志风
```

> 教学视频的封面尤其重要——它是用户在小红书/X/YouTube 上看到的唯一东西。标题 + 一个强烈的视觉元素 + 品牌色。

---

## 平台适配矩阵（全部路径通用）

| 维度 | 视频号 | 抖音 / TikTok | 小红书 | X / Twitter |
|------|--------|-------------|--------|-------------|
| **受众** | 30+ 职场人 | 泛人群、年轻 | 爱学习、收藏党 | 科技/创投圈 |
| **节奏** | 中等，3s 建立信任 | 极快，1s 抓注意力 | 中等，适合阅读 | 快，文字为主 |
| **钩子位置** | 前 3s | 第 1 秒 | 封面+前 3 秒 | 推文第一行 |
| **标题风格** | 信息量+专业感 | 口语+emoji | 公式化（75模板） | 极简观点 |
| **画面** | 9:16 或 16:9 | 9:16 竖版 | 3:4 或 1:1 | 16:9 或 1:1 |
| **字幕** | 必须，适中 | 必须，居中大字 | 必须，底部适中 | 可选 |
| **CTA** | "点赞转发" | "关注我" | "点赞收藏" | "转发" |

---

## Step 6：多平台分发

> 三条路径的产出最终都汇集到这里。

### 各路径产出物

| 路径 | 产出 | 分发方式 |
|------|------|---------|
| A 图文 | article.md + PNG 图片集 | sau CLI（小红书图文）/ wewrite（公众号草稿箱） |
| B 口播 | MP4（含字幕+配乐） + PNG 封面 | sau CLI（短视频平台） |
| C 教学 | MP4 视频 + PNG 封面 | sau CLI（短视频平台） |

### 分发后端总览

```
Step 6 多平台分发
├── sau CLI（social-auto-upload）           ← 短视频平台
│   ├── 抖音 / 小红书 / 快手 / Bilibili
│   └── 视频 + 图文轮播
│
└── wewrite CLI（公众号全流程）              ← 公众号
    ├── publish article.md → 微信草稿箱
    ├── preview article.md → 微信兼容 HTML（降级预览）
    └── image-post → 小绿书（图片轮播帖）
```

### 支持平台

| 平台 | 图文 | 视频 | 标题来源 | 后端 |
|------|:--:|:--:|---------|------|
| 抖音 | - | 竖版 MP4 | 口语化标题 | `sau douyin` |
| TikTok | - | 竖版 MP4 | 英文/日文标题 | `sau tiktok` |
| 小红书 | 轮播图 | 竖版 MP4 | dbs-xhs-title 公式标题 | `sau xiaohongshu` |
| 公众号 | 文章 / 小绿书 | - | dbs-xhs-title | `wewrite` |
| Bilibili | - | 16:9 MP4 | 信息量标题 | `sau bilibili` |
| 快手 | - | 竖版 MP4 | 口语化标题 | `sau kuaishou` |
| X/Twitter | 单图 | 1:1 MP4 | 极简观点 | 未接入 |
| YouTube Shorts | - | 竖版 MP4 | 英文/日文标题 | 未接入 |

### 公众号分发方式

> Path A（图文）产出 `article.md` 后，自动走以下流程：

| 模式 | 命令 | 说明 |
|------|------|------|
| 推送到草稿箱 | `wewrite publish` | Markdown → 微信 HTML → 草稿箱，需微信 appid/secret |
| 本地预览 | `wewrite preview` | Markdown → 微信兼容 HTML，浏览器打开（无需凭证） |
| 小绿书 | `wewrite image-post` | 图片轮播帖（1-20 张），推送到草稿箱 |

#### 前置：安装与配置 wewrite

```powershell
# 安装（首次）
git clone --depth 1 https://github.com/oaker-io/wewrite.git ~/.claude/skills/wewrite
pip install -r ~/.claude/skills/wewrite/requirements.txt

# 配置微信凭证 → ~/.config/wewrite/config.yaml
# wechat:
#   appid: "wx_your_appid"
#   secret: "your_appsecret"
#   author: "SNS Aladdin"
# theme: "professional-clean"
```

#### wewrite CLI 命令

> ⚠️ Windows 需设 `$env:PYTHONUTF8=1; $env:PYTHONIOENCODING='utf-8'`（解决 CJK 编码问题）。
> wewrite 配置文件搜索顺序：CWD → skill 根目录 → `~/.config/wewrite/config.yaml`

```powershell
# 安装路径
$wewrite = "$env:USERPROFILE\.claude\skills\wewrite\toolkit\cli.py"

# 查看可用主题（16 套）
$env:PYTHONUTF8=1; python $wewrite themes

# 预览：Markdown → 公众号 HTML，浏览器打开
$env:PYTHONUTF8=1; python $wewrite preview article.md --theme professional-clean

# 发布：推送到微信草稿箱
$env:PYTHONUTF8=1; python $wewrite publish article.md `
  --cover cover.png `
  --theme professional-clean `
  --title "文章标题" `
  --digest "摘要 ≤120 字节"

# 小绿书：图片轮播帖（第 1 张为封面，最多 20 张）
$env:PYTHONUTF8=1; python $wewrite image-post img1.jpg img2.jpg img3.jpg `
  -t "帖子标题（≤32 字）" `
  -c "文字描述"
```

#### 公众号降级方案

| 情况 | 处理 |
|------|------|
| 未配置微信 appid/secret | 自动降级为 `preview` 模式，生成 HTML 在浏览器打开 |
| preview 生成失败 | 回退到 A.3 自包含 HTML（当前方案） |
| 图片上传失败 | 警告，继续推送（微信会显示默认封面） |
| 用户说「只要预览」 | 只跑 `preview`，不推草稿箱 |

#### 推荐排版主题（按品类自动匹配）

| 品类 | 推荐主题 | 风格说明 |
|------|---------|---------|
| 职场/干货/商业 | `bold-navy` | 深蓝专业感 |
| AI 工具教程 | `bytedance` / `tech-modern` | 科技简洁 |
| 产品测评/数码 | `tech-modern` | 干净利落 |
| 旅行/生活方式 | `warm-editorial` | 温暖有人情味 |
| 美食/食谱 | `warm-editorial` | 暖色烟火气 |
| 读书/笔记 | `ink` / `newspaper` | 印刷品质感 |
| 影视/文化 | `midnight` / `sspai` | 暗调深度 |
| 个人故事/经历 | `elegant-rose` / `warm-editorial` | 温暖叙事 |
| 教程/How-to | `professional-clean` | 清晰结构 |
| 通用/默认 | `professional-clean` | 百搭 |

---

### sau CLI 命令（短视频平台）

> 使用 social-auto-upload (`sau`) CLI。安装路径：`~/social-auto-upload`，激活：`source .venv/Scripts/activate`（Windows）或 `source .venv/bin/activate`（Linux）。

#### 前置：登录账号（首次使用）

```bash
cd ~/social-auto-upload && source .venv/Scripts/activate

# 各平台登录（交互式，需要扫码或手动操作）
sau douyin login --account <账号名>
sau tiktok login --account <账号名>
sau xiaohongshu login --account <账号名>
sau kuaishou login --account <账号名>
sau bilibili login --account <账号名>
```

#### 检查登录状态

```bash
sau douyin check --account <账号名>
sau xiaohongshu check --account <账号名>
```

#### 上传视频

```bash
sau douyin upload --account <账号名> --file <视频路径.mp4> --title "<标题>" --tags "AI,教程"
sau tiktok upload --account <账号名> --file <视频路径.mp4> --title "<标题>" --tags "AI,tutorial"
sau xiaohongshu upload --account <账号名> --file <视频路径.mp4> --title "<标题>" --tags "AI,效率"
sau kuaishou upload --account <账号名> --file <视频路径.mp4> --title "<标题>"
sau bilibili upload --account <账号名> --file <视频路径.mp4> --title "<标题>" --tags "AI,教程"
```

#### 定时发布

```bash
sau douyin upload --account <账号名> --file <视频路径.mp4> --title "<标题>" --schedule "2026-06-01 20:00"
```

### 分发规则

- 用户说「发到全平台」→ Path A（图文）发小红书+公众号；Path B/C（视频）发抖音+小红书+快手+B站
- 用户说「发到<平台名>」→ 单平台
- 用户说「发公众号」/「发到草稿箱」→ 走 wewrite publish
- 用户说「做小绿书」→ 走 wewrite image-post
- 发布前确认标题
- 发布后报结果：「抖音 ✓ / 小红书 ✓ / 公众号 ✓ / B站 ✓ / TikTok ⚠ 需手动确认」

### 支持平台（当前）

| 平台 | CLI | 视频 | 图文 | 定时 | 后端 |
|------|:--:|:--:|:--:|:--:|------|
| 抖音 | `sau douyin` | ✅ | ✅ | ✅ | sau |
| 小红书 | `sau xiaohongshu` | ✅ | ✅ | ✅ | sau |
| 快手 | `sau kuaishou` | ✅ | ✅ | ✅ | sau |
| Bilibili | `sau bilibili` | ✅ | ❌ | ✅ | sau |
| 公众号 | `wewrite` | — | ✅ | ❌ | wewrite |
| TikTok | `sau tiktok` | ✅ | ❌ | ✅ | sau |
| X/Twitter | 未接入 | — | — | — | — |
| YouTube | 未接入 | — | — | — | — |

---

## 批量生产模式

```
选题列表 → 逐条质检 → 逐条分支选择 → 逐条生产 → 逐条分发
```

每完成一个报进度：「5/10 完成：[C] ChatGPT 注册教程 (2:43)，抖音 ✓」

---

## 扩展指令速查

| 指令 | 效果 |
|------|------|
| 「只做质检」 | 只跑 Step 1.5，不生产 |
| 「做小红书图文」 | 质检后自动走路径 A |
| 「录个口播」 | 质检后自动走路径 B |
| 「做教学视频」 | 质检后自动走路径 C |
| 「出双语版」 | 额外生成日文版 |
| 「发到全平台」 | Step 6 一键分发 |
| 「批量生产」 | 选题列表依次执行 |
| 「发到 X」「发到小红书」 | 跨平台再发布模式 ↓ |

---

## 跨平台再发布模式

> 客户已有一篇文章发布在某平台，想适配到其他平台。**不需要重新选题·质检·生产**，直接从已有文章出发。

### 触发条件

- 用户说「把这篇发到 X」「小红书也发一份」「公众号的文章改一下发 X」
- 已有产物：`article.md` + 某平台的已渲染图片

### 流程

```
已有 article.md
       ↓
Step R1：确认源平台 + 目标平台
       ↓
Step R2：文字适配（压缩/分页/改语气）
       ↓
Step R3：选 recipe + 图尺寸
       ↓
Step R4：按 A.2 流程生成卡片（拷种子→填 POSTERS_HERE→渲染）
       ↓
Step R5：分发（能自动发的自动发，不能的手动给文案+图）
```

### R1：平台差异速查

| 目标平台 | 比例 | poster class | 推荐页数 | 文字风格 | 发布后端 |
|---------|------|-------------|---------|---------|---------|
| 小红书 | 3:4 | `.poster.xhs` | 5-8 张 | 口语+emoji+分页 | `sau xiaohongshu` |
| 公众号 | 21:9+1:1 | `.poster.wide`+`.poster.square` | 封面对 | 信息量+专业感 | `wewrite` |
| X/Twitter | 1:1 或 16:9 | `.poster.square` | 1 张 | 极简观点 | 未接入，手动 |
| TikTok | 9:16 视频 | — | — | 极快口语 | `sau tiktok` |

### R2：文字适配规则

| 源→目标 | 操作 |
|---------|------|
| 公众号长文→X | 提取核心观点（≤280 字），一句 hook + 一句解释 |
| 公众号长文→小红书 | 按 `content-planning.md` 分页，每页一个观点，5-8 页 |
| 小红书→X | 封面句直接用作推文，配 1:1 图 |
| 任何→公众号 | 补回完整长文，生成 21:9 主封面 + 1:1 短标题方封面 |

### R3：Recipe 推荐

按 `layout-recipes.md` 选。跨平台适配**不换风格模式**（源是 Swiss 就继续 Swiss），只换 recipe 和画板尺寸。

### R4：生成

**规则同 A.2**——拷种子模板、设主题、填 POSTERS_HERE、渲染。不准手写 HTML/CSS。
