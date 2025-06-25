project(floresta)

# Game library
add_library(${PROJECT_NAME}_lib)

add_subdirectory(game)

target_include_directories(${PROJECT_NAME}_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(${PROJECT_NAME}_lib PUBLIC mistral_lib)

# Game executable
add_executable(${PROJECT_NAME} main.cpp)

target_link_libraries(${PROJECT_NAME} PUBLIC ${PROJECT_NAME}_lib)

# Copy resources directory into build path
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E copy_directory
		${CMAKE_CURRENT_SOURCE_DIR}/resources
		"${CMAKE_CURRENT_BINARY_DIR}/resources"
)