include(FindPackageHandleStandardArgs)

find_package(PkgConfig QUIET)
if(PkgConfig_FOUND)
  pkg_check_modules(PC_libudev QUIET libudev)
endif()

set(Libudev_VERSION ${PC_libudev_VERSION})

find_path(Libudev_INCLUDE_DIR
  NAMES libudev.h
  HINTS
    ${PC_libudev_INCLUDE_DIRS}
)

find_library(Libudev_LIBRARY
  NAMES udev
  HINTS
    ${PC_libudev_LIBRARY_DIRS}
)

find_package_handle_standard_args(Libudev
  REQUIRED_VARS
    Libudev_LIBRARY
    Libudev_INCLUDE_DIR
  VERSION_VAR
    Libudev_VERSION
)

if(Libudev_FOUND AND NOT TARGET Libudev::Libudev)
  add_library(Libudev::Libudev UNKNOWN IMPORTED)
  set_target_properties(Libudev::Libudev PROPERTIES
    IMPORTED_LOCATION "${Libudev_LIBRARY}"
    INTERFACE_INCLUDE_DIRECTORIES "${Libudev_INCLUDE_DIR}"
  )
endif()

mark_as_advanced(Libudev_LIBRARY Libinput_Libudev_INCLUDE_DIR)

if(Libudev_FOUND)
  set(Libudev_LIBRARIES ${Libudev_LIBRARY})
  set(Libudev_INCLUDE_DIRS ${Libudev_INCLUDE_DIR})
endif()
