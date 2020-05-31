VERSION     ?= master
PREFIX      ?=

# VERSION    ?= 2.0.8
# PREFIX     ?= v
# SHA256_SUM ?= fba60411ab7f3b42b853e8e5a14a16d05791912f6f133508750ee69ab3d64a47


export GOPATH = $(CURDIR)/src
CELLS_PATH := $(GOPATH)/src/github.com/pydio/cells
PACKR_BIN  := $(GOPATH)/bin/packr

.PHONY: clean

cells: $(PACK_PATH) $(PACKR_BIN)
	GOARCH=arm GOARM=5 make -C $(CELLS_PATH) generate dev
	mv $(CELLS_PATH)/cells ./

$(PACKR_BIN):
	go get -u github.com/pydio/packr/packr

$(CELLS_PATH): src.tar.gz
	rm -rf $(CELLS_PATH)
	mkdir -p src/src/github.com/pydio
	tar -zxf src.tar.gz && mv cells-$(VERSION) $(CELLS_PATH)
	patch -i $(CURDIR)/armv5-$(VERSION).patch -d $(CELLS_PATH) -p1

src.tar.gz:
	curl -L https://github.com/pydio/cells/archive/$(PREFIX)$(VERSION).tar.gz --output src.tar.gz
	if [ "$(SHA256_SUM)" ]; then \
		echo "$(SHA256_SUM) src.tar.gz" | sha256sum -c \
	fi

clean:
	rm src.tar.gz
	rm -rf src

