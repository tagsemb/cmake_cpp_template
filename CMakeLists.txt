cmake_minimum_required(VERSION 3.27.2 FATAL_ERROR)

#--------------------------------------------------------------------------------------------------
# Project setting
set(PROJNAME sampleproject)
project(${PROJNAME} LANGUAGES CXX)
message(STATUS "-------------------------------")
message(STATUS "Processing Project ${PROJNAME}:")
set(BASE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

#--------------------------------------------------------------------------------------------------
# C++ target and defines
#include(${CMAKE_CURRENT_SOURCE_DIR}/nvpro_core/CMakeLists.txt)
#include(${CMAKE_CURRENT_SOURCE_DIR}/nvpro_core/cmake/utilities.cmake)
#include(${CMAKE_CURRENT_SOURCE_DIR}/nvpro_core/cmake/setup.cmake)
#add_subdirectory(nvpro_core)
set(CMAKE_CXX_STANDARD 23)
add_executable(${PROJNAME})

#--------------------------------------------------------------------------------------------------
# Source files for this project
#
file(GLOB SOURCE_FILES src/*.cpp src/*.hpp src/*.inl src/*.h src/*.c)
set(BUILD_FILES CMakePresets.json vcpkg.json)
set(ALL_FILES ${SOURCE_FILES} ${BUILD_FILES})
target_sources(${PROJNAME} PUBLIC ${ALL_FILES})
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${ALL_FILES})

#--------------------------------------------------------------------------------------------------
# Third-party libs
#
function(link libname libtarget)
	find_package(${libname} REQUIRED)
	target_link_libraries(${PROJNAME} PRIVATE ${libtarget})
endfunction()

link(fmt fmt::fmt)

#--------------------------------------------------------------------------------------------------
# Finish up
message(STATUS "Project ${PROJNAME} configured")
message(STATUS "-------------------------------")
