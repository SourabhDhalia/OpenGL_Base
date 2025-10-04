# OGLQuickstart Guide

Welcome to the OGLQuickstart base project. This guide explains the repo layout, required tooling, and how to build and run the sample app on macOS, Windows, and Linux. Share this document as a GitHub wiki page or keep it within the repo for quick reference.

## 1. What This Project Provides

- A minimal GLFW + GLAD setup ready to extend into your own OpenGL experiments.
- CMake build scripts with toolchain files for macOS (arm64/x86_64), Windows (MSVC + MinGW), and Linux (arm64/x86_64).
- Convenience scripts for generating builds per platform.
- A simple triangle sample you can replace with your own rendering code.

### GPT-friendly Template
- Straightforward file layout so AI assistants can add or modify modules with minimal context.
- Documentation under `docs/wiki/` doubles as prompts for automated build or packaging tasks.
- `.gitignore` keeps generated outputs out of version control, even when using code-generation tools that create binaries locally.

## 2. Repository Layout

| Path | Purpose | Track in Git? |
| --- | --- | --- |
| `CMakeLists.txt` | Top-level build configuration | ✅
| `main.cpp` | Sample OpenGL application | ✅
| `shaders/` | Starter GLSL shaders | ✅
| `src/` | Reusable headers (IO helpers, etc.) | ✅
| `external/` | Imported 3rd-party sources (GLAD) | ✅ – vendor copy is small and avoids network installs
| `icon/` & `icon.iconset/` | App icons used for packaging | ✅
| `build*/`, `mac-*/`, `win-*/` | Generated build folders and packaged binaries | ❌ – add to `.gitignore`
| `llvm-mingw/` | Local LLVM/MinGW toolchain clone (gigabytes) | ❌ – download separately when needed
| `OGLQuickstart*` | Local executable/app bundle outputs | ❌
| `gitDownloadPackages/`, `WinOpenGLFiles/` | Cached downloads and vendor SDKs | Optional – include only if you need to distribute them

> **Important:** Keep the repo lightweight by excluding generated binaries, build folders, caches, and the `llvm-mingw` toolchain. Git should store only source code, scripts, configs, and compact vendored dependencies that are hard to obtain.

## 3. Prerequisites

| Platform | Requirements |
| --- | --- |
| **macOS** | Xcode command line tools (`xcode-select --install`), Homebrew packages: `brew install cmake glfw` if GLFW not already installed. |
| **Windows** | Visual Studio with Desktop development workload **or** LLVM/MinGW. CMake 3.16+. If using this repo's `llvm-mingw` toolchain locally, download it separately and point the scripts to it. |
| **Linux** | Build essentials (`sudo apt install build-essential cmake`), GLFW development package (`sudo apt install libglfw3-dev`) or build from source. |

## 4. Building with the Multi-Platform Script

The `build-multi.sh` helper accepts flags to select a target platform. Run from the project root:

```bash
chmod +x build-multi.sh
./build-multi.sh --help
```

The script generates a build directory, runs CMake with the right toolchain file, and compiles the sample app. Outputs land in the corresponding platform folder (`mac-arm-app/`, `win-x86-app/`, etc.).

## 5. Manual CMake Steps (Example: macOS ARM)

```bash
cmake -B build-macos-arm64 -S . -DCMAKE_OSX_ARCHITECTURES=arm64
cmake --build build-macos-arm64
./mac-arm-app/OGLQuickstart.app/Contents/MacOS/OGLQuickstart
```

### Windows (Visual Studio)
```powershell
cmake -B build-windows-x86_64 -S . -G "Visual Studio 17 2022" -A x64
cmake --build build-windows-x86_64 --config Release
# Output: build-windows-x86_64/Release/OGLQuickstart.exe
```

### Linux (x86_64)
```bash
cmake -B build-linux-x86_64 -S .
cmake --build build-linux-x86_64
./build-linux-x86_64/OGLQuickstart
```

Use the provided toolchain files (`cmake/toolchains/linux-arm64-toolchain.cmake`, `cmake/toolchains/windows-arm64-toolchain.cmake`, etc.) when cross-compiling.

## 6. Customising for Your Project

1. **Replace sample shaders:** edit `shaders/basic.vert` and `shaders/basic.frag`.
2. **Add source files:** update `APP_SOURCES` in `CMakeLists.txt` and drop new headers in `src/`.
3. **Package icons:** replace the assets in `icon/` and `icon.iconset/`.
4. **Add external libraries:** vendor them under `external/` and extend `CMakeLists.txt` accordingly.

## 7. Cleaning Up Before Pushing

- Delete or ignore `build*/`, `mac-*/`, `win-*/`, `OGLQuickstart*`.
- Remove `llvm-mingw/` (re-download when needed) to keep the repository small.
- Clear any downloaded SDK caches (`gitDownloadPackages/`, `WinOpenGLFiles/`) unless you intend to ship them.
- Run `git status` to ensure only source/config/doc files remain staged.

## 8. Publishing to GitHub

1. Initialise the repo: `git init`
2. Add only tracked files: `git add CMakeLists.txt main.cpp src/ shaders/ external/ build-multi.sh icon*/ docs/ README.md .gitignore`
3. Commit: `git commit -m "Initial OGLQuickstart project"`
4. Create a GitHub repo and `git remote add origin ...`
5. Push: `git push -u origin main`

## 9. Next Steps

- Use GitHub Releases to attach compiled binaries separately from source.
- Consider creating a GitHub Actions workflow to build macOS, Windows, and Linux releases automatically.
- Expand this document into a full wiki by splitting per-platform guides.

Happy hacking!
