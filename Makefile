
export GOPATH:=$(PWD)/go
export PATH:=$(PATH):$(GOPATH)/bin/

.PHONY: clean all syncthing

all: filebrowser syncthing

clean:
	rm -rf $(GOPATH) .build

syncthing:
	mkdir -p .build .out
	curl -L https://github.com/syncthing/syncthing/releases/download/v1.6.1/syncthing-linux-arm-v1.6.1.tar.gz \
		--out .build/syncthing-linux-arm-v1.6.1.tar.gz 
	cd .build && tar -zxvf syncthing-linux-arm-v1.6.1.tar.gz syncthing-linux-arm-v1.6.1/syncthing
	cp .build/syncthing-linux-arm-v1.6.1/syncthing .out/


filebrowser:
	mkdir -p .build .out
	curl -L https://github.com/filebrowser/filebrowser/releases/download/v2.1.1/linux-armv5-filebrowser.tar.gz \
		--out .build/linux-armv5-filebrowser.tar.gz
	cd .build && tar -zxvf linux-armv5-filebrowser.tar.gz filebrowser
	cp .build/filebrowser .out/

build-filebrowser:
	mkdir -p .build .out
	curl -L https://github.com/filebrowser/filebrowser/archive/master.tar.gz \
		--output .build/filebrowser.tar.gz
	cd .build && tar -zxf filebrowser.tar.gz
	cd .build/filebrowser-master/ && \
		go install github.com/GeertJohan/go.rice/rice && \
		GOARCH=arm GOARM=5 ./wizard.sh -b && \
		mv filebrowser ../../.out/

navidrome:
	mkdir -p .build .out
	curl -L https://github.com/deluan/navidrome/archive/master.tar.gz \
		--out .build/navidrome.tar.gz
	cd .build && tar -zxf navidrome.tar.gz
	cd .build/navidrome-master && \
		make setup && \
		CC=arm-linux-gnueabi-gcc CGO_ENABLED=1 GOARCH=arm GOARM=5 make buildall && \
		mv navidrome ../../.out/