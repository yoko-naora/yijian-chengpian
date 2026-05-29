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

### B.1 优化口播稿（dbs-hook）

录制前，先把口播稿提交给 `dbs-hook` 优化开场：

```
调用 dbs-hook：
  「优化这段口播的开场白」
  目标：视频号，90s，家长人群
```

### B.2 口播剪辑（video-use）

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

### B.4 生成封面（guizang-social-card-skill）

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

### CLI 命令

> 使用 social-auto-upload (`sau`) CLI。安装路径：`~/social-auto-upload`，激活：`source .venv/Scripts/activate`（Windows）或 `source .venv/bin/activate`（Linux）。

#### 前置：登录账号（首次使用）

```bash
cd ~/social-auto-upload && source .venv/Scripts/activate

# 各平台登录（交互式，需要扫码或手动操作）
sau douyin login --account <账号名>
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
sau xiaohongshu upload --account <账号名> --file <视频路径.mp4> --title "<标题>" --tags "AI,效率"
sau kuaishou upload --account <账号名> --file <视频路径.mp4> --title "<标题>"
sau bilibili upload --account <账号名> --file <视频路径.mp4> --title "<标题>" --tags "AI,教程"
```

#### 定时发布

```bash
sau douyin upload --account <账号名> --file <视频路径.mp4> --title "<标题>" --schedule "2026-06-01 20:00"
```

### 支持平台（当前）

| 平台 | CLI | 视频 | 图文 | 定时 |
|------|:--:|:--:|:--:|:--:|
| 抖音 | `sau douyin` | ✅ | ✅ | ✅ |
| 小红书 | `sau xiaohongshu` | ✅ | ✅ | ✅ |
| 快手 | `sau kuaishou` | ✅ | ✅ | ✅ |
| Bilibili | `sau bilibili` | ✅ | ❌ | ✅ |
| TikTok | 未接入 | — | — | — |
| X/Twitter | 未接入 | — | — | — |
| YouTube | 未接入 | — | — | — |

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
