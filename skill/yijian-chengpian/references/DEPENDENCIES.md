# 子 Skill 依赖清单

> 最后更新：2026-05-30
> 用途：子 skill 更新时，对着这份清单 diff，快速判断哪些新功能可以接、哪些改动可能影响我们。

---

## 1. guizang-social-card-skill — 社交卡片

**路径**：`~/.claude/skills/guizang-social-card-skill/`
**仓库**：`https://github.com/op7418/guizang-social-card-skill`
**版本**：`v0.14` | **更新**：2026-05-28 | **我们接入**：2026-05-30
**我们的调用位置**：Path A.2（图文卡片）、Path B.4（口播封面）、Path C.5（教学封面）

### 功能清单

| 功能 | 使用 | 备注 |
|------|:--:|------|
| 2 套视觉系统（Swiss / Editorial） | ✅ | 品类路由自动匹配 |
| 28 个版式 recipe（S01-S12 / M01-M16） | ✅ | 每个品类绑定 recipe 序列 |
| 10 套主题色板（4 accent + 6 theme） | ✅ | 品类路由自动匹配 |
| 3 个画板尺寸（3:4 / 1:1 / 21:9） | ✅ | 小红书 + X + 公众号 |
| 11 品类路由 | ✅ | category-cookbook.md，生产流程入口 |
| 种子模板（拷→填 POSTERS_HERE） | ✅ | A.2 硬约束 |
| 3 个免费图库自动搜图（Pexels / Unsplash / Wallhaven） | ⚠️ | 规则已写入 production.md，实际调用未测试 |
| 文字压图 3 步法（主体识别→明度→字号） | ⚠️ | 规则已写入，未逐卡测试 |
| 截图美化四件套（设备框+材质+阴影+圆角） | ⚠️ | 规则已写入，`.device-browser` / `.frame-shot` 未端到端测试 |
| AI 生图（最后兜底，带风格约束词） | ⚠️ | 规则已写入，未测试 |
| 版权留痕（SOURCES.md） | ⚠️ | 规则已写入，流程中未强制执行 |
| 校验脚本（validate-social-deck.mjs） | ❌ | 可选，用户要求时跑。未集成到自动流程 |
| 地图组件（Mapbox / OSM / SVG） | ❌ | 旅行品类可用。我们目前没有旅行内容触发 |
| WebGL 墨流背景（Editorial 专用） | ❌ | 依赖 magazine-bg-webgl.js。预览文件已包含，生产未验证 |
| 标题压缩器（1:1 短标题） | ❌ | 公众号封面对需要。我们目前公众号封面未单独测试 |
| 公众号封面对预览（21:9 + 1:1 同框） | ❌ | `.pair-preview` 组件。未测试 |
| 多平台一次出包 | ❌ | 我们是跨平台再发布模式，走的是同一内容→不同画板尺寸 |

### 更新时重点检查

- 种子模板 CSS 有改动 → 我们的品类路由 recipe 序列需要重新预览验证
- 新增 recipe → 更新品类路由的 recipe 序列
- category-cookbook.md 有改动 → 同步我们的能力边界表
- 图源 API 策略有改动 → 同步图片管线

---

## 2. dbs-content — 内容选题诊断

**调用方式**：`Skill: dbs:dbs-content` | **类型**：远程 Skill
**版本**：远程（无法本地检查） | **我们接入**：2026-05-28
**我们的调用位置**：Step 1.5 质检

### 功能清单

| 功能 | 使用 | 备注 |
|------|:--:|------|
| 选题质量诊断（值不值得做） | ✅ | 返回 Go / Fix / Kill |
| 内容结构建议 | ✅ | 输出结构建议，传入下一步 |

### 我们没用但可接的

| 功能 | 原因 | 优先级 |
|------|------|:--:|
| — | 接口简单，已用完 | — |

---

## 3. dbs-hook — 短视频开头优化

**调用方式**：`Skill: dbs:dbs-hook` | **类型**：远程 Skill
**版本**：远程（无法本地检查） | **我们接入**：2026-05-28
**我们的调用位置**：Step 2.5（路径 C，脚本写完后），Step 1.5（路径 A/B）

### 功能清单

| 功能 | 使用 | 备注 |
|------|:--:|------|
| 前 3-5 秒钩子优化 | ✅ | 生成 10-15 条优化方案 |
| 叙事钩/数据钩/悬念钩/情绪钩分类 | ✅ | |
| 让用户选最佳方案 | ✅ | 交互式 |

### 我们没用但可接的

| 功能 | 原因 | 优先级 |
|------|------|:--:|
| — | 接口简单，已用完 | — |

---

## 4. dbs-xhs-title — 小红书标题公式

