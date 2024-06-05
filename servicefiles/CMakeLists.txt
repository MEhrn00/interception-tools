configure_file("${CMAKE_CURRENT_SOURCE_DIR}/udevmon.service.in"
               "${CMAKE_CURRENT_BINARY_DIR}/udevmon.service" @ONLY)

if(${INSTALL_SYSTEMD_SERVICE})
  install(FILES "${CMAKE_CURRENT_BINARY_DIR}/udevmon.service"
          DESTINATION "/usr/lib/systemd/system")
endif()
