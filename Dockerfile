FROM adminer:latest

USER root

RUN apk add git openssh && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

RUN cd /tmp && \
    git clone https://github.com/pematon/adminer-theme.git && \
    cp -R /tmp/adminer-theme/lib/* /var/www/html && \
    echo "<?php include __DIR__.'/../plugins/AdminerTheme.php'; if(empty(getenv('ADMINER_DESIGN'))) return new AdminerTheme(getenv('PEMATON_THEME') ?: 'default-blue');" > /var/www/html/plugins-enabled/adminer-theme.php  && \
    echo "upload_max_filesize=512M" >> /usr/local/etc/php/conf.d/upload-max-filesize.ini && \
    echo "post_max_size=512M" >> /usr/local/etc/php/conf.d/upload-max-filesize.ini

USER adminer
