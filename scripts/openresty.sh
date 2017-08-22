#!/bin/sh

sleep 5

apk add --no-cache /root/openresty-1.11.2.5-r1.apk
apk add --no-cache /root/luarocks-2.4.2-r1.apk

apk add --no-cache sqlite-dev 
ln -s /usr/openresty/luajit/bin/luajit-2.1.0-beta3 /bin/lua
ln -s /usr/openresty/luajit/bin/luarocks-5.1 /bin/luarocks
ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log 
 
luarocks install inspect
luarocks install lsqlite3
luarocks install pgmoon
luarocks install web 
luarocks install lua-resty-exec
luarocks install docker

apk del luarocks unzip gcc musl-dev
rm /root/*.apk

