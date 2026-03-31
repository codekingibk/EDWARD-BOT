#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-build}"
PROJECT_DIR="Mega-Md-WhatsApp"

if [ ! -d "$PROJECT_DIR" ]; then
  echo "Expected project directory '$PROJECT_DIR' was not found." >&2
  exit 1
fi

if ! command -v pnpm >/dev/null 2>&1; then
  corepack enable
  corepack prepare pnpm@10.17.1 --activate
fi

cd "$PROJECT_DIR"

case "$MODE" in
  build)
    pnpm install --frozen-lockfile
    pnpm --filter @workspace/api-server run build
    ;;
  start)
    exec pnpm --filter @workspace/api-server run start
    ;;
  *)
    echo "Usage: ./render-deploy.sh [build|start]" >&2
    exit 1
    ;;
esac
