FROM drupalcomposer/drupal
MAINTAINER William Hearn <sylus1984@gmail.com>

ARG GIT_USERNAME
ARG GIT_PASSWORD

# Install certificates.
# COPY docker/certs/* /usr/local/share/ca-certificates/
# RUN update-ca-certificates

# Allow Composer to be run as root.
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_VERSION 1.8.1
ENV COMPOSER_MEMORY_LIMIT -1
# ENV COMPOSER_EXIT_ON_PATCH_FAILURE 1

# Setup the Composer installer.
RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
  && curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
  && php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }"

# Install Composer.
RUN php /tmp/composer-setup.php --no-ansi \
                                --install-dir=/usr/local/bin \
                                --filename=composer \
                                --version=${COMPOSER_VERSION} && \
    rm -rf /tmp/composer-setup.php

# Install Drupal via composer.
RUN rm -f /var/www/composer.lock && \
    rm -rf /root/.composer

RUN rm -rf /var/www/*
COPY scripts/ScriptHandler.php /var/www/scripts/ScriptHandler.php
COPY composer.json /var/www/composer.json
COPY composer.lock /var/www/composer.lock
WORKDIR /var/www
RUN composer global require "hirak/prestissimo:^0.3" && \
    composer install --prefer-dist \
                     --no-interaction

# Permissions.
WORKDIR /var/www/html
RUN chown -R www-data:www-data sites/default

# Drush.
RUN ln -s /var/www/vendor/drush/drush/drush /usr/local/bin/drush

RUN php -r 'opcache_reset();'

# See: https://github.com/docker/docker/issues/9299
RUN echo "export TERM=xterm" >> ~/.bashrc
