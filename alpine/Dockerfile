FROM alpine:latest
LABEL maintainer="Yifang Dai <yifangd@gmail.com>"

ENV USER browser

RUN apk update \
  && apk add firefox tigervnc font-noto-cjk font-dejavu \
  && rm -rf /var/cache/apk/* \
  && adduser -s /bin/bash -D ${USER} \
        && chown -R ${USER}:${USER} /home/${USER}

VOLUME ["/home/${USER}"]
WORKDIR /home/${USER}

USER ${USER}
EXPOSE 5900

CMD /home/${USER}/bin/v server && /usr/bin/tail -F /var/log/messages
