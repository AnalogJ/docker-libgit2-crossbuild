#!/bin/sh
set -x

# Set temp environment vars
export LIBGIT2REPO=https://github.com/libgit2/libgit2.git
export LIBGIT2BRANCH=v0.25.0
export LIBGIT2_BUILD_PATH=/tmp/libgit2
export LIBGIT2_OUTPUT_PREFIX=/usr/local/lib/libgit2

# Env used during libgit2 install
export OPENSSL_OUTPUT_PREFIX=/usr/local/lib/openssl
export OPENSSL_SSL_LIBRARY="${OPENSSL_OUTPUT_PREFIX}/lib"
export OPENSSL_CRYPTO_LIBRARY="${OPENSSL_OUTPUT_PREFIX}/lib"
export LIBSSH2_OUTPUT_PREFIX=/usr/local/lib/libssh2
export LIBSSH2_FOUND=true
export LIBSSH2_INCLUDE_DIRS="${LIBSSH2_OUTPUT_PREFIX}/include"
export LIBSSH2_LIBRARY_DIRS="${LIBSSH2_OUTPUT_PREFIX}/lib64"

# Compile & Install libgit2 (v0.25)
git clone -b ${LIBGIT2BRANCH} --depth 1 -- ${LIBGIT2REPO} ${LIBGIT2_BUILD_PATH}

mkdir -p ${LIBGIT2_BUILD_PATH}/build
mkdir -p ${LIBGIT2_OUTPUT_PREFIX}

cd ${LIBGIT2_BUILD_PATH}/build
cmake -DTHREADSAFE=ON \
      -DBUILD_CLAR=OFF \
      -DBUILD_SHARED_LIBS=OFF \
      -DCMAKE_C_FLAGS=-fPIC \
      -DCMAKE_BUILD_TYPE="RelWithDebInfo" \
      -DCMAKE_INSTALL_PREFIX=${LIBGIT2_OUTPUT_PREFIX} \
      ..
cmake --build . --target install

# copy into /usr/lib
#cp /tmp/libgit2/build/libgit2.a /usr/lib

# Cleanup
# rm -r ${LIBGIT2PATH}
