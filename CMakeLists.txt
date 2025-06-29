cmake_minimum_required(VERSION 3.16)
project(OPENGL_JOURNEY)
set(CMAKE_OSX_ARCHITECTURES "arm64")

# set the path to where GLFW3 is installed on your system to check 1st
set(GLFW3_DIR "/opt/homebrew/lib/cmake/glfw3")
# find glfw3 package
find_package(GLFW3 REQUIRED)



# Set output directory for executables
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR})



add_executable(OPENGL_JOURNEY_EXE_APP 
main.cpp
external/glad/src/glad.c
)
target_include_directories(OPENGL_JOURNEY_EXE_APP PRIVATE
    external/glad/include
)
target_link_libraries(OPENGL_JOURNEY_EXE_APP PRIVATE glfw  "-framework OpenGL") #-framework OpenGL tells your Mac to use Apple’s built-in OpenGL code, which is needed to draw graphics.

target_compile_features(OPENGL_JOURNEY_EXE_APP PRIVATE cxx_std_17)