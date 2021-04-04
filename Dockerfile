# Watcom Docker Build Environment
#
# To build use:
# docker build -t lapinlabs/watcom .
FROM alpine:3.13
MAINTAINER Chad Rempp <crempp@gmail.com>

LABEL description="An OpenWatcom V2 build environment."

# Setup the build environment all in one pass. This helps us to reduce image
# size by doing cleanup in the same layer as the setup.
RUN apk add --no-cache --update --virtual .build-deps \
      g++ \
      gcc \
      git \
      make \
      musl-dev \
    # Build and install Watcom package
    && cd /tmp \
    && git clone --depth 1 --branch 2021-04-02-Build https://github.com/open-watcom/open-watcom-v2.git \
    && cd open-watcom-v2 \
    && echo "export OWNOBUILD=\"nt386 wgml\"" >> setvars.sh \
    && echo "export OWGUINOBUILD=1" >> setvars.sh \
    # Comment out inclusion of wgml/builder.ctl to avoid Dosbox dependency -- this SHOULD NOT be necessary
    && sed '/\[ INCLUDE <OWSRCDIR>\/wgml\/builder.ctl \]/{s/^/#/}' -i bld/builder.ctl \
    # buildrel.sh exists, but for reasons that are unclear, it doesn't end up actually copying anything
    && OWRELROOT=/opt/watcom ./build.sh rel os_linuxx64 \
    && cd / \
    # Clean up after ourselves (do this in the same layer)
    && rm -rf /tmp/open-watcom-v2 \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/*

ENV WATCOM=/opt/watcom
ENV INCLUDE="$WATCOM/h"
ENV PATH="$WATCOM/binl64:$WATCOM/binl:$PATH"

# Finally, display installed binaries + version info in image build log
RUN ls /opt/watcom/binl64 /opt/watcom/binl && wcl -v | grep Version

CMD ["/bin/sh"]
