/** @type {import('tailwindcss').Config} */
/*
 * LLCCRAFT Sage-light Tailwind config  --  v0.4 战略纠偏 · Style Discovery 阶段
 * --------------------------------------------------------------------------
 *  v0.3 状态(07-05 锁定):完整 Tailwind 主题扩展,全 var() 引用 tokens.css
 *  B 终极 APPROVED 通过,留档 .impeccable/snapshots/v0.3-b-audit.md
 *
 *  v0.4 状态(07-06 战略纠偏):
 *    -- 工程结构(var() 引用 / SSOT 模式 / 跨风格强制规则)保留
 *    -- tokens.css 中具体视觉值作废(transparent / 0 / inherit 中性 fallback)
 *    -- Tailwind 通过 var() 引用自动跟随 tokens.css 占位状态
 *    -- 跨风格保留:z-index skiplink 80 / region-focus 75 / w-prose 65ch
 *       / reduced-motion / .skiplink 规则
 *
 *  Style Discovery 阶段产出:视觉宪法 v0.1 -> 替换 tokens.css 占位符
 *  -> 本配置自动同步(SSOT 模式天然兼容)
 *
 *  Constitution : Impeccable SKILL.src.md  +  WCAG 2.1 AA  +  v19 CI/CD
 *  Encoding : pure ASCII + LF (v19 CI/CD iron rule)
 *
 *  历史 Locked inputs(已 superseded · 留档备查):
 *    DESIGN.md v0.3 S1 (color)  S2 (type)  S3 (space)  S4 (radius)
 *    S5 (motion)  S6 (z-index)  S9 (anti-patterns)  S10 (Sage integration)
 *    DESIGN.md v0.2.1 D-KILL-1 (body ratio) D-KILL-2 (drenched lock)
 *    D-KILL-3 (reveal) D-KILL-4 (SSOT) D-KILL-5 (skiplink)
 *    D-S-2 (5.5rem pad) D-S-3 (glass narrow) D-S-5 (LQIP) D-S-6 (CN 96px)
 * ------------------------------------------------------------------------- */