**调用方式**：`Skill: dbs:dbs-xhs-title` | **类型**：远程 Skill
**版本**：远程（无法本地检查） | **我们接入**：2026-05-28
**我们的调用位置**：Step 1.5 质检（仅小红书/图文平台）

### 功能清单

| 功能 | 使用 | 备注 |
|------|:--:|------|
| 75 个爆款标题公式 | ✅ | 匹配最佳公式 |
| 公式编号 + 建议标题 | ✅ | 输出给用户确认 |

### 我们没用但可接的

| 功能 | 原因 | 优先级 |
|------|------|:--:|
| — | 接口简单，已用完 | — |

---

## 5. dbs-ai-check — AI 写作检测

**调用方式**：`Skill: dbs:dbs-ai-check` | **类型**：远程 Skill
**版本**：远程（无法本地检查） | **我们接入**：2026-05-28
**我们的调用位置**：Step 1.6（所有路径，文字初稿后）

### 功能清单

| 功能 | 使用 | 备注 |
|------|:--:|------|
| AI 写作特征扫描 | ✅ | 🔴强信号 / ⚠️中信号 / 💡弱信号 |
| 逐条自动修改 | ✅ | 不逐条问用户 |
| 复检闭环（最多 3 轮） | ✅ | |
| 诊断报告 | ✅ | 仅当 3 轮不通过时呈现 |

### 我们没用但可接的

| 功能 | 原因 | 优先级 |
|------|------|:--:|
| — | 接口简单，已用完 | — |

---

## 6. video-use — 视频剪辑

**路径**：`~/.claude/skills/video-use/`
**仓库**：`https://github.com/browser-use/video-use`
**版本**：`0.1.0`（pyproject.toml） | **更新**：2026-05-10 | **我们接入**：2026-05-28
**我们的调用位置**：Path B.2（口播剪辑）、Path B.3（字幕+配乐）

### 功能清单

| 功能 | 使用 | 备注 |
|------|:--:|------|
| 转录 | ✅ | 自动转写口播内容 |
| 剪辑（去空白/口误） | ✅ | |
| 字幕烧录 | ✅ | 居中大字，关键字高亮 |
| 配乐 | ✅ | Lo-fi / 轻快电子，-18dB |
| 调色 | ❌ | 我们的口播场景不需要 |
| 叠加动画 | ❌ | 教学视频走 Path C Hyperframes |

### 我们没用但可接的

| 功能 | 原因 | 优先级 |
|------|------|:--:|
| 转场效果 | 口播视频可能用得上 | 低 |
| 多机位切换 | B-roll 素材插入 | 低 |

---

## 7. wewrite — 公众号发布

**调用方式**：`Skill: wewrite` / CLI `python toolkit/cli.py`
**仓库**：`https://github.com/oaker-io/wewrite` | **版本**：单 commit | **更新**：2026-04-02
**我们接入**：2026-05-30
**我们的调用位置**：Step 6（公众号分发）

### 功能清单

| 功能 | 使用 | 备注 |
|------|:--:|------|
| Markdown → 微信 HTML 转换 | ✅ | publish / preview |
| 推送到草稿箱 | ✅ | `wewrite publish` |
| 本地预览 | ✅ | `wewrite preview`（降级方案） |
| 小绿书图片轮播帖 | ✅ | `wewrite image-post` |
| 16 套排版主题 | ⚠️ | 只用 professional-clean 默认，品类路由未匹配主题 |
| 封面图生成 | ❌ | 我们用 guizang-social-card-skill 做封面 |
| 热点抓取 | ❌ | 我们不做选题发现 |
| 学习用户改稿风格 | ❌ | 自动发布场景不需要 |
| 文章数据复盘 | ❌ | 不在生产流程内 |
| 容器语法（:::dialogue / :::timeline / :::callout）| ❌ | 我们的文章结构简单，不需要 |

### 可接的

| 功能 | 怎么接 | 优先级 |
|------|--------|:--:|
| 品类路由匹配排版主题 | 职场→tech-modern，商业→bold-navy，生活→warm-editorial | 中 |

---

## 8. social-media-auto-publish (sau) — 多平台发布

**路径**：`~/.claude/skills/social-media-auto-publish/`
**仓库**：`https://github.com/dreammis/social-auto-upload`
**版本**：无版本号（非 git 安装） | **安装**：2026-05-11 | **我们接入**：2026-05-28
**我们的调用位置**：Step 6（短视频平台分发）

### 功能清单

