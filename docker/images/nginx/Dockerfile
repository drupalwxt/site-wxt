ARG BASE_IMAGE=drupalwxt/site-wxt:latest
FROM $BASE_IMAGE as src

FROM nginx:alpine
COPY --from=src /var/www/html /var/www/html
