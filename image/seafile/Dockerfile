FROM debian:buster-slim
MAINTAINER Christoph Haas <christoph.h44z@gmail.com>

ENV TZ=Europe/Vienna

# For support set local time zone.
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
    procps default-libmysqlclient-dev python3 python3-setuptools python3-pip \
    ldap-utils curl sqlite3 tzdata locales && \
  pip3 install --timeout=3600 \
    future mysqlclient Pillow pylibmc pyjwt==1.7.1 captcha jinja2 sqlalchemy \
    django-pylibmc django-simple-captcha python3-ldap && \
  sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen && \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

ENV DOCKERIZE_VERSION v0.6.1
RUN curl -L https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz | tar -xz -C /usr/local/bin


WORKDIR /opt/seafile

# build-time arguments, use them in docker build with --build-arg switch to build different version
ARG SEAFILE_VERSION=8.0.4

ENV SEAFILE_VERSION=${SEAFILE_VERSION}

RUN mkdir -p /opt/seafile/ /seafile/ && \
    curl -sSL -o - https://download.seadrive.org/seafile-server_${SEAFILE_VERSION}_x86-64.tar.gz \
    | tar xzf - -C /opt/seafile/ && \
    ln -s /opt/seafile/seafile-server-${SEAFILE_VERSION} /opt/seafile/seafile-server-latest

# For using TLS connection to LDAP/AD server with docker-ce.
RUN find /opt/seafile/ \( -name "liblber-*" -o -name "libldap-*" -o -name "libldap_r*" -o -name "libsasl2.so*" \) -delete

COPY scripts /scripts

EXPOSE 8000 8082 8080

ENTRYPOINT ["/scripts/seafile-entrypoint.sh"]
