ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

MAINTAINER pbkhrv@pm.me

# Install necessary packages
RUN apk add --no-cache python3 git

# Install latest pip
RUN python3 -m ensurepip && \
    pip3 install --no-cache --upgrade pip

# Install rtl_433 mqtt bridge prereq
RUN pip3 install --no-cache paho-mqtt

# Clone rtl_433 repo and copy the latest tested version of the mqtt bridge script
# (latest as of 12/25/2020)
RUN mkdir /tmp/build && \
    cd /tmp/build && \
    git clone https://github.com/pbkhrv/rtl_433 && \
    cd rtl_433 && \
    cp examples/rtl_433_mqtt_hass.py /rtl_433_mqtt_hass.py && \
    rm -rf /tmp/build

# Run script
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
