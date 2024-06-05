add_executable(uinput uinput.cpp)
target_include_directories(uinput PRIVATE ${LIBEVDEV_INCLUDE_DIRS})
target_compile_options(uinput PRIVATE -Wall -Wextra -pedantic -std=c++11)
target_link_libraries(uinput evdev udev yaml-cpp)

install(TARGETS uinput RUNTIME DESTINATION bin)
