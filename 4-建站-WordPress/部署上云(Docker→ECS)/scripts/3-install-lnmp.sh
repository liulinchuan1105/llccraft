#!/usr/bin/env bash
# ============================================================
# 3-install-lnmp.sh — 在 ECS 上装 LNMP 栈 (nginx + php-fpm 8.2 + mariadb-server)
# 跑在 ECS 上,SSH 后用 sudo bash 跑
# ============================================================
set -euo pipefail

echo "============================================================"
echo "▶ 3. ECS 装 LNMP 栈"
echo "============================================================"

echo "▶ 3a. apt 换源(阿里云 Ubuntu 源)"
sed -i 's|http://archive.ubuntu.com|https://mirrors.aliyun.com|g' /etc/apt/sources.list || true
apt update

echo "▶ 3b. 装 nginx + php8.2-fpm + mariadb-server"
apt install -y nginx php8.2-fpm php8.2-mysql php8.2-curl php8.2-gd \
                php8.2-xml php8.2-mbstring php8.2-zip php8.2-intl \
                mariadb-server mysql-client

echo "▶ 3c. 启动 + 开机自启"
systemctl enable --now nginx
systemctl enable --now php8.2-fpm
systemctl enable --now mariadb

echo "▶ 3d. ufw 放开 80 + 443"
ufw allow 80/tcp comment 'HTTP for WordPress'
ufw allow 443/tcp comment 'HTTPS for WordPress'
ufw status verbose

echo "▶ 3e. 数据库创库 + 用户"
DB_NAME="${WP_DB_NAME:-wp_db}"
DB_USER="${WP_DB_USER:-wp_user}"
# 生成随机 24 字符 db 密码
DB_PASS=$(openssl rand -base64 24 | tr -d '/=+' | cut -c1-24)
# 同 Task 003 凭证机制:写入 .ecs-deploy-credentials(不进 git)
CRED_FILE="/etc/llccraft/.ecs-deploy-credentials"
mkdir -p /etc/llccraft
cat > "$CRED_FILE" <<EOF
# llccraft ECS 部署 凭证(本地私有)
GENERATED_AT='$(date -u +%Y-%m-%dT%H:%M:%SZ)'
WP_DB_NAME='${DB_NAME}'
WP_DB_USER='${DB_USER}'
WP_DB_PASS='${DB_PASS}'
WP_ADMIN_USER='llccraft_admin'
# 注意:WP admin 密码沿用本地 .admin-credentials 的值,避免重置
EOF
chmod 600 "$CRED_FILE"
echo "  ... DB 凭证写到 $CRED_FILE"

# 建库
mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME} DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';"
mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"
echo "✅ DB ${DB_NAME} + user ${DB_USER} 已创建"

echo "▶ 3f. ECS 系统状态摘要"
echo "--- nginx status ---"
systemctl is-active nginx
echo "--- php-fpm status ---"
systemctl is-active php8.2-fpm
echo "--- mariadb status ---"
systemctl is-active mariadb
echo "--- listening ports ---"
ss -lntp | grep -E ":(80|443|3306)\s" | head -5

echo
echo "✅ LNMP 栈装完"
echo "下一步:跑 4-import-db.sh"
