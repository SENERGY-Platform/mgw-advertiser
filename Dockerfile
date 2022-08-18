FROM alpine:3

LABEL org.opencontainers.image.source https://github.com/SENERGY-Platform/mgw-advertiser

RUN apk add --no-cache avahi

RUN rm /etc/avahi/services/*

COPY services/ /etc/avahi/services/

ADD entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
