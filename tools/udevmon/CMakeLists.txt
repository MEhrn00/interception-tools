add_executable(udevmon main.cpp)
target_include_directories(udevmon PRIVATE ${LIBEVDEV_INCLUDE_DIRS})
target_compile_options(udevmon PRIVATE -Wall -Wextra -pedantic -std=c++11)
target_link_libraries(udevmon evdev udev yaml-cpp)

install(TARGETS udevmon RUNTIME DESTINATION bin)

configure_file("${CMAKE_CURRENT_SOURCE_DIR}/udevmon.service.in"
               "${CMAKE_CURRENT_BINARY_DIR}/udevmon.service" @ONLY)

if(${INSTALL_SYSTEMD_SERVICE})
  install(FILES "${CMAKE_CURRENT_BINARY_DIR}/udevmon.service"
          DESTINATION "/usr/lib/systemd/system")
endif()
