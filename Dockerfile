FROM adminer:4.8.1

USER root

RUN apt-get update \
    && apt-get install -y git openssh-client \
    && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
    && git clone https://github.com/pematon/adminer-theme.git \
    && cp -R /tmp/adminer-theme/lib/* /var/www/html \
    && echo "<?php include __DIR__.'/../plugins/AdminerTheme.php'; if(empty(getenv('ADMINER_DESIGN'))) return new AdminerTheme(getenv('PEMATON_THEME') ?: 'default-blue');" > /var/www/html/plugins-enabled/adminer-theme.php \
    && echo "upload_max_filesize=1024M" >> /etc/php/7.4/cli/conf.d/99-upload-max-filesize.ini \
    && echo "post_max_size=1024M" >> /etc/php/7.4/cli/conf.d/99-upload-max-filesize.ini

USER adminer
