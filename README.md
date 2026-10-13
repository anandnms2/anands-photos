# anands-photos
Branding overlay for Immich (photos.anands.xyz).
1. Build/push image: `docker build -t ghcr.io/anandnms2/anands-photos:latest .` (or Coolify Dockerfile app / GHCR CI)
2. In Coolify service "Anands Photos", change immich server `image:` to `ghcr.io/anandnms2/anands-photos:latest`, redeploy. Volumes/DB unchanged.
3. Paste theme.css into Admin > Settings > Theme. Set Server > Welcome/Login message to "Anands Photos".
Mobile app: icon/splash are compiled into the app; cannot be pushed from the server.
