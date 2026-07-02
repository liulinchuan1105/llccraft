#!/usr/bin/env bash
# ============================================================
# llccraft 瓷器独立站 · 本地一键初始化脚本
# Task 003 执行 - 2026-07-01
# 配套:docker-compose.yml
# 作用:WP 装 + 装 3 项洁癖插件 + 删默认 + 装 Storefront 父主题
#     + 激活 llccraft-child + 配 WC options(币种/国家/时区/lbs-in/地址)
#
# 关键 Trick:用 wp container 当 wp-cli 的执行器(MINGW/Win + docker
# wpcli container 的 user/permission 有 bug)。本脚本第一件事是装 wp-cli
# 到 wp 容器 /usr/local/bin/wp,然后所有 wp 命令都是
# `docker compose exec --user root wordpress wp --allow-root ...`
# ============================================================
set -euo pipefail
cd "$(dirname "$0")"

echo "============================================================"
echo "▶ llccraft 本地 WP 一键初始化"
echo "============================================================"

echo "▶ 1. 等容器健康..."
for i in $(seq 1 60); do
  if docker compose exec wordpress sh -c 'curl -fsS -o /dev/null http://localhost/wp-login.php' 2>/dev/null; then
    echo "✅ wp 容器健康"
    break
  fi
  echo "  ... waiting ($i / 60)"
  sleep 5
done

# 在 wp 容器内安装 wp-cli(只第一次跑需要;已存在则跳过)
echo "▶ 2. 在 wp 容器装 wp-cli(只装一次)"
docker compose exec --user root wordpress bash -c '
  if ! command -v wp >/dev/null 2>&1; then
    curl -fsS -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
  fi
  wp --version | head -1
'

# 全局 wp 命令简写
WP() {
  docker compose exec --user root wordpress wp --allow-root "$@"
}

# 凭证管理 -------------------------------------------------------
# 严禁把 admin 密码写进 setup.sh / docker-compose.yml / README.md / 任何进 git 的文件
# 第一次跑:用 python secrets 生成 32 字符 url-safe 随机密码 → 写到 .admin-credentials
# 后续跑:直接读 .admin-credentials(避免覆盖旧 admin)
CRED_FILE="$(dirname "$0")/.admin-credentials"
echo "▶ 3. 处理管理员凭据(.admin-credentials)"
if [ -f "$CRED_FILE" ]; then
    set -a; source "$CRED_FILE"; set +a
    echo "  ... 复用现有凭据(user=$WP_ADMIN_USER,生成于 $GENERATED_AT)"
else
    WP_ADMIN_USER="${WP_ADMIN_USER:-llccraft_admin}"
    WP_ADMIN_EMAIL="${WP_ADMIN_EMAIL:-admin@llccraft.local}"
    WP_ADMIN_PASS=$(python -c "import secrets; print(secrets.token_urlsafe(24))")
    GENERATED_AT="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    cat > "$CRED_FILE" <<EOF
# llccraft 本地开发环境 · 管理员凭据
# 严禁 commit(GITIGNORED by ../../.gitignore rule: local-dev/.admin-credentials)
# 生成时间: ${GENERATED_AT}
# README 4-建站-WordPress/local-dev/README.md "凭证复现" 章节有完整说明
WP_ADMIN_USER='${WP_ADMIN_USER}'
WP_ADMIN_EMAIL='${WP_ADMIN_EMAIL}'
WP_ADMIN_PASS='${WP_ADMIN_PASS}'
WP_ADMIN_URL='http://localhost:8081/wp-admin'
GENERATED_AT='${GENERATED_AT}'
EOF
    chmod 600 "$CRED_FILE"
    echo "  ... 生成新随机密码(${GENERATED_AT})→ ${CRED_FILE} (mode 600)"
fi

# 检查 WP 是否已装(避免重复 install 报 "site not installed")
echo "▶ 4. 检查 WP 是否已装"
if WP core is-installed 2>/dev/null; then
  echo "  ... WP 已装,跳过 core install"
else
  echo "▶ 4. 装 WP core"
  WP core install \
      --url=http://localhost:8081 \
      --title='llccraft' \
      --admin_user="$WP_ADMIN_USER" \
      --admin_password="$WP_ADMIN_PASS" \
      --admin_email="$WP_ADMIN_EMAIL" \
      --skip_email
fi

echo "▶ 5. 装 WC + Rank Math SEO + Wordfence(洁癖 3 件套)"
WP plugin install woocommerce --activate || true
WP plugin install seo-by-rank-math --activate || true
WP plugin install wordfence --activate || true

echo "▶ 6. 卸默认冗余插件(Hello Dolly / Akismet)"
WP plugin delete hello-dolly akismet || true

echo "▶ 7. 装 Storefront 父主题(WooCommerce 官方)"
WP theme install storefront --activate=twentytwentythree || true

echo "▶ 8. 激活 llccraft-child 子主题(从仓库 bind mount)"
WP theme activate llccraft-child || true

echo "▶ 9. 配 WooCommerce options"
WP option update woocommerce_currency 'USD'
WP option update woocommerce_default_country 'US:CA'
WP option update woocommerce_timezone_string 'America/Los_Angeles'
WP option update woocommerce_weight_unit 'lbs'
WP option update woocommerce_dimension_unit 'in'
WP option update woocommerce_store_address '123 S Figueroa St'
WP option update woocommerce_store_city 'Los Angeles'
WP option update woocommerce_store_postcode '90012'

echo "▶ 10. 配 WP 全局选项"
WP option update timezone_string 'America/Los_Angeles'
WP option update default_comment_status 'closed'
WP option update default_ping_status 'closed'
WP option update blogname 'llccraft'

echo
echo "▶ 11. 三重验证"
echo "--- 主题列表 ---"
WP theme list
echo "--- 插件列表(active only) ---"
WP plugin list --status=active
echo "--- WC options ---"
WP option get woocommerce_currency
WP option get woocommerce_default_country
WP option get woocommerce_timezone_string
WP option get woocommerce_weight_unit
WP option get woocommerce_dimension_unit
WP option get woocommerce_store_address
WP option get woocommerce_store_city
WP option get woocommerce_store_postcode

echo
echo "▶ 12. HTTP 探活"
if curl -fsS -o /dev/null http://localhost:8081/wp-login.php; then
  echo "✅ http://localhost:8081/wp-login.php 200 OK"
else
  echo "❌ HTTP 探活失败"
fi

echo
echo "============================================================"
echo "🎉 Task 003 初始化完成"
echo "============================================================"
echo "前端:http://localhost:8081"
echo "后台:http://localhost:8081/wp-admin"
echo "管理员账号: $WP_ADMIN_USER"
echo "管理员密码: $([ -f "$CRED_FILE" ] && echo "在 $CRED_FILE(mode 600,严禁进 git)" || echo "未生成 — 看 setup.sh 输出")"
echo "============================================================"

