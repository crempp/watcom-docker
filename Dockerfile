FROM alpine:3.8

# Dependencies
RUN apk add --no-cache --update \
      g++ \
      gcc \
      git \
      make \
      musl-dev \
    && rm -rf /var/cache/apk/*

# Build and install Watcom package
RUN cd /tmp \
    && git clone https://github.com/open-watcom/open-watcom-v2.git \
    && cd open-watcom-v2 \
    && echo "export OWNOBUILD=\"nt386 wgml\"" >> setvars.sh \
    && echo "export OWGUINOBUILD=1" >> setvars.sh \
    && ./build.sh \
    && cp build/binbuild/* /usr/local/bin \
    && cd / \
    && rm -rf /tmp/open-watcom-v2
