<?php
$data["demo_session_id"] = 'fd_3';
$data["path"] = '/home/pjabbers/public_html/source/fd_3/';
$data["url"] = 'http://demo.phpjabbers.com/source/fd_3/';
$data["lid"] = array('1','2','3','4','5');

$data["preview_file"] = "preview.php";


$data["mysql_database"] = "pjabbers_demo_fd_3";

$drop_create = "DROP TABLE IF EXISTS `food_delivery_categories`;
CREATE TABLE IF NOT EXISTS `food_delivery_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order` int(10) unsigned DEFAULT NULL,
  `status` enum('T','F') NOT NULL DEFAULT 'T',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `food_delivery_clients`;
CREATE TABLE IF NOT EXISTS `food_delivery_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `foreign_id` int(10) unsigned DEFAULT NULL,
  `c_title` varchar(255) DEFAULT NULL,
  `c_company` varchar(255) DEFAULT NULL,
  `c_address_1` varchar(255) DEFAULT NULL,
  `c_address_2` varchar(255) DEFAULT NULL,
  `c_country` varchar(255) DEFAULT NULL,
  `c_state` varchar(255) DEFAULT NULL,
  `c_city` varchar(255) DEFAULT NULL,
  `c_zip` varchar(255) DEFAULT NULL,
  `c_notes` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `food_delivery_dates`;
CREATE TABLE IF NOT EXISTS `food_delivery_dates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `location_id` int(10) unsigned DEFAULT NULL,
  `type` enum('pickup','delivery') DEFAULT NULL,
  `date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `is_dayoff` enum('T','F') DEFAULT 'F',
  PRIMARY KEY (`id`),
  UNIQUE KEY `location_id` (`location_id`,`type`,`date`),
  KEY `is_dayoff` (`is_dayoff`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_extras`;
