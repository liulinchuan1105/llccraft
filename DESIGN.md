# DESIGN.md — LLCCRAFT

> **v0.4 · 战略纠偏版 · Style Discovery 阶段 · 视觉宪法 hold / 工程结构保留**
>
> **本版 vs v0.3**:Impeccable 通用反 AI-slop 规则跨风格保留 + 视觉风格宪法(配色/字体/间距/版式)hold 待 Style Discovery 重定
>
> **宪法继承**:Impeccable SKILL.src.md(2026-07-05 落盘于 03_元工具/impeccable/)**通用反 AI-slop 规则跨风格保留**
>
> **落盘位置**:`C:\Users\Administrator\Desktop\独立站\`(业务主阵地)
>
> **历史继承**:`v0.2.1 → v0.3` 双锁文件保留为历史档案(`.impeccable/snapshots/v0.2.1-b-audit.md` + `v0.3-b-audit.md`)
>
> **纠偏快照**:`.impeccable/snapshots/v0.4-strategic-reset.md`

---

## 第 0 号铁律 · 视觉风格探索期(Style Discovery)

> 在 CEO 提供参考 URL 案例前,LLCCRAFT 视觉定调处于 **hold 状态**。设计方向、配色、字体、间距、版式**全部以 CEO 后续提供的 URL 案例为唯一逆向拆解依据**——包括任何看似合理的"风格预设"(极简、老钱、留白、暖色、暗黑、装饰艺术等)均不预采纳。
>
> **Impeccable 通用反 AI-slop 规则作为质量底线独立保留**,不因风格探索而让步(详细清单见 `.impeccable/snapshots/v0.4-strategic-reset.md` §三)。
>
> Style Discovery 阶段产出 = **视觉宪法 v0.1**(配色 / 字体 / 间距 / 组件 / 版式),由 B 复审,CEO 拍板后取代当前 DESIGN.md 视觉部分。

---

## 0 · v0.1 → v0.2 → v0.2.1 修改对照(三段式审计追踪)

### 0.1 v0.1 → v0.2 自我重构(7 项)

| # | v0.1 缺陷 | v0.2 处理 |
|---|---|---|
| 1 | §11 列 7 个待裁决问题(逃避决策) | 整段删除,改为 §11 Decision Log |
| 2 | surface 由 `#faf8f3` 改中性灰悬而未决 | oklch(0.97 0 0) 真中性,Phase 2 旧值弃用 |
| 3 | Glassmorphism 是否给 Lightbox 例外 | 全禁 |
| 4 | 大数字章号作为唯一允许例外 | 仅 BP-05 用,Cormorant 罗马数字 Ⅰ/Ⅱ/Ⅲ |
| 5 | 6 新 component class 全量 vs 分批 | Phase 2 v0.3 实装 3 关键 |
| 6 | Drenched 章节封面色轮换随机 vs 时序 | 时序 mod 3 → 墨/霁/天青 |
| 7 | 中文 Source Han vs Founder 商业体 | Source Han 起步 |

### 0.2 v0.2 → v0.2.1 B 真实审计 12 项修复(本版核心)

| # | B 项编号 | v0.2 缺陷 | v0.2.1 决策 |
|---|---|---|---|
| 1 | **D-KILL-1** | body 50% 深色化违反高端同行基准 | **架构反转**:surface 70% + ink-body 5-8% 仅作 section accent |
| 2 | **D-KILL-2** | Drenched 时序 mod 3 仍非主题锁定 | **改为主题釉色锁定**:每章封面在 P-03 创建时显式选定,锁入 frontmatter |
| 3 | **D-KILL-3** | Reveal 默认可见被列入 §11 决策 | **从 §11 移除,内嵌为强制锁定规则** |
| 4 | **D-KILL-4** | Tailwind 硬编码 OKLCH token | **改用 `var(--ink-body)` 引用,CSS :root 单一真相源** |
| 5 | **D-KILL-5** | Z-Index 缺 a11y skiplink 层 | **加 `--z-skiplink: 80` + `--z-region-focus: 75`** |
| 6 | **D-KILL-6** | §7 字体范例缺 BP-12/13 | **补 BP-12(care-guide)+ BP-13(about-mission)** |
| 7 | **D-S-1** | §1.1 "稀释瓷器釉色"弱论证 | **改写**:Drenched vs Committed 反差节奏 + Full Palette 品控难度指数级 |
| 8 | **D-S-2** | 5.5rem 缺安全垫注脚 | **加注**:"5.5rem = 6rem 硬限内保守上限,留 8px 余量" |
| 9 | **D-S-3** | Glassmorphism 例外过宽 | **收窄**:仅摄影器物大图 / 检测过程视频底层可用 |
| 10 | **D-S-4** | §9.2 #7 中英混排缺细则 | **补 4 条**:1/4 em 全角空格 / 字体回退 / 标点规则 / 主从关系 |
| 11 | **D-S-5** | §5 缺 progressive image loading | **加 §5.6**:aspect-ratio 占位 + LQIP blur-up + IO lazy |
| 12 | **D-S-6** | 中文 88px 单薄 | **中文 display ≥ 96px + weight 800**;独立 token `--text-display-cn-l` |

---

### 0.3 v1.0 → v0.3 DESIGN 文档 1 项修复(D2 双重逻辑)

> **v1.0 LOCKED 后,B + PM 在深度审计中发现的 DESIGN 文档 v0.3 唯一 1 项细节问题**。

