cmake_minimum_required(VERSION 2.8.7)
project(zip C)

OPTION (ZIP_BUILD_LUA "Build build lua" ON)

aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR}/../lib SRC_LIST)
if (NOT WIN32)
    list(REMOVE_ITEM SRC_LIST ${CMAKE_CURRENT_SOURCE_DIR}/../lib/mkstemp.c)
endif ()
IF (ZIP_BUILD_LUA)
    LIST (APPEND SRC_LIST
        ${CMAKE_CURRENT_SOURCE_DIR}/../lua-zip/lua_zip.c
        ${CMAKE_CURRENT_SOURCE_DIR}/../lua-zip/lua_zip.def
    )
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/lua_include)
ENDIF ()

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../lib)

IF (WIN32)
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/zlib_include)
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../win32)
ELSE()
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../xcode)
ENDIF ()

add_library(zip ${SRC_LIST})

IF (WIN32)
    SET_TARGET_PROPERTIES(zip PROPERTIES COMPILE_FLAGS "/MP" ${BUILD_FLAGS})
ENDIF ()
