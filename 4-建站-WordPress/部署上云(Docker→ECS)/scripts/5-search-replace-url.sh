#!/usr/bin/env bash
# ============================================================
# 5-search-replace-url.sh — wp search-replace 把 siteurl/home 从本地
#   localhost:8081 替换成 8.219.190.222(或 llccraft.com,见 DNS 部署阶段)
# 跑在 ECS 上
# ============================================================
set -euo pipefail

source /etc/llccraft/.ecs-deploy-credentials

WP_ROOT="/var/www/llccraft"
OLD_URL="http://localhost:8081"
NEW_URL="${1:-http://8.219.190.222}"   # 默认 IP 直访,DNS 切完改 https://llccraft.com

echo "============================================================"
echo "▶ 5. WP search-replace URL"
echo "  $OLD_URL → $NEW_URL"
echo "============================================================"

cd "$WP_ROOT"

echo "▶ 5a. dry-run(看下有多少行要改)"
sudo -u www-data wp search-replace "$OLD_URL" "$NEW_URL" --all-tables --dry-run | tail -10

echo "▶ 5b. 确认覆盖?"
read -p "替换确认? [yes/NO] " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
    echo "❌ 取消"
    exit 0
fi

echo "▶ 5c. 真替换"
sudo -u www-data wp search-replace "$OLD_URL" "$NEW_URL" --all-tables

echo "▶ 5d. 更新 wp-config.php(WP_HOME / WP_SITEURL)"
# 由于 wp-config.php 自定义了 WP_HOME/SITEURL,改写它
sed -i "s|define( 'WP_HOME', 'http://8.219.190.222' );|define( 'WP_HOME',    '${NEW_URL}' );|" "$WP_ROOT/wp-config.php"
sed -i "s|define( 'WP_SITEURL', 'http://8.219.190.222' );|define( 'WP_SITEURL', '${NEW_URL}' );|" "$WP_ROOT/wp-config.php"

echo "▶ 5e. 看 wp_options 几个 URL 字段"
sudo -u www-data wp option get siteurl
sudo -u www-data wp option get home
sudo -u www-data wp option get blogname

echo
echo "✅ Step 5 完成"
echo "下一步:跑 6-nginx-vhost.sh + DNS A record 切换(老板在阿里云控制台手点)"
