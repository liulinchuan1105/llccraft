#!/usr/bin/env bash
# ============================================================
# 6-nginx-vhost.sh — nginx vhost 配置 + reload (HTTP-only, SSL 后续)
# 跑在 ECS 上
# ============================================================
set -euo pipefail

WP_ROOT="/var/www/llccraft"
DOMAIN="${1:-8.219.190.222}"   # 默认 IP 形式;之后切域名 DNS 后改 llccraft.com

echo "============================================================"
echo "▶ 6. nginx vhost · $DOMAIN"
echo "============================================================"

echo "▶ 6a. 写 nginx site config"
cat > /etc/nginx/sites-available/llccraft <<EOF
server {
    listen 80;
    listen [::]:80;
    server_name $DOMAIN www.$DOMAIN;

    root $WP_ROOT;
    index index.php index.html;

    # 主 location
    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    # PHP-FPM
    location ~ \\.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
        fastcgi_read_timeout 60s;
        fastcgi_buffers 16 16k;
        fastcgi_buffer_size 32k;
    }

    # 静态文件 caching
    location ~* \\.(js|css|png|jpg|jpeg|gif|ico|svg|woff2?)\$ {
        expires 30d;
        add_header Cache-Control "public, immutable";
        access_log off;
    }

    # wp-admin 限速防爆破
    location ~ ^/wp-login\\.php {
        limit_req zone=wordpress burst=10 nodelay;
    }

    # 安全 headers
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;

    # 静态文件 4 MB 上限(WP 默认 8M)
    client_max_body_size 64m;

    # log
    access_log /var/log/nginx/llccraft-access.log;
    error_log  /var/log/nginx/llccraft-error.log;
}
EOF

echo "▶ 6b. 启用 site"
# 删 default site
rm -f /etc/nginx/sites-enabled/default
ln -sf /etc/nginx/sites-available/llccraft /etc/nginx/sites-enabled/llccraft

echo "▶ 6c. nginx limit_req zone"
# 在 nginx.conf 的 http {} 块加 limit_req zone
if ! grep -q "limit_req_zone.*wordpress" /etc/nginx/nginx.conf; then
    sed -i 's|^http {|http {\n    limit_req_zone \$binary_remote_addr zone=wordpress:10m rate=10r/s;|' /etc/nginx/nginx.conf
fi

echo "▶ 6d. 语法检查 + reload"
nginx -t
systemctl reload nginx

echo "▶ 6e. 探活"
sleep 1
curl -sI "http://$DOMAIN/wp-login.php" | head -3
echo
curl -sI "http://$DOMAIN/" | head -3

echo
echo "✅ nginx vhost 配完,WP 应该已经可以 http 访问"
echo "下一步:"
echo "  - 老板去阿里云 DNS 控制台把 llccraft.com A 记录改成 8.219.190.222 → 等 DNS 传播"
echo "  - 加 Let's Encrypt SSL(脚本 6b 后)"
echo "  - 后续生产(美西硅谷):脚本可一键复用"
