ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:10.1.0
FROM ${BUILD_FROM}

ENV LANG C.UTF-8

MAINTAINER pbkhrv@pm.me

# Install latest pip
RUN python3 -m ensurepip && \
    pip3 install --no-cache --upgrade pip

# Install rtl_433 mqtt bridge prereq
RUN pip3 install --no-cache paho-mqtt

# Clone rtl_433 repo and copy the latest tested version of the mqtt bridge script
# (latest as of 12/25/2020)
# RUN curl -LO https://github.com/pbkhrv/rtl_433/raw/29c04d8b412eb09f4cd1db4b363050d2d72e9065/examples/rtl_433_mqtt_hass.py && \
#   chmod +x /rtl_433_mqtt_hass.py

# Run script
# COPY run.sh /
COPY run.sh rtl_433_mqtt_hass.py /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
