# Odin Ball Bounce Example

This repository contains a small example game written in [Odin](https://odin-lang.org). It displays a ball bouncing around the window using `vendor:raylib`.

## Building on Linux

Make sure you have the Odin compiler available (see `deps.sh` if you need to download the nightly build). Run:

```bash
odin run ball_bounce
```

This compiles and launches the program for the host platform.

## Building and running on macOS (Metal)

On macOS you can build and run the project directly. Odin will automatically use Metal via the system frameworks when available.

```bash
odin run ball_bounce -target:macos_arm64
```

Adjust the target architecture (`macos_arm64` or `macos_amd64`) depending on your machine. The resulting application will render using Metal.

## Building for Web (WASM + WebGL)

Even if you installed Odin using Homebrew you must run `./deps.sh` once to fetch
the vendor libraries used for WebAssembly builds.

To build the same project for the web you can target `js_wasm32` and produce a `.wasm` file along with the runtime JavaScript helper:

```bash
odin build ball_bounce -target:js_wasm32 -out:ball_bounce.wasm
cp $(odin root)/core/sys/wasm/js/odin.js .
mkdir -p wasm
cp $(odin root)/vendor/raylib/wasm/libraylib.a wasm/
```

Then create a minimal HTML file that loads `odin.js` and your `ball_bounce.wasm` and open it with a web browser that supports WebGL.

Alternatively you can run the provided helper script which performs all of the above steps and writes the HTML file automatically:

```bash
./wasm.sh
```

