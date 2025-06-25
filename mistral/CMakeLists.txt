project(mistral)

add_library(${PROJECT_NAME} STATIC)

target_sources(${PROJECT_NAME} PRIVATE
		Mistral.h
		Mistral.cpp
		Entity.h
		Entity.cpp
		Resources.h
		Resources.cpp
		Camera.h
		Camera.cpp
		Random.h
		Random.cpp
)

target_include_directories(${PROJECT_NAME} PUBLIC
		${CMAKE_CURRENT_SOURCE_DIR}
)

include(Dependencies.cmake)