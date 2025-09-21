# Building on Windows

## Requirements
- Windows 10/11
- CMake 3.16+
- One of the following toolchains:
  - **Visual Studio 2022** with Desktop development workload
  - **LLVM/MinGW** (download separately; keep outside the Git repo or add to `.gitignore`)

## Using the helper script
```powershell
bash build-multi.sh win-x86
bash build-multi.sh win-arm   # if using the arm64 toolchain
```
(The script expects Git Bash or WSL to run.)

## Manual build with Visual Studio
```powershell
cmake -B build-windows-x86_64 -S . -G "Visual Studio 17 2022" -A x64
cmake --build build-windows-x86_64 --config Release
# Executable located at build-windows-x86_64/Release/OGLQuickstart.exe
```

## Manual build with LLVM/MinGW
```powershell
cmake -B build-windows-mingw -S . -G "MinGW Makefiles" -DCMAKE_TOOLCHAIN_FILE=windows-x86_64-toolchain.cmake
cmake --build build-windows-mingw
```

## Troubleshooting
- **GLFW library missing:** verify the paths in `windows-*-toolchain.cmake` point to your GLFW SDK.
- **Linker errors with MSVC:** ensure you’re building all dependent libraries (GLFW, OpenGL) for the same architecture (x64 or arm64).
