import { defineConfig } from 'vite';
import { resolve } from 'path';
import { fileURLToPath } from 'url';

const __dirname = fileURLToPath(new URL('.', import.meta.url));

export default defineConfig({
  build: {
    outDir: 'build',
    emptyOutDir: true,
    rollupOptions: {
      input: resolve(__dirname, 'src/styles/main.css'),
      output: {
        entryFileNames: '[name].css',
        assetFileNames: 'assets/[name][extname]',
      },
    },
    // cssCodeSplit true is default; explicit for clarity
    cssCodeSplit: true,
    minify: 'esbuild',
    target: 'es2020',
  },
});
