ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.16
FROM $BUILD_FROM as builder
MAINTAINER pbkhrv@pm.me

ENV LANG C.UTF-8

# Copied with minor edits from https://github.com/hertzg/rtl_433_docker/blob/master/images/alpine/build-context/Dockerfile
RUN apk add --no-cache --virtual .buildDeps \
    build-base \
    libusb-dev \
    librtlsdr-dev \
    cmake \
    git

WORKDIR /build

# Ensure we invalidate the Docker cache on updates: https://stackoverflow.com/a/39278224/7982687
ADD https://${GITHUB_AUTH}api.github.com/repos/merbanan/rtl_433/git/refs/heads/master version.json

RUN git clone https://github.com/merbanan/rtl_433
WORKDIR ./rtl_433

# Build a specific commit or tag.
FROM builder as build_hash
ARG rtl433GitRevision=5f76eae6f6bf9c696b859296301bbbe234de77fe
RUN git checkout ${rtl433GitRevision}
WORKDIR ./build
RUN cmake ..
RUN make -j 4

WORKDIR /build/root
WORKDIR /build/rtl_433/build
RUN make DESTDIR=/build/root/ install

# Build whatever the latest master commit is, and store it separately in /opt/rtl_433/...
FROM builder as build_latest
WORKDIR ./build
RUN cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/rtl_433 ..
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
COPY --from=build_hash /build/root/ /
COPY --from=build_latest /build/root/ /

# Run script
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
