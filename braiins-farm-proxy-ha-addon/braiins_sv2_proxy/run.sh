#!/bin/bash
set -uo pipefail
export HOME=/data/home
mkdir -p "$HOME"
chown -R braiins:braiins /data/home

WEB_PASSWORD="$(jq -r '.web_password // ""' /data/options.json)"
as_proxy() { setpriv --reuid=braiins --regid=braiins --init-groups env HOME="$HOME" "$@"; }

echo "== $(as_proxy braiins-proxy --version 2>&1 | head -n1)"

# `braiins-proxy run` has no password option, and requests coming from loopback
# are not asked for one. So the proxy's web interface listens on 127.0.0.1:8081
# only, and nginx publishes it on 8080 behind HTTP basic auth.
if [ -n "$WEB_PASSWORD" ]; then
  printf '%s' "$WEB_PASSWORD" | openssl passwd -apr1 -stdin | sed 's/^/admin:/' > /etc/nginx/htpasswd
  chmod 644 /etc/nginx/htpasswd
  cat > /etc/nginx/braiins.conf << 'NGINX_EOF'
worker_processes 1;
pid /run/nginx-braiins.pid;
error_log /dev/stderr warn;
events { worker_connections 256; }
http {
  access_log off;
  server {
    listen 8080;
    auth_basic "Braiins Proxy";
    auth_basic_user_file /etc/nginx/htpasswd;
    location / {
      proxy_pass http://127.0.0.1:8081 ;
      proxy_http_version 1.1;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "upgrade";
      proxy_set_header Host $http_host;
      proxy_read_timeout 3600s;
    }
  }
}
NGINX_EOF
  nginx -c /etc/nginx/braiins.conf
  echo "Web interface protected by password on port 8080 (user: admin)"
else
  echo "WARNING: web_password is empty. The web interface is NOT exposed. Set a password in the add-on options."
fi

echo "Starting: braiins-proxy run --http 127.0.0.1:8081"
exec setpriv --reuid=braiins --regid=braiins --init-groups env HOME="$HOME" braiins-proxy run --http 127.0.0.1:8081
