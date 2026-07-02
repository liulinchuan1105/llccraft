# 子主题(Child Theme) · llccraft 瓷器独立站

> 路径：`4-建站-WordPress/主题与设计/子主题(Child Theme)/`
> 状态：🟢 Path B · Storefront 父 + llccraft-child 子 · 2026-07-01 闭环

---

## 🎯 父亲子主题关系

```
Storefront  (父主题 · WooCommerce 官方 · WordPress.org 下载)
    └── llccraft-child  (子主题 · 仓库维护 · 唯一可改主题层)
```

| 角色 | 主题 | 维护方 | 在仓库? |
|---|---|---|---|
| **父** | Storefront | Automattic(WC 母公司)· 跟 wp.org 更新 | ❌ 不在,装时下载 |
| **子** | llccraft-child | **我们** · 所有视觉/代码魔改锁死在这里 | ✅ 整个目录进 git |

**Path B 决策理由**(老板拍):父用官方 Storefront(商城适配最优、零兼容负担),不重复造轮子。

## 📁 仓库目录结构

```
主题与设计/子主题(Child Theme)/
├── README.md                         ← 本文件
└── llccraft-child/                   ← 唯一进 git 的可改层
    ├── style.css                    ← Theme Name + Template: storefront + 基本 CSS 占位
    ├── functions.php                ← enqueue Storefront CSS + setup hooks(空壳,后续填)
    └── index.php                    ← fallback 模板(可删,用 Storefront 默认)
```

## 🚀 启用方法

**已在 `local-dev/setup.sh` 自动完成,无需手点**。手动的话:
1. WP 后台 → 外观 → 主题
2. 看到 "llccraft Child" 在列表里(因为 bind-mount 已挂)
3. 点"启用" → 生效

## ✏️ 改主题的工作流

1. 直接在仓库的 `llccraft-child/` 下编辑
2. 因为 `local-dev/docker-compose.yml` 把这个目录 bind-mount 到容器
3. 浏览器刷 http://localhost:8080 即生效(不需重启容器)
4. 仓库 commit 即跟踪

## 🔧 父子主题加载顺序(重要概念)

`llccraft-child/functions.php` 里:
```php
wp_enqueue_style( 'storefront-style', ... );           // 先父
wp_enqueue_style( 'llccraft-child-style', array( 'storefront-style' ), ... );  // 后子,可覆盖
```

子主题 CSS 在父之后,所以子主题 CSS 优先级高。

## ⏭️ 后续规划(不是现在做)

- [ ] Phase 2(景德镇回来):详情页八件套 + 匠人故事 + 釉色典故
- [ ] Phase 3 上 ECS 美西硅谷:`llccraft-child/` 同步上,Storefront 重新装
- [ ] 字体(Cormorant Garamond)通过 `after_setup_theme` 钩子加载

## 更新记录

- 2026-07-01　初版骨架:Path B(Storefront + llccraft-child)Task 003 落地
