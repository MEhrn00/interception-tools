include(FindPackageHandleStandardArgs)

find_package(PkgConfig QUIET)
if(PkgConfig_FOUND)
  pkg_check_modules(PC_libevdev QUIET libevdev)
endif()

set(Libevdev_VERSION ${PC_libevdev_VERSION})

find_path(Libevdev_INCLUDE_DIR
  NAMES libevdev/libevdev.h
  HINTS
    ${PC_libevdev_INCLUDE_DIRS}
    "libevdev-${Libevdev_FIND_VERSION_MAJOR}.${Libevdev_FIND_VERSION_MINOR}"
)

find_library(Libevdev_LIBRARY
  NAMES evdev
  HINTS
    ${PC_libevdev_LIBRARY_DIRS}
)

find_package_handle_standard_args(Libevdev
  REQUIRED_VARS
    Libevdev_LIBRARY
    Libevdev_INCLUDE_DIR
  VERSION_VAR
    Libevdev_VERSION
)

if(Libevdev_FOUND AND NOT TARGET Libevdev::Libevdev)
  add_library(Libevdev::Libevdev UNKNOWN IMPORTED)
  set_target_properties(Libevdev::Libevdev PROPERTIES
    IMPORTED_LOCATION "${Libevdev_LIBRARY}"
    INTERFACE_INCLUDE_DIRECTORIES "${Libevdev_INCLUDE_DIR}"
  )
endif()

mark_as_advanced(Libevdev_LIBRARY Libinput_Libevdev_INCLUDE_DIR)

if(Libevdev_FOUND)
  set(Libevdev_LIBRARIES ${Libevdev_LIBRARY})
  set(Libevdev_INCLUDE_DIRS ${Libevdev_INCLUDE_DIR})
endif()
