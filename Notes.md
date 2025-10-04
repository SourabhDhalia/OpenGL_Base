
# OpenGL Quickstart Notes

## Goal
- Understand what each library does, why it’s needed, and how the pieces fit together to render with OpenGL.

## Core Libraries
- GLFW — window + input
  - Opens a window, creates the OpenGL context, and handles keyboard/mouse so your C++ app stays cross‑platform.
- GLAD — OpenGL function loader
  - Retrieves real OpenGL function pointers from the active GPU driver at runtime. Alternatives exist (e.g., GLEW); this project uses GLAD. Think of it like the DLL/SO/dylib bridge exposing the API you call.
- stb_image — image loader
  - Decodes images (PNG/JPG/etc.) into raw pixel buffers you upload as OpenGL textures.
- Platform OpenGL
  - macOS: link with `-framework OpenGL`
  - Windows: link with `opengl32`
  - Linux: link with `GL` (plus standard dependencies via your package manager)

## Rendering Pipeline
1. Your C++ code runs.
2. GLFW creates a window and OpenGL context.
3. GLAD loads OpenGL function pointers for that context.
4. Your code issues OpenGL API calls (buffers, shaders, textures, draw).
5. The GPU vendor’s OpenGL driver validates and forwards commands.
6. The OS mediates hardware access; the GPU renders pixels to the window.

### Architecture Diagram
```text
Your C++ Code
      |
      v
GLFW | GLAD | stb_image   (windowing, function loading, assets)
      |
      v
OpenGL 3.3 Core API Calls (buffers, shaders, textures, draw)
      |
      v
GPU Vendor Driver (NVIDIA / AMD / Intel / Apple)
      |
      v
Operating System (windowing/compositor, kernel)
      |
      v
GPU Hardware (executes commands, renders pixels)
```

## Typical Initialization Order
- Initialize GLFW → create window → make context current.
- Initialize GLAD using `glfwGetProcAddress`.
- Set viewport and resize callback.
- Create/upload geometry (VBO + VAO).
- Compile/link shaders.
- Load images with stb_image (if using textures) → create/bind GL textures.
- Render loop: clear → bind program/VAO/textures → draw → swap → poll events.

## Build/Link Cheatsheet
- CMake example:
  ```cmake
  target_link_libraries(OGLQuickstart PRIVATE ${GLFW_LINK_DEPENDENCY} OpenGL::GL)
  ```
- macOS: ensure Homebrew path matches your arch (arm64 vs x86_64) and link `-framework OpenGL` via `OpenGL::GL`.
- Windows: link `opengl32` and GLFW.
- Linux: link `GL` and GLFW.

## Why Each Is Needed (Quick)
- GLFW: window/context creation and input events.
- GLAD: loads OpenGL functions; without it, calls are null and crash.
- stb_image: converts image files into pixel data for textures.
- Platform OpenGL: actual implementation that talks to the GPU.

## Sanity Checks
- After GLAD init, print OpenGL version:
  ```cpp
  std::cout << reinterpret_cast<const char*>(glGetString(GL_VERSION)) << "\n";
  ```
- After shader compile/link: log errors if compilation/linking fails.
- After texture upload: check for `GL_NO_ERROR` and correct sampler binding.

## Common Pitfalls
- Calling OpenGL before creating the context or before GLAD is initialized.
- Attribute layout mismatch: `layout(location=0)` must match `glVertexAttribPointer(0, ...)`.
- Forgetting to set viewport on creation/resize.
- UVs flipped: use `stbi_set_flip_vertically_on_load(true)` if needed.

## Cross‑Platform Guide

### Overview
- Same codebase works across macOS/Windows/Linux using GLFW + GLAD + OpenGL 3.3 Core.
- Differences are mainly in install method, link libraries, runtime assets, and windowing details.

### macOS
- Install:
  ```bash
  brew install glfw
  ```
  Ensure Homebrew path matches your CPU arch: arm64 → `/opt/homebrew`, x86_64 → `/usr/local`.
- Link: via CMake `OpenGL::GL` (translates to `-framework OpenGL`).
- Notes: OpenGL is deprecated but available; request 3.3 Core profile. Handle HiDPI (Retina) with framebuffer size callback. Enable VSync with `glfwSwapInterval(1)`.
- Paths: this repo’s CMake already switches Homebrew paths per arch.

### Windows
- Install (vcpkg example):
  ```bash
  vcpkg install glfw3:x64-windows
  ```
- Link: `opengl32` and GLFW (`glfw3` static/dynamic). Ensure runtime DLLs sit beside the EXE if using dynamic.
- Notes: Match CRT settings (/MD or /MT) with your libraries. Use Developer Command Prompt for environment.
- Assets: keep `shaders/` next to the EXE or adjust paths.

### Linux
- Install (Debian/Ubuntu example):
  ```bash
  sudo apt-get install libglfw3-dev mesa-common-dev mesa-utils
  ```
- Link: `GL` and GLFW; GLFW pulls in X11/Wayland deps as needed.
- Notes: On Wayland, GLFW may fall back to X11 unless built with Wayland support. Verify GPU drivers (Mesa/NVIDIA proprietary) are installed.
- Test OpenGL:
  ```bash
  glxinfo | grep "OpenGL version"
  ```

## Build Steps Checklist (All Platforms)
- Ensure GLFW and GLAD are available (this repo includes GLAD source; GLFW is external).
- Configure with CMake for your platform/arch; when cross‑compiling, set `-DCMAKE_TOOLCHAIN_FILE=` to a provided toolchain:
  - Windows cross: `windows-*-toolchain.cmake`
  - Linux cross: `linux-*-toolchain.cmake`
- Keep runtime assets available (e.g., copy `shaders/` next to the app). Post‑build copy snippet:
  ```cmake
  add_custom_command(TARGET OGLQuickstart POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_SOURCE_DIR}/shaders
            $<TARGET_FILE_DIR:OGLQuickstart>/shaders)
  ```
- Run the app from the folder containing the `shaders/` directory or use absolute paths.

## Platform Gotchas to Remember
- File paths: relative asset paths differ when launching from build folders; prefer copying `shaders/` next to the binary.
- Context first, then GLAD: never call OpenGL before making the context current and initializing GLAD.
- Version/profile: always request 3.3 Core; older GPUs may need a lower version.
- HiDPI: use framebuffer size, not window size, to set the viewport.
- Runtime libs: Windows needs DLLs present; Linux needs dev/runtime packages; macOS frameworks are system‑provided.
