cmake_minimum_required(VERSION 3.14)
project(floresta)

# raylib
find_package(raylib QUIET)
if (NOT raylib_FOUND)
	include(FetchContent)
	FetchContent_Declare(
			raylib
			GIT_REPOSITORY https://github.com/raysan5/raylib.git
			GIT_TAG 5.0
			GIT_SHALLOW 1
	)
	FetchContent_MakeAvailable(raylib)
endif ()

# raylib-cpp
find_package(raylib_cpp QUIET)
if (NOT raylib_cpp_FOUND)
    if (NOT DEFINED RAYLIB_CPP_VERSION)
        set(RAYLIB_CPP_VERSION v5.0.2)
    endif()
    include(FetchContent)
    FetchContent_Declare(
        raylib_cpp
        GIT_REPOSITORY https://github.com/RobLoach/raylib-cpp.git
        GIT_TAG ${RAYLIB_CPP_VERSION}
    )
    FetchContent_MakeAvailable(raylib_cpp)
endif()

# This is the main part:
set(SOURCES main.cpp)
add_executable(${PROJECT_NAME} ${SOURCES})
set_target_properties(${PROJECT_NAME} PROPERTIES CXX_STANDARD 11)
target_link_libraries(${PROJECT_NAME} PUBLIC raylib raylib_cpp)