| # | ID | 议题 | 来源 | 状态 |
|---|---|---|---|---|
| 1 | **D2** | Drenched 主题锁定内在逻辑混线(§1.1 写"反差节奏"vs §1.4 表格"鸟杯·霜月/天青""釉里红·焰/深墨"等是同调延伸) | B 复查 | ✅ **本补丁已修** |

**D2 修复详情**:
- **原 §1.1**:"Drenched 章节封面与 Committed 主体形成**反差节奏**"
- **原 §1.4**:表格 5 行示例中,"天青·雨过/霁红""窑变·火痕/霁红"是反差冲击;"青花·海东青/深墨""鸟杯·霜月/天青""玲珑·瓷/暖白"是同调延伸
- **矛盾诊断**:战略声称"反差",表格实际混用"反差 + 同调",逻辑打架
- **本补丁处理**:
  - §1.1 战略层重写为"**双重逻辑节奏**",明示同时允许**反差冲击**与**同调延伸**两种语义,均由策展人按章主题显式选定
  - §1.4 表格新增"**逻辑类型**"列,每行示例明确标注为"反差冲击"或"同调延伸"
- **修复原则**:章封面色 = 主题语义的视觉化,而非装饰性循环;逻辑类型由策展人显式选定,与 `chapter_drenched_color` 字段一同存入 P-03 frontmatter

---

## 1 · Color Strategy

> **🟡 v0.4 战略纠偏 hold:本节原 OKLCH token / 70/5-8 颜色配额 / Drenched 双重逻辑等具体视觉宪法待 Style Discovery 重定。**
>
> v0.3 锁定的具体颜色值(§1.3 OKLCH 10 token + §1.5 70/5-8 比例 + §1.4 Drenched 4 锁色)标记 superseded。Style Discovery 完成后,本节将被新视觉宪法 v0.1 取代。
>
> 跨风格保留:§1.3 token NAMES(ink-body / surface / accent-jihong 等工程名)保留,具体值改 placeholder。
>
> **本节以下原 v0.3 锁定内容作为历史档案保留,不再视为有效视觉宪法**。

### 1.1 战略层级:Committed 浅色主导 + 偶发 Drenched 章节封面(**D2 v0.3 修复 · 双重逻辑**)

> **【D-S-1 修复 · 战略论证改写】**

**为什么不用 Restrained / Full Palette**:
- 不用 Restrained:工具型产品默认;LLCCRAFT 是品牌策展,需要 Identified visual language
- 不用 Full Palette:**3-4 个 named roles 会让品控难度指数级上升**——任何色彩偏差都会破坏品牌一致性;**LLCCRAFT 没有 Pixel-perfect design ops 团队,Full Palette 是自杀性战略**
- **选中段:Committed 浅色主体(70% surface) + 偶发 Drenched 章节封面(单页一次性饱和冲击)**:Drenched 章节封面与 Committed 主体形成**双重逻辑节奏**(详见 §1.4 表格标注)——
  - **反差冲击**:Drenched 色与章节主题釉色处于色相轴的相对极,形成视觉冲击力(例:暖红冲击冷青)
  - **同调延伸**:Drenched 色与章节主题釉色同色系,形成视觉延续与沉浸感(例:冷调延续冷调)
- 两种逻辑**并存,均由策展人按章主题显式选定**(每章封面在 P-03 创建时通过 `chapter_drenched_color` 字段标注),符合高端杂志图录学的视觉传统(Eskenazi/Marchant 印刷品的章节扉页惯例)

### 1.2 物理场景(Impeccable 强制项 · 保留)

> 客户在伦敦 Belgravia 公寓二楼书房,下午四点,雨后阴天自然光从东向窗入射,房间里有一只 Ming 早期青花罐。他打开笔记本浏览 LLCCRAFT,屏幕 14 寸哑光,在认真阅读器物出处档案,可能在两件 5,000 USD 候选之间抉择。

→ 浅色主导(瓷器在浅背景釉色更准确——物理光学事实;参考所有正向锚定机构)
→ 单一深色 accent(不喧宾夺主)
→ 极少饱和点缀(品牌节制信号)

### 1.3 OKLCH 色彩 Token(不变,token 体系本身通过)

| Token | OKLCH | hex 等价 | 用途 |
|---|---|---|---|
| `--ink-body` | `oklch(0.14 0.012 28)` | `#1a1614` | **section accent / 引文区 / 章节封面 / footer**(5-8%) |
| `--surface` | `oklch(0.97 0 0)` | `#f7f7f7` | **body 主导背景**(≈ 70%) |
| `--surface-warm` | `oklch(0.95 0.006 28)` | `#efece8` | 次级卡 / 目录底色(8-12%) |
| `--ink-text` | `oklch(0.18 0.010 28)` | `#2b2622` | 正文 |
| `--ink-soft` | `oklch(0.42 0.012 28)` | `#6b625b` | 次级文字 / 注释 |
| `--ink-mute` | `oklch(0.62 0.008 28)` | `#9a928b` | 辅助文字 / 图说 / 时间戳 |
| `--accent-jihong` | `oklch(0.42 0.165 27)` | `#a8323f` | 霁红(品牌唯一饱和点缀) |
| `--accent-ru` | `oklch(0.78 0.045 195)` | `#c4dad8` | 天青(汝窑釉色,极克制) |
| `--accent-qing` | `oklch(0.45 0.110 260)` | `#3a5b8a` | 青(青花钴蓝,极克制) |
| `--rule` | `oklch(0.85 0.005 28)` | `#d8d3cd` | 分隔线、1px 描边 |

