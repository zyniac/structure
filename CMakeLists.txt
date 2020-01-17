cmake_minimum_required(VERSION 3.16)
include(cmake/build.cmake)
project(ZyniacDevBase VERSION 0.1 DESCRIPTION "Development Base that is required to build the Zyniac projects.")

set(CMAKE_BINARY_DIR ${CMAKE_SOURCE_DIR}/bin)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR})

addproject("command-line-interface")
addproject("command-handler")

set(IncludeDir "${CMAKE_CURRENT_SOURCE_DIR}/Include/")
set(SourceDir "${CMAKE_CURRENT_SOURCE_DIR}/src/")

if(PROJECT_commandlineinterface_INCLUDED)
    message(STATUS "Project Included")
else()
    message(STATUS "Project not Included")
endif()

message(STATUS ${TESTING})
message(STATUS ${LENGTH})

file(GLOB_RECURSE IncludeFiles "${IncludeDir}*.h")
file(GLOB_RECURSE SourceFiles "${SourceDir}*.cpp")

add_executable(Zyniac ${IncludeFiles} ${SourceFiles})
message(STATUS "-------------------------------")
message("[x] Zyniac Executable")
message(STATUS "-------------------------------")
addincdirs(Zyniac)