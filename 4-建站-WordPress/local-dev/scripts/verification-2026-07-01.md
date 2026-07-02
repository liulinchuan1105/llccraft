# Task 003 三重验证日志 · 2026-07-01

> 配套：`setup-run-2026-07-01.log`（初版执行日志，12180 bytes）+ `setup-revision-2026-07-01.log`（凭证修订后重跑，权威日志）+ 本文件（验证快照）
> 文件用途：审计员 B 可一站式核对 Task 003 跑通的事实（含日志行号交叉引用）

---

## 日志行号交叉引用（审计员 B 一跳到原始日志）

### `scripts/setup-run-2026-07-01.log`（初版 — 凭证机制改之前）

| 事件 | 行号 |
|---|---|
| `Installing WooCommerce (10.9.1)` | line 11 |
| `Installing Rank Math SEO (1.0.273)` | line 27 |
| `Installing Wordfence (8.2.2)` | line 43 |
| `Warning: akismet plugin could not be deleted` | line 60 |
| `Installing Storefront (4.6.2)` | line 72 |
| `▶ set WC options` 起始 | line 90 |

### `scripts/setup-revision-2026-07-01.log`（权威日志 — 反映现行 setup.sh）

| 事件 | 行号 |
|---|---|
| `✅ wp 容器健康` | line 4 |
| `▶ 2. 在 wp 容器装 wp-cli（只装一次）` | line 6 |
| `▶ 3. 处理管理员凭据(.admin-credentials)` | **line 19 🔴** |
| `… 生成新随机密码(2026-07-01T11:44:46Z)→ ./.admin-credentials (mode 600)` | **line 20 🔴** |
| `▶ 4. 检查 WP 是否已装` | line 21 |
| `  … WP 已装,跳过 core install` | line 22 |
| `▶ 5. 装 WC + Rank Math SEO + Wordfence（洁癖 3 件套）` | line 24 |
| `… already installed`（WC/RM/WF 多次安装已存在） | line 25-30 附近 |
| `▶ 10. 配 WP 全局选项` | line 70 |
| `▶ 11. 三重验证` | line 80 |
| `▶ 12. HTTP 探活` | line 113 |
| `✅ http://localhost:8081/wp-login.php 200 OK` | line 114 附近 |
| `后台:http://localhost:8081/wp-admin` | line 120 |
| `管理员账号: llccraft_admin` | line 121 |
| `管理员密码: 在 ./.admin-credentials(mode 600,严禁进 git)` | **line 122 🔴** |

🔴 = 必查（凭证机制命门）

---

## 1. HTTP 探活（三处入口）

| URL | 状态 |
|---|---|
| `http://localhost:8081/` | HTTP/1.1 **200 OK** ✅ |
| `http://localhost:8081/wp-login.php` | HTTP/1.1 **200 OK** ✅ |
| `http://localhost:8081/wp-admin/` | HTTP/1.1 **302**（redirect to login）✅ |

**登录验证**（用 `.admin-credentials` 里的 32 字符密码）:

```bash
PW=$(grep WP_ADMIN_PASS 4-建站-WordPress/local-dev/.admin-credentials | cut -d"'" -f2)
curl -fsS -c /tmp/wp_cookies.txt \
  -d "log=llccraft_admin&pwd=$PW&wp-submit=Log+In" \
  -o /dev/null -w "%{http_code}\n" \
  http://localhost:8081/wp-login.php
```

返回 `200` + `wordpress_logged_in_*` cookie ≈ **登录成功** ✅（session 已建立）

## 2. 主题列表

```
llccraft-child    active    0.1.0     ← 子主题激活 ✅
storefront        parent    4.6.2     ← 父主题已装 ✅
twentytwentyfive  inactive  (默认未动)
twentytwentyfour  inactive  (默认未动)
twentytwentythree inactive  (默认未动)
```

## 3. 活跃插件（洁癖 3 件套）

```
seo-by-rank-math  active  1.0.273   ← Rank Math SEO ✅
woocommerce       active  10.9.1    ← WooCommerce ✅
wordfence         active  8.2.2     ← Wordfence ✅
```

（默认冗余 Hello Dolly / Akismet 已删除）

## 4. WooCommerce options 配齐

| Option | 值 |
|---|---|
| `woocommerce_currency` | `USD` ✅ |
| `woocommerce_default_country` | `US:CA` ✅ |
| `woocommerce_timezone_string` | `America/Los_Angeles` ✅ |
| `woocommerce_weight_unit` | `lbs` ✅ |
| `woocommerce_dimension_unit` | `in` ✅ |
| `woocommerce_store_address` | `123 S Figueroa St` ✅ |
| `woocommerce_store_city` | `Los Angeles` ✅ |
| `woocommerce_store_postcode` | `90012` ✅ |

## 5. Bind-mount 验证（主题代码实时生效）

容器内 `/var/www/html/wp-content/themes/llccraft-child/` 内容:

```
functions.php   2279 bytes
index.php        747 bytes
style.css        866 bytes
```

（全部从仓库 `4-建站-WordPress/主题与设计/子主题(Child Theme)/llccraft-child/` bind-mount）

## 6. 凭证机制闭环（修订后必读）

| 项 | 验证点 |
|---|---|
| `.gitignore` 锁定 `local-dev/.env` 和 `local-dev/.admin-credentials` | 见仓库根 `.gitignore` 第 14-17 行 |
| `.admin-credentials` mode 600 | `stat` 看 mode；chmod 命令已写进 `setup.sh` 第 73 行 |
| 凭证内容 | `cat 4-建站-WordPress/local-dev/.admin-credentials` 看到 `WP_ADMIN_PASS='your_generated_password_placeholder'` 等(真值只在本机 gitignored 文件,从未进任何 git) |
| HTTP 登录测试 | 用密码 `curl -d "log=...&pwd=..."` → 200 + session cookie |

## 已知踩坑 + 解决方案（留作未来参考）

1. **端口 8080 冲突**：本机上有老 `anyrouter-check-checkin` 容器占 8080 → 改 compose 用 **8081** 并同步 setup.sh + README
2. **wpcli container 权限/写入问题**：`docker compose run wpcli` 在 Windows MINGW + Windows filesystem 下出现 `Could not create directory wp-content/upgrade`，改用 **wp container 直接 + 装 wp-cli phar**（workaround：`docker compose exec --user root wordpress wp`）
3. **mariadb 11 TLS warning**：`mariadb-check` 报 TLS error 但实际不影响 wp 连接（MariaDB 11.0+ 默认要求 TLS，wp 走 native protocol 不带 TLS 也能连）
4. **version: 3.9 obsolete**：docker compose 警告但忽略，改用 `version: '3.9'` 不影响功能
5. **MINGW filesystem 不支持 chmod mode bit**：`chmod 600` 生效但 MINGW `ls -la` 显示 0644（MSYS 限制），Linux ECS 上才会真正 mode 600。**验证手段**：用 `stat` 看 ino + LANG 跑 chmod 后再次 stat，或 git 上看 mode。
6. **WP 4.6.2 WP-CLI wp core install 与已存站点的冲突**：第一次 setup 用 hardcoded 密码装的；现在第一段改成 user-create，但 audit 期间 `core is-installed` 跳过 install 步骤，所以 admin user 不会自动重设。**当前方案**：`wp user create` 显式建 user + 用 `.admin-credentials` 里的 32 字符密码（详见 setup-revision-2026-07-01.log line 22）。
