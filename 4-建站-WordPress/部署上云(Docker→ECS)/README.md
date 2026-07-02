# 部署上云 · Docker → ECS Task 004

> 路径：`4-建站-WordPress/部署上云(Docker→ECS)/`
> 状态：🟡 进行中（等老板对齐方案 · 2026-07-01）

---

## 🎯 一句话定心

把本地 `local-dev/` Docker 跑通的 WordPress + WooCommerce + 子主题,完整迁移到阿里云新加坡 ECS `8.219.190.222`,然后改 `llccraft.com` 的 A 记录指过去,完成"端到端可访问"的部署闭环(**沙盒 + 演练双重意义**:既是真上线,也是 7-31 迁美西硅谷前的部署演练)。

## ⚠️ 现实提醒

- 这台 ECS 区域是**新加坡**(误开,7-31 前必迁美西),本次上线**真实对外可访问**
- 7-30 之前必须再做一次美西硅谷版 Task 004(同样姿势)
- 部署姿势要**可重复**(美西机复用同一套脚本)

## 📋 6 步上云部署流水线

| 步 | 脚本 | 跑在 | 动作 |
|---|------|------|------|
| **1** | `scripts/1-backup-local.sh` | 本机 | `docker exec` 导出 WP 源文件 (.tar.gz) + 数据库 (.sql.gz) |
| **2** | `scripts/2-scp-to-ecs.sh` | 本机 | scp 备份 + 子主题代码 + 配置 三个文件到 ECS |
| **3** | `scripts/3-install-lnmp.sh` | ECS | apt 装 nginx + php-fpm 8.2 + mariadb-server + certbot |
| **4** | `scripts/4-import-db.sh` | ECS | 解包 WP source + mysql import .sql + 写 wp-config.php |
| **5** | `scripts/5-search-replace-url.sh` | ECS | `wp search-replace 'http://localhost:8081' 'http://llccraft.com'` |
| **6** | `scripts/6-nginx-vhost.sh` | ECS | nginx vhost + reload |
| **7** | `scripts/DNS-A-record.md`(指引)| 老板手 | 阿里云 DNS 控制台改 `llccraft.com` A 记录 |

## 🚪 端到端目录流

```
4-建站-WordPress/
├── local-dev/                          ← 已闭环(Tasks 003 验证)
│   ├── .admin-credentials             (gitignored)
│   └── ...
└── 部署上云(Docker→ECS)/             ← 本目录(Task 004 通道)
    ├── README.md                       ← 你正看着
    └── scripts/
        ├── 1-backup-local.sh          ← 本地 dump + tar
        ├── 2-scp-to-ecs.sh            ← scp 到 49821
        ├── 3-install-lnmp.sh          ← apt 装 nginx + php + mariadb
        ├── 4-import-db.sh             ← 解包 + mysql import
        ├── 5-search-replace-url.sh    ← wp search-replace
        ├── 6-nginx-vhost.sh           ← nginx config + reload
        └── DNS-A-record.md            ← 老板手操作的 DNS 指引
```

## 🛡️ 安全约束(沿用 Task 002 加固红线)

- 🔴 全程 ssh 端口 49821(不是 22)— 阿里云安全组已放行
- 🔴 ssh 全程用 `~/.ssh/llccraft_sg` ed25519 key(不输密码)
- 🔴 llccraft_admin 账号操作(不直接 root)
- 🔴 ECS root 密码不入仓/不入 chat(只在 .admin-credentials 概念的 server-side 文件)
- 🔴 本地 `.env` / `.admin-credentials` 不 commit(`.gitignore` 第 14-17 行锁)

## ⏭️ 状态依赖

- **前置**:Task 003 已 ✅ + 路径 B(Storefront 父 + llccraft-child 子)通了
- **并行**:Task 005/006/007(后续任务)
- **下游**:Task 014(详情页八件套填实,在生产站上做)

## 更新记录

- 2026-07-01　Task 004 骨架落档(通气方案等老板拍板)
