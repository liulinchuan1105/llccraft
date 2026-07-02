#!/usr/bin/env bash
# ============================================================
# 4-import-db.sh — 解包 WP 源码 + mysql import + 写 wp-config.php
# 跑在 ECS 上
# ============================================================
set -euo pipefail

source /etc/llccraft/.ecs-deploy-credentials

WP_ROOT="/var/www/llccraft"
REMOTE_DIR="/tmp/llccraft-deploy"

echo "============================================================"
echo "▶ 4. 解包 WP + import DB"
echo "============================================================"

echo "▶ 4a. 拿最新上传的备份"
SRC_TAR=$(ls -t "$REMOTE_DIR"/wp-source-*.tar.gz | head -1)
DB_DUMP=$(ls -t "$REMOTE_DIR"/wp-db-*.sql.gz | head -1)
THEMES_TAR=$(ls -t "$REMOTE_DIR"/wp-themes-llccraft-child-*.tar.gz | head -1)
echo "  source:    $SRC_TAR"
echo "  db dump:   $DB_DUMP"
echo "  themes:    $THEMES_TAR"

echo "▶ 4b. 创建 web root"
mkdir -p "$WP_ROOT"
chown -R www-data:www-data "$WP_ROOT"

echo "▶ 4c. 解包 WP 源码"
# --strip-components=1 解到 $WP_ROOT,避免 wp-source-<ts> 父目录嵌套
tar xzf "$SRC_TAR" -C "$WP_ROOT" --strip-components=1 || \
    tar xzf "$SRC_TAR" -C "$WP_ROOT"
ls -la "$WP_ROOT" | head -10

echo "▶ 4d. 写 wp-config.php(用 ECS 凭证)"
cat > "$WP_ROOT/wp-config.php" <<EOF
<?php
//  wp-config.php · llccraft 瓷器独立站 · Task 004 上云部署版
//  凭证在 /etc/llccraft/.ecs-deploy-credentials (mode 600)

define( 'DB_NAME', '${WP_DB_NAME}' );
define( 'DB_USER', '${WP_DB_USER}' );
define( 'DB_PASSWORD', '${WP_DB_PASS}' );
define( 'DB_HOST', 'localhost' );
define( 'DB_CHARSET', 'utf8mb4' );
define( 'DB_COLLATE', '' );

\$table_prefix = 'wp_';

// 认证密钥(SALT)自动生成 8 个
\$salt_keys = array(
    'AUTH_KEY',         'SECURE_AUTH_KEY',     'LOGGED_IN_KEY',
    'NONCE_KEY',         'AUTH_SALT',           'SECURE_AUTH_SALT',
    'LOGGED_IN_SALT',    'NONCE_SALT',
);
foreach ( \$salt_keys as \$sk ) {
    \$line = "define( '{\$sk}', '";
    \$line .= bin2hex( random_bytes( 32 ) );
    \$line .= "' );\n";
    \$wp_salt_lines[] = \$line;
}

define( 'WP_DEBUG', false );

//  URL 暂留 8.219.190.222(IP 直访),Step 5 调 search-replace
define( 'WP_HOME',    'http://8.219.190.222' );
define( 'WP_SITEURL', 'http://8.219.190.222' );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';
EOF

echo "  ... wp-config.php 已写"
chown www-data:www-data "$WP_ROOT/wp-config.php"
chmod 644 "$WP_ROOT/wp-config.php"

echo "▶ 4e. mysql import 数据库 dump"
zcat "$DB_DUMP" | mysql -u"$WP_DB_USER" -p"$WP_DB_PASS" "$WP_DB_NAME"
echo "  ... 已导入 $(zcat "$DB_DUMP" | grep -c '^INSERT') 个 INSERT"

echo "▶ 4f. 同步子主题代码"
mkdir -p "$WP_ROOT/wp-content/themes"
tar xzf "$THEMES_TAR" -C /tmp/
cp -r /tmp/llccraft-child "$WP_ROOT/wp-content/themes/"
chown -R www-data:www-data "$WP_ROOT/wp-content/themes/llccraft-child"
rm -rf /tmp/llccraft-child

echo "▶ 4g. 装 Storefront 父主题(自动下载 wp-cli)"
# 用 wp-cli 自动装 Storefront,通过 wp-cli 在 wp 路径
curl -fsS -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# 在 WP root 跑 wp 命令
cd "$WP_ROOT"
sudo -u www-data wp theme install storefront --activate=twentytwentythree || \
    sudo -u www-data wp theme install storefront --activate=twentytwentyfour
sudo -u www-data wp theme activate llccraft-child

echo "▶ 4h. 验证"
sudo -u www-data wp theme list
sudo -u www-data wp plugin list --status=active

echo
echo "✅ Step 4 完成"
echo "下一步:跑 5-search-replace-url.sh"
