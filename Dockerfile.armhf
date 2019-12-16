FROM alpine:3.10 AS builder
RUN apk --update add --no-cache curl
RUN cd /tmp && \
    curl -L https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-arm.tar.gz | tar zxvf - -C . && mv qemu-3.0.0+resin-arm/qemu-arm-static .

FROM arm32v6/alpine:3.10
COPY --from=builder /tmp/qemu-arm-static /usr/bin/
ENV MODE update
ENV HOST 192.168.1.1
ENV USER admin
RUN apk --update add --no-cache openssh
ADD *.sh /opt/usg-blacklist/
RUN chmod +x /opt/usg-blacklist/*.sh
CMD [ "/bin/sh", "-c", "/opt/usg-blacklist/run.sh ${MODE} ${HOST} ${USER}" ]