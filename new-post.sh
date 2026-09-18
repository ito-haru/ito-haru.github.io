#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

usage() {
  cat >&2 <<'USAGE'
Usage:
  ./new-post.sh en "Title" [slug]
  ./new-post.sh ja "タイトル" [slug]
  ./new-post.sh both "English Title" "日本語タイトル" [slug]

[slug] overrides the auto-generated ASCII slug (must not already exist).
USAGE
  exit 1
}

[ $# -ge 2 ] || usage
lang="$1"

slugify() {
  perl -CSD -pe '
    s/\s+/-/g;
    s/[^\p{L}\p{N}\-]//g;
    s/-+/-/g;
    s/^-|-$//g;
    $_ = lc($_);
  ' <<< "$1"
}

date_str="$(date +%Y-%m-%d)"

# Appends -2, -3, ... to base_slug until an unused posts/ directory is found.
unique_slug() {
  local base_slug="$1" n=2
  local slug="$base_slug"
  while [ -e "posts/$slug" ]; do
    slug="$base_slug-$n"
    n=$((n + 1))
  done
  echo "$slug"
}

make_dir() {
  local slug="$1"
  dir="posts/$slug"
  if [ -e "$dir" ]; then
    echo "Error: $dir already exists" >&2
    exit 1
  fi
  mkdir -p "$dir"
}

case "$lang" in
  en)
    title="$2"
    custom_slug="${3:-}"
    if [ -n "$custom_slug" ]; then
      make_dir "$custom_slug"
    else
      make_dir "$(unique_slug "$date_str-$(slugify "$title")")"
    fi
    cat > "$dir/index.qmd" <<EOF
---
title: "$title"
author: "Haruto Ito"
date: "$date_str"
lang: en
categories: [English]
---

EOF
    ;;
  ja)
    title="$2"
    custom_slug="${3:-}"
    if [ -n "$custom_slug" ]; then
      make_dir "$custom_slug"
    else
      make_dir "$(unique_slug "$date_str")"
    fi
    cat > "$dir/index.qmd" <<EOF
---
title: "$title"
author: "Haruto Ito"
date: "$date_str"
lang: ja
categories: [日本語]
---

EOF
    ;;
  both)
    [ $# -ge 3 ] || usage
    title_en="$2"
    title_ja="$3"
    custom_slug="${4:-}"
    if [ -n "$custom_slug" ]; then
      make_dir "$custom_slug"
    else
      make_dir "$(unique_slug "$date_str-$(slugify "$title_en")")"
    fi
    cat > "$dir/index.qmd" <<EOF
---
title: "$title_en / $title_ja"
author: "Haruto Ito"
date: "$date_str"
categories: [English, 日本語]
---

::: {.panel-tabset}
## English

## 日本語

:::
EOF
    ;;
  *)
    usage
    ;;
esac

echo "Created $dir/index.qmd"
