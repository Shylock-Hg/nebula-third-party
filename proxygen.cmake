ExternalProject_Add(
    proxygen
    URL https://github.com/facebook/proxygen/archive/v2018.08.20.00.tar.gz
    URL_HASH MD5=cc71ffdf502355b05451bcd81478f3d7
    DOWNLOAD_NAME proxygen-2018-08-20.tar.gz
    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/proxygen
    TMP_DIR ${CMAKE_CURRENT_BINARY_DIR}/proxygen/build-meta
    STAMP_DIR ${CMAKE_CURRENT_BINARY_DIR}/proxygen/build-meta
    DOWNLOAD_DIR ${CMAKE_CURRENT_BINARY_DIR}/download
    SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/proxygen/source
    PATCH_COMMAND patch -p0 < ${CMAKE_SOURCE_DIR}/patches/proxygen-2018-08-20.patch
    CONFIGURE_COMMAND ""
    BUILD_COMMAND make -s -j${NCPU} -C proxygen
    BUILD_IN_SOURCE 1
    INSTALL_COMMAND make -s -j${NCPU} install -C proxygen
    LOG_CONFIGURE TRUE
    LOG_BUILD TRUE
    LOG_INSTALL TRUE
    LOG_MERGED_STDOUTERR TRUE
)
add_dependencies(proxygen wangle folly glog gflags boost double-conversion openssl libevent libunwind gperf)
ExternalProject_Add_Step(proxygen mannual-configure
    DEPENDEES download update patch configure
    DEPENDERS build install
    COMMAND autoreconf -ivf
    COMMAND
        ${common_configure_envs}
        "LIBS=-lssl -lcrypto -ldl -lrt -lglog -lunwind"
        ${CMAKE_CURRENT_BINARY_DIR}/proxygen/source/proxygen/configure
            ${common_configure_args}
            --disable-shared
            --enable-static
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/proxygen/source/proxygen
)
