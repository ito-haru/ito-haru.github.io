
サイトをビルドして、チェックする際は以下のコマンドを実行する。

```
./build.sh
```

英語・日本語ページを含む単一のQuartoプロジェクトを `quarto render` でビルドして `docs/index.html` を開く。

## 発表・講演の追加

`data/presentations.yml` にエントリを1つ足すだけでよい（書き方はファイル冒頭のコメントを参照）。
Home の英語版（`index.qmd`）・日本語版（`ja/index.qmd`）の両方に、日付の新しい順で自動表示される。
表示の書式は `_templates/presentations-en.ejs` / `presentations-ja.ejs` で決めている。

## 正規URLとサイトマップ

各ページには canonical タグが付く（`_quarto.yml` の `canonical-url: true`、トップは各 `index.qmd` で `/` と `/ja/` を指定）。
ビルド後に `scripts/fix-sitemap.ts` がサイトマップの `…/index.html` を末尾スラッシュのURLに書き換え、canonical タグと一致させる。

## ブログ記事の追加

```
./new-post.sh en "Title"                       # 英語記事
./new-post.sh ja "タイトル"                      # 日本語記事
./new-post.sh both "English Title" "日本語タイトル"  # バイリンガル記事
```

`posts/<slug>/index.qmd` を生成し、title・author・date・lang・categories を埋める。
記事は言語ごとに書き分けてよく（`lang: en` / `lang: ja`）、`both` の場合は `.panel-tabset` でEnglish/日本語を1ページ内に併記する。
