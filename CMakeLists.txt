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
function(link libname)
	find_package(${libname} REQUIRED)
	
	# Use second argument as libtarget if provided, otherwise name::name
	if(ARGC EQUAL 2)
		set(libtarget ${ARGV1})
	else()
		set(libtarget ${libname}::${libname})
	endif()

	# Link to project
	target_link_libraries(${PROJECT_NAME} PRIVATE ${libtarget})

	# Install files if applicable	
	get_target_property(target_type ${libtarget} TYPE)
	if (target_type STREQUAL "EXECUTABLE" OR target_type STREQUAL "STATIC_LIBRARY" OR target_type STREQUAL "SHARED_LIBRARY" OR target_type STREQUAL "MODULE_LIBRARY" )
		install(FILES $<TARGET_FILE:${libtarget}> DESTINATION bin)
	endif ()
endfunction()

link(fmt)

#--------------------------------------------------------------------------------------------------
# Install
set(CMAKE_INSTALL_PREFIX ${CMAKE_CURRENT_SOURCE_DIR})
install(TARGETS ${PROJECT_NAME} DESTINATION bin)

#--------------------------------------------------------------------------------------------------
# Finish up
message(STATUS "Project ${PROJECT_NAME} configured")
message(STATUS "-------------------------------")
