cmake_minimum_required(VERSION 3.5)

project(
  interception-tools
  VERSION 0.6.8
  DESCRIPTION
    "A minimal composable infrastructure on top of libudev and libevdev"
  HOMEPAGE_URL "https://github.com/MEhrn00/interception-tools"
  LANGUAGES CXX)

option(INSTALL_SYSTEMD_SERVICE "Install udevmon systemd service file" ON)

find_package(Boost REQUIRED)
find_package(Threads REQUIRED)

find_package(PkgConfig)
pkg_check_modules(LIBEVDEV REQUIRED libevdev)

add_subdirectory(tools)

string(CONCAT CONFIGURATION_MSG "Configuration options:\n"
              "\tINSTALL_SYSTEMD_SERVICE: \t${INSTALL_SYSTEMD_SERVICE}" "\n")
message(STATUS ${CONFIGURATION_MSG})
