cmake_minimum_required(VERSION 3.22 FATAL_ERROR)

#--------------------------------------------------------------------------------------------------
# Project setting
project(sampleproject LANGUAGES CXX)
message(STATUS "-------------------------------")
message(STATUS "Processing Project ${PROJNAME}:")
set(BASE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

#--------------------------------------------------------------------------------------------------
# C++ target and defines
set(CMAKE_CXX_STANDARD 23)
add_executable(${PROJECT_NAME})
if(MSVC)
	message(STATUS "Adding MSVC-specific definitions")
	target_compile_definitions(${PROJECT_NAME} PRIVATE -DNOMINMAX -DWIN32_LEAN_AND_MEAN)
endif(MSVC)

#--------------------------------------------------------------------------------------------------
# Source files for this project
file(GLOB SOURCE_FILES src/*.cpp src/*.hpp src/*.inl src/*.h src/*.c)
set(BUILD_FILES CMakePresets.json vcpkg.json)
set(MISC_FILES README.md)
set(ALL_FILES ${SOURCE_FILES} ${BUILD_FILES} ${MISC_FILES})
target_sources(${PROJECT_NAME} PUBLIC ${ALL_FILES})
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${ALL_FILES})

#--------------------------------------------------------------------------------------------------
# Third-party libs
function(link libname libtarget)
	find_package(${libname} REQUIRED)
	target_link_libraries(${PROJECT_NAME} PRIVATE ${libtarget})
endfunction()

link(fmt fmt::fmt)

#--------------------------------------------------------------------------------------------------
# Install
set(CMAKE_INSTALL_PREFIX ${CMAKE_CURRENT_SOURCE_DIR})
install(TARGETS ${PROJECT_NAME} DESTINATION bin)

#--------------------------------------------------------------------------------------------------
# Finish up
message(STATUS "Project ${PROJECT_NAME} configured")
message(STATUS "-------------------------------")
