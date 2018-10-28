FROM golang:alpine

# Version latest is 8.7.x but go-bimg crashes because of that
# Issue: https://github.com/h2non/bimg/issues/244
# So using 8.6.5 for now
ARG VIPS_VERSION="8.6.5"

RUN wget https://github.com/libvips/libvips/releases/download/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz
RUN apk update && apk add automake build-base pkgconfig glib-dev gobject-introspection libxml2-dev expat-dev jpeg-dev libwebp-dev libpng-dev
# Exit 0 added because warnings tend to exit the build at a non-zero status
RUN tar -xf vips-${VIPS_VERSION}.tar.gz && cd vips-${VIPS_VERSION} && ./configure && make && make install && ldconfig; exit 0
RUN apk del automake build-base