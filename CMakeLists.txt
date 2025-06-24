cmake_minimum_required(VERSION 3.22)

project(my_gpu_project LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# VS Code で利用するため compile_commands.json を出力
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(MPI REQUIRED CXX)

# MPIの動作確認用
add_executable(hello_mpi hello_mpi.cpp)
target_link_libraries(hello_mpi PRIVATE MPI::MPI_CXX)

# CUDAの動作確認用
enable_language(CUDA)
add_executable(vector_add vector_add.cu)

