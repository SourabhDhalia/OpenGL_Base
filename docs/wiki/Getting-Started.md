# Getting Started

This page covers the basics for anyone cloning the OGLQuickstart template and running it locally.

## 1. Clone the Repository

```bash
git clone https://github.com/<your-user>/OGLQuickstart.git
cd OGLQuickstart
```

## 2. Install Prerequisites

See the per-platform pages listed below. At minimum you need:
- A C++17-capable compiler
- CMake 3.16 or newer
- GLFW development libraries (or use the ones provided via toolchains)

## 3. Build With the Helper Script

```bash
chmod +x build-multi.sh
./build-multi.sh --help
# Example: build for macOS arm64
./build-multi.sh mac-arm
```

The script chooses a build directory, configures CMake with the right toolchain, and compiles the sample triangle application. Outputs go into platform-specific folders (e.g., `mac-arm-app/`, `build-linux-x86_64/`).

## 4. Run the Sample App

Depending on the platform, the executable will live under the build directory or inside an application bundle. Examples:

```bash
# macOS bundle
./mac-arm-app/OGLQuickstart.app/Contents/MacOS/OGLQuickstart

# Linux or Windows build tree
./build-linux-x86_64/OGLQuickstart
```

## 5. Next Steps
- Modify `main.cpp` to render your own scene.
- Update `shaders/basic.vert` and `shaders/basic.frag`.
- Review [Repository Hygiene](Repository-Hygiene.md) for what to keep out of Git before publishing.

Continue to the platform pages for detailed dependency installation instructions.
