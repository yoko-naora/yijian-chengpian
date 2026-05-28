# 日常生产工作流

## 完整流水线

```
Step 1       Step 1.5      Step 1.6         ──────── 三条生产路线 ────────       Step 6
输入选题  →  内容质检  →  内容类型分支  ─┬─ A 图文 → 文案+卡片 ──────────→ 多平台分发
                                         ├─ B 口播 → 剪辑+封面 ──────────→ 多平台分发
                                         └─ C 教学 → 脚本→配音→模板→导出 → 多平台分发
```

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

## Step 1.6：内容类型分支

> **必须交互，不能跳过。** 质检通过后让用户选择生产路线。

```
这条内容做什么形式？

A. 图文 — 小红书轮播图 / 公众号封面（不用拍视频）
B. 口播 — 对着镜头讲，需要剪辑（不用做动画）
C. 教学 — AI 自动生成画面 + 配音的教学视频
```

| 分支 | 调用的 Skill | 成品 | 跳转 |
|------|-------------|------|------|
| **A 图文** | dbs-content → guizang-social-card-skill | 小红书图文 / 公众号 21:9+1:1 | ↓ 路径 A |
| **B 口播** | video-use（字幕+配乐+剪辑）→ guizang-social-card-skill（封面） | 口播短视频 + 封面 | ↓ 路径 B |
| **C 教学** | ElevenLabs → Hyperframes → FFmpeg → guizang-social-card-skill（封面） | AI 教学视频 + 封面 | ↓ 路径 C |

用户如果已经说了形式（如「做一期小红书图文」），自动跳过此步直接进入对应路径。

---

## 路径 A：图文生产

> 适用：小红书轮播图 / 公众号封面图。不出视频。

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

### A.2 生成卡片（guizang-social-card-skill）

把文案交给 `guizang-social-card-skill`，指定输出格式：

```
调用 guizang-social-card-skill：
  「用这段文案做一套图文卡片」
  
  小红书：.poster.xhs（1080×1440，3-8 张轮播）
  公众号：.poster.wide（2100×900 头图）+ .poster.square（1080×1080 分享卡）
  
  风格：{瑞士国际主义 / 电子杂志风，默认瑞士}
  主题：{让用户选，默认 IKB Klein Blue}
```

### A.3 输出

→ 图片文件路径  
→ 跳转 Step 6 多平台分发

---

## 路径 B：口播生产

> 适用：对着镜头讲的短视频。用户自己录制画面，AI 负责剪辑和封面。

### B.1 口播剪辑（video-use）

```
调用 video-use：
  「剪辑这段口播视频」
  素材：{用户提供的视频文件 / 刚录制的}
  要求：
  - 去掉空白和口误
  - 按 Step 1.5 的钩子优化开头
  - 节奏：抖音版剪快 20%
  - 时长：{根据目标平台建议}
```

输出：剪辑后的视频（无字幕、无配乐）

### B.2 字幕 + 配乐

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

### B.3 生成封面（guizang-social-card-skill）

```
调用 guizang-social-card-skill：
  「给这条口播视频做封面」
  标题：{Step 1.5 优化后的标题}
  风格：瑞士国际主义
  输出：.poster.xhs（1080×1440）或 .poster.square（1080×1080）
```

### B.4 输出

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

**抖音/TikTok 版**
```
[0-1s 视觉钩子] 配合画面冲击
[1-3s 文案钩子] {质检优化后的钩子}
[3-40s 正文] 快节奏步骤
[最后3s CTA] "关注我，每天一个AI技巧"
```

**小红书版**
```
[封面标题] {dbs-xhs-title 优化后的标题}
[0-3s] 痛点代入
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

---

### C.2 Step 3：ElevenLabs 配音

```python
from elevenlabs import generate, save, set_api_key
import os

set_api_key(os.environ["ELEVENLABS_API_KEY"])

audio = generate(
    text=script_text,
    voice="Rachel",
    model="eleven_multilingual_v2"
)
save(audio, "output/voiceover.mp3")
```

- 中文选 multilingual v2，不是 monolingual
- 语速默认 1.0，教学视频调到 0.9
- 脚本中 `[pause]` 标记自然停顿

---

### C.3 Step 4：Hyperframes 模板选择

#### 4.0 模板选择（必须交互）

```
📺 选视频画面模板：

【内置模板 — 教学场景】
A. 教程步骤 — Step 1→2→3 分步讲解，步骤编号+标题+说明
B. 概念讲解 — 大标题+正文+高亮BOX，适合抽象概念
C. 工具对比 — 左右双栏PK+VS徽章+结论，适合A vs B
D. 清单技巧 — 编号列表逐条弹出，适合技巧合集

【Hyperframes 社区 — 增强组件】
E. 查看社区模板 — 运行 npx hyperframes catalog 浏览 45+ 组件

