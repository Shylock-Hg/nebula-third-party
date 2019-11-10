ExternalProject_Add(
    jemalloc
    URL https://github.com/jemalloc/jemalloc/releases/download/5.1.0/jemalloc-5.1.0.tar.bz2
    URL_HASH MD5=1f47a5aff2d323c317dfa4cf23be1ce4
    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/jemalloc
    TMP_DIR ${CMAKE_CURRENT_BINARY_DIR}/jemalloc/build-meta
    STAMP_DIR ${CMAKE_CURRENT_BINARY_DIR}/jemalloc/build-meta
    SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/jemalloc/source
    DOWNLOAD_DIR ${CMAKE_CURRENT_BINARY_DIR}/download
    CONFIGURE_COMMAND
        ${common_configure_envs}
        ./configure ${common_configure_args}
                    --disable-stats --enable-prof
    BUILD_COMMAND make -s -j${NCPU}
    BUILD_IN_SOURCE 1
    INSTALL_COMMAND make -s install_bin install_include install_lib_static -j${NCPU}
    LOG_BUILD 1
    LOG_INSTALL 1
)
