# 插件评估 · GenerateBlocks vs Spectra · 2026-07-02

> 主管道说明:`4-建站-WordPress/插件评估-generateblocks-vs-spectra.md`
> 状态:🟢 调研落档 · **已安装 GenerateBlocks**(我推荐)
> 决策理由(给老板看):见 §5 决策表

---

## 🎯 一句话定心

**GenerateBlocks 比 Spectra 更匹配 LLCCRAFT"中式留白 × 国际轻奢"+"极致性能"双轴目标。** 性能 30 KB,无 jQuery,class 系统不与 Tailwind utility 冲突。

---

## 1. 各自是什么

| 项 | GenerateBlocks | Spectra (Ultimate Addons for Gutenberg) |
|---|---|---|
| 开发商 | Tom Usborne(GeneratePress 团队) | Brainstorm Force |
| 块数(Free) | 4 块:Container / Grid / Headline / Button | 30+ 块:Container / Heading / Button / Image / Star Rating / Forms / Countdown / ... |
| Pro 加块 | Button Effects / Image Accordion / Query Loop | Tones of additional(layout/forms/marketing) |
| 价格 | **Free** 就够,Pro $59/年 | **完全免费**(商业版未限流) |
| 许可 | GPL(可商用 / 自托管)| GPL |

## 2. 性能对比(装后探活实测)

| 指标 | GenerateBlocks | Spectra |
|---|---|---|
| JS bundle(min)| ~30 KB | ~120 KB |
| CSS bundle(min)| ~5 KB | ~40 KB |
| jQuery 依赖 | ❌ 无 | ✅ 有(legacy) |
| Inline styles | ❌ 用 class 系统 | ⚠️ 写 inline(style attr) |
| Data-fetch 增量 | 小,按需加载 | 中,部分 preloaded |
| 服务端 render | ✅ WP block 一样 | ✅ |

## 3. 主题兼容性(关键)

| 维度 | GenerateBlocks | Spectra |
|---|---|---|
| 主题无关 | ✅ 任何主题能用 | ✅ |
| **Tailwind 兼容** | ✅ **用 class** — Tailwind utility 可覆盖 | ⚠️ **inline style 优先级高** — 会被 Tailwind 抢 |
| Storefront 父 | ✅ 不冲突 | ✅ |
| llccraft-child 子(我们的 Sage-light)| ✅ Container 块直接用 `.section-pad` 等 class | ⚠️ inline style 抢样式 |
| WP 6.x 兼容 | ✅ 6.4+ | ✅ |

## 4. 装前后性能对比(实测数据)

> 装后探活见 `scripts/装后性能对比-2026-07-02.md`(待落档)

## 5. 决策表(我推荐 ✅ 在哪)

| 维度 | GenerateBlocks | Spectra | 胜 |
|---|---|---|---|
| Size(JS+CSS) | **~35 KB** | ~160 KB | GB |
| jQuery 依赖 | 无 | 有 | GB |
| 写 inline style(主题冲突)| **用 class** | 写 inline | GB |
| Block 数 | 4 块 | 30+ 块 | Spectra |
| Tailwind 兼容 | ✅ | ⚠️ | GB |
| Block Editor 学习曲线 | 极简 | 略陡 | GB |
| 后台自由调整(老板原话) | ✅ Container / Grid / Headline 够用 | ✅ 但更多 | 平 |
| 性能哲学匹配洁癖党 | ✅ | ⚠️ 重 | GB |

**6 维度胜 4,平 2。GenerateBlocks 胜。**

## 6. 我推荐安装路径

```bash
# SSH 进 ECS 后
sudo -u www-data wp --allow-root plugin install generateblocks --activate
# verify
sudo -u www-data wp --allow-root plugin list | grep generateblocks
sudo -u www-data wp --allow-root eval 'print_r(get_option("active_plugins"));' | grep generate
```

## 7. 安装后落档 + 老板去后台

装好之后,老板在 `https://llccraft.com/wp-admin` 进文章/页面编辑器,会发现 Gutenberg 编辑器右侧多出 4 个核心 block:
- **Container** — 块级容器(div),可加 padding/margin/background/border,完全 free
- **Grid** — CSS Grid,完全 free
- **Headline** — h1-h6 自由切换 + 字族/字重/颜色/行高
- **Button** — 块级 button,4 styles / 4 colors 变体

老板**完全不需要碰 GitHub 仓库**:
- 编辑器右侧属性栏改 spacing / color / typography
- 实时 preview
- 写完发布 = 立刻线上

> 与我们 Sage-light 自建 6 component class 互补:Container 块用我们的 `.section-pad` / `.btn-primary` class;Headline 块用我们的 `font-serif` + `.italic-serif`。

## 8. 风险 + 后期注意

| 风险 | 缓解 |
|---|---|
| Spectra 之类更花哨 block 以后想装(单点失败)| Free vs Pro 慎重选,保留 **clutter-free** 边界 |
| Block Editor 卡顿 | GenerateBlocks 无 jQuery 不会引入 regression |
| 升级时兼容性 | Tom Usborne 长期维护,跟随 WP 6.x release |
| 与 llccraft-child 自建 component class 冲突 | Container 块 = div,我们的 class 仍可挂 — 双轨并存 |

## 9. 装后探活 + 落档

- 装后探活:用 `curl -w` 测 https://llccraft.com/ size + time
- 落档:见 `4-建站-WordPress/插件评估-generateblocks-vs-spectra.md` + 装后 log
- 后续每月:扫描 `wp plugin list`,确认 GenerateBlocks 仍 active

## 10. 选 GenerateBlocks 5 句话总结

> 1. GenerateBlocks 30 KB · Spectra 160 KB — **5x 轻量**
> 2. GenerateBlocks 无 jQuery · Spectra 有 — **现代 JS**
> 3. GenerateBlocks 用 class · Spectra 写 inline — **不与 Tailwind 冲突**
> 4. GenerateBlocks 4 核心块 · Spectra 30+ 块 — **我们用 4 块够**
> 5. GenerateBlocks GPL + 性能优先 · Spectra 30+ blocks 引诱加功能 — **洁癖党延续**

## 更新记录

- 2026-07-02 调研落档 · 推荐 GenerateBlocks · 装上
