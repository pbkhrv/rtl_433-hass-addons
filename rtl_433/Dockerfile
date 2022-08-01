ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.16
FROM $BUILD_FROM as builder
MAINTAINER pbkhrv@pm.me

ENV LANG C.UTF-8

# Copied with minor edits from https://github.com/hertzg/rtl_433_docker/blob/master/images/alpine/build-context/Dockerfile
RUN apk add --no-cache --virtual .buildDeps \
    build-base \
    libusb-dev \
    librtlsdr-dev \
    patch \
    cmake \
    git

WORKDIR /build
ARG rtl433GitRevision=9d2e0b7fdc7ea8248102df9cbc479d4c8a715843
RUN git clone https://github.com/merbanan/rtl_433
WORKDIR ./rtl_433

RUN git checkout ${rtl433GitRevision}

# Copy files from root folder
COPY 2116.diff \
     /

# https://github.com/merbanan/rtl_433/pull/2116
RUN patch -u 2116.diff

WORKDIR ./build
RUN cmake ..
RUN make -j 4

WORKDIR /build/root
WORKDIR /build/rtl_433/build
RUN make DESTDIR=/build/root/ install

FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add --no-cache libusb \
    librtlsdr \
    sed
WORKDIR /root
COPY --from=builder /build/root/ /

# Run script
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
