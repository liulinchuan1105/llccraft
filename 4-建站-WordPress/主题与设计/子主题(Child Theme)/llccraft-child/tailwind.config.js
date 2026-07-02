/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './*.php',
    './inc/**/*.php',
    './patterns/**/*.php',
    './src/**/*.{css,js}',
    './*.{html,js,php}',
    './build/**/*.css',
  ],
  theme: {
    extend: {
      colors: {
        ink:    '#0e0e0e',  // 墨黑(标题)
        paper:  '#faf8f3',  // 米白(底)
        dust:   '#e8e1d4',  // 沙尘(分隔)
        accent: '#a8323f',  // 霁红(细节点缀)
        celadon:'#aac4b0',  // 影青绿(可选用)
      },
      fontFamily: {
        serif: ['Cormorant Garamond', 'EB Garamond', 'Georgia', 'serif'],
        sans:  ['Inter', 'system-ui', '-apple-system', 'sans-serif'],
        mono:  ['JetBrains Mono', 'ui-monospace', 'monospace'],
      },
      letterSpacing: {
        loose: '0.18em',
      },
      maxWidth: {
        gutter: '64rem',
      },
      transitionTimingFunction: {
        soft: 'cubic-bezier(.22,.61,.36,1)',
      },
    },
  },
  plugins: [],
};
