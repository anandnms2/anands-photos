# Anands Photos - branding overlay on top of the stock Immich server image.
# Database/uploads untouched: only static web assets are replaced.
ARG IMMICH_VERSION=release
FROM ghcr.io/immich-app/immich-server:${IMMICH_VERSION}
COPY assets /tmp/brand
RUN set -e; W=/usr/src/app/www; \
  [ -f $W/favicon.ico ] && cp /tmp/brand/favicon.ico $W/favicon.ico || true; \
  [ -f $W/favicon-16x16.png ] && cp /tmp/brand/icon-16.png $W/favicon-16x16.png || true; \
  [ -f $W/favicon-32x32.png ] && cp /tmp/brand/icon-32.png $W/favicon-32x32.png || true; \
  [ -f $W/favicon-48x48.png ] && cp /tmp/brand/icon-48.png $W/favicon-48x48.png || true; \
  [ -f $W/favicon-96x96.png ] && cp /tmp/brand/icon-192.png $W/favicon-96x96.png || true; \
  find $W -type f \( -name 'apple-icon*.png' -o -name 'apple-touch-icon*.png' \) -exec cp /tmp/brand/icon-180.png {} \; ; \
  find $W -type f \( -name 'pwa-192*.png' -o -name 'android-chrome-192*.png' \) -exec cp /tmp/brand/pwa-192.png {} \; ; \
  find $W -type f \( -name 'pwa-512*.png' -o -name 'android-chrome-512*.png' \) -exec cp /tmp/brand/pwa-512.png {} \; ; \
  find $W -type f -name 'immich-logo-inline*.svg' -exec cp /tmp/brand/logo-inline.svg {} \; ; \
  find $W -type f -name 'immich-logo*.svg' ! -name '*inline*' -exec cp /tmp/brand/logo-icon.svg {} \; ; \
  find $W -type f -name 'manifest.json' -exec sed -i 's/Immich/Anands Photos/g' {} \; ; \
  echo "branded files:"; find $W -newer /tmp/brand/logo-icon.svg -type f | head -50; \
  rm -rf /tmp/brand
