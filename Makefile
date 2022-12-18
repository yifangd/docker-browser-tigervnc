include /etc/docker/Makefile

ch chown:
	sudo chown -R 1000:1000 etc /keep/docker-browser-data
reset:
	cd /keep/docker-browser-data/; sudo rsync -avx --delete skel/ live/; sudo chown -R 1000:1000 live
build:
	cd /home/yifang/ogit/browser; vi Dockerfile; docker build . -t yifang/docker-browser-tigervnc:latest #--rm=false
