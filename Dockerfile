FROM alpine:latest
#ENV APK_REPOSITORIES=http://dl-cdn.alpinelinux.org/alpine/v3.14/main
ARG LIBRESPOT_VERSION=0.4.2-r2

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories
RUN apk add --no-cache bash librespot=${LIBRESPOT_VERSION} sed
#RUN apk update && apk add librespot


#ENV LIBRESPOT_CACHE /tmp
ENV LIBRESPOT_NAME LibrespotAlpine
#ENV LIBRESPOT_DEVICE /data/spotfifo
#ENV LIBRESPOT_DEVICE /tmp/spotfifo
ENV LIBRESPOT_BACKEND pipe
ENV LIBRESPOT_BITRATE 320
ENV LIBRESPOT_INITVOL 65

#CMD ["librespot"]
CMD librespot \
    --name "$LIBRESPOT_NAME" \
#    --device "$LIBRESPOT_DEVICE" \
    --backend "$LIBRESPOT_BACKEND" \
    --bitrate "$LIBRESPOT_BITRATE" \
    --initial-volume "$LIBRESPOT_INITVOL" \
#    --cache "$LIBRESPOT_CACHE" 


#ENV DEVICE_NAME=Librespot
EXPOSE 5353
