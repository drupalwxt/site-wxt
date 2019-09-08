ARG BASE_IMAGE=drupalwxt/site-wxt:latest
FROM $BASE_IMAGE
MAINTAINER William Hearn <sylus1984@gmail.com>

COPY tasks/ /etc/periodic/
RUN chmod -R +x /etc/periodic/

CMD ["crond", "-f", "-d", "8"]
