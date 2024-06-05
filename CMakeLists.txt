cmake_minimum_required(VERSION 3.5)

project(
  interception-tools
  VERSION 0.6.8
  DESCRIPTION
    "A minimal composable infrastructure on top of libudev and libevdev"
  HOMEPAGE_URL "https://github.com/MEhrn00/interception-tools"
  LANGUAGES CXX)

option(BUILD_CAPS2ESC "Build caps2esc plugin" ON)
option(INSTALL_SYSTEMD_SERVICE "Install udevmon systemd service file" ON)

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

add_subdirectory(tools)

string(CONCAT CONFIGURATION_MSG "Configuration options:\n"
              "\tBUILD_CAPS2ESC:          \t${BUILD_CAPS2ESC}\n"
              "\tINSTALL_SYSTEMD_SERVICE: \t${INSTALL_SYSTEMD_SERVICE}" "\n")
message(STATUS ${CONFIGURATION_MSG})
