#Special thanks to PD75 with https://github.com/PD75/docker-librespot

ARG RUST_V=1.66
FROM rust:${RUST_V} as librespot
ARG LIBRESPOT_VERSION=0.4.2 
#WORKDIR /usr/src/libraspot
RUN apt-get update && \
	apt-get install -y libasound2-dev build-essential pkg-config curl unzip \
	&& apt-get clean && rm -fR /var/lib/apt/lists
        
RUN cd /tmp \
	&& wget https://github.com/librespot-org/librespot/archive/v${LIBRESPOT_VERSION}.zip \
	&& unzip v${LIBRESPOT_VERSION}.zip \
	&& mv librespot-${LIBRESPOT_VERSION} librespot-master \
	&& cd librespot-master \
	&& cargo build --release \
	&& chmod +x /tmp/librespot-master/target/release/librespot


FROM debian:stable-slim as libre

RUN apt-get update \
	&& apt-get install -y \
	libasound2-dev \
	nano \ 
	tzdata \
#	pkg-config \
#	alsa-utils \ 
	xz-utils \
	coreutils \
	mosquitto-clients \
	&& apt-get clean && rm -fR /var/lib/apt/lists

#Download the most recent s6 overlay.
#ADD https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-amd64.tar.gz /tmp
#RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

          
RUN mkdir -p /data  
WORKDIR /data
RUN mkfifo librefifo 


#RUN touch /tmp/librespotfifo
#WORKDIR /tmp 
CMD mkfifo librespotfifo
WORKDIR ./





COPY --from=librespot /tmp/librespot-master/target/release/librespot /usr/local/bin/

ENV LIBRESPOT_CACHE /tmp
ENV LIBRESPOT_NAME librespot
ENV LIBRESPOT_DEVICE /data/snapfifo
#ENV LIBRESPOT_DEVICE /tmp/snapfifo
ENV LIBRESPOT_BACKEND pipe
ENV LIBRESPOT_BITRATE 320
ENV LIBRESPOT_INITVOL 65

VOLUME /data

EXPOSE 5353

CMD librespot \
    --name "$LIBRESPOT_NAME" \
    --device "$LIBRESPOT_DEVICE" \
    --backend "$LIBRESPOT_BACKEND" \
    --bitrate "$LIBRESPOT_BITRATE" \
    --initial-volume "$LIBRESPOT_INITVOL" \
    --cache "$LIBRESPOT_CACHE" 

