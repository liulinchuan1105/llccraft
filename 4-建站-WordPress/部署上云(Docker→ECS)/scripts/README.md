# scripts/ · Task 004 上云部署流水线

> 路径：`4-建站-WordPress/部署上云(Docker→ECS)/scripts/`
> 状态：🟡 进行中（等老板对齐 · 2026-07-01）

---

## 📜 7 步流水线（按顺序跑）

| 步 | 脚本 | 跑在哪 |
|---|------|--------|
| 1 | `1-backup-local.sh` | 本地（Mac/Win bash）|
| 2 | `2-scp-to-ecs.sh` | 本地 |
| 3 | `3-install-lnmp.sh` | ECS（SSH 进去后 sudo bash） |
| 4 | `4-import-db.sh` | ECS |
| 5 | `5-search-replace-url.sh` | ECS |
| 6 | `6-nginx-vhost.sh` | ECS |
| 7 | `DNS-A-record.md`（人操作）| 老板手 · 阿里云 DNS 控制台 |

---

## 跑前必备（一次性）

- ✅ 本地 `local-dev/.admin-credentials` 已生成（凭证机制就绪，见 003 README）
- ✅ ECS `8.219.190.222` 已加固：SSH 端口 49821 + llccraft_admin 账号 + ufw + fail2ban（在走，参考 Task #002）
- ✅ `~/.ssh/llccraft_sg` SSH key 在本地，`authorized_keys` 在 ECS 的 `llccraft_admin` home
- ✅ 老板确认 DNS 控制台账号（国际 vs 中国，详见 DNS-A-record.md "账号辨析"）
- ✅ `ECS开通记录.md` "7 月底迁美西硅谷计划" 在 7-31 之前是锚点 → 本次姿势全在那重演一遍

## 跑时铁律

- 全程用 SSH key,不输密码(密码机制保护)
- 全程 SSH 端口 49821,**不是 22**
- 全程 `llccraft_admin` 账号,**不用 root**
- 凭证文件在 /etc/llccraft/.ecs-deploy-credentials (mode 600,不进 git)
- ufw 状态保持 default deny + 白名单 49821/80/443

## 更新记录

- 2026-07-01　初版 7 步流水线骨架
