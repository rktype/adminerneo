FROM adminer

USER root

RUN apk add git openssh && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

RUN cd /tmp && \
    git clone https://github.com/pematon/adminer-theme.git && \
    cp -R /tmp/adminer-theme/lib/* /var/www/html && \
    echo "<?php include __DIR__.'/../plugins/AdminerTheme.php'; if(empty(getenv('ADMINER_DESIGN'))) return new AdminerTheme(getenv('PEMATON_THEME') ?: 'default-blue');" > /var/www/html/plugins-enabled/adminer-theme.php

USER adminer