**单一真相源(SSOT)声明(D-KILL-4 修复)**:以上 token 定义在 `:root { ... }`(置于 `global.css` 或 `tokens.css`),**Tailwind 配置、Figma 库、CSS-in-JS 一律通过 `var(--xxx)` 引用**,**禁止任何位置硬编码 OKLCH 或 hex 值**——除本表外的任何硬编码均为 bug。

### 1.4 Drenched 章节封面(**D-KILL-2 修复 · 主题釉色锁定**)

> **强制规则**:每章封面 Drenched 色由该章策展主题的釉色语义锁定,**不允许随机、不允许时序轮换、不允许每次访问不同**。

| 章主题示例 | 锁定 Drenched 色 | **逻辑类型** | 语义依据 |
|---|---|---|---|
| "天青·雨过" | `--accent-jihong` 霁红 | **反差冲击** | 雨过天青的反差意象(暖红冲击冷青) |
| "青花·海东青" | `--ink-body` 深墨 | **同调延伸** | 海东青(猎鹰)的肃杀与墨色同调 |
| "鸟杯·霜月" | `--accent-ru` 天青 | **同调延伸** | 霜月冷调与天青冷色延续 |
| "釉里红·焰" | `--ink-body` 深墨 | **反差冲击** | 火焰熄灭后的炭黑(动→静的反差) |
| "玲珑·瓷" | `--surface-warm` 暖白 | **同调延伸** | 玲珑透光的轻盈与暖白延续 |
| "窑变·火痕" | `--accent-jihong` 霁红 | **反差冲击** | 窑变不可控与人为锁定的色彩反差 |
| ... | ... | 每章独立判断 | 在 P-03 创建时显式选定 + 备注逻辑类型 |

**实现机制**:WordPress 自定义字段 `chapter_drenched_color`(枚举值限定上述允许 token),章节封面模板读取该字段渲染。**Impeccable intentionality 原则**:每一章封面色都是该章策展意图的视觉化,而非装饰性循环。

### 1.5 颜色使用配额(**D-KILL-1 修复 · 大反转**)

| 比例 | 应用 | v0.2 → v0.2.1 变化 |
|---|---|---|
| `--surface` | **≈ 70%**(body 主导背景) | ⚠️ **v0.2 35% → 70%**(反转) |
| `--surface-warm` | **8-12%**(次级卡 / 目录底色) | 8% → 8-12% |
| `--ink-body` | **5-8%**(section accent / 引文区 / 章节封面 / footer) | ⚠️ **v0.2 50% → 5-8%**(反转) |
| 文字色(各 `--ink-*`) | **≈ 5%** | 持平 |
| `--accent-jihong` | **≤ 5%** | 持平 |
| `--accent-ru` / `--accent-qing` | **≤ 2%** | 仅专题器物页釉色说明位 |

**反转决策依据(D-KILL-1)**:
1. 全部正向参考(Eskenazi / Marchant / J.J. Lally / Kaikodo)均为**浅色主导**,无一例外
2. 瓷器在浅背景下釉色更准确——物理光学事实
3. 笔记本屏幕在书房长时间阅读,浅色主导更护眼
4. v0.2 的 50% 深色化 = "暗室",不是"高端展厅"

---

## 2 · Typography

> **🟡 v0.4 战略纠偏 hold:Cormorant Garamond / Inter / Source Han Serif 等字体选择为旧"老钱风"视觉预设,待 Style Discovery 重定。**
>
> v0.3 锁定的具体字体名(§2.1 字族 + §2.2 流体字号 + §2.3 行宽/行高/引文 + §2.4 引号与排版)标记 superseded。
>
> 跨风格保留:Impeccable 通用字体规则(line-length ≤ 65-75ch / display ≤ 6rem / tracking ≥ -0.04em / text-wrap: balance)跨风格适用。
>
> **本节以下原 v0.3 锁定内容作为历史档案保留,不再视为有效视觉宪法**。

### 2.1 字族(不变)

| 角色 | 字族 | 来源 |
|---|---|---|
| 英文 Display | **Cormorant Garamond** | Adobe Fonts / Google Fonts |
| 英文 Body | **Inter** | open source |
| 英文 Caption / Quote | **Cormorant Garamond Italic** | — |
| **中文 Display** | **思源宋体(Source Han Serif SC) Heavy / 800** | open source |
| **中文 Body** | **思源黑体(Source Han Sans SC) Regular** | open source |
| 中文 Caption / Quote | **思源宋体 Italic** | — |

**D-S-6 修复 · 中文 Display ≥ 96px + weight 800**:思源宋体在 88px 以下视觉重量偏单薄,**章节首页与主标题强制中文 display ≥ 96px + font-weight: 800**;**font-stretch: 100%** 以避免变窄变形。

### 2.2 字号比例(**D-S-2 修复 · 加 5.5rem 安全垫注脚**)

| Token | 流体规格(min / fluid / max) | tracking | 用途 |
|---|---|---|---|
| `--text-display-xl` | `clamp(3rem, 4vw + 1rem, 5.5rem)` | `-0.035em` | hero 主标题 |
| `--text-display-cn-l` | `clamp(3.5rem, 4.5vw + 1rem, 6rem)` | `-0.035em` | **中文 display(D-S-6,中文章节首页专用)** |
| `--text-display-l` | `clamp(2.25rem, 2.5vw + 1rem, 4rem)` | `-0.025em` | 章首页 H1 |
| `--text-display-m` | `clamp(1.75rem, 1.5vw + 1rem, 2.75rem)` | `-0.02em` | 章节 H2 |
| `--text-heading-l` | `clamp(1.5rem, 1vw + 1rem, 2rem)` | `-0.015em` | 卡片 / 段标题 |
| `--text-heading-m` | `1.25rem` | `-0.01em` | 子段标题 |
| `--text-body-l` | `1.125rem` | `0` | 长文 / 编辑正文 |
| `--text-body` | `1rem` | `0` | 默认正文 |
| `--text-body-s` | `0.9375rem` | `0` | 次要正文 |
| `--text-caption` | `0.8125rem` | `0.02em` | 图说 / 注释 |
| `--text-eyebrow` | `0.75rem` | `0.18em` | **极少使用**,仅品牌标识 |

