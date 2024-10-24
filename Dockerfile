FROM webdevops/php-nginx:8.3-alpine
ARG ADMINER_VERSION=4.10
ARG PEMATON_THEME_VERSION=1.8

# Installing Adminer and theme
RUN wget https://github.com/pematon/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php -O /app/adminer.php \
    # Pematon theme
    && wget https://github.com/pematon/adminer-theme/archive/refs/tags/v${PEMATON_THEME_VERSION}.tar.gz -O /tmp/adminer-theme.tar.gz \
    && tar -xf /tmp/adminer-theme.tar.gz -C /tmp \
    && cp -R /tmp/adminer-theme-${PEMATON_THEME_VERSION}/lib/* /app/ \
    # Adminer plugin file
    && wget https://github.com/pematon/adminer/archive/refs/tags/v${ADMINER_VERSION}.tar.gz -O /tmp/adminer.tar.gz \
    && tar -xf /tmp/adminer.tar.gz -C /tmp \
    && cp /tmp/adminer-${ADMINER_VERSION}/plugins/plugin.php /app/plugins/plugin.php \
    && rm -rf /tmp/*

# Moving default port from 80 to 8080
RUN sed -i 's/listen 80/listen 8080/g' /opt/docker/etc/nginx/vhost.conf \
    && sed -i 's/listen \[::\]:80/listen \[::\]:8080/g' /opt/docker/etc/nginx/vhost.conf

# Copying index.php
COPY ./index.php /app/index.php

EXPOSE 8080