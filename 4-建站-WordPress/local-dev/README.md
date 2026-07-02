# 本地开发环境（Docker Compose · Task 003）

> 路径：`4-建站-WordPress/local-dev/`
> 用途：本地 WordPress + WooCommerce + 子主题开发的 docker 一键环境
> 状态：🟢 跑通（2026-07-01 闭环）

---

## 起手 3 行

```bash
cd 4-建站-WordPress/local-dev
cp .env.example .env          # 默认密码占位,生产前请改
docker compose up -d          # 起 wp + db(~60s 等健康)
./setup.sh                    # 一键初始化 WP + WC + 主题
```

## 访问地址

| 入口 | URL |
|---|---|
| **WP 前台** | http://localhost:8081 |
| **WP 后台** | http://localhost:8081/wp-admin |
| **账号** | `llccraft_admin` |
| **密码** | ⚠️ **见下方【凭证复现】** — 随机生成,不在主代码 |

## 接入清单(Task 003 完成后)

- ✅ WordPress 6.x + PHP 8.2
- ✅ WooCommerce 9.x 已激活
- ✅ 插件洁癖 3 件套:**WooCommerce / Rank Math SEO / Wordfence**
- ✅ 删除默认冗余:**Hello Dolly / Akismet**
- ✅ 父主题 **Storefront**(WooCommerce 官方出品,WordPress.org 下载)已装
- ✅ 子主题 **`llccraft-child`** 已激活(从仓库 bind-mount,改代码实时生效)
- ✅ WooCommerce options 配齐:
  - 币种 = USD
  - 国家 = US:CA
  - 时区 = America/Los_Angeles
  - 重量 = lbs / 尺寸 = in
  - 地址 = 123 S Figueroa St / Los Angeles / 90012
- ✅ WP 全局:时区 LA / 评论关

## 容器生命周期

```bash
docker compose ps              # 看状态
docker compose logs -f wp      # 看 wp 日志
docker compose logs -f db      # 看 db 日志
docker compose stop            # 停(数据保留)
docker compose down            # 删容器(数据卷保留)
docker compose down -v         # 删容器 + 数据卷(全清)
```

## 主题代码修改工作流

1. 直接在仓库 `4-建站-WordPress/主题与设计/子主题(Child Theme)/llccraft-child/` 编辑
2. 因为 bind-mount,改完立即在容器内可见
3. 浏览器刷新 http://localhost:8081 看效果
4. 不需要重启容器

## 调试 wp-cli(随时可用)

```bash
# 进 wp 容器内 bash
docker compose exec wordpress bash

# 跑任意 wp-cli 命令
docker compose --profile tools run --rm wpcli wp --allow-root plugin list
docker compose --profile tools run --rm wpcli wp --allow-root post list
docker compose --profile tools run --rm wpcli wp --allow-root option get blogname
```

## 🔐 凭证复现(管理员账号与密码)

`setup.sh` **随机生成**管理员密码,**绝不写死在主代码**。

### 机制

- 第一次跑 `setup.sh`:用 python `secrets.token_urlsafe(24)` 生成 32 字符 url-safe 密码
- 写到 `local-dev/.admin-credentials`(被仓库根 `.gitignore` 锁住)
- chmod 600,只有你能读
- 后续重跑 `setup.sh`:读现有 `.admin-credentials` 复用(避免覆盖导致旧 admin 失效)
- 可通过环境变量 `WP_ADMIN_USER` / `WP_ADMIN_PASS` / `WP_ADMIN_EMAIL` 覆盖默认(适合 CI/CD)

### 文件位置

```
local-dev/.admin-credentials   (gitignored, mode 600)
```

查看命令:

```bash
cat 4-建站-WordPress/local-dev/.admin-credentials
```

### 后台登录(`http://localhost:8081/wp-admin`)

1. 用户名 = `llccraft_admin`(默认)
2. 密码 = 看 .admin-credentials 的 `WP_ADMIN_PASS` 那一行

提取密码一行命令:

```bash
grep WP_ADMIN_PASS 4-建站-WordPress/local-dev/.admin-credentials | cut -d"'" -f2
```

### 004 上 ECS 生产机时怎么迁移密码

**方式 A(本地手工抄写)— 早期部署推荐**:
1. 本地 `cat local-dev/.admin-credentials` 抄下密码
2. SSH 到 ECS,浏览器登 `https://llccraft.com/wp-admin`
3. 用 `llccraft_admin` + 抄来的密码登录
4. **当场立刻改密码** 成正式密码(部署专用,不再用本地的随机码)

**方式 B(secret manager)— CI/CD 推荐**:
1. 把 `.admin-credentials` 推到 1Password / 阿里云 KMS
2. ECS 启动脚本从 secret manager pull,**不落地**

**方式 C(env in CI)— 自动化**:
1. CI 里 export `WP_ADMIN_USER` / `WP_ADMIN_PASS` / `WP_ADMIN_EMAIL`
2. `setup.sh` 读 env(优先级高于 `.admin-credentials`)
3. 直接注入 ECS 部署脚本

### 故障恢复 / 重置

| 场景 | 操作 |
|---|---|
| 忘了本地密码 | `rm local-dev/.admin-credentials` + 重跑 `setup.sh` → 自动生成新密码 + 新 admin user |
| 加第二个 admin | `WP user create NEW_USER EMAIL --role=administrator --user_pass=NEW_PASS` |
| 想换本地密码 | WP 后台 → 用户 → 编辑 → 改密码 + **手动同步更新** `.admin-credentials` |

### 严禁清单 🔴

- ❌ 把 `.admin-credentials` commit 到 git(被 `.gitignore` 锁,但人工 `git add -f` 可绕过 — 这是审计员 B 必检项)
- ❌ 把 `WP_ADMIN_PASS` 写进 `setup.sh` / `docker-compose.yml` / `README.md` / 任何进 git 的文件
- ❌ 把 `WP_ADMIN_PASS` 写到聊天 / 邮件 / Slack / 屏幕分享 / 公开 issue
- ❌ 把 `.admin-credentials` 推到 public 云盘 / 邮件附件
- ❌ 在生成完密码后**不回退 setup.sh 去掉打印密码逻辑**(已严格遵守)

## 上 ECS 部署(Task 004 衍生)

到时候把以下同步上 ECS 美西硅谷主机:
1. `wp-content/themes/llccraft-child/` 整个目录
2. `wp-config.php`(替换 DB host / user / pass)
3. 数据库 dump → restore(`wp db export / wp db import`)
4. `wp search-replace old → new` 替换 URL

`Storefront` 父主题生产时也装,但走 wp.org 下载,不必带仓库。
