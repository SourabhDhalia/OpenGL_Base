# OpenGLJourney: Cross-Platform OpenGL App

This project demonstrates a robust, portable OpenGL application that can be built for **macOS**, **Linux**, and **Windows** on both **x86_64** and **arm64** architectures, all from a single codebase.  
Toolchain files and scripts are provided for seamless cross-compilation.

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Building](#building)
- [Running](#running)
- [How It Works](#how-it-works)
- [Why Use Toolchains?](#why-use-toolchains)
- [How Toolchains Are Integrated](#how-toolchains-are-integrated)
- [Troubleshooting & Fixes](#troubleshooting--fixes)
- [Adding RISC-V Support (Future)](#adding-risc-v-support-future)
- [FAQ](#faq)

---

## Prerequisites

### On macOS (Apple Silicon or Intel)

- [Homebrew](https://brew.sh/)
- CMake, Ninja, and cross-compilers:
  ```sh
  brew install cmake ninja mingw-w64 FiloSottile/musl-cross/musl-cross messense/macos-cross-toolchains/aarch64-unknown-linux-gnu


  For Windows arm64: llvm-mingw (see below)
On Linux
CMake, Ninja, build-essential, and cross-compilers (if cross-compiling)
sudo apt update

sudo apt update
sudo apt install build-essential cmake ninja-build libglfw3-dev libgl1-mesa-dev

On Windows
CMake
Visual Studio or MinGW-w64
vcpkg (optional, for dependencies)
Installation
Clone the repository
git clone https://github.com/yourusername/OpenGLJourney.git
cd OpenGLJourney
(Optional, for Windows arm64 cross-compilation on macOS)

Install prerequisites:
brew install cmake ninja autoconf libtool pkgconf python3 wget make gmp mpfr libmpc isl zstd

Clone and build llvm-mingw:
git clone https://github.com/mstorsjo/llvm-mingw.git
cd llvm-mingw
./release-macos.sh 20250613
export PATH="$HOME/llvm-mingw-20250613-ucrt-macos-universal/bin:$PATH"

You can now use clang --target=aarch64-w64-windows-gnu for Windows arm64.
Building
macOS (arm64/x86_64)

./build-multi.sh macos arm64
./build-multi.sh macos x86_64

Linux (x86_64/arm64)

./build-multi.sh linux x86_64
./build-multi.sh linux arm64


Windows (x86_64/arm64)

./build-multi.sh windows x86_64
./build-multi.sh windows arm64
# (arm64 requires llvm-mingw as above)


Binaries will be in:

build-macos-arm64, build-macos-x86_64
build-linux-x86_64, build-linux-arm64
build-windows-x86_64, build-windows-arm64
Running
macOS:
Run the binary directly:
OPENGL_JOURNEY_EXE_APP or OPENGL_JOURNEY_EXE_APP
Linux:
Transfer and run on a Linux machine/VM:
./linux-x86-app/OPENGL_JOURNEY_EXE_APP or ./linux-arm-app/OPENGL_JOURNEY_EXE_APP
Windows:
Transfer and run on a Windows machine/VM:
OPENGL_JOURNEY_EXE_APP.exe in the appropriate build folder.
How It Works
CMakeLists.txt detects the platform and architecture, sets output folders, and links the correct libraries.
Toolchain files tell CMake which compiler and system root to use for cross-compilation.
build-multi.sh automates the build process for all supported platforms and architectures.
Why Use Toolchains?
Native builds (e.g., macOS on macOS) use system compilers and libraries.
Cross-compiling (e.g., Windows/Linux from macOS) requires telling CMake which compiler to use and where to find the correct libraries for the target platform.
Toolchain files make this process reproducible and portable.
How Toolchains Are Integrated
When you run .[build-multi.sh](http://_vscodecontentref_/10) windows arm64, the script uses windows-arm64-toolchain.cmake:
Sets clang as the compiler.
Adds --target=aarch64-w64-windows-gnu to build Windows arm64 binaries.
For Linux, similar toolchain files are used for x86_64 and arm64 with the correct cross-compiler.
Troubleshooting & Fixes
Missing compiler:
If you see not found in PATH, ensure the toolchain is installed and in your PATH.
Missing toolchain file:
If you see Toolchain file ... not found!, copy the provided toolchain files or create your own.
Windows arm64:
Homebrew does not provide aarch64-w64-mingw32-gcc. Use llvm-mingw as described above.
Linux/Windows libraries:
For cross-compiling, you may need to build or provide target platform libraries (e.g., GLFW).
Adding RISC-V Support (Future)
Add a toolchain file for RISC-V (e.g., riscv64-linux-gnu-gcc).
Install a RISC-V cross-compiler (e.g., via Homebrew or from source).
Update build-multi.sh and CMake logic to support riscv64.
FAQ
Q: Can I run Windows or Linux binaries on macOS?
A: No. You must transfer them to the target OS or use a VM.

Q: Why do I get linker errors about missing symbols?
A: You are likely using the wrong libraries for the target platform. Make sure you use the correct toolchain and libraries.

Q: How do I add a new architecture?
A: Add a toolchain file, install the cross-compiler, and update build-multi.sh.

Credits
GLFW
llvm-mingw
musl-cross
Homebrew
CMake

Happy cross-platform building!