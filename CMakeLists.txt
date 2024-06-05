cmake_minimum_required(VERSION 3.5)

project(interception-tools)

option(BUILD_CAPS2ESC "Build caps2esc plugin" ON)

include(cmake/git_submodules.cmake)

if(${BUILD_CAPS2ESC})
  message(STATUS "Build caps2esc plugin")
  fetch_submodule(plugins/caps2esc)
  add_subdirectory(plugins/caps2esc)
endif()

find_package(Boost REQUIRED)
find_package(Threads REQUIRED)

find_package(PkgConfig)
pkg_check_modules(LIBEVDEV REQUIRED libevdev)

add_subdirectory(src)

string(CONCAT CONFIGURATION_MSG "Configuration options:\n"
              "\tBUILD_CAPS2ESC:\t${BUILD_CAPS2ESC}" "\n")
message(STATUS ${CONFIGURATION_MSG})
