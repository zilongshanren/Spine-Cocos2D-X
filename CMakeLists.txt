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

if(IOS)
add_definitions(-DCC_TARGET_OS_IPHONE)
set(PLATFORM_FOLDER ios)
elseif(MACOX)
set(PLATFORM_FOLDER mac)
add_definitions(-DCC_TARGET_OS_MAC)
add_definitions(-D_USRDLL)
add_definitions(-DCC_KEYBOARD_SUPPORT)
elseif(LINUX)
add_definitions(-DLINUX)
set(PLATFORM_FOLDER linux)
elseif(WIN32)
set(PLATFORM_FOLDER win32)
elseif(ANDROID)
set(PLATFORM_FOLDER android)
endif(IOS)

if(LINUX32)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m32")
elseif(LINUX64)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m64")
endif(LINUX32)

set(CMAKE_C_FLAGS_DEBUG "-g -Wall -DCOCOS2D_DEBUG=1")
set(CMAKE_CXX_FLAGS_DEBUG ${CMAKE_C_FLAGS_DEBUG})
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fno-exceptions -std=c99")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-exceptions -std=c++11")

set(CMAKE_EXE_LINKER_FLAGS
    "-framework AudioToolbox -framework CoreGraphics -framework QuartzCore -framework UIKit -framework OpenGLES"
)

include_directories(
  /usr/include
  /usr/include/GLFW
  /usr/local/include/GLFW
  ${CMAKE_CURRENT_SOURCE_DIR}/glfw3/include/${PLATFORM_FOLDER}
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/gles/include/OGLES
  ${CMAKE_CURRENT_SOURCE_DIR}/edtaa3func/
  ${CMAKE_CURRENT_SOURCE_DIR}/freetype2/include/${PLATFORM_FOLDER}
  ${CMAKE_CURRENT_SOURCE_DIR}/cocos
  ${CMAKE_CURRENT_SOURCE_DIR}/cocos/base
  ${CMAKE_CURRENT_SOURCE_DIR}/android-toolchain/sysroot/usr/include
  ${CMAKE_CURRENT_SOURCE_DIR}/cocos/platform/${PLATFORM_FOLDER}
)

if(IOS)
link_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}/freetype2/prebuilt/ios
)
elseif(MACOX)
link_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}/glfw3/prebuilt/mac
  ${CMAKE_CURRENT_SOURCE_DIR}/freetype2/prebuilt/mac
)
endif(IOS)

file(GLOB_RECURSE spine_source_files 
  "${CMAKE_CURRENT_SOURCE_DIR}/spine/*.cpp"
  )


add_library(Spine STATIC ${spine_source_files})


if(ANDROID)
message(STATUS "android doesn't need ARCHIVE_OUTPUT_DIRECTORY")
else()
set_target_properties(Spine
    PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
)
endif()


# add_subdirectory(cocos)
