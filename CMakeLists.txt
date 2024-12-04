cmake_minimum_required(VERSION 3.11)

project(Assembly CXX)

set(CMAKE_CXX_STANDARD 23)

if(MSVC)
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS true)

    if(CMAKE_CXX_FLAGS MATCHES "/W[0-4]")
        string(REGEX REPLACE "/W[0-4]" "/W4" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
    else()
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4")
    endif()
endif()

# Собираем medium.cc как исполняемый файл
add_executable(medium_exec "src/medium.cc")
target_include_directories(medium_exec PUBLIC "include")

# Собираем hard.cc как исполняемый файл
add_executable(hard_exec "src/hard.cc")
target_include_directories(hard_exec PUBLIC "include")