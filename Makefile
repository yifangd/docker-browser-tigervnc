include /etc/docker/Makefile

ch chown:
	sudo chown -R 1000:1000 etc /keep/docker-browser-tigervnc-data
reset:
	cd /keep/docker-browser-tigervnc-data/; sudo rsync -avx --delete skel/ live/; sudo chown -R 1000:1000 live
save:
	cd /keep/docker-browser-tigervnc-data/; sudo rsync -avx --delete live/ skel/; sudo chown -R 1000:1000 skel
C=--pull --no-cache
b build:
	sudo docker build . $C -t yifang/browser-tigervnc:latest -t yifang/browser-tigervnc:`date +%Y%m%d`
