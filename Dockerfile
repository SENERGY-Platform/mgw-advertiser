FROM alpine:3

LABEL org.opencontainers.image.source https://github.com/SENERGY-Platform/mgw-discovery

RUN apk add --no-cache avahi

RUN rm /etc/avahi/services/*

ADD mgw.service /etc/avahi/services/mgw.service

ADD entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
