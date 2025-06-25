#!/bin/sh
set -e

# Determine Odin command
ODIN=${ODIN:-odin}
if ! command -v "$ODIN" >/dev/null 2>&1; then
    ODIN="./odin-bin/odin-linux-amd64-nightly+2025-06-02/odin"
fi

# Build the example to WebAssembly
"$ODIN" build ball_bounce -target:js_wasm32 -out:ball_bounce.wasm

# Discover Odin root path for runtime resources
ODIN_ROOT=$("$ODIN" root)

# Copy the vendor raylib WASM library expected by odin.js
# Prefer the one fetched by deps.sh in odin-bin so Homebrew installs work
mkdir -p wasm
RAYLIB_WASM=$(find odin-bin -path '*/vendor/raylib/wasm/libraylib.a' 2>/dev/null | head -n 1)
if [ -z "$RAYLIB_WASM" ]; then
    RAYLIB_WASM="$ODIN_ROOT/vendor/raylib/wasm/libraylib.a"
fi
cp "$RAYLIB_WASM" wasm/

# Copy the Odin runtime JavaScript helper next to the wasm file
cp "$ODIN_ROOT/core/sys/wasm/js/odin.js" .

# Generate a minimal HTML file to load the wasm module
cat >ball_bounce.html <<'HTML'
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <script src="odin.js"></script>
</head>
<body>
  <script>
    odin.runWasm('ball_bounce.wasm');
  </script>
</body>
</html>
HTML

printf '\nGenerated ball_bounce.html. Open it in a WebGL-enabled browser.\n'
printf 'Run `python3 -m http.server` and navigate to http://localhost:8000/ball_bounce.html\n'
