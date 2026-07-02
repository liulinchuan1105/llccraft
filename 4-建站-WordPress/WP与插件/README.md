# WP 与插件(洁癖精简版)

> 路径：`4-建站-WordPress/WP与插件/`
> 状态：🟢 Path 洁癖党 · 2026-07-01 Task 003 闭环
>
> **铁律**:插件最少够用,速度/性能第一 — 高端瓷器站的底线是页面 1.5s 加载完。

---

## 装好后必装清单(3 件,绝不多)

| # | 插件 | 干嘛 | 必装? | 免费? |
|---|---|---|:---:|:---:|
| 1 | **WooCommerce** | 商城核心 | ✅ | ✅ |
| 2 | **Rank Math SEO** | SEO(比 Yoast 轻) | ✅ | ✅ |
| 3 | **Wordfence** | 防火墙 + 暴力登录拦截 | ✅ | ✅ |

**总计 3 件。** 不多装。

## 卸默认的(放进 setup.sh 自动跑)

| # | 插件 | 为什么删 |
|---|---|---|
| 1 | **Hello Dolly** | WP 自带,纯 bloat |
| 2 | **Akismet** | 评论 spam — 我们做 B2C 跨境,评论永远关闭 |

## ❌ 不装的(洁癖铁律)

| 类别 | 拒绝项 | 原因 |
|---|---|---|
| 主题 | Astra / Kadence / Avada / OceanWP | 父主题已用 Storefront,占位期不堆 |
| 页面搭建 | Elementor / WPBakery / Bricks | 占位期不做营销页;后期上主页时单独评估 |
| 备份 | UpdraftPlus | docker volume 本身就是备份介质,占位期够了 |
| 图片加速 | ShortPixel / Imagify | 占位期没图,真站时再上 |
| 客服聊天 | Crisp / Tidio / Intercom | 占位期没人聊 |
| 表单 | WPForms / Contact Form 7 | 占位站不需要联系表单 |
| SEO 双选 | Yoast | 用 Rank Math |
| 缓存 | WP Super Cache / LiteSpeed | 占位期不需要;生产上 ECS 配 nginx fastcgi cache |
| 评论 | Akismet / wpdiscuz | 评论永久关闭 |
| 跟踪 | PixelYourSite / TikTok Pixel | 还没投流 |
| Jetpack | Jetpack | bloat 王,任何模块都可单独装替代品 |
| Cron | WP Crontrol | WP 自带 cron 够了 |
| SMTP | WP Mail SMTP | 占位期不需要;接 PayPal 时一起上 |

## 装好后必做的(7 步)

1. **改默认 admin 用户名**:`llccraft_admin`(已经在 setup.sh 改好)
2. **关评论**:在 "设置 → 讨论 → 关闭评论"(setup.sh 已设 default_comment_status = closed)
3. **Wordfence 跑初次扫描**:后台 → Wordfence → Scan
4. **WP_DEBUG**:dev 期开(setup.sh 已开),生产时关
5. **媒体库限制**:设最大宽 2000px(占位期不上,后期补)
6. **备份策略**:docker volume 命名绑定 + 定期 docker volume 备份(占位期手动即可)
7. **强制 SSL**:占位期不强制(localhost 无 SSL);生产上 ECS 时用 Let's Encrypt

## 当前进度

- [x] ✅ Task 003 闭环 · WooCommerce / Rank Math / Wordfence 3 件套激活
- [x] ✅ Hello Dolly / Akismet 默认卸
- [x] ✅ WC options(币种/国家/时区/lbs-in/地址)配齐
- [ ] ⬜ Wordfence 初次扫描
- [ ] ⬜ 媒体库限制

## 关键提醒

- 🎯 **核心判断**:3 个插件够用就够用。Speed score 90+ > 功能多 10 件
- 🎯 后期接 PayPal 时再评估 SMTP + 物流插件,别现在装
- 🎯 docker dev 容器只在本地跑,不直连外网 — Wordfence 防火墙在生产 ECS 才发挥完整作用

## 更新记录

- 2026-07-01　**覆盖式改写**:原 11 项臃肿大杂烩 → 3 项洁癖党(WC + Rank Math + Wordfence)
- 2026-07-01　原目录 scaffold 11 项(已被 Task 003 推翻,档案留作历史)
