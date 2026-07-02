# llccraft-child · Phase 2 主主题

> LLCCRAFT 瓷器独立站 · WordPress 子主题
> **Sage-light · Vite + Tailwind · 自建 6 component class · Gutenberg Block Patterns**

---

## 🎨 视觉语言

- **色彩**:`ink #0e0e0e` / `paper #faf8f3` / `dust #e8e1d4` / `accent #a8323f` (霁红) / `celadon #aac4b0` (影青绿,可选用)
- **字体**:`Cormorant Garamond` 衬线(标题 / 落款) + `Inter` sans(正文 / UI)
- **气质**:中式留白 × 现代轻奢 / 70vh hero · gallery-style cards · 极细 1px ink 边框

## 🔨 工具链(sage-light)

7 个核心文件,**不装完整 Sage 框架**:
```
package.json           — npm scripts + dev deps
vite.config.js        — Vite build pipeline (output → ./build/)
postcss.config.js     — tailwindcss + autoprefixer
tailwind.config.js    — sage-light color palette + content paths
src/styles/main.css   — @tailwind base/components/utilities + 6 自定义 component classes
functions.php         — enqueue build/main.css + register_block_pattern()
patterns/*.php        — Gutenberg Block Patterns (Phase 2 v0.1: 4 套首页 pattern)
```

## 🛠 6 个自建 component classes

| class | 用途 |
|---|---|
| `.btn-primary` | 主按钮(ink → accent hover)|
| `.product-card` | 产品卡(画廊感阴影过渡)|
| `.section-pad` | section 间距(max-w-gutter + py 16/24/32)|
| `.hero-frame` | 70vh 极简 hero 边框 |
| `.italic-serif` | 斜体衬线副标题 |
| `.text-balance` | 标题换行对齐(`text-wrap: balance`)|

## 🎨 Gutenberg Block Patterns(v0.1:首页 4 套)

| Pattern | 内容 |
|---|---|
| `llccraft-hero` | 70vh 极简 hero + LLCCRAFT 字标 + 衬线 subtitle + 两按钮 |
| `llccraft-three-tiers` | 三档工艺线 Starter / Curator / Reserve(中间 Curator 凸出)|
| `llccraft-story` | 品牌故事(中文 + 英文 双语衬线)|
| `llccraft-collection-grid` | 3×3 九宫格选品 + View all 按钮 |

> v0.2 v0.3 后续按需补(关于 / 联系 / shipping policy 等留 Phase 3)。

## 🚀 开发命令

```bash
# 首次装依赖
npm install

# dev 持续 build(写完 CSS 即编译 → /build)
npm run dev

# 生产 build(去调试 + minify → /build/main.css)
npm run build

# 预览生产 build
npm run preview
```

## 📂 仓库结构

```
llccraft-child/
├── package.json
├── vite.config.js
├── postcss.config.js
├── tailwind.config.js
├── .gitignore
├── README.md (本文件)
├── style.css           (WP 必需 — 空 placeholder)
├── functions.php       (WP 必需 — enqueue + register patterns)
├── index.php           (WP 必需)
├── src/styles/
│   └── main.css        (Vite 入口 + 6 component classes)
├── patterns/
│   ├── hero.php
│   ├── three-tiers.php
│   ├── story.php
│   └── collection-grid.php
└── build/              (Vite output · gitignored · commit 后用 .main.css?v=cache)
```

## 🎯 选品 3 档 / 占位 SKU

| 档 | 价位 | 类目 | 占位 SKU |
|---|---|---|---|
| Starter | $129-199 | 入门礼盒 | 30ml 闻香杯 / 35ml 小盖碗 / 茶则 · 香插 |
| Curator | $249-349 | 进阶收藏 | 110ml 手拉盖碗 / 素三彩方壶 / 单杯 + 杯垫 |
| Reserve | 孤品 | 艺术家署名 | Liu Jingdong 柴窑 1/3 / Sancai 方壶 / Tenmoku 对盏 |

## 🔁 上 ECS 流水线(GitHub Actions)

`../.github/workflows/deploy.yml`(仓库根)用 AppleVegan/rsync + custom `actions-deploy` 把 `llccraft-child/`(除 `node_modules` / `build/.gitignore`)同步到 ECS `llccraft_admin@8.219.190.222:/var/www/llccraft/wp-content/themes/llccraft-child/`(走 SSH 49821),然后 `wp theme activate llccraft-child` 强制刷新。

## 更新记录

- 2026-07-02 Phase 2 v0.1 骨架:7 个 build 文件 + 4 Gutenberg block patterns
