#/****************************************************************************
# Copyright (c) 2013 cocos2d-x.org
# Copyright (c) 2014 martell malone
#
# http://www.cocos2d-x.org
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# ****************************************************************************/

# this CMakeLists is to generate libChipmunk.a
cmake_minimum_required(VERSION 2.8)

include(BuildHelpers.CMakeLists.txt)

if(DEBUG_MODE)
  set(CMAKE_BUILD_TYPE DEBUG)
else(DEBUG_MODE)
  set(CMAKE_BUILD_TYPE RELEASE)
endif(DEBUG_MODE)

set(CMAKE_C_FLAGS_DEBUG "-DCOCOS2D_DEBUG=1")
set(CMAKE_CXX_FLAGS_DEBUG ${CMAKE_C_FLAGS_DEBUG})

if(MSVC)
  ADD_DEFINITIONS(-D_CRT_SECURE_NO_WARNINGS -D_SCL_SECURE_NO_WARNINGS
                  -wd4251 -wd4244 -wd4334 -wd4005 -wd4820 -wd4710
                  -wd4514 -wd4056 -wd4996 -wd4099)
else()
  set(CMAKE_C_FLAGS_DEBUG "-g -Wall -DCOCOS2D_DEBUG=1")
  set(CMAKE_CXX_FLAGS_DEBUG ${CMAKE_C_FLAGS_DEBUG})
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fno-exceptions -std=c99")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-exceptions -std=c++11 -Wno-deprecated-declarations -Wno-reorder")
endif(MSVC)

if(WINDOWS)
  ADD_DEFINITIONS (-D_USRDLL -DCOCOS2DXWIN32_EXPORTS -D_WINDOWS -DWIN32)
  set(PLATFORM_FOLDER win32)
elseif(MACOSX)
  set(PLATFORM_FOLDER mac)
else(LINUX)
  ADD_DEFINITIONS(-DLINUX)
  set(PLATFORM_FOLDER linux)
endif()

if(MINGW)
  add_definitions(-DGLEW_STATIC)
  add_definitions(-D__SSIZE_T)
  set(CMAKE_C_STANDARD_LIBRARIES "${CMAKE_C_STANDARD_LIBRARIES} -lws2_32")
  set(CMAKE_CXX_STANDARD_LIBRARIES "${CMAKE_CXX_STANDARD_LIBRARIES} -lws2_32")

  if(CLANG)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fno-exceptions ")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-exceptions ")
  endif()
endif()

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/cocos
  ${CMAKE_CURRENT_SOURCE_DIR}/cocos/base
  ${CMAKE_CURRENT_SOURCE_DIR}/cocos/platform/ios
)

file(GLOB_RECURSE spine_source_files 
  "${CMAKE_CURRENT_SOURCE_DIR}/spine/*.cpp"
     "${CMAKE_CURRENT_SOURCE_DIR}cocos/base/ccFPSImages.c"
     "${CMAKE_CURRENT_SOURCE_DIR}cocos/2d/*.cpp"
     "${CMAKE_CURRENT_SOURCE_DIR}cocos/3d/*.cpp"
     "${CMAKE_CURRENT_SOURCE_DIR}cocos/audio/linux/*.cpp"
     "${CMAKE_CURRENT_SOURCE_DIR}cocos/base/*.cpp"
     "${CMAKE_CURRENT_SOURCE_DIR}cocos/deprecated/*.cpp"
     "${CMAKE_CURRENT_SOURCE_DIR}cocos/editor-support/cocosbuilder/*.cpp"
     "${CMAKE_CURRENT_SOURCE_DIR}cocos/editor-support/spine/*.cpp"
     "${CMAKE_CURRENT_SOURCE_DIR}cocos/math/*.cpp"
     "${CMAKE_CURRENT_SOURCE_DIR}cocos/network/*.cpp"
     "${CMAKE_CURRENT_SOURCE_DIR}cocos/physics/*.cpp"
     "${CMAKE_CURRENT_SOURCE_DIR}cocos/physics/chipmunk/*.cpp"
     "${CMAKE_CURRENT_SOURCE_DIR}cocos/platform/*.cpp"
     "${CMAKE_CURRENT_SOURCE_DIR}cocos/platform/linux/*.cpp"
     "${CMAKE_CURRENT_SOURCE_DIR}cocos/platform/desktop/*.cpp"
     "${CMAKE_CURRENT_SOURCE_DIR}cocos/renderer/*.cpp"
     "${CMAKE_CURRENT_SOURCE_DIR}cocos/storage/local-storage/*.cpp"
     "${CMAKE_CURRENT_SOURCE_DIR}cocos/ui/*.cpp"
  )


add_library(Spine STATIC ${spine_source_files})

if ( CMAKE_SIZEOF_VOID_P EQUAL 8 )
    set(FMOD_LIB "fmodex64")
else()
    set(FMOD_LIB "fmodex")
endif()

# target_link_libraries(cocos2d jpeg webp tiff freetype fontconfig png pthread glfw GLEW GL X11 rt z ${FMOD_LIB} curl)

set_target_properties(Spine
    PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
)
