FROM alpine:3.17.1

ARG LIBRESPOT_VERSION=0.4.2-r1

RUN apk add --no-cache bash librespot=${LIBRESPOT_VERSION} sed


CMD 

ENV DEVICE_NAME=Librespot
EXPOSE 5353
