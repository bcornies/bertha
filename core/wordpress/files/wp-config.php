<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', '@DB_NAME@');

/** MySQL database username */
define('DB_USER', '@DB_USER@');

/** MySQL database password */
define('DB_PASSWORD', '@DB_PASSWORD@');

/** MySQL hostname */
define('DB_HOST', '@DB_HOST@');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'mD[SrV99.?y847B,Unej;A^/X3:*?MK(Hs+xs&E)8-t!nx}?P:_yicl&V`3#j.29');
define('SECURE_AUTH_KEY',  'fF_LqZ&_Tx@]^cek&}$,Lo?}LQ>Sz.oM}rJ>Dnlry&ssK<H9wO{3Ydg9)g@g$9? ');
define('LOGGED_IN_KEY',    'SKp]cF[bZf)u~Cm>h0X`6n*2=G>B5qc&0DQ|u$%fHBaPZJmN@OTrR^~G:S0?f?_/');
define('NONCE_KEY',        'r:91|.j#Vx*X@3!kJW~t;@/a$}OY5PIs9:k9Dx5!~A$%A=!EH2gS]8$qFz0FUO[y');
define('AUTH_SALT',        '(a:x+urv:l7i6C,;B05s|lXf6-P^jSL-|9NJ9&(R0E_u#SigVH_]`.B4;;3+*Gfx');
define('SECURE_AUTH_SALT', '0y68>CQw(XfNb4,]6P5L&=Hn86{@%j8M &.f8erZj<{HZ8bR`aRoQcG/%RZP3A8Z');
define('LOGGED_IN_SALT',   '>R|k#z`PYgrz#CR/2mUu6vI8fKQWe{JbFOvtjXKPF,_({-}O[Fp^ipbY7Jq#-]5>');
define('NONCE_SALT',       'I?w@|<IQJdB|}i{U!l*M]aV-Fl,f[lZ,I[VrLC/Rfz}sn#QA_oProYU&B[jW|vV^');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = '@TABLE_PREFIX@';

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German
 * language support.
 */
define('WPLANG', '');

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
