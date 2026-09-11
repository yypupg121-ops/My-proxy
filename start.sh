#!/bin/sh
set -eu

PORT="${PORT:-443}"
WORKERS="${WORKERS:-1}"
PROXY_SECRET="${PROXY_SECRET:-}"
PROXY_TAG="${PROXY_TAG:-}"

cd /opt/MTProxy

echo "[1/3] Downloading Telegram proxy secret..."
curl -fsSL https://core.telegram.org/getProxySecret -o proxy-secret

echo "[2/3] Downloading current Telegram proxy config..."
curl -fsSL https://core.telegram.org/getProxyConfig -o proxy-multi.conf

if [ -z "$PROXY_SECRET" ]; then
    PROXY_SECRET="$(head -c 16 /dev/urandom | xxd -p)"
    echo "[WARNING] PROXY_SECRET is empty; a new secret was generated."
else
    echo "[OK] Using PROXY_SECRET from Railway."
fi

echo "======================================"
echo " BXCODE MTProto Proxy"
echo " Port   : $PORT"
echo " Secret : $PROXY_SECRET"
echo " Tag    : ${PROXY_TAG:-NOT_SET}"
echo "======================================"

if [ -z "$PROXY_TAG" ]; then
    echo "[WARNING] PROXY_TAG is empty."
    echo "The proxy can run, but no sponsored-channel tag is configured."
    exec ./objs/bin/mtproto-proxy         -u nobody         -p 8888         -H "$PORT"         -S "$PROXY_SECRET"         --aes-pwd proxy-secret proxy-multi.conf         -M "$WORKERS"
else
    exec ./objs/bin/mtproto-proxy         -u nobody         -p 8888         -H "$PORT"         -S "$PROXY_SECRET"         -P "$PROXY_TAG"         --aes-pwd proxy-secret proxy-multi.conf         -M "$WORKERS"
fi
