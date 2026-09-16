#!/bin/sh
# Preview the site locally exactly as GitHub Pages would serve it.
# Usage: ./tools/serve.sh [port]
set -eu
PORT="${1:-8972}"
HERE="$(cd "$(dirname "$0")/.." && pwd)"
echo "Serving $HERE at http://localhost:$PORT/"
exec python3 -m http.server "$PORT" --directory "$HERE" --bind 127.0.0.1
