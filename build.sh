#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

QUARTO=quarto
command -v quarto >/dev/null 2>&1 || QUARTO=/Applications/quarto/bin/quarto

"$QUARTO" render
"$QUARTO" render ja

open docs/index.html
