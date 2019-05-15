#!/bin/sh

apk add --no-cache alpine-sdk pcre-dev perl openssl-dev zlib-dev unzip
addgroup root abuild

cat <<EOF > /etc/abuild.conf
CHOST=x86_64-alpine-linux-musl
export CFLAGS="-Os -fomit-frame-pointer"
export CXXFLAGS="\$CFLAGS"
export CPPFLAGS="\$CFLAGS"
export LDFLAGS="-Wl,--as-needed"
export JOBS=2
export MAKEFLAGS=-j\$JOBS

USE_COLORS=1
SRCDEST=/var/cache/distfiles

REPODEST=/root/built/
PACKAGER="Vladimir Zorin <v.zorin@anchorfree.com>"

CLEANUP="srcdir pkgdir deps"
ERROR_CLEANUP="deps"
EOF

abuild-keygen -a -n -i -q
