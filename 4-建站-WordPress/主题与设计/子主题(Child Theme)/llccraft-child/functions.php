<?php
/**
 * llccraft Child Theme functions
 *
 * @package llccraft-Child
 * @since   0.1.0
 *
 * 这是唯一可改主题层,基于 WooCommerce 官方父主题 Storefront。
 * 父主题升级时本文件不受影响,所有定制锁死在这里。
 *
 * Phase 2 升级:
 *   - enqueue Vite-built `build/main.css`
 *   - register 6 个 Gutenberg Block Patterns (Phase 2 v0.1: 首页 3 套)
 *   - 后续:更多 patterns,见 ./patterns/ 目录
 */

if ( ! defined( 'ABSPATH' ) ) {
    exit;
}

/* -----------------------------------------------------------------------------
 * 1. 加载父主题 stylesheet + 子主题 vite-built main.css
 * -------------------------------------------------------------------------- */

/**
 * Compute the file mtime so we can bust caches.
 */
function llccraft_child_asset_version( $relative ) {
    $path = get_stylesheet_directory() . $relative;
    return file_exists( $path ) ? (string) filemtime( $path ) : '0.1.0';
}

add_action( 'wp_enqueue_scripts', 'llccraft_child_enqueue_styles', 20 );
function llccraft_child_enqueue_styles() {
    // 父主题 Storefront
    wp_enqueue_style(
        'storefront-style',
        get_template_directory_uri() . '/style.css',
        array(),
        wp_get_theme( 'storefront' )->get( 'Version' )
    );

    // 子主题 vite-built main.css(仅在 prod 存在)
    $main_css = '/build/assets/main.css';
    if ( file_exists( get_stylesheet_directory() . $main_css ) ) {
        wp_enqueue_style(
            'llccraft-child-main',
            get_stylesheet_directory_uri() . $main_css,
            array( 'storefront-style' ),
            llccraft_child_asset_version( $main_css )
        );
    }
}

/* -----------------------------------------------------------------------------
 * 2. 注册 Gutenberg Block Patterns (Phase 2 v0.1: 首页 3 套)
 *    路径:./patterns/hero.php · ./patterns/three-tiers.php · ./patterns/story.php · ./patterns/grid.php
 *    后续更多 pattern 落 ./patterns/ 即可
 * -------------------------------------------------------------------------- */
add_action( 'init', 'llccraft_child_register_block_patterns' );
function llccraft_child_register_block_patterns() {
    if ( ! function_exists( 'register_block_pattern' ) ) {
        return; // 老 WP 不支持
    }

    $pattern_dir = get_stylesheet_directory() . '/patterns';
    if ( ! is_dir( $pattern_dir ) ) {
        return;
    }

    $pattern_categories = array(
        'llccraft-home' => array(
            'label'       => __( 'LLCCRAFT · Home', 'llccraft-child' ),
            'description' => __( '首页专用 pattern', 'llccraft-child' ),
        ),
    );
    foreach ( $pattern_categories as $name => $args ) {
        if ( function_exists( 'register_block_pattern_category' ) ) {
            register_block_pattern_category( $name, $args );
        }
    }

    foreach ( glob( $pattern_dir . '/*.php' ) as $file ) {
        $slug  = 'llccraft-' . basename( $file, '.php' );
        $title = ucwords( str_replace( '-', ' ', basename( $file, '.php' ) ) );
        ob_start();
        include $file;
        $content = (string) ob_get_clean();
        if ( trim( $content ) === '' ) {
            continue;
        }
        register_block_pattern(
            $slug,
            array(
                'title'       => __( $title, 'llccraft-child' ),
                'description' => __( "LLCCRAFT 首页 pattern: $title", 'llccraft-child' ),
                'content'     => $content,
                'categories'  => array( 'llccraft-home' ),
                'keywords'    => array( 'llccraft', 'home' ),
            )
        );
    }
}

/* -----------------------------------------------------------------------------
 * 3. 注册 Patterns 目录(让 Gutenberg 编辑器能识别)
 *    让 WP 知道在哪里找 pattern HTML block markup
 * -------------------------------------------------------------------------- */
add_action( 'init', 'llccraft_child_register_pattern_categories_meta' );
function llccraft_child_register_pattern_categories_meta() {
    if ( function_exists( 'register_theme_feature' ) ) {
        register_theme_feature( 'llccraft-block-patterns' );
    }
}

/* -----------------------------------------------------------------------------
 * 4. (Phase 3 占位) WooCommerce template overrides
 * -------------------------------------------------------------------------- */
// add_filter( 'woocommerce_product_single_add_to_cart_text', ... );
// add_filter( 'woocommerce_add_to_cart_fragments', ... );
