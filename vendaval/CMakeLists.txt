project(vendaval)

add_executable(${PROJECT_NAME}
		main.cpp
		Vendaval.h
		Vendaval.cpp
)

target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(${PROJECT_NAME} PUBLIC floresta_lib)