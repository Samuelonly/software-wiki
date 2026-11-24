#!/usr/bin/env bash
# 把所有分文件拼成 ALL.md，方便一次喂给 AI。
# 用法：./scripts/build.sh
set -euo pipefail
cd "$(dirname "$0")/.."

OUT="ALL.md"

{
  echo "# Stacks + Checklists — 完整版"
  echo
  echo "本文件由 \`scripts/build.sh\` 自动生成。"
  echo "请编辑 \`stacks/\` 和 \`checklists/\` 下的分文件，然后重新运行本脚本，不要直接改本文件。"
  echo
  echo "---"
  echo
  echo "# 第一部分：stacks/ 技术选型库"
  echo
  for f in stacks/*.md; do
    [ -e "$f" ] || continue
    name="$(basename "$f")"
    [ "$name" = "_SCHEMA.md" ] && continue
    echo "<!-- source: $f -->"
    echo
    cat "$f"
    echo
    echo "---"
    echo
  done

  echo "# 第二部分：checklists/ 品类功能清单"
  echo
  for f in checklists/*.md; do
    [ -e "$f" ] || continue
    name="$(basename "$f")"
    [ "$name" = "_SCHEMA.md" ] && continue
    echo "<!-- source: $f -->"
    echo
    cat "$f"
    echo
    echo "---"
    echo
  done
} > "$OUT"

echo "已生成 ${OUT}（$(wc -l < "$OUT" | tr -d ' ') 行）"
