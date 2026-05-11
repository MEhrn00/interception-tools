cmake_minimum_required(VERSION 3.18)

project(
  interception-tools
  VERSION 0.6.8
  DESCRIPTION
    "A minimal composable infrastructure on top of libudev and libevdev"
  HOMEPAGE_URL "https://github.com/MEhrn00/interception-tools"
  LANGUAGES CXX)

option(INSTALL_SYSTEMD_SERVICE "Install udevmon systemd service file" ON)

find_package(Boost CONFIG REQUIRED)
find_package(Threads REQUIRED)

find_package(PkgConfig)
pkg_check_modules(LIBEVDEV REQUIRED libevdev)

add_executable(intercept src/intercept.cpp)
target_include_directories(intercept PRIVATE ${LIBEVDEV_INCLUDE_DIRS})
target_compile_options(intercept PRIVATE -Wall -Wextra)
target_link_libraries(intercept evdev)


add_executable(mux src/mux.cpp)
target_include_directories(mux PRIVATE ${Boost_INCLUDE_DIRS})
target_compile_options(mux PRIVATE -Wall -Wextra -pedantic -std=c++11
                                   -DBOOST_DATE_TIME_NO_LIB)
target_link_libraries(mux Threads::Threads rt)


add_executable(udevmon src/udevmon.cpp)
target_include_directories(udevmon PRIVATE ${LIBEVDEV_INCLUDE_DIRS})
target_compile_options(udevmon PRIVATE -Wall -Wextra -pedantic -std=c++11)
target_link_libraries(udevmon evdev udev yaml-cpp)

add_executable(uinput src/uinput.cpp)
target_include_directories(uinput PRIVATE ${LIBEVDEV_INCLUDE_DIRS})
target_compile_options(uinput PRIVATE -Wall -Wextra -pedantic -std=c++11)
target_link_libraries(uinput evdev udev yaml-cpp)


install(TARGETS intercept mux udevmon uinput RUNTIME DESTINATION bin)

if(INSTALL_SYSTEMD_SERVICE)
    configure_file("${CMAKE_CURRENT_SOURCE_DIR}/etc/udevmon.service.in"
                   "${CMAKE_CURRENT_BINARY_DIR}/etc/udevmon.service" @ONLY)
    install(FILES "${CMAKE_CURRENT_BINARY_DIR}/etc/udevmon.service"
          DESTINATION "lib/systemd/system")
endif()



string(CONCAT CONFIGURATION_MSG "Configuration options:\n"
              "\tINSTALL_SYSTEMD_SERVICE: \t${INSTALL_SYSTEMD_SERVICE}" "\n")
message(STATUS ${CONFIGURATION_MSG})
