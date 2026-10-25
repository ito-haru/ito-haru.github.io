サイトをビルドして、チェックする際は以下のコマンドを実行する。

```
./build.sh
```

英語・日本語ページを含む単一のQuartoプロジェクトを全体ビルドしたうえで、`quarto preview` のローカルサーバーでブラウザに開く。
編集すると自動で再ビルド・再読み込みされる。終了は `Ctrl+C`。

## 発表・講演の追加

`data/presentations.yml` の末尾にエントリを1件書き足すだけでよい（書き方はファイル冒頭のコメントを参照）。
Home の英語版（`index.qmd`）・日本語版（`ja/index.qmd`）の両方に、日付の新しい順で自動表示される。
会期の最終日（`date_end`、なければ `date`）が閲覧日以降のものには「Upcoming／予定」のラベルが付く（ページ内のスクリプトで判定するので再ビルドは不要）。
表示の書式は `_templates/presentations-en.ejs` / `_templates/presentations-ja.ejs` で決めている。

## 正規URLとサイトマップ

各ページに canonical タグが付く（`_quarto.yml` の `canonical-url: true`。トップは `index.qmd`・`ja/index.qmd` でそれぞれ `/`・`/ja/` を指定）。
ビルド後に `scripts/fix-sitemap.ts` がサイトマップの `…/index.html` を末尾スラッシュの URL に書き換え、canonical タグとそろえる。
サイト内のリンクも `index.html` 付きにせず、`/`・`/ja/` を使う。

## ブログ記事の追加

```
./new-post.sh en "Title"                       # 英語記事
./new-post.sh ja "タイトル"                      # 日本語記事
./new-post.sh both "English Title" "日本語タイトル"  # バイリンガル記事
```

`posts/<slug>/index.qmd` を生成し、title・author・date・lang・categories を埋める。
記事は言語ごとに書き分けてよく（`lang: en` / `lang: ja`）、`both` の場合は `.panel-tabset` でEnglish/日本語を1ページ内に併記する。
