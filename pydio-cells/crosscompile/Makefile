VERSION     ?= master
PREFIX      ?=

# VERSION    ?= 2.0.8
# PREFIX     ?= v
# SHA256_SUM ?= fba60411ab7f3b42b853e8e5a14a16d05791912f6f133508750ee69ab3d64a47

export GOPATH = $(CURDIR)/src

.PHONY: clean

cells: src
	GOARCH=arm GOARM=5 make -C src/src/github.com/pydio/cells dev
	mv src/src/github.com/pydio/cells/cells ./

src: src.tar.gz
	rm -rf src
	mkdir -p src/src/github.com/pydio
	tar -zxf src.tar.gz && mv cells-$(VERSION) src/src/github.com/pydio/cells
	patch -i $(CURDIR)/armv5.patch -d src/src/github.com/pydio/cells -p1

src.tar.gz:
	curl -L https://github.com/pydio/cells/archive/$(PREFIX)$(VERSION).tar.gz --output src.tar.gz
	if [ "$(SHA256_SUM)" ]; then \
		echo "$(SHA256_SUM) src.tar.gz" | sha256sum -c \
	fi

clean:
	rm src.tar.gz
	rm -rf src

