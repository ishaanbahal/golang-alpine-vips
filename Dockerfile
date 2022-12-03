ARG GOLANG_IMAGE_TAG="1.19.3-alpine3.17"
FROM golang:${GOLANG_IMAGE_TAG}

# So using 8.12.0 for now
ARG VIPS_VERSION="8.12.0"

RUN wget https://github.com/libvips/libvips/releases/download/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz
RUN apk update && apk add automake build-base pkgconfig glib-dev gobject-introspection libxml2-dev expat-dev jpeg-dev libwebp-dev libpng-dev
# Exit 0 added because warnings tend to exit the build at a non-zero status
RUN tar -xf vips-${VIPS_VERSION}.tar.gz && cd vips-${VIPS_VERSION} && ./configure && make && make install && ldconfig; exit 0
RUN apk del automake build-base
