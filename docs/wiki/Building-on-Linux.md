# Building on Linux

## Requirements
- GCC or Clang with C++17 support
- CMake 3.16+
- GLFW development package and OpenGL headers

### Install dependencies (Ubuntu/Debian example)
```bash
sudo apt update
sudo apt install build-essential cmake libglfw3-dev libx11-dev libxrandr-dev libxi-dev libxxf86vm-dev libxinerama-dev
```

### Using the helper script
```bash
./build-multi.sh linux-x86
./build-multi.sh linux-arm   # when cross-compiling to arm64
```

### Manual CMake build
```bash
cmake -B build-linux-x86_64 -S .
cmake --build build-linux-x86_64
./build-linux-x86_64/OGLQuickstart
```

For arm64 cross-compiles, include `-DCMAKE_TOOLCHAIN_FILE=linux-arm64-toolchain.cmake`.

## Troubleshooting
- **GLFW not found:** install `libglfw3-dev` or build GLFW from source and set `GLFW3_DIR` in the environment.
- **Wayland issues:** the template defaults to X11; ensure X11 headers are installed or adapt the CMake scripts for Wayland support.
