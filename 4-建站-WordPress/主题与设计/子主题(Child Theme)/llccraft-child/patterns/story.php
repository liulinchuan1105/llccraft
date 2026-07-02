<?php
/**
 * Title:       LLCCRAFT · Brand Story
 * Description: 品牌故事切入 · 600 字衬线粗体标题 + 简介 + Read 链接
 * Category:    llccraft-home
 * Keywords:    llccraft, story, about
 */
?>
<!-- wp:group {"tagName":"section","className":"section-pad","layout":{"type":"constrained"}} -->
<section class="section-pad wp-block-group">

    <!-- wp:columns {"align":"wide","verticalAlignment":"center"} -->
    <div class="wp-block-columns alignwide are-vertically-aligned-center">

        <!-- Left: copy -->
        <!-- wp:column {"width":"60%"} -->
        <div class="wp-block-column" style="flex-basis:60%">

            <!-- wp:paragraph {"className":"italic-serif","style":{"typography":{"fontSize":"0.875rem","letterSpacing":"0.18em"},"spacing":{"margin":{"bottom":"1.5rem"}}} -->
            <p class="italic-serif wp-block-paragraph" style="margin-bottom:1.5rem;font-size:0.875rem;letter-spacing:0.18em;text-transform:uppercase">Our story</p>
            <!-- /wp:paragraph -->

            <!-- wp:heading {"level":2,"className":"text-balance","style":{"typography":{"fontSize":"clamp(2rem, 4vw, 3rem)","letterSpacing":"-0.02em","fontWeight":"500"},"spacing":{"margin":{"bottom":"1.5rem","top":"0"}}} -->
            <h2 class="wp-block-heading text-balance" style="margin-top:0;margin-bottom:1.5rem;font-size:clamp(2rem, 4vw, 3rem);letter-spacing:-0.02em;font-weight:500">千年窑火,<br>加州客厅。</h2>
            <!-- /wp:heading -->

            <!-- wp:paragraph {"style":{"typography":{"fontSize":"1.0625rem","lineHeight":"1.7"},"spacing":{"margin":{"bottom":"1rem"}}} -->
            <p class="wp-block-paragraph" style="margin-bottom:1rem;font-size:1.0625rem;line-height:1.7">Jingdezhen's kilns have fired continuously for a thousand years. We bring that lineage into the living rooms of Los Angeles — one hand-thrown piece at a time.</p>
            <!-- /wp:paragraph -->

            <!-- wp:paragraph {"className":"italic-serif","style":{"typography":{"fontSize":"1.0625rem","lineHeight":"1.7"},"spacing":{"margin":{"bottom":"2rem"}}} -->
            <p class="italic-serif wp-block-paragraph" style="margin-bottom:2rem;font-size:1.0625rem;line-height:1.7">No two pieces are identical. The maker's hand leaves a kiln-recorded trace — a small, deliberate imperfection that mass production cannot replicate.</p>
            <!-- /wp:paragraph -->

            <!-- wp:buttons -->
            <div class="wp-block-buttons">
                <!-- wp:button {"className":"btn-primary"} -->
                <div class="wp-block-button btn-primary"><a class="wp-block-button__link wp-element-button" href="/about/">Read the journey</a></div>
                <!-- /wp:button -->
            </div>
            <!-- /wp:buttons -->
        </div>
        <!-- /wp:column -->

        <!-- Right: visual placeholder · 等回景德镇拍 -->
        <!-- wp:column {"width":"40%","verticalAlignment":"center"} -->
        <div class="wp-block-column is-vertically-aligned-center" style="flex-basis:40%">

            <!-- wp:html -->
            <div style="aspect-ratio:4/5;background:#e8e1d4;display:flex;align-items:center;justify-content:center;">
                <span style="font-family:Georgia,serif;font-style:italic;font-size:0.875rem;color:#0e0e0e80;letter-spacing:0.18em;text-transform:uppercase;text-align:center;padding:2rem">
                    Studio photo<br>placeholder<br>(待景德镇回填)
                </span>
            </div>
            <!-- /wp:html -->
        </div>
        <!-- /wp:column -->

    </div>
    <!-- /wp:columns -->

</section>
<!-- /wp:group -->
