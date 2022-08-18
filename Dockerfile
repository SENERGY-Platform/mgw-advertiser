FROM alpine:3

LABEL org.opencontainers.image.source https://github.com/SENERGY-Platform/mgw-advertiser

ARG avahi_path=/etc/avahi

ENV MGW_ADVER_PATH=/opt/mgw-advertiser
ENV AVAHI_CONF_PATH=$avahi_path/avahi-daemon.conf
ENV AVAHI_SRV_PATH=$avahi_path/services

COPY . $MGW_ADVER_PATH

RUN apk add --no-cache avahi git && cd $MGW_ADVER_PATH && rm $AVAHI_SRV_PATH/* && cp -r services/. $AVAHI_SRV_PATH/ && git log -1 --pretty=format:"commit=%H%ndate=%cd%n" > git_commit && apk del git && rm -r .git .github Dockerfile services

ENTRYPOINT .$MGW_ADVER_PATH/entrypoint.sh
