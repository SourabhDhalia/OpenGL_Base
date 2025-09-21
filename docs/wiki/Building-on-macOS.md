# Building on macOS

## Requirements
- macOS 12 or later (tested on Apple Silicon and Intel)
- Xcode command line tools: `xcode-select --install`
- (Optional) Homebrew packages for GLFW: `brew install cmake glfw`

## Using the helper script
```bash
./build-multi.sh mac-arm   # Apple Silicon
./build-multi.sh mac-x86   # Intel Macs
```

Each command generates a build directory (`build-macos-arm64` or `build-macos-x86_64`) and produces an app bundle under `mac-arm-app/` or `mac-x86-app/`.

## Manual CMake invocation (Apple Silicon example)
```bash
cmake -B build-macos-arm64 -S . -DCMAKE_OSX_ARCHITECTURES=arm64
cmake --build build-macos-arm64
./mac-arm-app/OGLQuickstart.app/Contents/MacOS/OGLQuickstart
```

To target Intel Macs, swap `arm64` for `x86_64`.

## Troubleshooting
- **GLFW not found:** install via Homebrew (`brew install glfw`) and ensure `/opt/homebrew` or `/usr/local` is in your CMake search path.
- **Codesign warnings:** development builds don’t require signing. For distribution, codesign the `.app` bundle manually.
