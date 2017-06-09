FROM alpine:latest as builder
MAINTAINER Vladimir Zorin

COPY keys/vladimir@deviant.guru.rsa /root/
COPY keys/vladimir@deviant.guru.rsa.pub /etc/apk/keys/

COPY scripts/builder.sh /root/
RUN /root/builder.sh
COPY apk/ /home/robopan/
RUN chown -R robopan /home/robopan
RUN su -c 'cd ~/openresty && abuild checksum && abuild -r' robopan
RUN apk add /home/robopan/packages/robopan/x86_64/openresty-1.11.2.3-r1.apk
RUN su -c 'cd ~/luarocks && abuild checksum && abuild -r' robopan


FROM alpine:latest
MAINTAINER Vladimir Zorin

COPY keys/vladimir@deviant.guru.rsa.pub /etc/apk/keys/
COPY --from=builder /home/robopan/packages/robopan/x86_64/openresty-1.11.2.3-r1.apk /root/
COPY --from=builder /home/robopan/packages/robopan/x86_64/luarocks-2.4.2-r1.apk /root/
COPY scripts/openresty.sh /root/
RUN /root/openresty.sh

ENTRYPOINT ["/sbin/runit-init"]
