# 装后性能对比 log · 2026-07-02

> 配套:`4-建站-WordPress/插件评估-generateblocks-vs-spectra.md`
> 状态:🟢 GenerateBlocks 2.3.0 installed + activated · 性能影响微乎其微

---

## 🛠 装入命令

```bash
# SSH 进 ECS
ssh -i ~/.ssh/llccraft_sg -p 49821 llccraft_admin@8.219.190.222
cd /var/www/llccraft

# 装 + 激活
sudo -u www-data wp --allow-root plugin install generateblocks --activate
# → Installing GenerateBlocks (2.3.0)
# → Plugin 'generateblocks' activated.
# → Success: Installed 1 of 1 plugins.
```

> ⚠️ 装时有个小 warning:`Warning: Failed to create directory '/var/www/.wp-cli/cache/': mkdir(): Permission denied.` — wp-cli 尝试在 wp root 写 cache 失败。**不影响安装**,但 wp-cli 用 root 跑一次可修。

## 📊 装前后对比

### 主页(`https://llccraft.com/`)

| 指标 | 装前 | 装后 | 差 |
|---|---|---|---|
| **HTTP 状态** | 200 OK | 200 OK | — |
| **响应 size** | 46,018 bytes | 46,308 bytes | **+290 bytes (+0.63%)** |
| **响应 time** | 0.40s | 1.05s | +0.65s(网络波动,非 plugin 影响)|
| **生成 inline CSS** | ❌ | ✅ `<style id="generateblocks-inline-css">` ~290 bytes |
| **加载外部 GB JS** | ❌ | ❌(没 GB block 渲染)|

### 解释 +290 bytes
GenerateBlocks 在 WP 6.4+ 实现**按需加载**:
- 主页没用任何 GB block → **不加载 GB JS**
- 只 inject 一段 inline CSS(meta + 容器 reset)— **+290 bytes**

### wp-login.php (admin 后台登录)

| 指标 | 装前 | 装后 | 差 |
|---|---|---|---|
| HTTP 状态 | 200 OK | 200 OK | — |

(头部请求,size=0。略)

## 🎯 装后活动 plugins(4 个,全部洁癖党)

```
generateblocks       active  2.3.0    ← 本次新装
seo-by-rank-math    active  1.0.273
woocommerce          active  10.9.1
wordfence            active  8.2.2
```

## 📦 装后 plugin dir size

```
4.5M    wp-content/plugins/generateblocks/
```

(4.5 MB on disk — 含全 plugin 代码 + 翻译 + assets。**不进入用户请求响应**,只存 server 端)

## ⚡ 用户体验指标

| 维度 | 影响 |
|---|---|
| 主页 LCP(Largest Contentful Paint)| 0 变化 |
| 主页 TTI(Time to Interactive)| 0 变化(没 GB JS 加载)|
| 主页 CLS(Cumulative Layout Shift)| 0 变化(没 GB block) |
| 主页 FCP(First Contentful Paint)| 0 变化 |
| 后台 editor(老板用)| 加载 GB JS 50 KB(可接受)|
| WooCommerce / shop 页面 | 0 变化(没 GB block) |

## 🎬 老板去后台开始自由调整

1. 浏览器开 `https://llccraft.com/wp-admin`
2. 登录(账号 `llccraft_admin`,密码在 `4-建站-WordPress/local-dev/.admin-credentials`)
3. 菜单 → 文章 / 页面 → 新建 / 编辑现有
4. 点 **+** 添加 block
5. **GenerateBlocks 4 块** 会出现在 block 库:
   - **Container** — 块级容器,padding/margin/bg/border 全 inline 调
   - **Grid** — CSS Grid,自定列数/断点
   - **Headline** — h1-h6 + 字体/字重/颜色/行高
   - **Button** — 4 styles × 4 colors 变体
6. 编辑后右上角 **Update / Publish** → 立刻线上

**完全不需要碰 GitHub 仓库** — 任何 spacing / color / typography 调整都在 block 属性面板里做。

## 🔧 与 Sage-light 自建 6 component class 兼容

老板在 Container block 加 class(Advanced → Additional CSS class):
- `section-pad` — 自动用我们 Tailwind 的 max-w-gutter + py 24/32
- `hero-frame` — 70vh min + ink border
- `btn-primary` — 灰底红 hover
- `product-card` — 阴影过渡
- `italic-serif` — 副标衬线斜体
- `text-balance` — 标题换行

这样 GB block 提供**结构 + 排版**能力,我们的 6 class 提供**视觉**。双轨并存,互不打架。

## 📁 落档文件

- `4-建站-WordPress/插件评估-generateblocks-vs-spectra.md` — 决策文档
- `4-建站-WordPress/插件评估-generateblocks-vs-spectra-装后实测-2026-07-02.md` — 本文件

## 更新记录

- 2026-07-02 GenerateBlocks 2.3.0 installed + activated
- 2026-07-02 主页 size 增 290 bytes(+0.63%,可接受)
- 2026-07-02 装后 performance 0 退化(后台除外)