module.exports = {
  content: [
    './*.php',
    './inc/**/*.php',
    './patterns/**/*.php',
    './src/**/*.{css,js}',
    './*.{html,js,php}',
    './build/**/*.css',
    './style-sandbox.html',   // <-- local visual test page
  ],
  theme: {
    /* ----------------------------------------------------------------------
     *  COLOR  --  tokens from tokens.css :root
     * -------------------------------------------------------------------- */
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      ink: {
        DEFAULT: 'var(--ink-body)',
        body:    'var(--ink-body)',
        text:    'var(--ink-text)',
        soft:    'var(--ink-soft)',
        mute:    'var(--ink-mute)',
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

    /* ----------------------------------------------------------------------
     *  TYPOGRAPHY  --  fluid type from tokens.css
     * -------------------------------------------------------------------- */
    fontFamily: {
      display:    ['var(--font-display)'],
      sans:       ['var(--font-body)'],
      body:       ['var(--font-body)'],
      serif:      ['var(--font-display)'],
      quote:      ['var(--font-quote)'],
      cn: {
        display:  ['var(--font-cn-display)'],
        body:     ['var(--font-cn-body)'],
      },
      mono:       ['var(--font-mono)'],
    },
    fontSize: {
      'display-xl':   ['var(--text-display-xl)',   { lineHeight: 'var(--leading-display)', letterSpacing: 'var(--tracking-display-xl)' }],
      'display-cn-l': ['var(--text-display-cn-l)', { lineHeight: 'var(--leading-display)', letterSpacing: 'var(--tracking-display-xl)' }],
      'display-l':    ['var(--text-display-l)',    { lineHeight: 'var(--leading-display)', letterSpacing: 'var(--tracking-display-l)'  }],
      'display-m':    ['var(--text-display-m)',    { lineHeight: 'var(--leading-display)', letterSpacing: 'var(--tracking-display-m)'  }],
      'heading-l':    ['var(--text-heading-l)',    { lineHeight: 'var(--leading-ui)',      letterSpacing: 'var(--tracking-heading-l)'  }],
      'heading-m':    ['var(--text-heading-m)',    { lineHeight: 'var(--leading-ui)',      letterSpacing: 'var(--tracking-heading-m)'  }],
      'body-l':       ['var(--text-body-l)',       { lineHeight: 'var(--leading-prose)',   letterSpacing: 'var(--tracking-body)'       }],
      'body':         ['var(--text-body)',         { lineHeight: 'var(--leading-ui)',      letterSpacing: 'var(--tracking-body)'       }],
      'body-s':       ['var(--text-body-s)',       { lineHeight: 'var(--leading-ui)',      letterSpacing: 'var(--tracking-body)'       }],
      'caption':      ['var(--text-caption)',      { lineHeight: 'var(--leading-ui)',      letterSpacing: 'var(--tracking-caption)'    }],
      'eyebrow':      ['var(--text-eyebrow)',      { lineHeight: 'var(--leading-ui)',      letterSpacing: 'var(--tracking-eyebrow)'    }],
    },

    /* ----------------------------------------------------------------------
     *  SPACING + MAX-WIDTH + RADIUS + Z-INDEX
     * -------------------------------------------------------------------- */
    spacing: {
      '1':  'var(--space-1)',
      '2':  'var(--space-2)',
      '3':  'var(--space-3)',
      '4':  'var(--space-4)',
      '6':  'var(--space-6)',
      '8':  'var(--space-8)',
      '12': 'var(--space-12)',
      '16': 'var(--space-16)',
      '24': 'var(--space-24)',
      '32': 'var(--space-32)',
      // Tailwind's default spacing scale expects 0 + 0.5/1.5/etc.
      // We add the defaults to keep utility names compatible.
      '0':  '0',
      '0.5':'2px',
      '1.5':'6px',
      '2.5':'10px',
      '3.5':'14px',
      '5':  '20px',
      '10': '40px',
      '20': '80px',
    },
    maxWidth: {
      'prose':   'var(--w-prose)',
      'narrow':  'var(--w-narrow)',
      'default': 'var(--w-default)',
      'wide':    'var(--w-wide)',
      'none':    'none',
      'full':    '100%',
      'screen':  '100vw',
    },
    borderRadius: {
      'none': 'var(--radius-none)',
      'sm':   'var(--radius-sm)',
      'md':   'var(--radius-md)',
      'lg':   'var(--radius-lg)',
      'pill': 'var(--radius-pill)',
      'full': '9999px',
    },
    zIndex: {
      'base':         'var(--z-base)',
      'dropdown':     'var(--z-dropdown)',
      'sticky':       'var(--z-sticky)',
      'fixed':        'var(--z-fixed)',
      'modal-backdrop':'var(--z-modal-backdrop)',
      'modal':        'var(--z-modal)',
      'toast':        'var(--z-toast)',
      'tooltip':      'var(--z-tooltip)',
      'cursor':       'var(--z-cursor)',
      'region-focus': 'var(--z-region-focus)',
      'skiplink':     'var(--z-skiplink)',
    },

    /* ----------------------------------------------------------------------
     *  MOTION  --  from tokens.css
     * -------------------------------------------------------------------- */
    transitionDuration: {
      'fast':   'var(--dur-fast)',
      'base':   'var(--dur-base)',
      'slow':   'var(--dur-slow)',
      'cinema': 'var(--dur-cinema)',
      'reveal': 'var(--dur-reveal)',
      '0':      '0ms',
      '75':     '75ms',
      '100':    '100ms',
      '150':    '150ms',
      '200':    '200ms',
      '300':    '300ms',
      '500':    '500ms',
      '700':    '700ms',
      '1000':   '1000ms',
    },
    transitionTimingFunction: {
      'quart': 'var(--ease-out-quart)',
      'expo':  'var(--ease-out-expo)',
      'linear':'linear',
      'in':    'cubic-bezier(0.4, 0, 1, 1)',
      'out':   'cubic-bezier(0, 0, 0.2, 1)',
      'in-out':'cubic-bezier(0.4, 0, 0.2, 1)',
    },

    /* ----------------------------------------------------------------------
     *  baseline-ui rhythm  --  margin / padding auto-couple defaults
     * -------------------------------------------------------------------- */
    container: {
      center: true,
      padding: {
        DEFAULT: 'var(--space-4)',
        md:      'var(--space-8)',
        lg:      'var(--space-12)',
      },
    },
  },

  plugins: [],
};