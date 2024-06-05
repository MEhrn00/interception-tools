add_executable(intercept main.c)
target_include_directories(intercept PRIVATE ${LIBEVDEV_INCLUDE_DIRS})
target_compile_options(intercept PRIVATE -Wall -Wextra)
target_link_libraries(intercept evdev)

install(TARGETS intercept RUNTIME DESTINATION bin)
