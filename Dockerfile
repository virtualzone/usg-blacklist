FROM alpine:latest
ENV MODE update
ENV HOST 192.168.1.1
ENV USER admin
RUN apk --update add --no-cache openssh
ADD *.sh /opt/usg-blacklist/
RUN chmod +x /opt/usg-blacklist/*.sh
CMD [ "/bin/sh", "-c", "/opt/usg-blacklist/run.sh ${MODE} ${HOST} ${USER}" ]