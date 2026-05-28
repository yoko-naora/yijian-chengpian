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

分步询问：工作区路径 → 安装方式(A/B) → ElevenLabs API密钥。
确认后按 `references/setup.md` 执行6阶段搭建。

## 模式二：日常生产

6步完整流水线，详见 `references/production.md`：

```
Step 1 → Step 1.5 → Step 2 → Step 3-5 → Step 6
选题输入 → 内容质检 → AI扩写脚本 → 配音+模板+导出 → 多平台分发
```

### 扩展指令

| 指令 | 效果 |
|------|------|
| 「只做质检」 | 只跑 Step 1.5，不生产视频 |
| 「出双语版」 | 额外生成日文配音版 |
| 「发到全平台」 | Step 6 多平台一键发布 |
| 「批量生产」 | 选题列表依次执行全流程 |

---

## 安全规则

- ElevenLabs API 密钥**只能**写入 `.env`，绝不进入仓库
- `.env` 必须在 `.gitignore` 中
