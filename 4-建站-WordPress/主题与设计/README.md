# 主题与设计(Path B · Storefront + llccraft-child)

> 路径：`4-建站-WordPress/主题与设计/`
> 状态：🟢 Path B 已锁 · 2026-07-01 Task 003 闭环
>
> 父主题 = **Storefront**(WooCommerce 官方),子主题 = `llccraft-child`(仓库维护)

---

## 选型决策

| 维度 | 选择 | 原因 |
|---|---|---|
| **父主题** | Storefront(免费) | Automattic(WC 母公司)出品,商城适配最优,跟 wp.org 更新 |
| **子主题** | `llccraft-child`(自建) | 所有视觉/代码魔改锁死在这里,父主题升级不受影响 |
| ❌ Astra | 不装 | 洁癖党反对 — 选 Storefront 是更"商城原生"的路 |
| ❌ Elementor | 占位期不装 | Phase 3 上主页时单独评估 |

## 设计基调(基于竞品调研)

**别做"茶具店",做"景德镇瓷器艺术品/礼品店"**:
- 配色:**米白底 + 墨黑字 + 一抹霁红/影青绿点缀**(东方审美,不是大红大金)
- 字体:英文用 **Cormorant Garamond** 或 **Playfair Display**(serif 衬线 = 高端感)
- 图片:**大图、留白、专业摄影感**(白底 + 自然光 + 底款特写)
- 文案口吻:**克制、有故事、不叫卖** — 学 Verdant Tea / Eastern Leaves 的写法人设

## 主题仓库结构

```
4-建站-WordPress/主题与设计/
├── README.md                                         ← 本文件
├── 子主题(Child Theme)/                              ← 仓库只存子主题代码
│   ├── README.md
│   └── llccraft-child/
│       ├── style.css                                ← Template: storefront + 基本 CSS
│       ├── functions.php                            ← enqueue 父 CSS + setup hooks
│       └── index.php                                ← fallback 模板
└── (未来:配色/字体决定笔记 screenshot 存在这里)
```

Storefront 父主题**不在仓库**,它在 wp.org 上随 setup.sh 一键下载安装。

## 必备页面(占位站也要有)

| 页面 | 内容支柱 | 状态 |
|---|---|---|
| **首页** | Hero 大图 + 品牌一句定位 + 工艺线三档($129-199 / $249-349 / 孤品)+ 品牌故事切入 | 🟡 Task 014 |
| **Shop** | WooCommerce 商品列表(占位:挂"Coming after July 2026 Jingdezhen trip")| 🟡 Task 014 |
| **About** | 你 + 景德镇的故事(先写"我是谁、为啥做这个、7-8 月去景德镇") | 🟡 Task 014 |
| **Shipping & Returns** | 运费 / 时效 / 破损退换政策 | 🟡 Task 015 |
| **Contact** | 表单 + 邮箱 + WhatsApp(如果有时)| 🟡 Task 014 |
| **Jingdezhen Teaware** | 工艺 / 釉色 / 器型科普(SEO + 取信用)| 🟡 Task 014 |

## 当前进度

- [x] ✅ Task 003 闭环 · 父 Storefront 装好 + 子 llccraft-child 激活 + bind-mount 工作
- [ ] ⬜ 配色 / 字体决定(Phase 2 上主页时定)
- [ ] ⬜ 6 个页面占位骨架拉好(Phase 3 Task 014)
- [ ] ⬜ Logo 设计(实在赶可以先用文字 logo)

## 关键提醒

- ⚪ 占位站**别堆虚假产品** — 直接挂"Coming after July 2026 Jingdezhen trip"
- 高客单站 = **图好 = 一切**。占位阶段宁可不放图也别用网图(找 Unsplash 几张瓷器茶具先顶)
- 子主题不要染指父主题文件 — 任何 Storefront 改动都改写到 `llccraft-child/` 里

## 更新记录

- 2026-07-01　**覆盖式改写**:原"主题 = Astra + Elementor" → Path B"父 Storefront + 子 llccraft-child,洁癖党不装 Elementor/Astra"
- 2026-07-01　初版主题骨架(已被推翻,档案留作历史)
