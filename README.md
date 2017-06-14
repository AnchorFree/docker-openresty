### [openresty](http://openresty.org/en/) docker image

#### Description

Dockerfile + APKBUILD files to build a docker container with openresty.
Dockerfile uses multi-stage building, so you need to have docker >= 17.05.
Openresty is built from sources (see ./apk directory).
The resulting image will also include the following luarocks modules:

* lua-resty-http
* pgmoon
* lsqlite3
* inspect

Note that the image is using runit-init by default, instead of traditional 
docker approach with shell scripts as entrypoints. If you want
to stick to the traditional way, just use Dockerfile.traditional
for the build -- it changes entrypoint from runit to openresty
binary and also makes nginx log to stdout and stderr.

#### Usage

Nginx is configured to include every `*.conf` file from
`/etc/nginx/conf.d/` and `/etc/nginx/vhosts/` directories,
so you can just mount a host directory with your virtual hosts
configs to container's `/etc/nginx/vhosts` directory.

