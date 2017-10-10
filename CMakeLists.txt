cmake_minimum_required(VERSION 3.7)
project(TP0_orga)

set(CMAKE_CXX_STANDARD 11)

set(SOURCE_FILES tp0/main.c
        tp0/fileHandler.c
        tp0/fileHandler.h
        tp0/flags.h
        tp0/buff.h
        tp0/buff.c
        tp0/main2.c)
add_executable(TP0_orga ${SOURCE_FILES})