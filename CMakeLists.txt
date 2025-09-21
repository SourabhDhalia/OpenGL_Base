cmake_minimum_required(VERSION 3.16)
project(OGLQuickstart)

if(APPLE)
    set(MACOSX_BUNDLE_ICON_FILE opengl.icns)
    set_source_files_properties(icon/opengl.icns PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
    set(APP_ICON icon/opengl.icns)
    set(MACOSX_BUNDLE TRUE)
    if(NOT DEFINED CMAKE_OSX_ARCHITECTURES)
        set(CMAKE_OSX_ARCHITECTURES "arm64")
    endif()
    if(CMAKE_OSX_ARCHITECTURES STREQUAL "arm64")
        set(GLFW3_DIR "/opt/homebrew/lib/cmake/glfw3")
    elseif(CMAKE_OSX_ARCHITECTURES STREQUAL "x86_64")
        set(GLFW3_DIR "/usr/local/lib/cmake/glfw3")
    endif()
endif()

if(WIN32)
    enable_language(RC)
    set(APP_ICON icon/opengl.ico)
    set(GLFW3_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/WinOpenGLFiles/glfw-3.3.2.bin.WIN64/include")
    set(GLFW3_LIBRARY "${CMAKE_SOURCE_DIR}/WinOpenGLFiles/glfw-3.3.2.bin.WIN64/lib-vc2019/glfw3.lib")  # Change lib-vc2019 to lib-vc2022 if needed
    set(GLFW3_LIBRARIES "${GLFW3_LIBRARY}")
    set(GLFW3_FOUND TRUE)
    add_library(glfw STATIC IMPORTED)
    set_target_properties(glfw PROPERTIES
        IMPORTED_LOCATION "${GLFW3_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${GLFW3_INCLUDE_DIR}"
    )
endif()



find_package(OpenGL REQUIRED)
find_package(GLFW3 QUIET)


# Only set manual include/library for macOS if not found
if(APPLE AND NOT GLFW3_FOUND)
    if(CMAKE_OSX_ARCHITECTURES MATCHES "arm64")
        set(GLFW3_INCLUDE_DIR "/opt/homebrew/include")
        set(GLFW3_LIBRARY "/opt/homebrew/lib/libglfw.3.dylib")
    else()
        set(GLFW3_INCLUDE_DIR "/usr/local/include")
        set(GLFW3_LIBRARY "/usr/local/lib/libglfw.3.dylib")
    endif()
    if(EXISTS "${GLFW3_INCLUDE_DIR}/GLFW/glfw3.h" AND EXISTS "${GLFW3_LIBRARY}")
        set(GLFW3_FOUND TRUE)
        set(GLFW3_LIBRARIES "${GLFW3_LIBRARY}")
    else()
        message(FATAL_ERROR "GLFW3 not found! Please install via Homebrew for your architecture.")
    endif()
elseif(NOT GLFW3_FOUND)
    message(FATAL_ERROR "GLFW3 not found! Please install GLFW3 for your platform.")
endif()

# Output folders
if(APPLE)
    if(CMAKE_OSX_ARCHITECTURES MATCHES "arm64")
        set(PLATFORM_FOLDER "mac-arm-app")
    else()
        set(PLATFORM_FOLDER "mac-x86-app")
    endif()
elseif(WIN32)
    set(PLATFORM_FOLDER "win-x86-app")
elseif(UNIX)
    if(CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64|arm64")
        set(PLATFORM_FOLDER "linux-arm-app")
    else()
        set(PLATFORM_FOLDER "linux-x86-app")
    endif()
else()
    set(PLATFORM_FOLDER "other-app")
endif()
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/${PLATFORM_FOLDER})

set(APP_SOURCES
    main.cpp
    external/glad/src/glad.c
)

if(APP_ICON)
    list(APPEND APP_SOURCES ${APP_ICON})
endif()

add_executable(OGLQuickstart ${APP_SOURCES})

target_include_directories(OGLQuickstart PRIVATE
    external/glad/include
    src
)
if(APPLE AND DEFINED GLFW3_INCLUDE_DIR)
    target_include_directories(OGLQuickstart PRIVATE ${GLFW3_INCLUDE_DIR})
endif()

set(GLFW_LINK_DEPENDENCY "")
if(TARGET glfw)
    set(GLFW_LINK_DEPENDENCY glfw)
elseif(TARGET GLFW3::GLFW)
    set(GLFW_LINK_DEPENDENCY GLFW3::GLFW)
elseif(DEFINED GLFW3_LIBRARIES)
    set(GLFW_LINK_DEPENDENCY ${GLFW3_LIBRARIES})
else()
    message(FATAL_ERROR "Unable to determine GLFW library to link against")
endif()

target_link_libraries(OGLQuickstart PRIVATE ${GLFW_LINK_DEPENDENCY} OpenGL::GL)

target_compile_features(OGLQuickstart PRIVATE cxx_std_17)

if(WIN32)
  set_target_properties(OGLQuickstart PROPERTIES
    SUFFIX ".exe"
    RESOURCE "${APP_ICON}"
  )
elseif(APPLE)
  set_target_properties(OGLQuickstart PROPERTIES
    MACOSX_BUNDLE_BUNDLE_NAME "OGLQuickstart"
    MACOSX_BUNDLE_BUNDLE_VERSION "1.0.0"
    MACOSX_BUNDLE_SHORT_VERSION_STRING "1.0.0"
    MACOSX_BUNDLE_GUI_IDENTIFIER "com.example.oglquickstart"
    MACOSX_BUNDLE_ICON_FILE opengl.icns
    RESOURCE "${APP_ICON}"
  )
elseif(UNIX)
  set_target_properties(OGLQuickstart PROPERTIES
    OUTPUT_NAME "OGLQuickstart"
    VERSION "1.0.0"
    SOVERSION "1"
    RESOURCE "${APP_ICON}"
  )
# else()
#   # Optional: handle other platforms or default
endif()

set_target_properties(OGLQuickstart PROPERTIES
    MACOSX_BUNDLE TRUE
    MACOSX_BUNDLE_ICON_FILE opengl.icns
    RESOURCE "${APP_ICON}"
)
