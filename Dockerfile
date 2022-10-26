FROM ubuntu:latest

ARG GW2USE=qbusMqttGw-x64.tar

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y git \
    && apt-get install -y tftp \
    && git clone https://github.com/QbusKoen/qbusMqtt \
    && cd /qbusMqtt/qbusMqtt/qbusMqttGw \
    && tar -xf "${GW2USE}" \
    && cd / \
    && mkdir /usr/bin/qbus \
    && mkdir /opt/qbus \
    && cp -R qbusMqtt/qbusMqtt/fw/ /opt/qbus/ \
    && cp qbusMqtt/qbusMqtt/puttftp /opt/qbus/ \
    && cp qbusMqtt/qbusMqtt/qbusMqttGw/qbusMqttGw /usr/bin/qbus/ \
    && chmod +x /usr/bin/qbus/qbusMqttGw \
    && chmod +x /opt/qbus/puttftp

ENTRYPOINT ["usr/bin/qbus/./qbusMqttGw", "-serial", "QBUSMQTTGW", "-logbuflevel", "-1", "-logtostderr", "true", "-storagedir", "/opt/qbus"]

