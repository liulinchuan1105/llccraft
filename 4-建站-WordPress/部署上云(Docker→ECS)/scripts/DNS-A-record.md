# 阿里云 DNS A 记录一键指引 · Task 004

> 用途：把 `llccraft.com` 域名解析切到 `8.219.190.222`（新加坡 ECS），
> 让全世界访问 `http://llccraft.com` 跳转到我们刚部署好的 WP 站点。
> 状态：🟡 等老板执行（在阿里云 DNS 控制台点几下）

---

## 🔧 操作步骤

### 1. 登录阿里云 DNS 控制台

- URL：<https://dns.console.aliyun.com/>
- 账号：用**注册 .com 域名时填的那个阿里云账号**（应该是 `llccraft` 业务账号，可能跟 ECS 国际账号不同 —— 见下方"账号辨析"）

### 2. 进入 `llccraft.com` 的解析设置

- 左侧导航 → **权威 DNS** → 找到 `llccraft.com` → 点 **解析设置**

### 3. 修改 A 记录（重点）

| 字段 | 值 |
|---|---|
| **主机记录** | `@`（即 `llccraft.com` 本身，不带 www） |
| **记录类型** | **A** |
| **解析线路** | 默认 |
| **记录值** | **`8.219.190.222`** ← 改成这个！(就是新加坡 ECS IP) |
| **TTL** | **600 秒**（10 分钟）—— 临时降 TTL 让切生效更快，稳了之后再改回 3600 / 7207 |

> **关键**:记录值必须填 `8.219.190.222`，**不能**填 `https://llccraft.com` 或 `8.219.190.222/llccraft` —— A 记录就是裸 IP。

### 4.（可选）www 子域也加一个 A 记录

| 字段 | 值 |
|---|---|
| **主机记录** | `www` |
| **记录类型** | A |
| **记录值** | `8.219.190.222` |

### 5. 验证 DNS 传播

等待 5-30 分钟（TTL 600 = 10 分钟应该够），然后从外部 `ping llccraft.com`：

```bash
nslookup llccraft.com
# 应该返回 8.219.190.222
```

或在 https://www.whatsmydns.net/ 全球查。

---

## ⚠️ 现实提醒

### 切之前

- ✅ ECS `8.219.190.222` 的 nginx vhost 已 reload（步骤 6 完成）
- ✅ WordPress siteurl / home 已经被 search-replace 改成 `http://8.219.190.222`（步骤 5 完成）
- ✅ ufw 已在 ECS 上 allow 80/tcp（步骤 3 完成）

### 切之后

- ✅ `curl http://llccraft.com/` 应该返回 200（不要看首页内容，看 HTTP 状态）
- ⚠️ nginx 默认 server 是 `llccraft.com` — 用户访问时浏览器看到 `Server: nginx/1.18.0` 这种 banner，但 server_name 已经是 `llccraft.com`，所以 WP load 的就是它
- 🔴 **首选验证完后,记得把 TTL 改回 3600 / 7207**：让 DNS 缓存在合理水平，对生产 SEO 友好

### 不要做的

- ❌ 不要先改 CNAME、再改 A — DNS 生效会有冲突
- ❌ 不要在 TTL 7000+ 时改 — 等半天生效急死你
- ❌ 不要同时改 NS — 我们就用的阿里云 NS（`ns1.alidns.com` 等），别动

---

## 🔑 阿里云账号辨析

| 账号 | 负责什么 | 用户名 |
|---|---|---|
| **阿里云国际** (alibabacloud.com) | ECS 实例购买 + 新加坡沙盒 8.219.190.222 | ？ |
| **阿里云中国** (aliyun.com) | DNS 解析(`llccraft.com` 的 NS)、OSS、9610 备案主体 | ？ |

老板注意：**两个账号可能不同！**(国际账号和中国账号不通用)
- 邮箱是 `xxx@xxx.com` 的主域 — 看登录用的哪个
- DNS 控制台 URL：<https://dns.console.aliyun.com/> (中国) OR 在国际后台里有 DNS 模块

如果登录国际后台看不到 `llccraft.com` 域名(域名在中国账号下的)，用中国账号 DNS 控制台。

---

## ⏭️ 切完之后的动作

1. **观察 log**：`ssh llccraft_admin@8.219.190.222 -p 49821 'tail -f /var/log/nginx/llccraft-access.log'` 看是不是有流量
2. **WP 主页是否 404**：可能是因为 assets 路径用了 `localhost:8081` 引用，需要重新跑 search-replace 或装 WP plugin (Better Search Replace) 扫 wp_posts
3. **一个月后**（2026-07-31 前）：把同样的姿势再用一次，目标是美西硅谷新 ECS IP

## 更新记录

- 2026-07-01　Task 004 上云部署 DNS 指引初版
