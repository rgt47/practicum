#!/usr/bin/env bash
# Fail the build when an HTML character entity for a backtick appears in
# a chapter source. Entities such as &#96; are not decoded inside code
# blocks or inline code, so they print literally in both the HTML and the
# PDF output. To show Quarto inline code verbatim, write `{{r}} expr`;
# to show a chunk header verbatim, write ```{{r}} inside a four-backtick
# block. Quarto renders both with single braces and does not execute them.
#
# Scans QUARTO_PROJECT_DIR when Quarto runs it as a pre-render script,
# otherwise the directory given as the first argument, otherwise '.'.

set -euo pipefail

dir="${1:-${QUARTO_PROJECT_DIR:-.}}"
pattern='&#96;|&#x60;|&grave;'

shopt -s nullglob
files=("$dir"/*.qmd)
if [ "${#files[@]}" -eq 0 ]; then
  echo "check-entities: no .qmd files found in $dir" >&2
  exit 2
fi

if grep -H -n -E "$pattern" "${files[@]}"; then
  echo "check-entities: backtick entities found (see above);" \
    "use \`{{r}} expr\` to display inline code verbatim" >&2
  exit 1
fi
