cmake_minimum_required(VERSION 3.7)
project(TP0_orga)

set(CMAKE_CXX_STANDARD 11)

set(SOURCE_FILES main.c
        fileHandler.c
        fileHandler.h
        flags.h
        )
add_executable(TP0_orga ${SOURCE_FILES})