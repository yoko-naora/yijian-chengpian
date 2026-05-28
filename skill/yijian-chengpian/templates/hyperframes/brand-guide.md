# Hyperframes Brand Guide · 一键成片

kb.snsaladdin.com 設計系統を動画テンプレートに適用するための参照仕様。

## 字体 / Fonts

| 言語 | UI/本文 | 見出し | weight |
|------|---------|--------|--------|
| 中国語 | `Noto Sans SC` | `Noto Sans SC` | 400 / 600 |
| 日本語 | `Noto Sans JP` | `Noto Serif JP` | 400 / 600 |

```html
<!-- 中国語動画 -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@400;600&display=swap" rel="stylesheet">

<!-- 日本語動画 -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@400;500&family=Noto+Serif+JP:wght@400;600&display=swap" rel="stylesheet">
```

## 配色 / Colors

```css
:root {
  --bg-primary: #0a0a0b;       /* 暗色ベース（動画デフォルト） */
  --bg-secondary: #faf7f2;     /* 暖象牙白（ライトテーマ用） */
  --text-primary: #f1efea;     /* 明色テキスト */
  --text-dark: #1c1c2e;        /* 暗色テキスト（ライト背景用） */
  --accent: #FF6B35;           /* SNS Aladdin オレンジ */
  --accent-green: #2e7d32;     /* バッジ・成功表示 */
  --muted: rgba(241, 239, 234, 0.6);  /* 補足テキスト */
}
```

## 画面サイズ / Canvas Sizes

| プラットフォーム | サイズ | 用途 |
|-----------------|--------|------|
| 抖音 / TikTok | 1080×1920 (9:16) | 縦型ショート |
| 小紅書 | 1080×1440 (3:4) | 縦型カード |
| X / YouTube | 1920×1080 (16:9) | 横型 |

## レイアウト原則

- 余白を活かす。文字を詰め込まない
- 1画面に伝えるメッセージは1つ
- 見出しは 48-72px、本文は 28-36px、補足は 20-24px
- accent orange はCTAとキーワード強調のみに使用
- 画面下部にブランドバー（高さ60px）を常駐

## ブランドバー仕様

全画面の下部に固定表示：

```
[背景: rgba(0,0,0,0.7)]
左: SNS Aladdin ロゴテキスト (14px, muted)
右: kb.snsaladdin.com (14px, muted)
```

## アウトロ / CTA 仕様

最終カード（3-5秒）：
- 中央: ロゴ + 「AI知識庫」/「AI知识库」
- CTA ボタン: accent orange 背景、白文字
- 中国語: 「关注我，每天一个AI技巧」
- 日本語: 「フォローしてAI活用術をチェック」
- URL: kb.snsaladdin.com (小文字、muted)
