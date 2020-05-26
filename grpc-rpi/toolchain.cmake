SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_SYSTEM_PROCESSOR arm)

set(devel_root /grpc_rpi)
set(CMAKE_STAGING_PREFIX ${devel_root}/stage)
set(tool_root ${devel_root}/pitools/arm-bcm2708)
set(CMAKE_SYSROOT ${tool_root}/arm-rpi-4.9.3-linux-gnueabihf/arm-linux-gnueabihf/sysroot)
set(CMAKE_C_COMPILER ${tool_root}/arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER ${tool_root}/arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)