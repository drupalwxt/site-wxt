FROM drupalwxt/site-wxt:2.2.2 as src
MAINTAINER William Hearn <sylus1984@gmail.com>

FROM nginx:alpine
COPY --from=src /var/www/html /var/www/html
