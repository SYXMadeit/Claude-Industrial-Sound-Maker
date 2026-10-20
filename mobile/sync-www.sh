#!/usr/bin/env sh
# Copy the web app into mobile/www (the Capacitor webDir), then sync native projects.
set -e
cd "$(dirname "$0")"
rm -rf www && mkdir -p www
cp -r ../index.html ../css ../js ../icons ../manifest.webmanifest www/
# no service worker inside the native shell: Capacitor serves files locally already
npx cap sync
