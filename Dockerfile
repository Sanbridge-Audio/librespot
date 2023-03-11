FROM alpine:latest
ENV APK_REPOSITORIES=http://dl-cdn.alpinelinux.org/alpine/v3.14/main
#ARG LIBRESPOT_VERSION=0.4.2-r1

#RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories
#RUN apk add --no-cache bash librespot=${LIBRESPOT_VERSION} sed
RUN apk update && apk add librespot


CMD ["librespot"]

ENV DEVICE_NAME=Librespot
EXPOSE 5353
