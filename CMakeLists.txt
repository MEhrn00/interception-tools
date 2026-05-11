cmake_minimum_required(VERSION 3.18)

project(
  interception-tools
  VERSION 0.6.8
  DESCRIPTION
    "A minimal composable infrastructure on top of libudev and libevdev"
  HOMEPAGE_URL "https://github.com/MEhrn00/interception-tools"
  LANGUAGES CXX)

option(INSTALL_SYSTEMD_SERVICE "Install udevmon systemd service file" ON)

include(GNUInstallDirs)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

if(NOT PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  file(GENERATE OUTPUT .gitignore CONTENT "# CMake generated .gitignore\n*\n")
endif()

if(CMAKE_GENERATOR MATCHES "^Ninja" AND NOT DEFINED CMAKE_COLOR_DIAGNOSTICS)
  set(CMAKE_COLOR_DIAGNOSTICS ON)
endif()

find_package(Boost CONFIG REQUIRED)
find_package(yaml-cpp CONFIG REQUIRED)
find_package(Libevdev REQUIRED)
find_package(Libudev REQUIRED)
find_package(Threads REQUIRED)

add_executable(intercept src/intercept.cpp)
target_compile_features(intercept PRIVATE cxx_std_11)
target_compile_options(intercept PRIVATE -Wall -Wextra)
target_link_libraries(intercept Libevdev::Libevdev)

add_executable(mux src/mux.cpp)
target_compile_features(mux PRIVATE cxx_std_11)
target_compile_definitions(mux PRIVATE BOOST_DATE_TIME_NO_LIB)
target_compile_options(mux PRIVATE -Wall -Wextra)
target_link_libraries(mux Boost::headers Threads::Threads rt)

add_executable(udevmon src/udevmon.cpp)
target_compile_features(udevmon PRIVATE cxx_std_11)
target_compile_options(udevmon PRIVATE -Wall -Wextra -pedantic)
target_link_libraries(udevmon Libevdev::Libevdev Libudev::Libudev yaml-cpp::yaml-cpp)

add_executable(uinput src/uinput.cpp)
target_compile_features(uinput PRIVATE cxx_std_11)
target_compile_options(uinput PRIVATE -Wall -Wextra -pedantic)
target_link_libraries(uinput Libevdev::Libevdev Libudev::Libudev yaml-cpp::yaml-cpp)

install(
  TARGETS intercept mux udevmon uinput
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

if(INSTALL_SYSTEMD_SERVICE)
  configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/conf/udevmon.service.in"
    "${CMAKE_CURRENT_BINARY_DIR}/conf/udevmon.service"
    @ONLY
  )

  install(
    FILES "${CMAKE_CURRENT_BINARY_DIR}/conf/udevmon.service"
    DESTINATION "lib/systemd/system"
  )
endif()