【自定义】
F. 描述你想要的风格，我现场生成一个新模板
G. 帮我自动选
```

- A-D → 内置品牌模板，填入脚本内容，末尾追加 `outro.html`
- E → 运行 `npx hyperframes catalog` → 用户挑选 → `npx hyperframes add <name>`
- F → 根据用户描述当场写 Hyperframes composition HTML
- G → 根据内容类型自动匹配

#### 4.1 内置模板（5个）

`templates/hyperframes/compositions/` 中的品牌模板。

| 模板 | 文件 | 布局 | 适用 |
|------|------|------|------|
| 教程步骤 | `tutorial-step.html` | Step N + 标题 + 説明文 | 操作教学、分步演示 |
| 概念讲解 | `explainer.html` | 标签 + 大标题 + 正文 + 強調BOX | 抽象概念、方法论 |
| 工具对比 | `comparison.html` | 左右双栏 + VS 圆徽章 + 结论 | A vs B 对比测评 |
| 清单技巧 | `listicle.html` | 编号列表 stagger 逐条弹出 | 技巧合集、Top N |
| 片尾CTA | `outro.html` | Logo + 关注按钮 + URL | **所有视频末尾 3-5 秒** |

#### 4.2 社区模板（Hyperframes Registry）

用户运行 `npx hyperframes catalog` 可浏览安装 45+ 组件：

| 类别 | 数量 | 例 |
|------|------|-----|
| 数据可视化 | 8 | 柱状图、美国地图、世界地图、流程图 |
| 字幕特效 | 12 | 卡拉OK、霓虹发光、毛刺故障、矩阵解码 |
| 社交媒体 | 6 | Instagram/TikTok/YouTube/X 关注卡片 |
| 转场效果 | 4 | 像素化擦除、波纹燃烧、快速摇镜 |
| 质感叠加 | 4 | 胶片颗粒、微光扫描、暗角 |
| 品牌展示 | 1 | Logo 电影感片尾 |

安装方式：`npx hyperframes add <block-name>`

#### 4.3 自定义模板

用户描述需求 → Claude 当场写 Hyperframes composition HTML → 用户确认 → 使用。  
生成时遵循 `templates/hyperframes/brand-guide.md` 的品牌规范。

#### 4.4 品牌规范（全模板遵守）

- 字体：中文 `Noto Sans SC` / 日文 `Noto Sans JP` + `Noto Serif JP`
- 配色：背景 `#0a0a0b` / 文字 `#f1efea` / 强调 `#FF6B35` / 绿 `#2e7d32`
- 品牌栏：每页底部 60px「SNS Aladdin | kb.snsaladdin.com」
- 画面：抖音 1080×1920 / 小红书 1080×1440 / X・YouTube 1920×1080

#### 4.5 字幕（二选一）

**方案一：Hyperframes 字幕组件（推荐）**
`npx hyperframes add caption-pill-karaoke` 等 12 种社区字幕组件。
字幕作为画面的一部分渲染，与画面完美同步。

**方案二：FFmpeg 烧录字幕**
渲染后手动生成 SRT → FFmpeg 烧录。灵活但多一步。

```powershell
ffmpeg -i video.mp4 -vf "subtitles=subs.srt:force_style='FontName=Noto Sans SC,FontSize=28,PrimaryColour=&H00FFFFFF,Outline=2'" -c:v libx264 -c:a copy output.mp4
```

#### 4.6 配乐

在 Hyperframes composition 中添加 `<audio>` 元素作为背景音乐轨道：

```html
<audio src="assets/bgm.mp3" data-start="0" data-duration="60"
       data-track-index="10" volume="0.15" loop></audio>
```

或渲染后用 FFmpeg 混音：

```powershell
ffmpeg -i video.mp4 -i bgm.mp3 -filter_complex "[1:a]volume=0.15[a1];[0:a][a1]amix=inputs=2:duration=first" -c:v copy output.mp4
```

> 配乐来源：用户提供 / Hyperframes 内置 / Epidemic Sound / Artlist / Uppbeat（免版税）

#### 4.7 构建与渲染

1. 选好模板 → 填入脚本文字 → 调整 `data-duration`
2. 加入字幕组件 + 配乐轨道
3. 末尾追加 `outro.html`（3-5 秒 CTA）
4. `npm run check` → 验证
5. `npm run render` → MP4 输出
6. 多段用 FFmpeg 拼接

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

| 维度 | 抖音 / TikTok | 小红书 | X / Twitter |
|------|-------------|--------|-------------|
| **节奏** | 极快，1s 抓注意力 | 中等，适合阅读 | 快，文字为主 |
| **钩子位置** | 第 1 秒 | 封面+前 3 秒 | 推文第一行 |
| **标题风格** | 口语+emoji | 公式化（75模板） | 极简观点 |
| **画面** | 9:16 竖版 | 3:4 或 1:1 | 16:9 或 1:1 |
| **字幕** | 必须，居中大字 | 必须，底部适中 | 可选 |
| **CTA** | "关注我" | "点赞收藏" | "转发" |

---

## Step 6：多平台分发

> 三条路径的产出最终都汇集到这里。

### 各路径产出物

| 路径 | 产出 | 分发方式 |
|------|------|---------|
| A 图文 | PNG 图片集 | social-media-auto-publish（图文模式） |
| B 口播 | MP4（含字幕+配乐） + PNG 封面 | social-media-auto-publish（视频模式） |
| C 教学 | MP4 视频 + PNG 封面 | social-media-auto-publish（视频模式） |

### 支持平台

| 平台 | 图文 | 视频 | 标题来源 |
|------|:--:|:--:|---------|
| 抖音 | - | 竖版 MP4 | 口语化标题 |
| TikTok | - | 竖版 MP4 | 英文/日文标题 |
| 小红书 | 轮播图 | 竖版 MP4 | dbs-xhs-title 公式标题 |
| 公众号 | 21:9+1:1 | - | dbs-xhs-title |
| Bilibili | - | 16:9 MP4 | 信息量标题 |
| 快手 | - | 竖版 MP4 | 口语化标题 |
| X/Twitter | 单图 | 1:1 MP4 | 极简观点 |
| YouTube Shorts | - | 竖版 MP4 | 英文/日文标题 |

### 分发规则

- 用户说「发到全平台」→ 按产出类型自动匹配所有平台
- 用户说「发到<平台名>」→ 单平台
- 发布前确认标题
- 发布后报结果：「抖音 ✓ / 小红书 ✓ / X ✓ / TikTok ⚠ 需手动确认」

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
