
#Libraries
1.crossplatform window creationg and inputs -> GLFW (make the code platform(OS) indipendant)

2.using OpenGL api's written for specific GPU by (nvidia, amd, intel and apple) internals are different but api name are same and use case is same
->GLAD, GLEW
we are using GLAD
its like runtime liberaries (.ddl, .so, .dylib)

3.stb_image -> uesd to load image to openGL app(it can read image content)

4.-framework OpenGL tells your Mac to use Apple’s built-in OpenGL code, which is needed to draw graphics.



ARCHITECHTURE:
Your C++ Code
    |
    v
GLFW/GLAD/stb_image
    |
    v
OpenGL Function Calls
    |
    v
OpenGL Driver (from GPU vendor)
    |
    v
Operating System (manages hardware access)(kernal)
    |
    v
GPU Hardware (renders graphics)



