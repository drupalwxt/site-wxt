FROM drupalwxt/site-wxt:latest as src
MAINTAINER William Hearn <sylus1984@gmail.com>

FROM nginx:alpine
COPY --from=src /var/www/html /var/www/html
