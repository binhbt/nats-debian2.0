FROM debian
LABEL maintainer "Bitnami <containers@bitnami.com>"

# Install required system packages and dependencies
#RUN install_packages ca-certificates curl wget
RUN apt-get update
RUN apt upgrade
RUN apt-get -y install wget
RUN apt-get -y install sudo
RUN wget -nc -P /tmp/bitnami/pkg/cache/ https://downloads.bitnami.com/files/stacksmith/nats-2.0.0-0-linux-amd64-debian-9.tar.gz && \
    echo "13f08f280c448f2cb29de0d0084592b3c4216246d3a1bc2811f0059ce433236f  /tmp/bitnami/pkg/cache/nats-2.0.0-0-linux-amd64-debian-9.tar.gz" | sha256sum -c - && \
    tar -zxf /tmp/bitnami/pkg/cache/nats-2.0.0-0-linux-amd64-debian-9.tar.gz -P --transform 's|^[^/]*/files|/opt/bitnami|' --wildcards '*/files' && \
    rm -rf /tmp/bitnami/pkg/cache/nats-2.0.0-0-linux-amd64-debian-9.tar.gz

COPY rootfs /
#RUN chown -R 1001:root /opt/bitnami/nats && chmod g+rwX /opt/bitnami/nats
ENV BITNAMI_APP_NAME="nats" \
    BITNAMI_IMAGE_VERSION="2.0.0-debian-9-r13" \
    PATH="/opt/bitnami/nats/bin:$PATH"

EXPOSE 4222 6222 8222

WORKDIR /opt/bitnami/nats
#USER 1001
ENTRYPOINT [ "/entrypoint.sh" ]
