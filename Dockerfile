FROM alpine:3.17.1

ARG LIBRESPOT_VERSION=0.4.2-r1

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories
RUN apk add --no-cache bash librespot=${LIBRESPOT_VERSION} sed


CMD librespot

ENV DEVICE_NAME=Librespot
EXPOSE 5353
