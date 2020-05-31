FROM busybox:latest

ARG VERSION=2.0.8
ARG SHA256_SUM=fba60411ab7f3b42b853e8e5a14a16d05791912f6f133508750ee69ab3d64a47

RUN wget https://github.com/pydio/cells/archive/v${VERSION}.tar.gz -O src.tar.gz
RUN echo "${SHA256_SUM}  src.tar.gz" | sha256sum -c
RUN tar -zxvf src.tar.gz

RUN mkdir -p /go/src/github.com/pydio \
    && mv cells-${VERSION} /go/src/github.com/pydio/cells

WORKDIR /go/src/github.com/pydio/cells

RUN ls && cat Makefile

COPY armv5.patch ./
RUN patch -p1 -i armv5.patch
    
FROM golang:latest
COPY --from=0 /go /go

ENV GOPATH=/go
ENV GOARCH=arm
ENV GOARM=5

RUN cd /go/src/github.com/pydio/cells/ && make dev
