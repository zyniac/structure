# Function for adding other zyniac projects as library
function(addproject pn)
    set(PLUG_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../${pn}")
    if(NOT EXISTS ${PLUG_PATH})
        set(PLUG_PATH "${CMAKE_SOURCE_DIR}/packages/${pn}")
    endif()
    string(REPLACE "-" "" DEF_NAME ${pn})
    list(LENGTH ARGN LIST_LENGTH)
    if(LIST_LENGTH GREATER 0)
        list(GET ARGN 0 TMP_PLUG_PATH)
        set(PLUG_PATH ${TMP_PLUG_PATH}/${pn})
    endif()
    if(EXISTS ${PLUG_PATH})
        add_subdirectory(${PLUG_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/bin/${pn})
        set(${pn}_INCLUDED TRUE PARENT_SCOPE)
        set(IncludeDirs ${IncludeDirs} "${PLUG_PATH}/Include" PARENT_SCOPE)
        set(LibraryDirs ${LibraryDirs} ${CMAKE_BINARY_DIR} PARENT_SCOPE)
        set(Libraries ${Libraries} ${pn} PARENT_SCOPE)
        set(DEFINES ${DEF_NAME}_INCLUDED)
        add_definitions(-D${DEFINES})
        set(PROJECT_${DEF_NAME}_INCLUDED TRUE PARENT_SCOPE)
    else()
        set(PROJECT_${DEF_NAME}_INCLUDED FALSE PARENT_SCOPE)
    endif()
endfunction()

# This function points to the include directories. It is nomally included in genexe and genlib
function(addincdirs ln)
    target_include_directories(${ln} PUBLIC ${IncludeDirs})
    target_link_directories(${ln} PUBLIC ${LibraryDirs})
    target_link_libraries(${ln} PUBLIC ${Libraries})
    set_target_properties(${ln} PROPERTIES
                CXX_STANDARD 17
                CXX_STANDARD_REQUIRED ON)
endfunction()

# Generates a test executeable and points to the include files
function(genexe)
    if(NOT DEFINED ${PROJECT_LIB}_INCLUDED)
        add_executable(${PROJECT_TEST} ${ExeFiles})
        addincdirs(${PROJECT_TEST})
        set(MADE_BUILD TRUE PARENT_SCOPE)
        set(MADE_TEST_BUILD TRUE PARENT_SCOPE)
    endif()
endfunction()

# Generates the library and points to the include files
function(genlib)
    if(NOT DEFINED ${PROJECT_LIB}_INCLUDED)
        add_library(${PROJECT_LIB} ${LibFiles})
        addincdirs(${PROJECT_LIB})
        set(MADE_BUILD TRUE PARENT_SCOPE)
        set(MADE_LIBRARY_BUILD TRUE PARENT_SCOPE)
    endif()
endfunction()