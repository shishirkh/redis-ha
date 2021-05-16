FROM redis
RUN mkdir sentinel-conf-template
COPY sentinel.conf /sentinel-conf-template/sentinel.conf
COPY sentinel-entrypoint.sh /sentinel-entrypoint.sh
RUN chmod +x /sentinel-entrypoint.sh
ENTRYPOINT ["/bin/sh","-c","/sentinel-entrypoint.sh"]
