FROM golang:alpine

RUN apk update && apk add automake build-base pkgconfig glib-dev gobject-introspection libxml2-dev expat-dev jpeg-dev libwebp-dev libpng-dev
RUN wget https://github.com/libvips/libvips/releases/download/v8.7.0/vips-8.7.0.tar.gz
# Exit 0 added because warnings tend to exit the build at a non-zero status
RUN tar -xf vips-8.7.0.tar.gz && cd vips-8.7.0 && ./configure && make && make install && ldconfig; exit 0
RUN apk del automake build-base