# OGLQuickstart Base Project

A cross-platform starter for OpenGL projects using CMake, GLFW, and GLAD. The goal is to give you a clean foundation you can clone, customise, and build on macOS, Windows, or Linux.

## Highlights
- Minimal sample app (`main.cpp`) that creates a GLFW window and draws a triangle.
- CMake configuration plus toolchain files for macOS (arm64/x86_64), Linux (arm64/x86_64), and Windows (MSVC/MinGW).
- Helper scripts (`build-multi.sh` and per-platform variants) to generate builds quickly.
- Vendored dependencies under `external/` so you can build offline.

## Repository Contents

| Path | Description |
| --- | --- |
| `main.cpp`, `src/`, `shaders/` | Core application source and starter GLSL shaders |
| `CMakeLists.txt`, `linux-*.cmake`, `windows-*.cmake` | Build system and cross-compilation toolchains |
| `external/` | GLAD source (small, safe to version) |
| `icon/`, `icon.iconset/` | Branding assets used when packaging apps |
| `build*`, `mac-*`, `win-*`, `OGLQuickstart*` | Generated build directories and binaries – ignore/clean before committing |
| `llvm-mingw/` | Optional local LLVM/MinGW toolchain (~5 GB) – keep out of Git and download when needed |

The `.gitignore` already skips the large/generated directories above. If you plan to publish this project, double-check `git status` and ensure only source, scripts, assets, and docs are staged.

## Quick Start

```bash
chmod +x build-multi.sh
./build-multi.sh --help
```

Use the script to configure and build for your target platform. Outputs land in `mac-arm-app/`, `mac-x86-app/`, `win-x86-app/`, etc. To run the sample app manually:

```bash
cmake -B build -S .
cmake --build build
./build/OGLQuickstart
```

Refer to the [Project Guide](docs/ProjectGuide.md) or the new [Wiki pages](docs/wiki/Home.md) for platform-specific steps, repo hygiene tips, and publishing instructions you can copy straight into GitHub's wiki feature.

## Customising
1. Edit `shaders/basic.vert` and `shaders/basic.frag` to change rendering.
2. Add new source files and list them in `CMakeLists.txt` under `APP_SOURCES`.
3. Drop reusable headers into `src/`.
4. Replace assets inside `icon/` / `icon.iconset/` if you ship desktop bundles.

# OpenGL_Base

A simple project to start learning OpenGL, add to your own projects, and improve as you go.

## Features
- Vertex shader
- Fragment shader
- Custom model loading
- Texture loading (PNG/JPEG)
- Key input handling
- Mouse rotation
- And more...

---

## How to Build and Run

### 1. Save the Script
Save the provided `build-multi.sh` script in your project root.
<!-- 
    example:
        add build-multi.sh linux amr64
        same with others windwos/macos/linux arm64/x86_64
 -->
### 2. Make it Executable
```sh
chmod +x build-multi.sh
```

### 3. Run the Script
Execute the script for your desired platform/architecture:

- macOS ARM:
- macOS Intel:
- Linux ARM:
- Linux Intel:
- Windows:

(Follow the instructions printed by the script.)
