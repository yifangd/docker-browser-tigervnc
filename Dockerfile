FROM debian:bookworm-backports

LABEL maintainer="Yifang Dai <yifangd@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV USER browser

RUN apt-get update && apt-get install -y --no-install-recommends \
	gnupg2 ca-certificates openssh-client \
	iputils-ping net-tools iproute2 mtr-tiny curl \
	fonts-wqy-zenhei fonts-wqy-microhei ttf-bitstream-vera fonts-dejavu \
	pulseaudio pavucontrol paprefs tigervnc-standalone-server icewm xterm procps xfce4-terminal\
	firefox-esr \
  && apt-get clean \
	&& rm -rf /var/cache/* /var/log/apt/* /var/lib/apt/lists/* /tmp/* \
  && useradd -m -G pulse-access ${USER} \
	&& usermod -s /bin/bash ${USER} \
	&& chown -R ${USER}:${USER} /home/${USER}

VOLUME ["/home/${USER}"]
WORKDIR /home/${USER}

USER ${USER}
EXPOSE 5900

CMD /usr/bin/tigervncserver :0 -name vBrowser:0 -PasswordFile /home/${USER}/.vnc/passwd -localhost no -geometry 1600x1000 -depth 16 -dpi 75 -fg || /usr/bin/tail -F /var/log/messages