CREATE TABLE IF NOT EXISTS `food_delivery_extras` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `price` decimal(9,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_locations`;
CREATE TABLE IF NOT EXISTS `food_delivery_locations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lat` float(10,6) DEFAULT NULL,
  `lng` float(10,6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_locations_coords`;
CREATE TABLE IF NOT EXISTS `food_delivery_locations_coords` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `location_id` int(10) unsigned DEFAULT NULL,
  `type` enum('circle','polygon','rectangle') DEFAULT NULL,
  `data` text,
  PRIMARY KEY (`id`),
  KEY `location_id` (`location_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_notifications`;
CREATE TABLE IF NOT EXISTS `food_delivery_notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `recipient` enum('client','admin') DEFAULT NULL,
  `transport` enum('email','sms') DEFAULT NULL,
  `variant` varchar(30) DEFAULT NULL,
  `is_active` tinyint(1) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `recipient` (`recipient`,`transport`,`variant`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_options`;
CREATE TABLE IF NOT EXISTS `food_delivery_options` (
  `foreign_id` int(10) unsigned NOT NULL DEFAULT '0',
  `key` varchar(255) NOT NULL DEFAULT '',
  `tab_id` tinyint(3) unsigned DEFAULT NULL,
  `value` text,
  `label` text,
  `type` enum('string','text','int','float','enum','bool') NOT NULL DEFAULT 'string',
  `order` int(10) unsigned DEFAULT NULL,
  `is_visible` tinyint(1) unsigned DEFAULT '1',
  `style` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`foreign_id`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_orders`;
CREATE TABLE IF NOT EXISTS `food_delivery_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` int(10) unsigned DEFAULT NULL,
  `client_id` int(10) unsigned DEFAULT NULL,
  `location_id` int(10) unsigned DEFAULT NULL,
  `locale_id` int(10) DEFAULT NULL,
  `type` enum('pickup','delivery') DEFAULT NULL,
  `status` enum('pending','confirmed','cancelled') DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `is_paid` tinyint(1) unsigned DEFAULT '0',
  `txn_id` varchar(255) DEFAULT NULL,
  `processed_on` datetime DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `price` decimal(9,2) unsigned DEFAULT NULL,
  `price_delivery` decimal(9,2) unsigned DEFAULT NULL,
  `discount` decimal(9,2) unsigned DEFAULT NULL,
  `subtotal` decimal(9,2) unsigned DEFAULT NULL,
  `tax` decimal(9,2) unsigned DEFAULT NULL,
  `total` decimal(9,2) unsigned DEFAULT NULL,
  `voucher_code` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `p_dt` datetime DEFAULT NULL,
  `p_asap` enum('T','F') DEFAULT 'F',
  `p_notes` text,
  `d_address_1` varchar(255) DEFAULT NULL,
  `d_address_2` varchar(255) DEFAULT NULL,
  `d_country_id` int(10) unsigned DEFAULT NULL,
  `d_state` varchar(255) DEFAULT NULL,
  `d_city` varchar(255) DEFAULT NULL,
  `d_zip` varchar(255) DEFAULT NULL,
  `d_notes` text,
  `d_dt` datetime DEFAULT NULL,
  `d_asap` enum('T','F') DEFAULT 'F',
  `cc_type` blob,
  `cc_num` blob,
  `cc_code` blob,
  `cc_exp` blob,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `location_id` (`location_id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_orders_items`;
CREATE TABLE IF NOT EXISTS `food_delivery_orders_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `foreign_id` int(10) unsigned DEFAULT NULL,
  `type` enum('product','extra') DEFAULT NULL,
  `hash` varchar(32) DEFAULT NULL,
  `price_id` int(10) unsigned DEFAULT NULL,
  `price` decimal(9,2) unsigned DEFAULT NULL,
  `cnt` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `foreign_id` (`foreign_id`),
  KEY `price_id` (`price_id`),
  KEY `type` (`type`),
  KEY `hash` (`hash`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_orders_payments`;
CREATE TABLE IF NOT EXISTS `food_delivery_orders_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `payment_method` enum('paypal','authorize','creditcard','bank','cash') DEFAULT NULL,
  `payment_type` varchar(255) DEFAULT NULL,
  `amount` decimal(9,2) unsigned DEFAULT NULL,
  `status` enum('paid','notpaid') DEFAULT 'paid',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_auth_login_attempts`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_auth_login_attempts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_auth_permissions`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_auth_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `inherit_id` int(10) unsigned DEFAULT NULL,
  `key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_auth_roles`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_auth_roles` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `role` varchar(255) DEFAULT NULL,
  `is_backend` enum('T','F') NOT NULL DEFAULT 'T',
  `status` enum('T','F') NOT NULL DEFAULT 'T',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_auth_roles_permissions`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_auth_roles_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL,
  `permission_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_id` (`role_id`,`permission_id`),
  KEY `permission_id` (`permission_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_auth_users`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_auth_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` blob,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `pswd_modified` datetime DEFAULT NULL,
  `status` enum('T','F') NOT NULL DEFAULT 'T',
  `is_active` enum('T','F') NOT NULL DEFAULT 'F',
  `locked` enum('T','F') NOT NULL DEFAULT 'F',
  `login_token` varchar(255) DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `role_id` (`role_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_auth_users_permissions`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_auth_users_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `permission_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `permission_id` (`permission_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_base_countries`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_base_countries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `alpha_2` varchar(2) DEFAULT NULL,
  `alpha_3` varchar(3) DEFAULT NULL,
  `status` enum('T','F') NOT NULL DEFAULT 'T',
  PRIMARY KEY (`id`),
  UNIQUE KEY `alpha_2` (`alpha_2`),
  UNIQUE KEY `alpha_3` (`alpha_3`),
  KEY `status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_base_cron_jobs`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_base_cron_jobs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `controller` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `interval` int(11) DEFAULT NULL,
  `period` enum('minute','hour','day','week','month') DEFAULT 'hour',
  `next_run` datetime DEFAULT NULL,
  `last_run` datetime DEFAULT NULL,
  `status` text,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `controller_action` (`controller`,`action`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_base_currencies`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_base_currencies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(10) DEFAULT NULL,
  `sign` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_base_fields`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_base_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) DEFAULT NULL,
  `type` enum('backend','frontend','arrays') DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `source` enum('script','plugin') DEFAULT 'script',
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_base_locale`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_base_locale` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language_iso` varchar(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `flag` varchar(255) DEFAULT NULL,
  `dir` enum('ltr','rtl') DEFAULT 'ltr',
  `sort` int(10) unsigned DEFAULT NULL,
  `is_default` tinyint(1) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `language_iso` (`language_iso`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_base_locale_languages`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_base_locale_languages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iso` varchar(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `native` varchar(255) DEFAULT NULL,
  `dir` enum('ltr','rtl') DEFAULT 'ltr',
  `country_abbr` varchar(3) DEFAULT NULL,
  `language_abbr` varchar(3) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `iso` (`iso`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_base_log`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_base_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) DEFAULT NULL,
  `function` varchar(255) DEFAULT NULL,
  `value` text,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_base_log_config`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_base_log_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_base_multi_lang`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_base_multi_lang` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `foreign_id` int(10) unsigned DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `locale` tinyint(3) unsigned DEFAULT NULL,
  `field` varchar(50) DEFAULT NULL,
  `content` text,
  `source` enum('script','plugin','data') DEFAULT 'script',
  PRIMARY KEY (`id`),
  UNIQUE KEY `foreign_id` (`foreign_id`,`model`,`locale`,`field`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_base_options`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_base_options` (
  `foreign_id` int(10) unsigned NOT NULL DEFAULT '0',
  `key` varchar(255) NOT NULL DEFAULT '',
  `tab_id` tinyint(3) unsigned DEFAULT NULL,
  `value` text,
  `label` text,
  `type` enum('string','text','int','float','enum','bool') NOT NULL DEFAULT 'string',
  `order` int(10) unsigned DEFAULT NULL,
  `is_visible` tinyint(1) unsigned DEFAULT '1',
  `style` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`foreign_id`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_base_sms`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_base_sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` varchar(255) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_mollie`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_mollie` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `foreign_id` int(10) unsigned DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `amount` decimal(9,2) unsigned DEFAULT NULL,
  `txn_id` varchar(255) DEFAULT NULL,
  `ref_id` varchar(255) DEFAULT NULL,
  `bank_id` varchar(255) DEFAULT NULL,
  `processed_on` datetime DEFAULT NULL,
  `status` enum('paid','notpaid') DEFAULT 'notpaid',
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `foreign_id` (`foreign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_mollie_options`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_mollie_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `foreign_id` int(10) unsigned DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `foreign_id` (`foreign_id`,`method`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_payment_options`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_payment_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `foreign_id` int(10) unsigned DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `merchant_id` varchar(255) DEFAULT NULL,
  `merchant_email` varchar(255) DEFAULT NULL,
  `public_key` varchar(255) DEFAULT NULL,
  `private_key` varchar(255) DEFAULT NULL,
  `tz` varchar(255) DEFAULT NULL,
  `success_url` varchar(255) DEFAULT NULL,
  `failure_url` varchar(255) DEFAULT NULL,
  `description` text,
  `is_active` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `foreign_id` (`foreign_id`,`payment_method`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_paypal`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_paypal` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `foreign_id` int(10) unsigned DEFAULT NULL,
  `subscr_id` varchar(25) DEFAULT NULL,
  `txn_id` varchar(25) DEFAULT NULL,
  `txn_type` varchar(50) DEFAULT NULL,
  `mc_gross` decimal(9,2) unsigned DEFAULT NULL,
  `mc_currency` varchar(3) DEFAULT NULL,
  `payer_email` varchar(255) DEFAULT NULL,
  `dt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fid` (`foreign_id`,`subscr_id`,`txn_id`,`txn_type`),
  UNIQUE KEY `txn_id` (`txn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_stripe`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_stripe` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `foreign_id` int(10) unsigned DEFAULT NULL,
  `stripe_id` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `amount` decimal(9,2) unsigned DEFAULT NULL,
  `currency` varchar(3) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `foreign_id` (`foreign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_plugin_vouchers`;
CREATE TABLE IF NOT EXISTS `food_delivery_plugin_vouchers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `type` enum('amount','percent') DEFAULT NULL,
  `discount` decimal(9,2) unsigned DEFAULT NULL,
  `valid` enum('fixed','period','recurring') DEFAULT NULL,
  `date_from` date DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  `time_from` time DEFAULT NULL,
  `time_to` time DEFAULT NULL,
  `every` enum('monday','tuesday','wednesday','thursday','friday','saturday','sunday') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_prices`;
CREATE TABLE IF NOT EXISTS `food_delivery_prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `location_id` int(10) unsigned DEFAULT NULL,
  `total_from` decimal(9,2) unsigned DEFAULT NULL,
  `total_to` decimal(9,2) unsigned DEFAULT NULL,
  `price` decimal(9,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location_id` (`location_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_products`;
CREATE TABLE IF NOT EXISTS `food_delivery_products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `set_different_sizes` enum('T','F') DEFAULT 'F',
  `price` decimal(9,2) unsigned DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_featured` tinyint(1) unsigned DEFAULT '0',
  `order` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_products_categories`;
CREATE TABLE IF NOT EXISTS `food_delivery_products_categories` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_products_extras`;
CREATE TABLE IF NOT EXISTS `food_delivery_products_extras` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0',
  `extra_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_id`,`extra_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_products_prices`;
CREATE TABLE IF NOT EXISTS `food_delivery_products_prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned DEFAULT NULL,
  `price` decimal(9,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_vouchers`;
CREATE TABLE IF NOT EXISTS `food_delivery_vouchers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(100) DEFAULT NULL,
  `type` enum('amount','percent') DEFAULT NULL,
  `discount` decimal(9,2) unsigned DEFAULT NULL,
  `valid` enum('fixed','period','recurring') DEFAULT NULL,
  `date_from` date DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  `time_from` time DEFAULT NULL,
  `time_to` time DEFAULT NULL,
  `every` enum('monday','tuesday','wednesday','thursday','friday','saturday','sunday') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_working_times`;
CREATE TABLE IF NOT EXISTS `food_delivery_working_times` (
  `location_id` int(10) unsigned NOT NULL DEFAULT '0',
  `p_monday_from` time DEFAULT NULL,
  `p_monday_to` time DEFAULT NULL,
  `p_monday_dayoff` enum('T','F') DEFAULT 'F',
  `p_tuesday_from` time DEFAULT NULL,
  `p_tuesday_to` time DEFAULT NULL,
  `p_tuesday_dayoff` enum('T','F') DEFAULT 'F',
  `p_wednesday_from` time DEFAULT NULL,
  `p_wednesday_to` time DEFAULT NULL,
  `p_wednesday_dayoff` enum('T','F') DEFAULT 'F',
  `p_thursday_from` time DEFAULT NULL,
  `p_thursday_to` time DEFAULT NULL,
  `p_thursday_dayoff` enum('T','F') DEFAULT 'F',
  `p_friday_from` time DEFAULT NULL,
  `p_friday_to` time DEFAULT NULL,
  `p_friday_dayoff` enum('T','F') DEFAULT 'F',
  `p_saturday_from` time DEFAULT NULL,
  `p_saturday_to` time DEFAULT NULL,
  `p_saturday_dayoff` enum('T','F') DEFAULT 'F',
  `p_sunday_from` time DEFAULT NULL,
  `p_sunday_to` time DEFAULT NULL,
  `p_sunday_dayoff` enum('T','F') DEFAULT 'F',
  `d_monday_from` time DEFAULT NULL,
  `d_monday_to` time DEFAULT NULL,
  `d_monday_dayoff` enum('T','F') DEFAULT 'F',
  `d_tuesday_from` time DEFAULT NULL,
  `d_tuesday_to` time DEFAULT NULL,
  `d_tuesday_dayoff` enum('T','F') DEFAULT 'F',
  `d_wednesday_from` time DEFAULT NULL,
  `d_wednesday_to` time DEFAULT NULL,
  `d_wednesday_dayoff` enum('T','F') DEFAULT 'F',
  `d_thursday_from` time DEFAULT NULL,
  `d_thursday_to` time DEFAULT NULL,
  `d_thursday_dayoff` enum('T','F') DEFAULT 'F',
  `d_friday_from` time DEFAULT NULL,
  `d_friday_to` time DEFAULT NULL,
  `d_friday_dayoff` enum('T','F') DEFAULT 'F',
  `d_saturday_from` time DEFAULT NULL,
  `d_saturday_to` time DEFAULT NULL,
  `d_saturday_dayoff` enum('T','F') DEFAULT 'F',
  `d_sunday_from` time DEFAULT NULL,
  `d_sunday_to` time DEFAULT NULL,
  `d_sunday_dayoff` enum('T','F') DEFAULT 'F',
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;";

?>