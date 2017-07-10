#!/bin/sh

sleep 5
echo "@comm http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
apk update && apk upgrade

apk add /root/openresty-1.11.2.3-r1.apk
apk add /root/luarocks-2.4.2-r1.apk

apk add sqlite-dev 
ln -s /usr/openresty/luajit/bin/luajit-2.1.0-beta2 /bin/lua
ln -s /usr/openresty/luajit/bin/luarocks-5.1 /bin/luarocks
 
luarocks install pgmoon
luarocks install lsqlite3
luarocks install web
luarocks install inspect

apk del luarocks 
apk del unzip gcc musl-dev
rm /root/*.apk

apk add runit@comm

mkdir /etc/runit
 
cat <<EOF > /etc/runit/1
#!/bin/sh
 
PATH=/sbin:/usr/sbin:/bin:/usr/bin
touch /etc/runit/stopit
chmod 0 /etc/runit/stopit
EOF
 
chmod +x /etc/runit/1
 
cat <<EOF > /etc/runit/2
#!/bin/sh
 
PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin

exec env - PATH=$PATH \
runsvdir -P /etc/service 'log: ......................................................................................................................................... ........................................................................................................................................................................ ..........................................................................................'
EOF
 
chmod +x /etc/runit/2

ln -s /etc/sv/nginx /etc/service/
