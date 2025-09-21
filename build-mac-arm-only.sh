#!/bin/bash

# Exit on error
set -e

# Build directory
BUILD_DIR="build"

# Create build directory if it doesn't exist
mkdir -p $BUILD_DIR

# Run CMake and build
cmake -B $BUILD_DIR
cmake --build $BUILD_DIR

# Run the executable
./mac-x86-app/OGLQuickstart.app/Contents/MacOS/OGLQuickstart