| 功能 | 使用 | 备注 |
|------|:--:|------|
| 抖音发布 | ✅ | `sau douyin upload` |
| 小红书发布 | ✅ | `sau xiaohongshu upload` |
| 快手发布 | ✅ | `sau kuaishou upload` |
| Bilibili 发布 | ✅ | `sau bilibili upload` |
| 定时发布 | ❌ | 用户没说需要 |
| TikTok 发布 | ❌ | CLI 支持但未接入我们的流程 |
| YouTube Shorts 发布 | ❌ | CLI 支持但未接入 |
| X/Twitter 发布 | ❌ | CLI 不支持 |

### 可接的

| 功能 | 怎么接 | 优先级 |
|------|--------|:--:|
| TikTok | `sau tiktok upload`，登录后接入 | 高（PROJECT.md Next Action） |
| 定时发布 | `--schedule "2026-06-01 20:00"` | 低 |

---

## 9. Edge-TTS — 配音

**调用方式**：Python `edge-tts`（`pip install edge-tts`） | **类型**：免费工具
**版本**：最新（`pip install --upgrade edge-tts`） | **检查方式**：`pip show edge-tts`
**我们的调用位置**：Path C.2
**切换日期**：2026-05-30（从 ElevenLabs 切换，中文质量差）

### 功能清单

| 功能 | 使用 | 备注 |
|------|:--:|------|
| 文字转语音 | ✅ | `zh-CN-XiaoxiaoNeural` 默认 |
| 50+ 中文音色 | ⚠️ | 只用 Xiaoxiao（女声）和 Xiaoyi（活泼女声） |
| SSML 精细控制 | ⚠️ | 语速/音调/情感/停顿，规则已写 |
| 8 种情感风格 | ❌ | 教学视频不需要，短视频可能用得上 |
| 免费 | ✅ | 无需 API Key，无需注册 |

### 可接的

| 功能 | 怎么接 | 优先级 |
|------|--------|:--:|
| 口播用 XiaoyiNeural | Path B 配音时自动切换 | 中 |
| 情感控制 | 口播视频加 `cheerful` 或 `excited` 风格 | 低 |

---

## 10. Hyperframes — 视频画面引擎

**调用方式**：npm `npx hyperframes@0.6.52` | **类型**：外部 CLI
**版本**：`0.6.52` | **检查方式**：`npm view hyperframes version`
**我们的调用位置**：Path C.3

### 功能清单

| 功能 | 使用 | 备注 |
|------|:--:|------|
| 5 个 composition 模板 | ⚠️ | tutorial-step / explainer / comparison / listicle / outro |
| GSAP 入场动画 | ⚠️ | 模板内置，paused:true→render时播放 |
| 5 个社区组件（grain/vignette/caption/wipe/outro） | ⚠️ | 规则已写入 C.4.3，未端到端测试 |
| 品牌栏 | ✅ | brand-guide.md |
| `npm run check` lint | ⚠️ | 规则已写入 C.4.4 |
| `npm run render` 渲染 | ⚠️ | 规则已写入 |
| 自定义 composition | ❌ | 只用 5 个内置模板 |

### 可接的

| 功能 | 怎么接 | 优先级 |
|------|--------|:--:|
| 真动画（非静态帧） | 确保 GSAP timelines 在渲染时正确触发 | **高（Path C 最大质量问题）** |
| 素材嵌入 composition | C.4.4 阻断检查已要求 | 中 |

---

## 汇总：未使用功能的优先级

| 优先级 | 功能 | 所属 Skill | 影响 |
|:--:|------|-----------|------|
| ✅ 已解决 | 中文原生音色 | Edge-TTS（2026-05-30 切换） | Path C 配音质量 |
| ✅ 已解决 | 中文原生音色 | Edge-TTS（2026-05-30 切换） | Path C 配音质量 |
| ✅ 已解决 | GSAP 真动画规则 | Hyperframes C.4.4 阻断检查 | Path C 画面质量 |
| ✅ 已解决 | 素材管线统一 | Path A/C 共用搜图 | 全路径 |
| ✅ 已解决 | 品类→排版主题匹配 | wewrite 10 品类映射 | 公众号文章专业感 |
| ✅ 已解决 | TikTok 平台接入 | sau tiktok | 分发覆盖 |
| ✅ 已解决 | 调色/转场 | video-use grade.py + crossfade | 口播视频精致度 |
| 🟢 低 | 校验脚本自动跑 | guizang-social-card-skill | 质量兜底 |
| 🟢 低 | 地图组件 | guizang-social-card-skill | 旅行品类体验 |
| 🟢 低 | 标题压缩器 | guizang-social-card-skill | 公众号 1:1 封面 |
| 🟢 低 | 定时发布 | sau | 运营自动化 |

---

## 更新日志

| 日期 | 子 Skill | 变更 |
|------|---------|------|
| 2026-05-30 | — | 初始版本 |
