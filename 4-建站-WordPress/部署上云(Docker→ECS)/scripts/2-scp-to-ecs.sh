#!/usr/bin/env bash
# ============================================================
# 2-scp-to-ecs.sh — scp 上传备份到 ECS 8.219.190.222
# 跑在本机
# 关键:用本地 ~/.ssh/llccraft_sg key,通过 SSH 端口 49821
# ============================================================
set -euo pipefail

cd "$(dirname "$0")/../.."

SSH_KEY="$HOME/.ssh/llccraft_sg"
ECS_USER="llccraft_admin"
ECS_HOST="8.219.190.222"
ECS_PORT="49821"
REMOTE_DIR="/tmp/llccraft-deploy"

# 取最新的备份文件(支持 backup 在 /tmp 或当前目录)
SRC_DIR="${1:-/tmp}"
LATEST_SRC=$(ls -t "$SRC_DIR"/wp-source-*.tar.gz 2>/dev/null | head -1 || ls -t wp-source-*.tar.gz 2>/dev/null | head -1)
LATEST_DB=$(ls -t "$SRC_DIR"/wp-db-*.sql.gz 2>/dev/null | head -1 || ls -t wp-db-*.sql.gz 2>/dev/null | head -1)
LATEST_THEMES=$(ls -t "$SRC_DIR"/wp-themes-llccraft-child-*.tar.gz 2>/dev/null | head -1 || ls -t wp-themes-llccraft-child-*.tar.gz 2>/dev/null | head -1)

if [ -z "$LATEST_SRC" ] || [ -z "$LATEST_DB" ] || [ -z "$LATEST_THEMES" ]; then
    echo "❌ 找不到备份文件,先跑 1-backup-local.sh"
    exit 1
fi

echo "============================================================"
echo "▶ 2. scp 上传到 ECS"
echo "  source:        $LATEST_SRC"
echo "  db:            $LATEST_DB"
echo "  themes:        $LATEST_THEMES"
echo "  remote target: $ECS_USER@$ECS_HOST:$ECS_PORT -> $REMOTE_DIR"
echo "============================================================"

# SSH 连接测试
if ! ssh -i "$SSH_KEY" -p "$ECS_PORT" \
    -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
    "$ECS_USER@$ECS_HOST" 'echo connected-ok && uname -a' 2>&1 | grep -q connected-ok; then
    echo "❌ SSH 连接失败"
    exit 1
fi
echo "✅ SSH 通"

# 建远端目录
ssh -i "$SSH_KEY" -p "$ECS_PORT" \
    -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
    "$ECS_USER@$ECS_HOST" "mkdir -p $REMOTE_DIR && ls -la $REMOTE_DIR"

# scp 上传
scp -i "$SSH_KEY" -P "$ECS_PORT" \
    -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
    "$LATEST_SRC" "$ECS_USER@$ECS_HOST:$REMOTE_DIR/"

scp -i "$SSH_KEY" -P "$ECS_PORT" \
    -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
    "$LATEST_DB" "$ECS_USER@$ECS_HOST:$REMOTE_DIR/"

scp -i "$SSH_KEY" -P "$ECS_PORT" \
    -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
    "$LATEST_THEMES" "$ECS_USER@$ECS_HOST:$REMOTE_DIR/"

echo "✅ scp 完成"
echo
echo "下一步:SSH 到 ECS 跑 3-install-lnmp.sh"
echo "  ssh -i $SSH_KEY -p $ECS_PORT $ECS_USER@$ECS_HOST"
