<?php
/**
 * The main template file (fallback for archives / singular when no better match).
 *
 * 子主题惯例:保持空,fall back to parent theme.
 * 如果你想自定义,可在父主题模板之前用更高优先级 template_include filter 拦截。
 *
 * @package llccraft-Child
 */

get_header();
?>

<section class="llccraft-child-fallback">
    <?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
        <article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
            <h2 class="entry-title"><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h2>
            <div class="entry-summary"><?php the_excerpt(); ?></div>
        </article>
    <?php endwhile; endif; ?>
</section>

<?php
get_footer();
