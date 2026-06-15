#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${HOME}/.codex/skills"
DRY_RUN=0
AGENT_DOCS="write"

usage() {
  cat <<'USAGE'
Usage: bash scripts/install.sh [--target DIR] [--dry-run] [--agent-docs write|skip]

Copies public agentic quality skills into a local skills directory.
Default target: $HOME/.codex/skills
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      TARGET="${2:?missing --target value}"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --agent-docs)
      AGENT_DOCS="${2:?missing --agent-docs value}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "install: unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

case "$AGENT_DOCS" in
  write|skip) ;;
  *)
    echo "install: --agent-docs must be write or skip" >&2
    exit 2
    ;;
esac

copy_skill() {
  local skill="$1"
  local src="$ROOT/skills/$skill"
  local dst="$TARGET/$skill"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "would copy $src -> $dst"
  else
    mkdir -p "$TARGET"
    rm -rf "$dst"
    cp -R "$src" "$dst"
    echo "installed $skill -> $dst"
  fi
}

write_agent_docs() {
  local doc="$PWD/AGENTS.md"
  local block="$ROOT/agent-docs/AGENTS.managed-block.md"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "would update managed block in $doc"
    return
  fi

  if [[ ! -f "$doc" ]]; then
    cp "$block" "$doc"
    echo "created $doc"
    return
  fi

  python3 - "$doc" "$block" <<'PY'
from pathlib import Path
import sys

doc = Path(sys.argv[1])
block = Path(sys.argv[2]).read_text()
text = doc.read_text()
start = "<!-- BEGIN AGENTIC_QUALITY_SKILLS -->"
end = "<!-- END AGENTIC_QUALITY_SKILLS -->"

if start in text and end in text:
    before = text.split(start, 1)[0]
    after = text.split(end, 1)[1]
    doc.write_text(before + block + after)
else:
    sep = "" if text.endswith("\n") else "\n"
    doc.write_text(text + sep + "\n" + block + "\n")
PY
  echo "updated managed block in $doc"
}

copy_skill test-driven-development
copy_skill agentic-quality-gates
copy_skill golden-benchmark-uplift-loop

if [[ "$AGENT_DOCS" == "write" ]]; then
  write_agent_docs
else
  echo "agent docs skipped"
fi

echo "install: OK"
