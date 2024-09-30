project(Floresta)

add_executable(${PROJECT_NAME})
add_library(Game STATIC)

set(TARGETS ${PROJECT_NAME} Game)

foreach (TARGET IN LISTS TARGETS)
	target_sources(${TARGET} PRIVATE
			main.cpp
	)
endforeach ()

target_include_directories(${PROJECT_NAME} PUBLIC
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_SOURCE_DIR}/../Mistral
)

target_link_libraries(${PROJECT_NAME} PUBLIC raylib raylib_cpp Mistral)


set(OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/resources")

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_SOURCE_DIR}/Floresta/resources
    ${OUTPUT_DIRECTORY}
)