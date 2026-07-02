#!/usr/bin/env bash
# ============================================================
# 1-backup-local.sh — 本地 Docker WordPress 全量备份
# 跑在本机 = ./local-dev 父目录
# 输出:
#   /tmp/wp-source-<timestamp>.tar.gz   WP 源码(含 Storefront + llccraft-child + WC uploads)
#   /tmp/wp-db-<timestamp>.sql.gz        数据库 dump
# 注意:WP source tar 已经包含 wp-content/themes/llccraft-child/
#       本地仓库的子主题 git 跟踪与本备份是同一份,不需要独立打包。
# ============================================================
# ⚠️ MINGW/Windows 注意:bash 会自动转 /var/www/html 这种 Linux 路径
#    → C:\Program Files\Git\var\www\html,导致 docker exec 报 can't open
#    解决方案:这一段脚本**完全靠 cmd //c 调 docker**(直接用 Windows path 走 Win32 API)
# ============================================================
set -euo pipefail

TS=$(date -u +%Y%m%dT%H%M%SZ)
OUT_DIR="${1:-/tmp}"
# Windows 风格路径(给 cmd / docker for Windows 用)
OUT_DIR_WIN='C:\Users\Administrator\AppData\Local\Temp'

echo "============================================================"
echo "▶ 1. 本地 WP 全量备份 · $TS"
echo "============================================================"

echo "▶ 1a. 数据库 dump(走 cmd //c,绕开 bash 中文 path translation)"
cmd //c "docker exec llccraft-db mysqldump -u wp_user -pwp_dev_local_placeholder wp_db | gzip > ${OUT_DIR_WIN}\\wp-db-${TS}.sql.gz"
SRC_WIN="${OUT_DIR_WIN}\\wp-db-${TS}.sql.gz"
DEST="/tmp/wp-db-$TS.sql.gz"
cp "$SRC_WIN" "$DEST" 2>/dev/null && rm "$SRC_WIN" || mv "${OUT_DIR_WIN}\\wp-db-${TS}.sql.gz" "$DEST" 2>/dev/null || true
ls -la "$DEST" 2>&1 | head -1
[ ! -f "$DEST" ] && ls -la "${OUT_DIR_WIN}\\wp-db-${TS}.sql.gz" 2>&1 | head -1

echo "▶ 1b. WP 源码 tar(含 Storefront + llccraft-child)"
cmd //c "docker exec llccraft-wp tar czf /tmp/inside-source.tar.gz -C /var/www/html . && docker cp llccraft-wp:/tmp/inside-source.tar.gz ${OUT_DIR_WIN}\\wp-source-${TS}.tar.gz && docker exec llccraft-wp rm -f /tmp/inside-source.tar.gz"
srcsize=$(ls -la "${OUT_DIR_WIN}\\wp-source-${TS}.tar.gz" 2>&1 | awk '{print $5}')
echo "  ... /tmp/wp-source-$TS.tar.gz = ${srcsize} bytes"

echo "▶ 1d. 输出清单"
ls -la "/tmp/wp-source-$TS.tar.gz" "/tmp/wp-db-$TS.sql.gz" 2>&1

echo
echo "✅ 备份完成 · 2 个文件"
echo "  - wp-source-$TS.tar.gz  WP 全量源码 (含 themes + plugins + uploads)"
echo "  - wp-db-$TS.sql.gz      数据库 dump"
echo
echo "下一步:跑 2-scp-to-ecs.sh"
