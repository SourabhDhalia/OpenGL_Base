
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <iostream>

using namespace std;

int main()
{
    // Initialize GLFW
    if (!glfwInit())
    {
        std::cerr << "Failed to initialize GLFW\n";
        return -1;
    }
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    // Create a windowed mode window and its OpenGL context
    GLFWwindow *window = glfwCreateWindow(800, 600, "OGLQuickstart", nullptr, nullptr);
    try
    {
        cout << "Hello, OGLQuickstart!" << endl;
        cout << "App Started..." << endl;

        // Check if the window was created successfully
        if (!window)
        {
            cerr << "Failed to create GLFW window" << endl;
            glfwTerminate();
            return -1; // Return -1 to indicate failure
        }
        // Make the window's context current
        glfwMakeContextCurrent(window);
        // Load OpenGL functions using GLFW

        // gladLoadGLLoader is used to load OpenGL function pointers
        //  This is necessary to use OpenGL functions in the application
        //  gladLoadGLLoader is a function provided by the GLAD library
        //  It initializes the OpenGL function pointers based on the current OpenGL context
        //  The function takes a pointer to a function that retrieves the address of OpenGL functions
        //  In this case, glfwGetProcAddress is used to retrieve the addresses of OpenGL
        //  functions for the current context
        //  This is necessary because OpenGL functions are not directly available in the application
        //  and need to be loaded dynamically at runtime.
        if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
        {
            std::cerr << "Failed to initialize GLAD" << std::endl;
            return -1;
        }
        while (!glfwWindowShouldClose(window))
        {
            // Poll for and process events (update the state of the window)
            glfwPollEvents();
            glClearColor(0.39f, 0.58f, 0.93f, 0.0f);
            glClear(GL_COLOR_BUFFER_BIT);
            glfwSwapBuffers(window);
            cout << "\r" << "OGLQuickstart is running...";
        }
    }
    catch (const std::exception &e)
    {
        cout << "\nAn error occurred: " << e.what() << endl;
    }
    glfwDestroyWindow(window);
    glfwTerminate();
    cout << "\nApp Ended..." << endl;
    return 0; // Return 0 to indicate successful execution
}
