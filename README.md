
サイトをビルドして、チェックする際は以下のコマンドを実行する。

```
./build.sh
```

英語・日本語ページを含む単一のQuartoプロジェクトを `quarto render` でビルドして `docs/index.html` を開く。

## ブログ記事の追加

```
./new-post.sh en "Title"                       # 英語記事
./new-post.sh ja "タイトル"                      # 日本語記事
./new-post.sh both "English Title" "日本語タイトル"  # バイリンガル記事
```

`posts/<slug>/index.qmd` を生成し、title・author・date・lang・categories を埋める。
記事は言語ごとに書き分けてよく（`lang: en` / `lang: ja`）、`both` の場合は `.panel-tabset` でEnglish/日本語を1ページ内に併記する。
