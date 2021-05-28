FROM alpine:latest

WORKDIR /xmrig

RUN apk update
RUN apk --no-cache upgrade
RUN apk --no-cache add \
    gcc \
    binutils \
    musl-dev \
    g++ \
    make \
    cmake \
    libuv-dev \
    openssl-dev \
    libmicrohttpd \
    git

RUN apk --no-cache add \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    hwloc-dev

RUN git clone --single-branch --depth 1 https://github.com/MoneroOcean/xmrig .

# I'm sorry :(
RUN sed -i 's/kMinimumDonateLevel = 1;/kMinimumDonateLevel = 0;/g' ./src/donate.h

RUN mkdir build && cmake -DCMAKE_BUILD_TYPE=Release . && make -j$(nproc)

RUN apk del gcc binutils musl-dev g++ make cmake git

RUN adduser -S -D -H -h /xmrig miner

USER miner

# This isn't needed specified by moneroocean.stream
# --coin $COIN

CMD ./xmrig -k --tls $BACKEND \
    --proxy=tor:$PROXY_PORT \
    -o $POOL:$POOL_PORT \
    -u $WALLET
