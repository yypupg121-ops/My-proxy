#!/bin/bash
set -e

PORT="${PORT:-443}"
WORKERS="${WORKERS:-1}"
PROXY_SECRET="${PROXY_SECRET:-}"
PROXY_TAG="${PROXY_TAG:-}"

cd /opt/MTProxy

echo "[1/3] Downloading Telegram proxy secret..."
curl -fsSL https://core.telegram.org/getProxySecret -o proxy-secret

echo "[2/3] Downloading Telegram proxy config..."
curl -fsSL https://core.telegram.org/getProxyConfig -o proxy-multi.conf

if [ -z "$PROXY_SECRET" ]; then
    PROXY_SECRET=$(head -c 16 /dev/urandom | xxd -p)
    echo "[WARNING] Generated temporary secret:"
    echo "$PROXY_SECRET"
else
    echo "[OK] Using Railway PROXY_SECRET"
fi

echo "======================================"
echo "        BXCODE MTProto Proxy"
echo "======================================"
echo "PORT : $PORT"
echo "SECRET : $PROXY_SECRET"
echo "TAG : ${PROXY_TAG:-NOT SET}"
echo "======================================"

ARGS=(
    -u nobody
    -p 8888
    -H "$PORT"
    -S "$PROXY_SECRET"
    --aes-pwd proxy-secret
    proxy-multi.conf
    -M "$WORKERS"
)

if [ -n "$PROXY_TAG" ]; then
    ARGS+=(-P "$PROXY_TAG")
fi

exec ./objs/bin/mtproto-proxy "${ARGS[@]}"
