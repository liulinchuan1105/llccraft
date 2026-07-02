<?php
/**
 * Title:       LLCCRAFT · Collection Grid (9 cells)
 * Description: 九宫格选品 · 3 × 3 · 极简 product-card · 占位 SKU
 * Category:    llccraft-home
 * Keywords:    llccraft, grid, products
 *
 * 注:WordPress Gutenberg 原生 columns block 只能嵌套 2-4 列。
 *    真正 3×3 用 gallery block 或 columns 嵌套实现。
 *    这里采用 columns(3) + group 中 columns(3) 实现 3×3 简化,
 *    真实目录页 Phase 3 上 WooCommerce 会替换。
 */
?>
<!-- wp:group {"tagName":"section","className":"section-pad","layout":{"type":"constrained"}} -->
<section class="section-pad wp-block-group">

    <!-- wp:heading {"align":"center","level":2,"className":"text-balance","style":{"typography":{"fontSize":"clamp(1.75rem,3vw,2.5rem)","letterSpacing":"-0.02em"},"spacing":{"margin":{"bottom":"0.5rem"}}} -->
    <h2 class="wp-block-heading has-text-align-center text-balance" style="margin-bottom:0.5rem;font-size:clamp(1.75rem,3vw,2.5rem);letter-spacing:-0.02em">From the kiln</h2>
    <!-- /wp:heading -->

    <!-- wp:paragraph {"align":"center","className":"italic-serif","style":{"typography":{"fontSize":"0.875rem"},"spacing":{"margin":{"bottom":"2.5rem"}}} -->
    <p class="italic-serif has-text-align-center wp-block-paragraph" style="margin-bottom:2.5rem;font-size:0.875rem">Hand-thrown. One at a time. (回美西后从 WooCommerce 拉真 SKU)</p>
    <!-- /wp:paragraph -->

    <!-- wp:columns {"columns":3,"align":"wide"} -->
    <div class="wp-block-columns alignwide">

        <!-- ROW 1: 3 placeholder cards -->
        <!-- wp:column -->
        <div class="wp-block-column">
            <!-- wp:html -->
            <div class="product-card" style="aspect-ratio:1/1;background:#e8e1d4;display:flex;align-items:center;justify-content:center;">
                <span style="font-family:Georgia,serif;font-style:italic;color:#0e0e0e60;font-size:0.875rem">placeholder · 1/9</span>
            </div>
            <p class="product-card__price" style="text-align:left;margin-top:0.75rem">$ 0</p>
            <p class="italic-serif" style="text-align:left;font-size:0.875rem;margin-top:0.25rem">Tasting cup</p>
            <!-- /wp:html -->
        </div>
        <!-- /wp:column -->

        <!-- wp:column -->
        <div class="wp-block-column">
            <!-- wp:html -->
            <div class="product-card" style="aspect-ratio:1/1;background:#e8e1d4;display:flex;align-items:center;justify-content:center;">
                <span style="font-family:Georgia,serif;font-style:italic;color:#0e0e0e60;font-size:0.875rem">placeholder · 2/9</span>
            </div>
            <p class="product-card__price" style="text-align:left;margin-top:0.75rem">$ 0</p>
            <p class="italic-serif" style="text-align:left;font-size:0.875rem;margin-top:0.25rem">Hand-thrown gaiwan</p>
            <!-- /wp:html -->
        </div>
        <!-- /wp:column -->

        <!-- wp:column -->
        <div class="wp-block-column">
            <!-- wp:html -->
            <div class="product-card" style="aspect-ratio:1/1;background:#e8e1d4;display:flex;align-items:center;justify-content:center;">
                <span style="font-family:Georgia,serif;font-style:italic;color:#0e0e0e60;font-size:0.875rem">placeholder · 3/9</span>
            </div>
            <p class="product-card__price" style="text-align:left;margin-top:0.75rem">$ 0</p>
            <p class="italic-serif" style="text-align:left;font-size:0.875rem;margin-top:0.25rem">Tea scoop</p>
            <!-- /wp:html -->
        </div>
        <!-- /wp:column -->

    </div>
    <!-- /wp:columns -->

    <!-- wp:columns {"columns":3,"align":"wide"} -->
    <div class="wp-block-columns alignwide">

        <!-- wp:column -->
        <div class="wp-block-column">
            <!-- wp:html -->
            <div class="product-card" style="aspect-ratio:1/1;background:#e8e1d4;display:flex;align-items:center;justify-content:center;">
                <span style="font-family:Georgia,serif;font-style:italic;color:#0e0e0e60;font-size:0.875rem">placeholder · 4/9</span>
            </div>
            <p class="product-card__price" style="text-align:left;margin-top:0.75rem">$ 0</p>
            <p class="italic-serif" style="text-align:left;font-size:0.875rem;margin-top:0.25rem">Curator teapot</p>
            <!-- /wp:html -->
        </div>
        <!-- /wp:column -->

        <!-- wp:column -->
        <div class="wp-block-column">
            <!-- wp:html -->
            <div class="product-card" style="aspect-ratio:1/1;background:#e8e1d4;display:flex;align-items:center;justify-content:center;">
                <span style="font-family:Georgia,serif;font-style:italic;color:#0e0e0e60;font-size:0.875rem">placeholder · 5/9</span>
            </div>
            <p class="product-card__price" style="text-align:left;margin-top:0.75rem">$ 0</p>
            <p class="italic-serif" style="text-align:left;font-size:0.875rem;margin-top:0.25rem">Cup + coaster</p>
            <!-- /wp:html -->
        </div>
        <!-- /wp:column -->

        <!-- wp:column -->
        <div class="wp-block-column">
            <!-- wp:html -->
            <div class="product-card" style="aspect-ratio:1/1;background:#e8e1d4;display:flex;align-items:center;justify-content:center;">
                <span style="font-family:Georgia,serif;font-style:italic;color:#0e0e0e60;font-size:0.875rem">placeholder · 6/9</span>
            </div>
            <p class="product-card__price" style="text-align:left;margin-top:0.75rem">$ 0</p>
            <p class="italic-serif" style="text-align:left;font-size:0.875rem;margin-top:0.25rem">Incense holder</p>
            <!-- /wp:html -->
        </div>
        <!-- /wp:column -->

    </div>
    <!-- /wp:columns -->

    <!-- wp:columns {"columns":3,"align":"wide"} -->
    <div class="wp-block-columns alignwide">

        <!-- wp:column -->
        <div class="wp-block-column">
            <!-- wp:html -->
            <div class="product-card" style="aspect-ratio:1/1;background:#e8e1d4;display:flex;align-items:center;justify-content:center;">
                <span style="font-family:Georgia,serif;font-style:italic;color:#0e0e0e60;font-size:0.875rem">placeholder · 7/9</span>
            </div>
            <p class="product-card__price" style="text-align:left;margin-top:0.75rem">$ 0</p>
            <p class="italic-serif" style="text-align:left;font-size:0.875rem;margin-top:0.25rem">Sancai pot</p>
            <!-- /wp:html -->
        </div>
        <!-- /wp:column -->

        <!-- wp:column -->
        <div class="wp-block-column">
            <!-- wp:html -->
            <div class="product-card" style="aspect-ratio:1/1;background:#e8e1d4;display:flex;align-items:center;justify-content:center;">
                <span style="font-family:Georgia,serif;font-style:italic;color:#0e0e0e60;font-size:0.875rem">placeholder · 8/9</span>
            </div>
            <p class="product-card__price" style="text-align:left;margin-top:0.75rem">$ 0</p>
            <p class="italic-serif" style="text-align:left;font-size:0.875rem;margin-top:0.25rem">Tenmoku pair</p>
            <!-- /wp:html -->
        </div>
        <!-- /wp:column -->

        <!-- wp:column -->
        <div class="wp-block-column">
            <!-- wp:html -->
            <div class="product-card" style="aspect-ratio:1/1;background:#e8e1d4;display:flex;align-items:center;justify-content:center;">
                <span style="font-family:Georgia,serif;font-style:italic;color:#0e0e0e60;font-size:0.875rem">placeholder · 9/9</span>
            </div>
            <p class="product-card__price" style="text-align:left;margin-top:0.75rem">$ 0</p>
            <p class="italic-serif" style="text-align:left;font-size:0.875rem;margin-top:0.25rem">Reserve reserve</p>
            <!-- /wp:html -->
        </div>
        <!-- /wp:column -->

    </div>
    <!-- /wp:columns -->

    <!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"},"style":{"spacing":{"margin":{"top":"3rem"}}}} -->
    <div class="wp-block-buttons" style="margin-top:3rem">
        <!-- wp:button {"className":"btn-primary"} -->
        <div class="wp-block-button btn-primary"><a class="wp-block-button__link wp-element-button" href="/shop/">View all</a></div>
        <!-- /wp:button -->
    </div>
    <!-- /wp:buttons -->

</section>
<!-- /wp:group -->
