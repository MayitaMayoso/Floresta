project(floresta)

# Game project and files that compound it
add_executable(${PROJECT_NAME})

target_sources(${PROJECT_NAME} PRIVATE
		main.cpp
)

add_subdirectory(game)

# Dependencies and headers
target_include_directories(${PROJECT_NAME} PUBLIC
		${CMAKE_CURRENT_SOURCE_DIR}
		${mistral_SOURCE_DIR}
)

target_link_libraries(${PROJECT_NAME} PUBLIC mistral)

# Copy resources directory into build path
set(OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/resources")

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E copy_directory
		${CMAKE_SOURCE_DIR}/Floresta/resources
		${OUTPUT_DIRECTORY}
)