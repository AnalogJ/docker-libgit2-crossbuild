#!/bin/sh
set -x

# Set temp environment vars
export REPO=https://github.com/libssh2/libssh2
export BRANCH=libssh2-1.7.0
export LIBSSH2_BUILD_PATH=/tmp/libssh2
export LIBSSH2_OUTPUT_PREFIX=/usr/local/lib/libssh2
export OPENSSL_OUTPUT_PREFIX=/usr/local/lib/openssl

export PKG_CONFIG_PATH="/usr/lib/pkgconfig/:/usr/local/lib/pkgconfig/"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:${OPENSSL_OUTPUT_PREFIX}/lib/pkgconfig:/tmp/libssh2/build/src"

# Env used during libssh2 install
export OPENSSL_ROOT_DIR=${OPENSSL_OUTPUT_PREFIX}
export OPENSSL_LIBRARIES="${OPENSSL_OUTPUT_PREFIX}/lib"
export OPENSSL_INCLUDE_DIR="${OPENSSL_OUTPUT_PREFIX}/include"

# Compile & Install libgit2 (v0.23)
git clone -b ${BRANCH} --depth 1 -- ${REPO} ${LIBSSH2_BUILD_PATH}

mkdir -p ${LIBSSH2_BUILD_PATH}/build
mkdir -p ${LIBSSH2_OUTPUT_PREFIX}
cd ${LIBSSH2_BUILD_PATH}/build
cmake -DBUILD_SHARED_LIBS=OFF \
      -DCMAKE_C_FLAGS=-fPIC \
      -DCMAKE_BUILD_TYPE="RelWithDebInfo" \
      -DBUILD_EXAMPLES=OFF \
      -DBUILD_TESTING=OFF \
      -DCMAKE_INSTALL_PREFIX=${LIBSSH2_OUTPUT_PREFIX} \
      ..
cmake --build . --target install