**D-S-2 注脚**:`--text-display-xl` max = 5.5rem = 6rem 硬限内**保守上限,留 8px 余量**(应对中英混排或 grid 缩放时潜在溢出)。

**D-S-6 注脚**:`--text-display-cn-l` max = 6rem = 6rem 硬限,**不预留余量**(中文 display 必须顶到硬限以保证视觉重量;溢出风险由 grid + word-break 控制)。

### 2.3 行宽 / 行高 / 引文

- 正文行宽:`max-width: 65ch`(Impeccable 强制)
- 长文 line-height: `1.7`
- UI 行 line-height: `1.5`
- 引文:Cormorant Italic + 字号 +0.25 级 + 行宽 50ch + 微上色 `--ink-mute`
- 中文加 `text-wrap: balance`(h1–h3)、`text-wrap: pretty`(长文)

### 2.4 引号与排版

- 英文引号:`" "` curly,**不用 `" "` straight**
- 中文引号:`「 」` 外层、`『 』` 内层
- ❌ 引文块左侧**禁竖条**(Impeccable 反侧边条),改用字体差异 + 来源行微缩 + 微上色
- ❌ 英文两侧**必须有 1/4 em 全角空格**(详见 §9.2 #7 中英混排细则)

---

## 3 · Spacing & Layout

> **🟡 v0.4 战略纠偏 hold:4px 间距基线 / 10 步进 / Container 4 档具体值待 Style Discovery 重定。**
>
> v0.3 锁定的具体间距(§3.1 --space-1 ~ --space-32 + §3.2 --w-prose/narrow/default/wide/bleed + §3.3 grid 规则)标记 superseded。
>
> 跨风格保留:Impeccable 通用布局规则(1D flex / 2D grid 区分 / `repeat(auto-fit, minmax(280px, 1fr))` / 间距节奏变化 / cards 不是默认答案)跨风格适用。
>
> **本节以下原 v0.3 锁定内容作为历史档案保留,不再视为有效视觉宪法**。

### 3.1 间距标度(4px base)

| Token | 值 | 用途 |
|---|---|---|
| `--space-1` | `4px` | 标签 / icon 紧贴 |
| `--space-2` | `8px` | 行内元素 |
| `--space-3` | `12px` | 表单元素 |
| `--space-4` | `16px` | 段落内小段 |
| `--space-6` | `24px` | 段落 |
| `--space-8` | `32px` | 卡片内 |
| `--space-12` | `48px` | 区段 |
| `--space-16` | `64px` | 大区段 |
| `--space-24` | `96px` | 章首页顶 |
| `--space-32` | `128px` | Hero 上下 |

### 3.2 Container 宽度

| Token | 值 | 用途 |
|---|---|---|
| `--w-prose` | `65ch` | 长文 |
| `--w-narrow` | `720px` | 表单 / 出处档案 |
| `--w-default` | `1080px` | 普通内容 |
| `--w-wide` | `1320px` | 编辑型宽排版 |
| `--w-bleed` | `100vw` | 全屏图 / 章首封面 |

### 3.3 Grid 规则

- 二维:`grid-template-columns: repeat(auto-fit, minmax(280px, 1fr))`
- 一维:`flex-wrap`,**不要无脑 Grid**
- 主内容区默认单列堆叠,带 `gap: var(--space-12)`

---

## 4 · Component Rules

> **🟡 v0.4 战略纠偏 hold:具体圆角值(0/2/6/12/pill)、描边粗细、阴影大小待 Style Discovery 重定。**
>
> v0.3 锁定的圆角(§4.1 --radius-none/sm/md/lg/pill)+ 描边(§4.2)+ 阴影(§4.3)+ 玻璃拟态例外(§4.4)标记 superseded。
>
> 跨风格保留:Impeccable 通用组件规则(语义化 z-index / 圆角 ≤ 24px 上限 / ghost-card 禁 / 侧边条禁 / reduced-motion 强制)跨风格适用。
>
> **本节以下原 v0.3 锁定内容作为历史档案保留,不再视为有效视觉宪法**。

### 4.1 圆角

| Token | 值 | 适用 |
|---|---|---|
| `--radius-none` | `0` | 图、表格、章节分隔符、出处档案 |
| `--radius-sm` | `2px` | 极小装饰 |
| `--radius-md` | `6px` | 按钮 / tag / input |
| `--radius-lg` | `12px` | **卡片上限(Impeccable 硬限 ≤ 16px)** |
| `--radius-pill` | `999px` | tag / status |

❌ **禁**:24 / 28 / 32 / 40px 圆角

### 4.2 描边

- 默认:`1px solid var(--rule)`
- 强调:`1px solid var(--accent-jihong)`(**无 shadow 配合**)
- ❌ **禁**:`1px border + box-shadow blur ≥ 16px` 的 ghost-card
- ❌ **禁**:侧边条 `border-left > 1px` 作装饰

### 4.3 阴影(默认无 shadow)

- 小:`0 2px 4px oklch(0 0 0 / 0.06)`(按钮按压)
- 中:`0 4px 8px oklch(0 0 0 / 0.08)`(Modal)
- ❌ **禁**:大 / 软 / 模糊 ≥ 16px 的 shadow

### 4.4 Glassmorphism / Backdrop-filter(**D-S-3 修复 · 收窄例外**)

**收窄后的例外**:**仅摄影器物大图 / 检测过程视频**可作为 backdrop-filter 的底层,**允许 Lightbox / Modal 内的玻璃面板**。**不允许**:
- ❌ banner / promo / 品类卡片图 作 backdrop-filter 底层
- ❌ 通用 UI 卡片加 glass 效果
- ❌ 章节封面 / Hero 区域用 glassmorphism

**实现示意**:
```css
/* 允许:器物 Lightbox 玻璃面板 */
.piece-lightbox__panel {
  background: oklch(0.97 0 0 / 0.85);
  backdrop-filter: blur(12px) saturate(120%);
}

/* ❌ 禁止:banner glass */
.promo-banner { backdrop-filter: blur(...); }  /* 禁用 */
```

---

## 5 · Motion Grammar

> **🟡 v0.4 战略纠偏 hold:具体缓动曲线 / duration 数值 / reveal / LQIP 实现待 Style Discovery 重定。**
>
> v0.3 锁定的 motion(§5.1 ease-out-quart/expo + §5.2 5 duration + §5.3 reveal + §5.4 reduced-motion + §5.5 图像 hover 禁 + §5.6 progressive image loading)标记 superseded。
>
> 跨风格保留:Impeccable 通用动效规则(无 bounce/elastic / reduced-motion 强制 / reveal 默认可见 / 高级动效材质按需)跨风格适用。
>
> **本节以下原 v0.3 锁定内容作为历史档案保留,不再视为有效视觉宪法**。

### 5.1 缓动(已决)

```css
--ease-out-quart: cubic-bezier(0.25, 1, 0.5, 1);
--ease-out-expo:  cubic-bezier(0.16, 1, 0.3, 1);
```

❌ **禁**:bounce / elastic / 弹簧曲线

### 5.2 时长

| Token | 值 | 用途 |
|---|---|---|
| `--dur-fast` | `160ms` | hover / focus 微反馈 |
| `--dur-base` | `240ms` | 默认过渡 |
| `--dur-slow` | `400ms` | Modal 进出 |
| `--dur-cinema` | `800ms` | 编辑型章节封面转场 |
| `--dur-reveal` | `600ms` | 内容揭示(滚动进入) |

### 5.3 Reveal 动画(**D-KILL-3 修复 · 强制锁定 · 已从 §11 移除**)

> **【已从 §11 决策表移除 —— 此为 Impeccable 强制项,非待决项】**

**默认内容必须可见**,滚动进入时仅做 opacity + 微 transform(8–16px Y),**不依赖 class 触发显示**。

```css
/* ✅ 唯一允许的安全模式 */
.piece-card {
  opacity: 1; /* 默认可见 */
  transform: translateY(0);
  transition: opacity var(--dur-reveal) var(--ease-out-expo),
              transform var(--dur-reveal) var(--ease-out-expo);
}

@starting-style {
  .piece-card[data-revealed="false"] {
    opacity: 0.001;
    transform: translateY(12px);
  }
}
```

❌ **禁**(Impeccable reveal-safety 硬警告):依赖 JS 加 class 才显示内容——hidden tabs 内容永远不显示

### 5.4 Reduced Motion(强制)

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
```

降级:crossfade 替换 slide;transform 替换为 opacity 渐变;瞬时切换替换滚动。

### 5.5 图像 Hover(Gemini 禁令)

❌ **禁**:任何 `<img>` 的 `transform / scale / rotate / translate` 在 hover 时变化
❌ **禁**:Tailwind `group-hover:scale-*` 等通过父级触发
✅ 卡片 hover → 改 背景色 / 描边色 / 文字颜色,**永远不动图**

### 5.6 Progressive Image Loading(**D-S-5 修复 · 新增**)

> **【D-S-5 修复 · 器物大图加载策略】**

LLCCRAFT 器物大图是核心转化素材,**加载体验不允许"图慢慢出来"的廉价感**。所有 `<img>` 必须遵循:

```html
<!-- ✅ 唯一允许的模式 -->
<img
  src="piece-1600.jpg"
  srcset="piece-400.jpg 400w, piece-800.jpg 800w, piece-1600.jpg 1600w"
  sizes="(max-width: 600px) 100vw, (max-width: 1200px) 80vw, 1320px"
  loading="lazy"
  decoding="async"
  style="aspect-ratio: 3 / 4; background: url('piece-lqip.svg') center/cover"
  alt="Ming 早期青花梅瓶 高 28cm"
/>
```

**强制规则**:
- ✅ 所有 `<img>` 必须显式 `aspect-ratio` 占位(防 layout shift)
- ✅ 加载策略:**LQIP(low-quality image placeholder)SVG base64 内联** → 清晰原图
- ✅ 长器物大图:`IntersectionObserver` + lazy load
- ✅ 章节封面与 hero 大图:`fetchpriority="high"` + preload
- ❌ **禁**:无 aspect-ratio 占位的裸 `<img>`(LLCCRAFT 必须零 layout shift)
- ❌ **禁**:用 CSS `background-image` 加载器物大图(失去 alt 与 a11y)

**实现辅助**:在 Sage-light 主题封装 `<PieceImage />` 组件统一管理 srcset / LQIP / aspect-ratio。

---

## 6 · Z-Index Scale

> **🟡 v0.4 战略纠偏 hold:具体 z-index 数值(0/10/20/25/30/40/50/60/70/75/80)待 Style Discovery 重定,但**a11y 强制的 skiplink + region-focus 两层跨风格保留**。**
>
> v0.3 锁定的 11 档 z-index 标记 superseded。
>
> 🟢 **跨风格保留(强制项)**:
> - `--z-skiplink: 80` —— WCAG 2.4.1 Bypass Blocks 强制
> - `--z-region-focus: 75` —— 键盘焦点区域高亮
>
> 跨风格保留:Impeccable 通用规则(语义化 z-index scale,不用 999/9999 魔数)跨风格适用。
>
> **本节以下原 v0.3 锁定内容作为历史档案保留,部分数值(skiplink 80 + region-focus 75)继续生效**。

> **【WCAG 2.4.1 Bypass Blocks 合规 · 强制】**

```css
--z-base: 0;
--z-dropdown: 10;
--z-sticky: 20;
--z-fixed: 25;
--z-modal-backdrop: 30;
--z-modal: 40;
--z-toast: 50;
--z-tooltip: 60;
--z-cursor: 70;
--z-region-focus: 75;   /* ← 新增:键盘 focus 区域高亮 */
--z-skiplink: 80;       /* ← 新增:WCAG 2.4.1 Bypass Blocks */
```

**a11y skiplink 强制实现**:
```html
<a href="#main" class="skip-link">Skip to main content</a>
```
```css
.skip-link {
  position: fixed;
  top: -100px;  /* 默认隐藏 */
  left: 8px;
  z-index: var(--z-skiplink);
  padding: var(--space-2) var(--space-4);
  background: var(--ink-body);
  color: var(--surface);
}
.skip-link:focus {
  top: 8px;  /* focus 时显示 */
}
```

❌ **禁**:999 / 9999 等魔数;**禁**:同层不同 z 值

---

## 7 · Typography Hierarchy by Block Pattern

> **🟡 v0.4 战略纠偏 hold:具体 BP 字体/字号配置(§7 表格 13 BP)待 Style Discovery 重定。**
>
> v0.3 锁定的 13 BP 字体配置标记 superseded。
>
> 跨风格保留:11 个 BP 架构(BP-01 ~ BP-13)+ 13 BP 页面意图绑定(P-01 ~ P-11)属业务架构层,跨风格适用,不动。
>
> **本节以下原 v0.3 锁定内容作为历史档案保留,不再视为有效视觉宪法**。

| Block Pattern | H1 | H2 | Body | Eyebrow |
|---|---|---|---|---|
| BP-01 hero-essay | display-xl Cormorant 浅色 | display-m Cormorant 浅色 | body-l Inter 浅色 | **不用** |
| BP-05 chapter-opener | display-l Cormorant 反白 | display-m Cormorant 反白 | body-l Inter 反白 | 罗马数字 Ⅰ/Ⅱ/Ⅲ(display-xl) |
| BP-06 piece-document | display-m Cormorant ink | heading-l Cormorant ink | body Inter ink | 不用 |
| BP-07 maker-profile | display-m Cormorant ink | heading-l Cormorant ink | body-l Inter ink | 不用 |
| BP-08 journal-essay | display-m Cormorant ink | heading-l Cormorant ink | body-l Inter ink + w-prose | 不用 |
| BP-11 institutional-card | heading-l Cormorant ink | 无 | body Inter ink | 不用 |
| **BP-12 care-guide**(v0.2.1 新增) | heading-l Cormorant ink | heading-m Cormorant ink | body Inter ink + w-prose | 不用 |
| **BP-13 about-mission**(v0.2.1 新增) | display-l Cormorant ink | display-m Cormorant ink | body-l Inter ink + w-prose | 不用 |

**共性**:全站**仅 BP-05** 允许章号装饰(罗马数字);其余一律不用 eyebrow / 阿拉伯数字编号。

---

## 8 · Responsive Strategy

> **🟡 v0.4 战略纠偏 hold:具体断点(1200/900/600px)待 Style Discovery 重定。**
>
> v0.3 锁定的 4 档断点标记 superseded。
>
> 跨风格保留:Impeccable 通用规则(长 H1 防溢出 / text-wrap: balance / hyphens: auto)跨风格适用。
>
> **本节以下原 v0.3 锁定内容作为历史档案保留,不再视为有效视觉宪法**。

| 断点 | 适配 |
|---|---|
| ≥ 1200px | 完整版式(--w-wide) |
| 900–1199px | 缩至 --w-default,grid 3 列自动改 2 列 |
| 600–899px | 单列堆叠,字号 -0.5 级,hero 高度 60vh |
| < 600px | 单列,字号 -1 级,hero 高度 50vh,nav 转 hamburger |

❌ **禁**:长 H1 在 tablet 折断 → 必须用 `text-wrap: balance` + `hyphens: auto` 联合保险

---

## 9 · Anti-Patterns Banned

> **🟢 v0.4 战略纠偏:本节整体保留。**
>
> §9.1 Impeccable 通用禁令(跨风格强制)+ §9.2 LLCCRAFT 专属额外禁令(部分 hold 部分保留)+ §9.3 反模式纠正示例(hold)等。详见 §9.1 注释。

### 9.1 Impeccable 通用禁令(全部继承)

- ❌ 任何 cream / sand / paper / parchment / bone / linen / wheat / biscuit / ivory 色作为 body 背景
- ❌ 渐变文字 `background-clip: text`
- ❌ glassmorphism / backdrop-filter(**除 §4.4 收窄例外**)
- ❌ Hero-metric template
- ❌ 同尺寸 icon + 标题 + 文字的重复卡片网格
- ❌ 每个 section 上方一律小写 uppercase eyebrow
- ❌ 默认 01/02/03 阿拉伯数字编号章节标识
- ❌ 文本溢出容器
- ❌ 图像 hover 缩放 / 旋转(Gemini 缺陷)
- ❌ ghost-card(`border 1px + shadow blur ≥ 16px` 同框)
- ❌ 卡片圆角 ≥ 24px(Codex 缺陷)
- ❌ 手绘 / sketchy SVG 装饰
- ❌ `repeating-linear-gradient` 条纹背景
- ❌ 装饰性网格背景
- ❌ 元批评式自我标榜 copy

### 9.2 LLCCRAFT 专属额外禁令

- ❌ 任何 `shop now / buy now / add to cart` 文案出现在 Layer 2/3 器物页
- ❌ 任何 `limited time / discount / sale` 字样
- ❌ 任何"China shipping free over $XX"承诺
- ❌ 任何"⭐⭐⭐⭐⭐ happy customers"型社会证明块
- ❌ 任何"I love my new teapot ❤️"式 UGC 推荐语
- ❌ 任何 emoji 作为 UI 装饰
- ❌ "红 + 金 + 龙凤 + 祥云"任何组合的"中国风"刻板视觉
- **❌ 中英混排混乱(D-S-4 修复 · 强制细则)**:
  - **(a) 英文两侧必须有 1/4 em 全角空格**(HTML 实体 `&thinsp;` 或直接 ` ` 0.25em 空格),避免中英贴一起视觉粘连
  - **(b) 字体回退规则**:英文无衬线字体(Inter)优先于中文(Source Han Sans),即在 CSS font-family stack 中 Inter 排在 Source Han 之前;同字体但回退链 Inter → Source Han Sans
  - **(c) 标点规则**:英文标点(逗号 / 句号 / 问号 / 叹号)后必须有 1 个 ASCII 空格;中文标点(全角逗号 / 句号 / 问号)前后无空格
  - **(d) 主从关系**:中文主语英文修饰语 → 中文为主,英文 inline 包裹;例:`该窑口称「Ru ware」为「如瓷」`

### 9.3 禁令的"反模式纠正示例"

| 错误写法 | 正确写法 |
|---|---|
| `border-left: 4px solid #a8323f;` 在引文块 | 引文块改 Cormorant Italic + 行宽 50ch + 来源行小一号 |
| `<h2>OUR PROCESS</h2>` eyebrow 在每 section 上方 | 章号改 `Ⅰ` Cormorant 罗马数字,只在 BP-05 用 |
| `<button class="btn">Buy Now</button>` 在 5K USD 器物页 | `<button class="btn">Request a Viewing</button>` |
| `box-shadow: 0 8px 24px rgba(0,0,0,.15); border: 1px solid #ccc;` 同框 | 二选一:仅描边 或 仅 shadow ≤ 8px |
| `border-radius: 24px;` 在 piece-card | `border-radius: 12px;`(上限) |
| 该窑口生产Ru ware用于出口 | 该窑口生产「Ru ware」用于出口(英文两侧全角空格) |

---

## 10 · Sage-light 主题集成

> **🟡 v0.4 战略纠偏 hold:Vite / Tailwind / sage-light 集成的具体配置待 Style Discovery 重定,但**工程结构(SSOT / 路径双引号强引用 / LF + ASCII)跨风格强制保留**。**
>
> v0.3 锁定的 §10.1 Vite / §10.2 Tailwind 主题扩展 / §10.3 v19 部署铁律具体值标记 superseded。
>
> 🟢 **跨风格保留(工程结构强制项)**:
> - v19 部署铁律(§10.3 双引号强引用 / LF + ASCII / `--mkpath` / `-skL`)—— 永续保留
> - SSOT 原则(tailwind.config.js + tokens.css + Figma 库全 var() 引用,无硬编码)—— 永续保留
>
> **本节以下原 v0.3 锁定内容作为历史档案保留,工程结构层(skiplink / a11y / SSOT / v19 铁律)继续生效**。

### 10.1 Vite 编译流

- Tailwind 编译时注入 §1.3 OKLCH token(CSS :root 单一来源,**D-KILL-4 SSOT**)
- 6 个 Phase 2 锁定类**保留,继承 v19 `"$THEME_SRC"` 双引号强引用规范部署**
- v0.3 新增 3 类实装:`.editorial-prose` / `.provenance-table` / `.inquiry-sticky-panel`

### 10.2 Tailwind 主题扩展(**D-KILL-4 修复 · 单一真相源**)

> **【D-KILL-4 修复 · 禁止硬编码 token】**

**单一真相源在 `:root { ... }`(置于 `resources/css/tokens.css`),Tailwind 配置**一律通过 `var(--xxx)` 引用**,禁止任何位置出现 OKLCH 字面量或 hex 值。**

```css
/* resources/css/tokens.css — 唯一真相源 */
:root {
  --ink-body:        oklch(0.14 0.012 28);
  --surface:         oklch(0.97 0 0);
  --surface-warm:    oklch(0.95 0.006 28);
  --ink-text:        oklch(0.18 0.010 28);
  --ink-soft:        oklch(0.42 0.012 28);
  --ink-mute:        oklch(0.62 0.008 28);
  --accent-jihong:   oklch(0.42 0.165 27);
  --accent-ru:       oklch(0.78 0.045 195);
  --accent-qing:     oklch(0.45 0.110 260);
  --rule:            oklch(0.85 0.005 28);

  --text-display-xl:        clamp(3rem, 4vw + 1rem, 5.5rem);
  --text-display-cn-l:      clamp(3.5rem, 4.5vw + 1rem, 6rem);
  /* ... 其他 token 同 §2.2 / §3 / §5 */
}
```

```js
// tailwind.config.js — 仅引用,禁止硬编码
theme: {
  extend: {
    colors: {
      ink: {
        body: 'var(--ink-body)',
        text: 'var(--ink-text)',
        soft: 'var(--ink-soft)',
        mute: 'var(--ink-mute)',
      },
      surface: {
        DEFAULT: 'var(--surface)',
        warm:    'var(--surface-warm)',
      },
      accent: {
        jihong: 'var(--accent-jihong)',
        ru:     'var(--accent-ru)',
        qing:   'var(--accent-qing)',
      },
      rule: 'var(--rule)',
    },
    fontFamily: {
      display: ['"Cormorant Garamond"', '"Source Han Serif SC"', 'serif'],
      body:    ['Inter', '"Source Han Sans SC"', 'sans-serif'],
      quote:   ['"Cormorant Garamond"', '"Source Han Serif SC"', 'serif'],
    },
    borderRadius: { none: '0', sm: '2px', md: '6px', lg: '12px', pill: '999px' },
    // spacing / fontSize / transitionDuration / transitionTimingFunction 全部 var(--xxx) 引用
  }
}
```

### 10.3 v19 部署铁律继承(新增代码块必遵守)

1. 所有路径变量一律双引号强引用 `"$VAR"`
2. 新脚本保持纯 ASCII + LF 换行
3. 服务端安全路径限制(白名单)不试探
4. rsync 默认 `--mkpath`
5. HTTPS 调用默认 `-skL`

---

## 11 · Decision Log(全部已决 · 无悬而未决项 · Reveal 已移除)

> **【D-KILL-3 修复 · Reveal 默认可见已从本表移除,转为 §5.3 强制锁定规则】**

| # | 决策 | 依据 / 锚点 |
|---|---|---|
| D-01 | **body 比例反转**:`--surface` 70% / `--ink-body` 5-8% accent | D-KILL-1,正向参考全部浅色主导 + 物理光学 + 笔记本护眼 |
| D-02 | **Drenched 主题釉色锁定**(每章封面在 P-03 创建时显式选定) | D-KILL-2,Impeccable intentionality + 杂志图录学传统 |
| D-03 | **Reveal 默认可见 + 滚动 opacity/微 transform**(从本表移除,转 §5.3 锁定) | D-KILL-3,Impeccable reveal-safety 强制 |
| D-04 | **Tailwind 单一真相源**(:root CSS 变量 + var(--xxx) 引用) | D-KILL-4,SSOT |
| D-05 | **Z-Index 加 `--z-skiplink: 80` + `--z-region-focus: 75`** | D-KILL-5,WCAG 2.4.1 |
| D-06 | **§7 typography 补 BP-12(care-guide)+ BP-13(about-mission)** | D-KILL-6,P-10/P-11 闭环 |
| D-07 | **§1.1 色彩战略论证改写**:反差节奏 + Full Palette 品控难度指数级 | D-S-1 |
| D-08 | **5.5rem 安全垫注脚**(留 8px 余量) | D-S-2,Impeccable 6rem 硬限内保守 |
| D-09 | **Glassmorphism 收窄例外**(仅器物大图 / 检测视频底层) | D-S-3,品牌节制 + Impeccable 默认禁 |
| D-10 | **中英混排 4 条细则** | D-S-4,排版可执行性 |
| D-11 | **§5.6 Progressive Image Loading**(aspect-ratio + LQIP + IO lazy) | D-S-5,器物大图加载体验 |
| D-12 | **中文 display ≥ 96px + weight 800**,独立 token `--text-display-cn-l` | D-S-6,思源宋体 ≥ 88px 单薄 |
| D-13 | 字体 = Source Han 起步,Phase 4 评估 Founder | v0.2 继承,起步零成本 |
| D-14 | 新增 6 类组件分两批实装 | v0.2 继承,Phase 2 v0.3 实装 3 关键 |
| D-15 | 章号用 Cormorant 罗马数字 Ⅰ/Ⅱ/Ⅲ | v0.2 继承,弱化 AI 编号感 |

---

## 12 · 文档状态

- **🟡 v0.4 战略纠偏 · Style Discovery 阶段** · 2026-07-06 · CEO 战略纠偏明令
- **战略层**:✅ v0.2.1 + v0.3 双锁保留(13 P + 12 D + D1-D4 + OBS-1/OBS-2 全部通过 B 终极 APPROVED)
- **战术层**:**视觉风格宪法 hold** —— §1/§2/§3/§4/§5/§7/§8 + §10 具体值待 Style Discovery 重定
- **跨风格保留层**:Impeccable 通用反 AI-slop 规则 + WCAG 2.1 AA + v19 工程结构 + a11y skiplink/region-focus 永续
- **纠偏快照**:`.impeccable/snapshots/v0.4-strategic-reset.md`(全量重置记录)
- **配套工作区**:`.impeccable/` 已建(`README.md` + `config.json` + `design.json` + `snapshots/v0.2.1-b-audit.md` + `v0.3-b-audit.md` + `v0.4-strategic-reset.md`)
- **代码资产**:tokens.css / tailwind.config.js / style-sandbox.html 工程结构保留,具体值作废待重定
- **下一动作**:CEO 提供参考 URL 案例 → A 启动逆向拆解 + 重组 → B 复审 → 视觉宪法 v0.1 CEO 拍板 → 进入 P-01~P-11

---

**【Data-Lock Status: 🟡 Style Discovery 阶段 · 战略层锁 + 视觉层 hold】**