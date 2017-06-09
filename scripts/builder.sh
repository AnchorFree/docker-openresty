#!/bin/sh

sleep 5

builderUser=robopan

apk update && apk upgrade
apk add alpine-sdk pcre-dev perl openssl-dev zlib-dev

adduser -D -s /bin/sh ${builderUser}
addgroup ${builderUser} abuild
 
echo "${builderUser} ALL = NOPASSWD: ALL" > /etc/sudoers.d/${builderUser}
 

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

REPODEST=/home/${builderUser}/packages/
PACKAGER="Vladimir Zorin <vladimir@deviant.guru>"
PACKAGER_PRIVKEY=/home/${builderUser}/.abuild/vladimir@deviant.guru.rsa

CLEANUP="srcdir pkgdir deps"
ERROR_CLEANUP="deps"
EOF

mkdir /home/${builderUser}/.abuild
mkdir /home/${builderUser}/.ssh
mv /root/*.rsa /home/${builderUser}/.abuild/

