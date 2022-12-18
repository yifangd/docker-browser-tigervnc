include /etc/docker/Makefile

ch chown:
	sudo chown -R 1000:1000 etc /keep/docker-chrome-data
reset:
	cd /keep/docker-chrome-data/; sudo rsync -avx --delete skel/ live/; sudo chown -R 1000:1000 live
build:
	cd /home/yifang/ogit/chrome; vi Dockerfile; docker build . -t yifang/chrome:latest --rm=false
