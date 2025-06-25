#!/bin/sh
set -e
URL="https://github.com/odin-lang/Odin/releases/download/dev-2025-06/odin-linux-amd64-dev-2025-06.zip"
DEST="odin-bin"
if [ -d "$DEST" ]; then
  echo "Odin is already installed in $DEST" >&2
  exit 0
fi
mkdir -p "$DEST"
# download
TMPZIP="odin.zip"
if command -v curl >/dev/null 2>&1; then
  curl -fL "$URL" -o "$TMPZIP" || { echo "Download failed" >&2; exit 1; }
elif command -v wget >/dev/null 2>&1; then
  wget "$URL" -O "$TMPZIP" || { echo "Download failed" >&2; exit 1; }
else
  echo "Neither curl nor wget is available" >&2
  exit 1
fi

# unzip
unzip "$TMPZIP" -d "$DEST"
rm "$TMPZIP"

# verify
if [ -x "$DEST/odin" ]; then
  "$DEST/odin" version
else
  echo "Odin binary not found" >&2
  exit 1
fi
