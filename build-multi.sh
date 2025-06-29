#!/bin/bash

set -e

PLATFORM="$1"
ARCH="$2"

if [[ -z "$PLATFORM" || -z "$ARCH" ]]; then
    echo "Usage: $0 [macos|linux|windows] [arm64|x86_64]"
    exit 1
fi

BUILD_DIR="build-${PLATFORM}-${ARCH}"

case "$PLATFORM" in
    macos)
        if [[ "$ARCH" == "arm64" || "$ARCH" == "x86_64" ]]; then
            echo "Building for macOS $ARCH..."
            cmake -B $BUILD_DIR -DCMAKE_OSX_ARCHITECTURES="$ARCH" -DCMAKE_BUILD_TYPE=Release
            cmake --build $BUILD_DIR --config Release
            echo "Built app at $BUILD_DIR/OPENGL_JOURNEY_EXE_APP"
        else
            echo "Unsupported architecture for macOS: $ARCH"
            exit 2
        fi
        ;;
    linux)
        if [[ "$ARCH" == "arm64" || "$ARCH" == "x86_64" ]]; then
            TOOLCHAIN_FILE="linux-${ARCH}-toolchain.cmake"
            if [[ -f "$TOOLCHAIN_FILE" ]]; then
                echo "Cross-compiling for Linux $ARCH..."
                cmake -B $BUILD_DIR -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_FILE -DCMAKE_BUILD_TYPE=Release
            else
                echo "Building for Linux $ARCH (native toolchain)..."
                cmake -B $BUILD_DIR -DCMAKE_BUILD_TYPE=Release
            fi
            cmake --build $BUILD_DIR --config Release
            echo "Built app at $BUILD_DIR/OPENGL_JOURNEY_EXE_APP"
        else
            echo "Unsupported architecture for Linux: $ARCH"
            exit 2
        fi
        ;;
    windows)
        if [[ "$ARCH" == "x86_64" || "$ARCH" == "arm64" ]]; then
            TOOLCHAIN_FILE="windows-${ARCH}-toolchain.cmake"
            if [[ ! -f "$TOOLCHAIN_FILE" ]]; then
                echo "Toolchain file $TOOLCHAIN_FILE not found!"
                exit 3
            fi
            if [[ "$ARCH" == "arm64" ]]; then
                if ! command -v aarch64-w64-mingw32-gcc >/dev/null 2>&1; then
                    echo "aarch64-w64-mingw32-gcc not found in PATH. Windows arm64 cross-compiler is not installed."
                    echo "Homebrew does not provide this by default. Only Windows x86_64 is supported out-of-the-box."
                    exit 4
                fi
            fi
            echo "Cross-compiling for Windows $ARCH..."
            cmake -B $BUILD_DIR -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_FILE -DCMAKE_BUILD_TYPE=Release
            cmake --build $BUILD_DIR --config Release
            echo "Built Windows app at $BUILD_DIR/OPENGL_JOURNEY_EXE_APP.exe"
        else
            echo "Unsupported architecture for Windows: $ARCH"
            exit 3
        fi
        ;;
esac