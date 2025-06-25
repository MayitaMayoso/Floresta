include(FetchContent)

# raylib
FetchContent_Declare(
		raylib
		GIT_REPOSITORY https://github.com/raysan5/raylib.git
		GIT_TAG        5.5
		GIT_SHALLOW    1
)
FetchContent_MakeAvailable(raylib)

# raylib-cpp
FetchContent_Declare(
		raylib_cpp
		GIT_REPOSITORY https://github.com/RobLoach/raylib-cpp.git
		GIT_TAG        v5.5.0
)
FetchContent_MakeAvailable(raylib_cpp)

# raygui (header-only)
FetchContent_Declare(
		raygui
		GIT_REPOSITORY https://github.com/raysan5/raygui.git
		GIT_TAG        4.0
)
FetchContent_MakeAvailable(raygui)

# Add include path only, no library to link
target_include_directories(${PROJECT_NAME}_lib PUBLIC ${raygui_SOURCE_DIR}/src)

target_link_libraries(${PROJECT_NAME}_lib PUBLIC raylib raylib_cpp)
