#!/bin/sh
set -x
set -e

# Set temp environment vars
export REPO=https://github.com/openssl/openssl.git
export BRANCH=OpenSSL_1_0_2-stable
export OPENSSL_BUILD_PATH=/tmp/openssl
export OPENSSL_OUTPUT_PREFIX=/usr/local/lib/openssl

# Compile & Install openssl (v0.24)
git clone -b ${BRANCH} --depth 1 -- ${REPO} ${OPENSSL_BUILD_PATH}

mkdir -p ${OPENSSL_OUTPUT_PREFIX}/lib
cd ${OPENSSL_BUILD_PATH}
./config threads no-shared --prefix=${OPENSSL_OUTPUT_PREFIX} -fPIC -DOPENSSL_PIC &&
make depend &&
make &&
make install

# Cleanup
# rm -r ${LIBGIT2PATH}
