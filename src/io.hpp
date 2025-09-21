#pragma once

#include <fstream>
#include <sstream>
#include <stdexcept>
#include <string>

inline std::string loadFile(const char *path)
{
    std::ifstream file(path);
    if (!file)
    {
        throw std::runtime_error("Failed to read file: " + std::string(path));
    }

    std::stringstream buffer;
    buffer << file.rdbuf();
    return buffer.str();
}
