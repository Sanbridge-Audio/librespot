FROM alpine:3.17.1

ARG LIBRESPOT_VERSION=0.4.2-r1
ARG SNAPCAST_VERSION=0.26.0-r3

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories
RUN apk add --no-cache bash snapcast=${SNAPCAST_VERSION} librespot=${LIBRESPOT_VERSION} sed

CMD 

ENV DEVICE_NAME=Librespot
EXPOSE 5353/tcp
