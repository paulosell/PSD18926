cmake_minimum_required(VERSION 3.10)
project(Neuron)

set(CMAKE_C_STANDARD 11)

# Add the source file
set(SOURCE_FILES src/neuron.c)

# Create the executable
add_executable(neuron ${SOURCE_FILES})
