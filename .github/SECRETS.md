# GitHub Secrets 配置指南 · Task 035

> 配套:`.github/workflows/deploy.yml`(在仓库根)
> 创建时间:2026-07-02 Phase 2 v0.1

---

## 🎯 需要在 GitHub repo settings → Secrets 添加 3 项

| Secret 名 | 是什么 | 怎么拿到 |
|---|---|---|
| `LLCCRAFT_DEPLOY_KEY` | Actions 专用 SSH deploy key 的**私钥** | 在 ECS 上 `ssh-keygen -t ed25519 -C "llccraft-actions-deploy"` 生成;把 **`~/.ssh/id_ed25519`(私钥)** 整个文件内容粘进 GitHub · Actions 用 **Deploy key** (write access) |
| `LLCCRAFT_HOST` | `8.219.190.222` | 直接填 ECS 公网 IP |
| *(无需 LLCCRAFT_USER + LLCCRAFT_PORT)* | 已 hardcoded `llccraft_admin` + `49821` |  |

---

## 🔁 一键设置(老板照做)

### 步骤 1:在 ECS 上生成 deploy key(只读 → write 范畴)

```bash
# SSH 进 ECS
ssh -i ~/.ssh/llccraft_sg -p 49821 llccraft_admin@8.219.190.222

# 在 ECS 上生成 actions 专用 key
ssh-keygen -t ed25519 -C "llccraft-actions-deploy-$(date +%F)" -f ~/.ssh/llccraft_deploy_ed25519 -N ''

# 把 pub key 加进 authorized_keys(让你老板已有 key 同时保留)
cat ~/.ssh/llccraft_deploy_ed25519.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# 测试连接
ssh -i ~/.ssh/llccraft_deploy_ed25519 -p 49821 llccraft_admin@8.219.190.222 'echo SSH_OK'
```

### 步骤 2:把**私钥**粘进 GitHub → Settings → Secrets → Actions → New repository secret

`LLCCRAFT_DEPLOY_KEY` = `~/.ssh/llccraft_deploy_ed25519`(整份,包含 BEGIN / END 行)

`LLCCRAFT_HOST` = `8.219.190.222`

### 步骤 3:Actions run

- 自动:push 到 main → workflow 触发
- 手动:Actions tab → "Deploy Theme to ECS" → Run workflow

---

## 🔒 安全优势

| 优势 | 说明 |
|---|---|
| **私钥仅存 GitHub Secrets** | 不在仓库任何代码里,只有 GitHub Action runner 能读 |
| **Deploy key 与开发者隔离** | 开发者本地 `~/.ssh/llccraft_sg` 失陷不影响 ECS |
| **失效容易** | 用完一键从 ECS `authorized_keys` 删 + 删 GitHub Secrets |
| **无密码** | Actions 只拿 SSH 私钥,无人脑输密码 |

---

## 🛟 Fallback:如果你不想让我自动 push,你可以手动跑

```bash
# 在 Actions Tab 点 "Run workflow" → 选 branch + 输入可空的 reason
# 等 30-60s,看 ECS nginx access.log 流量
```

---

## ⚠️ 当前限制(待 Phase 3 解决)

- ECS 没装 `node` / `npm`(linux 环境没 node binary)— **需要在 ECS 跑过 1.5GB 装包**
- 备选:在 Actions runner 上 build CSS(`build/` 目录),rsync 只传 source + build 产物,然后 ECS 不需要 node(但 deploy 脚本会复杂)

**当前 deploy.yml 选择:ECS 跑 `npm install + build`**(需要 ECS 装 node),简单但多了 deps。

回滚到更纯的做法后话。

## 更新记录

- 2026-07-02 Phase 2 v0.1 决定:Actions 用 applebanana/ssh-action + webfactory/ssh-agent


## 🆕 v10 wrapper script(gitdep-rsync-wrapper)

v10 修了 v8 rsync protocol negotiation bug — `command="rsync --server ..."` 写死 flags 阻断了 client 端的 compress algo 协商。

**修法**:在 ECS 上写 `/usr/local/bin/gitdep-rsync-wrapper`,`authorized_keys` 改 `command="/usr/local/bin/gitdep-rsync-wrapper"`:
- Wrapper 接受 `SSH_ORIGINAL_COMMAND` env var
- Reject anything not starting with `rsync`
- Reject shell metachars (`;` `` ` `` `&` `|` etc)
- 提取 dest path(最后一个 token),lock 到 `/var/www/llccraft/wp-content/themes/llccraft-child/`
- Reject path traversal(`..`)
- Pass through 完整 client args(让 rsync client-server negotiation transparent)

**安全 lock**:
- gitdep 只能调 rsync(不是 generic shell)
- dest 必须在 theme dir 下(不是 `/etc/` 或别的)
- 不接受 `;` `` ` `` `&` shell escape

**verify**:
```bash
$ sudo cat /home/gitdep/.ssh/authorized_keys
command="/usr/local/bin/gitdep-rsync-wrapper",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-ed25519 ...

$ sudo ls -la /usr/local/bin/gitdep-rsync-wrapper
-rwxr-xr-x 1 root root 1665 Jul  3 11:52 /usr/local/bin/gitdep-rsync-wrapper
```
