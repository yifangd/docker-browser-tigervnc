FROM debian:bullseye-backports

LABEL maintainer="Yifang Dai <yifangd@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

ADD https://dl-ssl.google.com/linux/linux_signing_key.pub /tmp/
RUN apt-get update && apt-get install -y gnupg2 ca-certificates \
    && cat /tmp/linux_signing_key.pub | gpg --dearmor - > /etc/apt/trusted.gpg.d/google-linux-key.gpg \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update && apt-get install -y --no-install-recommends \
	fonts-wqy-zenhei fonts-wqy-microhei ttf-bitstream-vera fonts-dejavu \
	pulseaudio tigervnc-standalone-server icewm xterm \
	procps xfce4-terminal\
	google-chrome-stable \
	firefox-esr \
  && apt-get clean \
	&& rm -rf /var/cache/* /var/log/apt/* /var/lib/apt/lists/* /tmp/*

RUN useradd -m -G pulse-access chrome \
	&& usermod -s /bin/bash chrome \
	&& chown -R chrome:chrome /home/chrome

VOLUME ["/home/chrome"]
#COPY chrome.sh /usr/bin/chrome.sh
#RUN chmod +x /usr/bin/chrome.sh

USER chrome
EXPOSE 5900

CMD /usr/bin/tigervncserver :0 -name chrome:0 -PasswordFile /home/chrome/.vnc/passwd -localhost no -geometry 1600x1000 -depth 16 -dpi 75 -fg || /usr/bin/tail -F /var/log/messages
