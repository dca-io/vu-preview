#!/bin/sh
# Copy the built web bundle from the vumeter-openGL checkout into this repo.
# Build it first there with ./tools/build-web.sh.
#
# Usage:
#   ./tools/sync-bundle.sh [path/to/vumeter-openGL]
set -eu

HERE="$(cd "$(dirname "$0")/.." && pwd)"
SRC="${1:-$HERE/../vumeter-openGL}"
BUILD="$SRC/build-web"

for f in index.html dbmr-analyzer-web.js dbmr-analyzer-web.wasm dbmr-analyzer-web.data; do
    if [ ! -f "$BUILD/$f" ]; then
        echo "error: $BUILD/$f missing; run $SRC/tools/build-web.sh first" >&2
        exit 1
    fi
done

for f in index.html dbmr-analyzer-web.js dbmr-analyzer-web.wasm dbmr-analyzer-web.data; do
    cp "$BUILD/$f" "$HERE/$f"
done

if git -C "$SRC" rev-parse --short HEAD >/dev/null 2>&1; then
    rev="$(git -C "$SRC" rev-parse --short HEAD)"
    dirty=""
    if [ -n "$(git -C "$SRC" status --porcelain)" ]; then dirty="-dirty"; fi
    echo "$rev$dirty" > "$HERE/BUNDLE_SOURCE"
fi

echo "synced bundle from $BUILD"
ls -la "$HERE"/index.html "$HERE"/dbmr-analyzer-web.*
