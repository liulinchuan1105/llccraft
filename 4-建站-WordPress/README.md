# 4-建站（WP）

> 路径：`4-建站-WordPress/`
> 状态：🟢 Task 003 闭环 · 2026-07-01
>
> WP + WC + 子主题 Path B(Storefront 父 + llccraft-child 子)+ 洁癖 3 件插件

---

## 这里放什么

| 子模块 | 角色 | 状态 |
|---|---|---|
| `主机安全初始化/` | ECS 上线后的 ub + ufw + fail2ban 等系统加固(新加坡沙盒已闭环,美西硅谷未来复用)| ✅ 闭环 |
| `WP与插件/` | WordPress + WooCommerce + 3 件洁癖插件(WC + Rank Math + Wordfence) | ✅ Task 003 |
| `主题与设计/` | Storefront 父 + llccraft-child 子,所有视觉魔改锁死子主题 | ✅ Task 003 |
| `收款集成(PayPal+Airwallex)/` | PayPal + Airwallex 接入 + 收款测试 | ⚪ Task 005/006 |
| **`local-dev/`** *(新增)* | docker-compose 本地一键开发环境 | ✅ Task 003 |

## 当前进度(2026-07-01 Task 003 闭环)

- ✅ 阿里云新加坡沙盒 `8.219.190.222` 加固完毕(Task 002),7-31 前必迁美西硅谷
- ✅ **本地 WordPress 起好**:docker compose 起 wp + db;浏览器开 http://localhost:8080
- ✅ **WooCommerce 装好 + 配置完毕**:币种 USD / 国家 US-CA / 时区 LA / 测算 lbs + in / 地址 123 S Figueroa St LA 90012
- ✅ **3 件洁癖插件装好**:WooCommerce / Rank Math SEO / Wordfence
- ✅ **默认冗余删除**:Hello Dolly / Akismet
- ✅ **父主题 Storefront**:从 wp.org 下载,作为底层
- ✅ **子主题 `llccraft-child`**:在仓库维护,bind-mount 进容器,改代码实时生效
- ⬜ Wordfence 初次扫描(Task 003 后期小动作)
- ⬜ 上 ECS 美西硅谷 部署(Task 004)

## 整体流程(顺序)

1. ✅ Task 002 主机安全初始化(已闭环,新加坡沙盒)
2. ✅ Task 003 本地 WordPress + WC + 子主题骨架(**当前**)
3. ⬜ Task 004 本地 WP 部署到 ECS,绑 `llccraft.com`(7-31 前必迁到美西硅谷)
4. ⬜ Task 005 PayPal + Airwallex 申请
5. ⬜ Task 006 WC 收单配置
6. ⬜ Task 007 9610-跨境海关备案
7. ⬜ Phase 2 / 3(景德镇 + 上线)

## 本地开发快速入口

```bash
cd 4-建站-WordPress/local-dev
./setup.sh     # 首次 docker compose up + WP 初始化
```

详见 `local-dev/README.md`。

## 关键红线(继续强调)

- 🔴 **新加坡沙盒 7-31 前必迁美西硅谷** — 不迁 8-1 到期 = 域名 A 记录指向空气
- 🟡 **洁癖铁律** — 3 件插件够用就够用,任何时候诱惑"加个插件"前先问"是不是必须"
- 🟡 **子主题不碰父主题** — Storefront 升级时我们的 `llccraft-child/` 不受影响

## 更新记录

- 2026-07-01　**目录结构调整**(Task 003):新增 `local-dev/` 子目录 · README 反映 Path B(Storefront + llccraft-child)+ 洁癖 3 件插件
- 2026-07-01　仓库重构(8 个模块规范化命名)
