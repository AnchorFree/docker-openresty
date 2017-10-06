### [openresty](http://openresty.org/en/) docker image

#### Description

Dockerfile + APKBUILD files to build a docker container with openresty.
Dockerfile uses multi-stage building, so you need to have docker >= 17.05.
Openresty is built from sources (see ./apk directory).
The resulting image will also include the following luarocks modules:

* web (wrapper over lua-resty-http)
* docker
* pgmoon
* lsqlite3
* inspect

#### Usage

Nginx is configured to include every `*.conf` file from `/etc/nginx/conf.d/`
(files from this dir included **above** nginx http config block) and 
`/etc/nginx/vhosts/` directories, so you can just mount a host directory 
with your virtual hosts configs to container's `/etc/nginx/vhosts` directory.

#### anchorfree/openresty:cli variant
Same as the above, but entrypoint is set to resty instead of nginx,
so you can run your resty scripts with this image. This image includes
perl, cause resty won't run without it.

