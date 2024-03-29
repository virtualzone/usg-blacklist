FROM alpine:3.17
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="Dynamic IP Blacklisting for UniFi USG" \
        org.label-schema.description="Docker Image for remote dynamic IP blacklisting on UniFi USG." \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-url="https://github.com/virtualzone/usg-blacklist" \
        org.label-schema.schema-version="1.0"
ENV MODE update
ENV HOST 192.168.1.1
ENV USER admin
ENV IPV6 false
RUN apk --update add --no-cache openssh
ADD *.sh /opt/usg-blacklist/
RUN chmod +x /opt/usg-blacklist/*.sh
CMD [ "/bin/sh", "-c", "/opt/usg-blacklist/run.sh ${MODE} ${HOST} ${USER} ${IPV6}" ]