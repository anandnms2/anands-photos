# Anands Photos - branding overlay on top of the stock Immich server image.
# Only static web assets are replaced; database and uploads are untouched.
ARG IMMICH_VERSION=release
FROM ghcr.io/immich-app/immich-server:${IMMICH_VERSION}
COPY assets /tmp/brand
RUN W="$(find /usr/src -maxdepth 4 -type d -name www 2>/dev/null | head -1)"; \
  echo "web dir: $W"; \
  if [ -n "$W" ]; then \
    for pair in "favicon.ico:favicon.ico" "favicon-16.png:icon-16.png" "favicon-32.png:icon-32.png" "favicon-48.png:icon-48.png" "favicon-96.png:icon-192.png" "favicon-144.png:icon-192.png" "apple-icon-180.png:icon-180.png"; do \
      t="${pair%%:*}"; s="${pair##*:}"; [ -f "$W/$t" ] && cp "/tmp/brand/$s" "$W/$t"; \
    done; \
    find "$W" -type f \( -name 'apple-icon*.png' -o -name 'apple-touch-icon*.png' \) -exec cp /tmp/brand/icon-180.png {} \; ; \
    find "$W" -type f \( -name 'pwa-192*.png' -o -name 'android-chrome-192*.png' \) -exec cp /tmp/brand/pwa-192.png {} \; ; \
    find "$W" -type f \( -name 'pwa-512*.png' -o -name 'android-chrome-512*.png' \) -exec cp /tmp/brand/pwa-512.png {} \; ; \
    find "$W" -type f -name 'immich-logo-inline*.svg' -exec cp /tmp/brand/logo-inline.svg {} \; ; \
    find "$W" -type f -name 'immich-logo*.svg' ! -name '*inline*' -exec cp /tmp/brand/logo-icon.svg {} \; ; \
    find "$W" -type f -name 'manifest.json' -exec sed -i 's/Immich/Anands Photos/g' {} \; ; \
  fi; \
  rm -rf /tmp/brand; true
