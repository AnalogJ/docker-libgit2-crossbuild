#!/bin/sh
set -x
set -e

# make the /usr/local/lib/pkgconfig directory for pkg-config
mkdir -p /usr/local/lib/pkgconfig

# Install libraries
/scripts/install-openssl.sh
/scripts/install-libssh2.sh
/scripts/install-libgit2.sh

#make golang dirs.
mkdir -p /go/src
mkdir -p /go/bin
