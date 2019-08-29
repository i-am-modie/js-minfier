cmake_minimum_required(VERSION 3.14)
project(js_minifucker C)

set(CMAKE_C_STANDARD 11)

include_directories(.)

add_executable(js_minifucker
    lex.yy.c
    parser.tab.c
    parser.tab.h
    symtab.c
    symtab.h)
