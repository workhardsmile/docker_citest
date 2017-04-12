FROM hub.c.163.com/library/jenkins:2.32.1-alpine

MAINTAINER  Frank Wu "gang.wu@istuary.com"

USER root
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/docker-entrypoint.sh"]
CMD ["jenkins"]
