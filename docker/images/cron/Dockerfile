ARG BASE_IMAGE=drupalwxt/site-wxt:latest
FROM $BASE_IMAGE

COPY tasks/ /etc/periodic/

RUN chmod -R +x /etc/periodic/

CMD ["crond", "-f", "-d", "8"]
