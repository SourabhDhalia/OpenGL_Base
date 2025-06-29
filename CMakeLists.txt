cmake_minimum_required(VERSION 3.16)
project(OPENGL_JOURNEY)

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
    set(APP_ICON appicon.rc)
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

add_executable(OPENGL_JOURNEY_EXE_APP
    main.cpp
    external/glad/src/glad.c
    ${APP_ICON}
)

target_include_directories(OPENGL_JOURNEY_EXE_APP PRIVATE
    external/glad/include
)
if(APPLE AND DEFINED GLFW3_INCLUDE_DIR)
    target_include_directories(OPENGL_JOURNEY_EXE_APP PRIVATE ${GLFW3_INCLUDE_DIR})
endif()

if(APPLE)
    if(DEFINED GLFW3_LIBRARIES)
        target_link_libraries(OPENGL_JOURNEY_EXE_APP PRIVATE ${GLFW3_LIBRARIES} "-framework OpenGL")
    else()
        target_link_libraries(OPENGL_JOURNEY_EXE_APP PRIVATE glfw "-framework OpenGL")
    endif()
elseif(WIN32)
    target_link_libraries(OPENGL_JOURNEY_EXE_APP PRIVATE glfw OpenGL::GL)
else()
    target_link_libraries(OPENGL_JOURNEY_EXE_APP PRIVATE glfw OpenGL::GL)
endif()

target_compile_features(OPENGL_JOURNEY_EXE_APP PRIVATE cxx_std_17)

set_target_properties(OPENGL_JOURNEY_EXE_APP PROPERTIES
    MACOSX_BUNDLE TRUE
    MACOSX_BUNDLE_ICON_FILE opengl.icns
    RESOURCE "${APP_ICON}"
)