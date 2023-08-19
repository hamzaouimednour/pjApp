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

DROP TABLE IF EXISTS `food_delivery_orders`;
CREATE TABLE IF NOT EXISTS `food_delivery_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` int(10) unsigned DEFAULT NULL,
  `client_id` int(10) unsigned DEFAULT NULL,
  `location_id` int(10) unsigned DEFAULT NULL,
  `locale_id` int(10) DEFAULT NULL,
  `type` enum('pickup','delivery') DEFAULT NULL,
  `status` enum('pending','confirmed','cancelled') DEFAULT NULL,
  `payment_method` VARCHAR(255) DEFAULT NULL,
  `is_paid` tinyint(1) unsigned DEFAULT '0',
  `txn_id` varchar(255) DEFAULT NULL,
  `processed_on` datetime DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `price` decimal(9,2) unsigned DEFAULT NULL,
  `price_delivery` decimal(9,2) unsigned DEFAULT NULL,
  `discount` decimal(9,2) unsigned DEFAULT NULL,
  `subtotal` decimal(9,2) unsigned DEFAULT NULL,
  `tax` decimal(9,2) unsigned default NULL,
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
  `id` int(10) unsigned NOT NULL auto_increment,
  `order_id` int(10) unsigned default NULL,
  `payment_method` enum('paypal','authorize','creditcard','bank','cash') DEFAULT NULL,
  `payment_type` varchar(255) DEFAULT NULL,
  `amount` decimal(9,2) unsigned DEFAULT NULL,
  `status` enum('paid','notpaid') DEFAULT 'paid',
  PRIMARY KEY  (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

DROP TABLE IF EXISTS `food_delivery_products_prices`;
CREATE TABLE IF NOT EXISTS `food_delivery_products_prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,	
  `product_id` int(10) unsigned DEFAULT NULL,
  `price` decimal(9,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_extras`;
CREATE TABLE IF NOT EXISTS `food_delivery_extras` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `price` decimal(9,2) unsigned DEFAULT NULL,
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

DROP TABLE IF EXISTS `food_delivery_locations`;
CREATE TABLE IF NOT EXISTS `food_delivery_locations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lat` float(10,6) DEFAULT NULL,
  `lng` float(10,6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `food_delivery_categories`;
CREATE TABLE IF NOT EXISTS `food_delivery_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order` int(10) unsigned DEFAULT NULL,
  `status` enum('T','F') NOT NULL DEFAULT 'T',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

INSERT IGNORE INTO `food_delivery_notifications` (`id`, `recipient`, `transport`, `variant`, `is_active`) VALUES
(1, 'client', 'email', 'confirmation', 1),
(2, 'client', 'email', 'payment', 1),
(3, 'client', 'email', 'account', 1),
(4, 'client', 'email', 'cancel', 1),
(5, 'client', 'sms', 'confirmation', 1),
(6, 'admin', 'email', 'confirmation', 1),
(7, 'admin', 'email', 'payment', 1),
(8, 'admin', 'email', 'cancel', 1),
(9, 'admin', 'sms', 'confirmation', 1),
(10, 'admin', 'sms', 'payment', 1),
(11, 'client', 'email', 'forgot', 1);

INSERT INTO `food_delivery_options` (`foreign_id`, `key`, `tab_id`, `value`, `label`, `type`, `order`, `is_visible`, `style`) VALUES
(1, 'o_minimum_order', 2, '0.00', NULL, 'int', 2, 1, NULL),
(1, 'o_tax_payment', 2, '10.00', NULL, 'int', 4, 1, NULL),
(1, 'o_booking_status', 2, 'confirmed|pending|cancelled::pending', 'Confirmed|Pending|Cancelled', 'enum', 5, 1, NULL),
(1, 'o_payment_status', 2, 'confirmed|pending|cancelled::confirmed', 'Confirmed|Pending|Cancelled', 'enum', 6, 1, NULL),
(1, 'o_thankyou_page', 2, 'http://www.phpjabbers.com', NULL, 'string', 8, 1, NULL),
(1, 'o_payment_disable', 2, 'Yes|No::No', 'Yes|No', 'enum', 9, 1, NULL),
(1, 'o_allow_paypal', 2, 'Yes|No::Yes', 'Yes|No', 'enum', 10, 1, NULL),
(1, 'o_paypal_address', 2, 'paypal@domain.com', NULL, 'string', 11, 1, NULL),
(1, 'o_allow_authorize', 2, 'Yes|No::No', 'Yes|No', 'enum', 12, 1, NULL),
(1, 'o_authorize_transkey', 2, '', NULL, 'string', 13, 1, NULL),
(1, 'o_authorize_merchant_id', 2, '', NULL, 'string', 14, 1, NULL),
(1, 'o_authorize_timezone', 2, '-43200|-39600|-36000|-32400|-28800|-25200|-21600|-18000|-14400|-10800|-7200|-3600|0|3600|7200|10800|14400|18000|21600|25200|28800|32400|36000|39600|43200|46800::0', 'GMT-12:00|GMT-11:00|GMT-10:00|GMT-09:00|GMT-08:00|GMT-07:00|GMT-06:00|GMT-05:00|GMT-04:00|GMT-03:00|GMT-02:00|GMT-01:00|GMT|GMT+01:00|GMT+02:00|GMT+03:00|GMT+04:00|GMT+05:00|GMT+06:00|GMT+07:00|GMT+08:00|GMT+09:00|GMT+10:00|GMT+11:00|GMT+12:00|GMT+13:00', 'enum', 15, 1, NULL),
(1, 'o_authorize_md5_hash', 2, NULL, NULL, 'string', 16, 1, NULL),
(1, 'o_allow_cash', 2, 'Yes|No::Yes', 'Yes|No', 'enum', 17, 1, NULL),
(1, 'o_allow_creditcard', 2, 'Yes|No::Yes', 'Yes|No', 'enum', 18, 1, NULL),
(1, 'o_allow_bank', 2, 'Yes|No::No', NULL, 'enum', 19, 1, NULL),
(1, 'o_bank_account', 2, NULL, NULL, 'text', 20, 1, NULL),

(1, 'o_bf_include_title', 4, '1|2|3::3', 'No|Yes|Yes (required)', 'enum', 1, 1, NULL),
(1, 'o_bf_include_name', 4, '1|2|3::3', 'No|Yes|Yes (required)', 'enum', 2, 1, NULL),
(1, 'o_bf_include_phone', 4, '1|2|3::3', 'No|Yes|Yes (required)', 'enum', 4, 1, NULL),
(1, 'o_bf_include_email', 4, '1|2|3::3', 'No|Yes|Yes (required)', 'enum', 5, 0, NULL),
(1, 'o_bf_include_company', 4, '1|2|3::1', 'No|Yes|Yes (required)', 'enum', 6, 1, NULL),
(1, 'o_bf_include_address_1', 4, '1|2|3::1', 'No|Yes|Yes (required)', 'enum', 7, 1, NULL),
(1, 'o_bf_include_address_2', 4, '1|2|3::1', 'No|Yes|Yes (required)', 'enum', 8, 1, NULL),
(1, 'o_bf_include_notes', 4, '1|2|3::1', 'No|Yes|Yes (required)', 'enum', 9, 1, NULL),
(1, 'o_bf_include_city', 4, '1|2|3::1', 'No|Yes|Yes (required)', 'enum', 10, 1, NULL),
(1, 'o_bf_include_state', 4, '1|2|3::1', 'No|Yes|Yes (required)', 'enum', 11, 1, NULL),
(1, 'o_bf_include_zip', 4, '1|2|3::1', 'No|Yes|Yes (required)', 'enum', 12, 1, NULL),
(1, 'o_bf_include_country', 4, '1|2|3::1', 'No|Yes|Yes (required)', 'enum', 13, 1, NULL),
(1, 'o_bf_include_captcha', 4, '1|2|3::3', 'No|Yes|Yes (required)', 'enum', 14, 1, NULL),

(1, 'o_pf_include_notes', 4, '1|2|3::3', 'No|Yes|Yes (required)', 'enum', 15, 1, NULL),

(1, 'o_terms', 5, '', NULL, 'text', 1, 1, NULL),

(1, 'o_df_include_address_1', 6, '1|2|3::3', 'No|Yes|Yes (required)', 'enum', 1, 1, NULL),
(1, 'o_df_include_address_2', 6, '1|2|3::3', 'No|Yes|Yes (required)', 'enum', 2, 1, NULL),
(1, 'o_df_include_city', 6, '1|2|3::3', 'No|Yes|Yes (required)', 'enum', 3, 1, NULL),
(1, 'o_df_include_country', 6, '1|2|3::3', 'No|Yes|Yes (required)', 'enum', 4, 1, NULL),
(1, 'o_df_include_notes', 6, '1|2|3::3', 'No|Yes|Yes (required)', 'enum', 5, 1, NULL),
(1, 'o_df_include_state', 6, '1|2|3::1', 'No|Yes|Yes (required)', 'enum', 6, 1, NULL),
(1, 'o_df_include_zip', 6, '1|2|3::1', 'No|Yes|Yes (required)', 'enum', 7, 1, NULL),

(1, 'o_print_order', 7, '', NULL, 'text', 1, 1, NULL),

(1, 'o_theme', 99, 'theme1|theme2|theme3|theme4|theme5|theme6|theme7|theme8|theme9|theme10::theme1', 'Theme 1|Theme 2|Theme 3|Theme 4|Theme 5|Theme 6|Theme 7|Theme 8|Theme 9|Theme 10', 'enum', NULL, '0', NULL),
(1, 'o_add_tax', 99, '1|0::1', NULL, 'enum', NULL, 0, NULL),
(1, 'o_multi_lang', 99, '1|0::1', NULL, 'enum', NULL, 0, NULL),
(1, 'o_fields_index', 99, 'd874fcc5fe73b90d770a544664a3775d', NULL, 'string', NULL, 0, NULL);

INSERT INTO `food_delivery_plugin_base_cron_jobs` (`name`, `controller`, `action`, `interval`, `period`, `is_active`) VALUES
('Create automatic back-ups for database and files', 'pjBaseBackup', 'pjActionAutoBackup', 1, 'week', 1);
UPDATE `food_delivery_plugin_base_options` SET `value`='Yes|No::Yes' WHERE `key`='o_auto_backup';

INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdmin_pjActionIndex');
INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdminOrders');
SET @level_1_id := (SELECT LAST_INSERT_ID());

  INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjAdminOrders_pjActionIndex');
  SET @level_2_id := (SELECT LAST_INSERT_ID());

    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminOrders_pjActionCreate');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminOrders_pjActionUpdate');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminOrders_pjActionDeleteOrder');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminOrders_pjActionDeleteOrderBulk');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminOrders_pjActionExportOrder');
    
INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdminClients');
SET @level_1_id := (SELECT LAST_INSERT_ID());

  INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjAdminClients_pjActionIndex');
  SET @level_2_id := (SELECT LAST_INSERT_ID());

    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminClients_pjActionCreate');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminClients_pjActionUpdate');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminClients_pjActionDeleteClient');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminClients_pjActionDeleteClientBulk');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminClients_pjActionStatusClient'); 
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminClients_pjActionExportClient');


INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdminProducts');
SET @level_1_id := (SELECT LAST_INSERT_ID());

  INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjAdminProducts_pjActionIndex');
  SET @level_2_id := (SELECT LAST_INSERT_ID());

    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminProducts_pjActionCreate');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminProducts_pjActionUpdate');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminProducts_pjActionDeleteProduct');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminProducts_pjActionDeleteProductBulk');
    
INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdminCategories');
SET @level_1_id := (SELECT LAST_INSERT_ID());

  INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjAdminCategories_pjActionIndex');
  SET @level_2_id := (SELECT LAST_INSERT_ID());
  
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminCategories_pjActionCreateForm');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminCategories_pjActionUpdateForm');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminCategories_pjActionDeleteCategory');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminCategories_pjActionDeleteCategoryBulk');
    
INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdminExtras');
SET @level_1_id := (SELECT LAST_INSERT_ID());

  INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjAdminExtras_pjActionIndex');
  SET @level_2_id := (SELECT LAST_INSERT_ID());

    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminExtras_pjActionCreateForm');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminExtras_pjActionUpdateForm');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminExtras_pjActionDeleteExtra');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminExtras_pjActionDeleteExtraBulk');
    
INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdminLocations');
SET @level_1_id := (SELECT LAST_INSERT_ID());

  INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjAdminLocations_pjActionIndex');
  SET @level_2_id := (SELECT LAST_INSERT_ID());

    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminLocations_pjActionCreate');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminLocations_pjActionUpdate');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminLocations_pjActionDeleteLocation');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminLocations_pjActionDeleteLocationBulk'); 
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminTime_pjActionIndex');
    INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminLocations_pjActionPrice');

INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdminReports_pjActionIndex');
    
INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdminOptions');
SET @level_1_id := (SELECT LAST_INSERT_ID());

  INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjAdminOptions_pjActionOrders'); 
  INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjAdminOptions_pjActionPayments');
  INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjAdminOptions_pjActionOrderForm'); 
  INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjAdminOptions_pjActionTerm');
  INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjAdminOptions_pjActionNotifications');
  INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjAdminOptions_pjActionPrintOrder');
  
INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdminOptions_pjActionPreview');
INSERT INTO `food_delivery_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdminOptions_pjActionInstall');

INSERT INTO `food_delivery_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, 1, 'pjPayment', 1, 'creditcard', 'Credit Card', 'script'),
(NULL, 1, 'pjPayment', 1, 'cash', 'Cash', 'script'),
(NULL, 1, 'pjPayment', 1, 'bank', 'Bank Account', 'script');

INSERT INTO `food_delivery_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, 1, 'pjOption', 1, 'o_print_order', '<p>Personal details:<br />Name: {Name}<br />E-Mail: {Email}<br />Phone: {Phone}<br />Notes: {Notes}<br />Country: {Country}<br />City: {City}<br />State: {State}<br />Zip: {Zip}<br />Address 1: {Address1}<br />Address 2: {Address2}</p><p>[Delivery]<br />Delivery address:<br />Country: {dCountry}<br />City: {dCity}<br />State: {dState}<br />Zip: {dZip}<br />Address 1: {dAddress1}<br />Address 2: {dAddress2}<br />[/Delivery]</p><p>Order details:<br />Date/Time: {DateTime}<br />Location: {Location}<br />Order ID: {OrderID}<br />Order Details: {OrderDetails}<br />Subtotal: {Subtotal}<br />Delivery: {Delivery}<br />Discount: {Discount}<br />Total: {Total}</p>', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'addLocale', 'backend', 'addLocale', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add language', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'adminForgot', 'backend', 'adminForgot', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Password reminder', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'adminLogin', 'backend', 'adminLogin', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Admin Login', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'backend', 'backend', 'backend', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Back-end titles', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'bf_options_ARRAY_1', 'backend', 'bf_options_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'bf_options_ARRAY_2', 'backend', 'bf_options_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Yes', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'bf_options_ARRAY_3', 'backend', 'bf_options_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Yes (Required)', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnAdd', 'backend', 'btnAdd', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add +', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnAddCategory', 'backend', 'btnAddCategory', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add Category', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnAddClient', 'backend', 'btnAddClient', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add client', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnAddDeliveryFee', 'backend', 'btnAddDeliveryFee', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add delivery fee', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnAddExtra', 'backend', 'btnAddExtra', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add Extra', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnAddOrder', 'backend', 'btnAddOrder', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add order', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnAddPrice', 'backend', 'btnAddPrice', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add order amount and delivery price', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnAddProduct', 'backend', 'btnAddProduct', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add Product', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnAddSize', 'backend', 'btnAddSize', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add Size', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnAddUser', 'backend', 'btnAddUser', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '+ Add user', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnBack', 'backend', 'btnBack', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '« Back', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnBackup', 'backend', 'btnBackup', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnCalculateTotal', 'backend', 'btnCalculateTotal', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calculate Total', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnCancel', 'backend', 'btnCancel', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancel', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnContinue', 'backend', 'btnContinue', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Continue', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnDelete', 'backend', 'btnDelete', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnDeleteShape', 'backend', 'btnDeleteShape', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete Selected Shape', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnEmail', 'backend', 'btnEmail', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnFindCoord', 'backend', 'btnFindCoord', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'LOCATE ON MAP', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnLogin', 'backend', 'btnLogin', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Login', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnOK', 'backend', 'btnOK', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'OK', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnPlusAddExtra', 'backend', 'btnPlusAddExtra', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '+ Add extra', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnPlusAddProduct', 'backend', 'btnPlusAddProduct', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '+ Add product', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnPreview', 'backend', 'btnPreview', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Preview', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnPrint', 'backend', 'btnPrint', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Print', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnPrintOrderDetails', 'backend', 'btnPrintOrderDetails', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Print Order Details', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnRemove', 'backend', 'btnRemove', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Remove', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnResendOrder', 'backend', 'btnResendOrder', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Re-send confirmation email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnReset', 'backend', 'btnReset', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reset', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnSave', 'backend', 'btnSave', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Save', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnSearch', 'backend', 'btnSearch', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Search', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnSend', 'backend', 'btnSend', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnUpdate', 'backend', 'btnUpdate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'btnUseThisTheme', 'backend', 'btnUseThisTheme', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use this theme', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'buttons_ARRAY_cancel', 'backend', 'buttons_ARRAY_cancel', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancel', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'buttons_ARRAY_delete', 'backend', 'buttons_ARRAY_delete', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'buttons_ARRAY_ok', 'backend', 'buttons_ARRAY_ok', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'OK', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'buttons_ARRAY_send', 'backend', 'buttons_ARRAY_send', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'cancel_err_ARRAY_1', 'backend', 'cancel_err_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Missing parameters', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'cancel_err_ARRAY_2', 'backend', 'cancel_err_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order with such ID does not exist.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'cancel_err_ARRAY_200', 'backend', 'cancel_err_ARRAY_200', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The order has been cancelled successfully.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'cancel_err_ARRAY_3', 'backend', 'cancel_err_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Security hash did not match.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'cancel_err_ARRAY_4', 'backend', 'cancel_err_ARRAY_4', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your order was already cancelled.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'cc_types_ARRAY_AmericanExpress', 'backend', 'cc_types_ARRAY_AmericanExpress', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'AmericanExpress', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'cc_types_ARRAY_Maestro', 'backend', 'cc_types_ARRAY_Maestro', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Maestro', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'cc_types_ARRAY_MasterCard', 'backend', 'cc_types_ARRAY_MasterCard', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'MasterCard', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'cc_types_ARRAY_Visa', 'backend', 'cc_types_ARRAY_Visa', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Visa', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'client_notify_arr_ARRAY_account', 'backend', 'client_notify_arr_ARRAY_account', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New client account email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'client_notify_arr_ARRAY_cancel', 'backend', 'client_notify_arr_ARRAY_cancel', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send cancellation email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'client_notify_arr_ARRAY_confirmation', 'backend', 'client_notify_arr_ARRAY_confirmation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New order received email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'client_notify_arr_ARRAY_forgot', 'backend', 'client_notify_arr_ARRAY_forgot', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Forgot password email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'client_notify_arr_ARRAY_payment', 'backend', 'client_notify_arr_ARRAY_payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send payment confirmation email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'created', 'backend', 'created', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'DateTime', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'dash_delivery', 'backend', 'dash_delivery', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'dash_new_orders', 'backend', 'dash_new_orders', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'new orders', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'dash_orders', 'backend', 'dash_orders', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'orders', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'dash_pickup', 'backend', 'dash_pickup', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pickup', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'dash_today', 'backend', 'dash_today', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Today', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'dash_total', 'backend', 'dash_total', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Total', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'dash_total_orders', 'backend', 'dash_total_orders', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'total orders', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'days_ARRAY_0', 'backend', 'days_ARRAY_0', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Sunday', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'days_ARRAY_1', 'backend', 'days_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Monday', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'days_ARRAY_2', 'backend', 'days_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tuesday', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'days_ARRAY_3', 'backend', 'days_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Wednesday', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'days_ARRAY_4', 'backend', 'days_ARRAY_4', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Thursday', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'days_ARRAY_5', 'backend', 'days_ARRAY_5', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Friday', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'days_ARRAY_6', 'backend', 'days_ARRAY_6', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Saturday', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'day_names_ARRAY_0', 'backend', 'day_names_ARRAY_0', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'S', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'day_names_ARRAY_1', 'backend', 'day_names_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'M', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'day_names_ARRAY_2', 'backend', 'day_names_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'T', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'day_names_ARRAY_3', 'backend', 'day_names_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'W', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'day_names_ARRAY_4', 'backend', 'day_names_ARRAY_4', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'T', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'day_names_ARRAY_5', 'backend', 'day_names_ARRAY_5', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'F', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'day_names_ARRAY_6', 'backend', 'day_names_ARRAY_6', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'S', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'day_short_names_ARRAY_0', 'backend', 'day_short_names_ARRAY_0', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Su', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'day_short_names_ARRAY_1', 'backend', 'day_short_names_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Mo', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'day_short_names_ARRAY_2', 'backend', 'day_short_names_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tu', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'day_short_names_ARRAY_3', 'backend', 'day_short_names_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'day_short_names_ARRAY_4', 'backend', 'day_short_names_ARRAY_4', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Th', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'day_short_names_ARRAY_5', 'backend', 'day_short_names_ARRAY_5', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Fr', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'day_short_names_ARRAY_6', 'backend', 'day_short_names_ARRAY_6', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Sa', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'delete_confirmation', 'backend', 'delete_confirmation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Are you sure that you want to delete selected record(s)?', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'delete_selected', 'backend', 'delete_selected', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete selected', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'double_check_error_ARRAY_101', 'backend', 'double_check_error_ARRAY_101', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Captcha is missing.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'double_check_error_ARRAY_102', 'backend', 'double_check_error_ARRAY_102', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Captcha cannot be empty.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'double_check_error_ARRAY_103', 'backend', 'double_check_error_ARRAY_103', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Captcha is not correct.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'double_check_error_ARRAY_104', 'backend', 'double_check_error_ARRAY_104', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Invalid Data!', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'email', 'backend', 'email', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'emailForgotBody', 'backend', 'emailForgotBody', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Dear {Name},Your password: {Password}', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'emailForgotSubject', 'backend', 'emailForgotSubject', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Password reminder', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'email_taken', 'backend', 'email_taken', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Client with such email address exists.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AA10', 'backend', 'error_bodies_ARRAY_AA10', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Given email address is not associated with any account.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AA11', 'backend', 'error_bodies_ARRAY_AA11', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'For further instructions please check your mailbox.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AA12', 'backend', 'error_bodies_ARRAY_AA12', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry, please try again later.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AA13', 'backend', 'error_bodies_ARRAY_AA13', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to your profile have been saved.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AB01', 'backend', 'error_bodies_ARRAY_AB01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at ligula non arcu dignissim pretium. Praesent in magna nulla, in porta leo.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AB02', 'backend', 'error_bodies_ARRAY_AB02', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All backup files have been saved.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AB03', 'backend', 'error_bodies_ARRAY_AB03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No option was selected.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AB04', 'backend', 'error_bodies_ARRAY_AB04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup not performed.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AC01', 'backend', 'error_bodies_ARRAY_AC01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All changes made to the client have been saved.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AC03', 'backend', 'error_bodies_ARRAY_AC03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New client has been added into the system.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AC04', 'backend', 'error_bodies_ARRAY_AC04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New client could not be added into the system.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AC08', 'backend', 'error_bodies_ARRAY_AC08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry that client you are looking for is missing.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_ACT01', 'backend', 'error_bodies_ARRAY_ACT01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All changes made to the category have been saved.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_ACT03', 'backend', 'error_bodies_ARRAY_ACT03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New category has been added into the list.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_ACT04', 'backend', 'error_bodies_ARRAY_ACT04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry that the category could not be added successfully.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_ACT08', 'backend', 'error_bodies_ARRAY_ACT08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry that the category you are looking for is missing.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AE01', 'backend', 'error_bodies_ARRAY_AE01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All changes made to the extra have been saved.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AE03', 'backend', 'error_bodies_ARRAY_AE03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New extra has been added into the list.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AE04', 'backend', 'error_bodies_ARRAY_AE04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry that new extra could not bee added successfully.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AE08', 'backend', 'error_bodies_ARRAY_AE08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry that the extra you are looking for is missing.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AL01', 'backend', 'error_bodies_ARRAY_AL01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All changes made to the location have been saved successfully.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AL03', 'backend', 'error_bodies_ARRAY_AL03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New location has been added into the list.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AL04', 'backend', 'error_bodies_ARRAY_AL04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry that new location could not be added successfully.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AL08', 'backend', 'error_bodies_ARRAY_AL08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry that location you are looking for is missing.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AL09', 'backend', 'error_bodies_ARRAY_AL09', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All changes made to the delivery price have been saved.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_ALC01', 'backend', 'error_bodies_ARRAY_ALC01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to titles have been saved.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO01', 'backend', 'error_bodies_ARRAY_AO01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to options have been saved.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO02', 'backend', 'error_bodies_ARRAY_AO02', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All changes made to the order options have been saved successfully.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO03', 'backend', 'error_bodies_ARRAY_AO03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All changes made to the order form have been saved successfully.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO04', 'backend', 'error_bodies_ARRAY_AO04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All changes made to notifications have been saved successfully.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO05', 'backend', 'error_bodies_ARRAY_AO05', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All changes made to terms and conditions have been saved successfully.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO06', 'backend', 'error_bodies_ARRAY_AO06', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All changes made to delivery form have been saved successfully.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO07', 'backend', 'error_bodies_ARRAY_AO07', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Changes made to the print template have been saved.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AP01', 'backend', 'error_bodies_ARRAY_AP01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All changes to the product have been saved.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AP03', 'backend', 'error_bodies_ARRAY_AP03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New product has been added to the list.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AP04', 'backend', 'error_bodies_ARRAY_AP04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry that new product could not be added successfully.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AP05', 'backend', 'error_bodies_ARRAY_AP05', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New product could not be added because image size is too large and your server cannot upload it. Maximum allowed size is {SIZE}. Please, upload smaller image.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AP06', 'backend', 'error_bodies_ARRAY_AP06', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The product could not be updated successfully because image size is too large and your server cannot upload it. Maximum allowed size is {SIZE}. Please, upload smaller image.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AP08', 'backend', 'error_bodies_ARRAY_AP08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry that product you are looking for is missing.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AP09', 'backend', 'error_bodies_ARRAY_AP09', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New product has been added, but image could not be uploaded because filesize is too big. Upload max filesize is {SIZE}. Please upload another file!', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AP10', 'backend', 'error_bodies_ARRAY_AP10', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The product has been updated, but image could not be uploaded successfully.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR01', 'backend', 'error_bodies_ARRAY_AR01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All changes made to the order have been updated.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR03', 'backend', 'error_bodies_ARRAY_AR03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New order has been added into the list.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR04', 'backend', 'error_bodies_ARRAY_AR04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry that new order could not be added successfully.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR08', 'backend', 'error_bodies_ARRAY_AR08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry that order you are looking for is missing.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AT01', 'backend', 'error_bodies_ARRAY_AT01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All changes made to the working time have been saved.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AT02', 'backend', 'error_bodies_ARRAY_AT02', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Custom working time has been saved successfully.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AU01', 'backend', 'error_bodies_ARRAY_AU01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to this user have been saved.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AU03', 'backend', 'error_bodies_ARRAY_AU03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to this user have been saved.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AU04', 'backend', 'error_bodies_ARRAY_AU04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry, but the user has not been added.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AU08', 'backend', 'error_bodies_ARRAY_AU08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'User your looking for is missing.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AV01', 'backend', 'error_bodies_ARRAY_AV01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All changes made to the voucher have been saved.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AV03', 'backend', 'error_bodies_ARRAY_AV03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New voucher has been added to the list.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AV04', 'backend', 'error_bodies_ARRAY_AV04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry that new voucher could not bee added successfully.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AV08', 'backend', 'error_bodies_ARRAY_AV08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry that voucher you are looking for is missing.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AA10', 'backend', 'error_titles_ARRAY_AA10', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Account not found!', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AA11', 'backend', 'error_titles_ARRAY_AA11', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Password send!', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AA12', 'backend', 'error_titles_ARRAY_AA12', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Password not send!', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AA13', 'backend', 'error_titles_ARRAY_AA13', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Profile updated!', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AB01', 'backend', 'error_titles_ARRAY_AB01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AB02', 'backend', 'error_titles_ARRAY_AB02', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup complete!', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AB03', 'backend', 'error_titles_ARRAY_AB03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup failed!', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AB04', 'backend', 'error_titles_ARRAY_AB04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup failed!', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AC01', 'backend', 'error_titles_ARRAY_AC01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Client updated', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AC03', 'backend', 'error_titles_ARRAY_AC03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Client added!', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AC04', 'backend', 'error_titles_ARRAY_AC04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Client not added!', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AC08', 'backend', 'error_titles_ARRAY_AC08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Client not found', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_ACT01', 'backend', 'error_titles_ARRAY_ACT01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Category updated', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_ACT03', 'backend', 'error_titles_ARRAY_ACT03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Category added', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_ACT04', 'backend', 'error_titles_ARRAY_ACT04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Category failed to add', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_ACT08', 'backend', 'error_titles_ARRAY_ACT08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Category not found', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AE01', 'backend', 'error_titles_ARRAY_AE01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Extra updated', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AE03', 'backend', 'error_titles_ARRAY_AE03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Extra added', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AE04', 'backend', 'error_titles_ARRAY_AE04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Extra failed to add', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AE08', 'backend', 'error_titles_ARRAY_AE08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Extra not found', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AL01', 'backend', 'error_titles_ARRAY_AL01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Location updated', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AL03', 'backend', 'error_titles_ARRAY_AL03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Location added', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AL04', 'backend', 'error_titles_ARRAY_AL04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Location failed to add', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AL08', 'backend', 'error_titles_ARRAY_AL08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Location not found', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AL09', 'backend', 'error_titles_ARRAY_AL09', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery fees updated', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO01', 'backend', 'error_titles_ARRAY_AO01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Options updated!', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO02', 'backend', 'error_titles_ARRAY_AO02', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order options updated', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO03', 'backend', 'error_titles_ARRAY_AO03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order form updated', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO04', 'backend', 'error_titles_ARRAY_AO04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notifications updated', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO05', 'backend', 'error_titles_ARRAY_AO05', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Terms and Conditions updated', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO06', 'backend', 'error_titles_ARRAY_AO06', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery Form updated', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO07', 'backend', 'error_titles_ARRAY_AO07', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Template updated', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AP01', 'backend', 'error_titles_ARRAY_AP01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Product updated', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AP03', 'backend', 'error_titles_ARRAY_AP03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Product added', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AP04', 'backend', 'error_titles_ARRAY_AP04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Product failed to add', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AP05', 'backend', 'error_titles_ARRAY_AP05', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Image size too large', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AP06', 'backend', 'error_titles_ARRAY_AP06', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Image size too large', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AP08', 'backend', 'error_titles_ARRAY_AP08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Product not found', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AP09', 'backend', 'error_titles_ARRAY_AP09', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Upload error', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AP10', 'backend', 'error_titles_ARRAY_AP10', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Upload error', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR01', 'backend', 'error_titles_ARRAY_AR01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order updated', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR03', 'backend', 'error_titles_ARRAY_AR03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order added', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR04', 'backend', 'error_titles_ARRAY_AR04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order not added', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR08', 'backend', 'error_titles_ARRAY_AR08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order not found', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AT01', 'backend', 'error_titles_ARRAY_AT01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Working Time Updated', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AT02', 'backend', 'error_titles_ARRAY_AT02', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Custom working time saved', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AU01', 'backend', 'error_titles_ARRAY_AU01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'User updated!', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AU03', 'backend', 'error_titles_ARRAY_AU03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'User added!', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AU04', 'backend', 'error_titles_ARRAY_AU04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'User failed to add.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AU08', 'backend', 'error_titles_ARRAY_AU08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'User not found.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AV01', 'backend', 'error_titles_ARRAY_AV01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Voucher updated', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AV03', 'backend', 'error_titles_ARRAY_AV03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Voucher added', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AV04', 'backend', 'error_titles_ARRAY_AV04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Voucher failed to add', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AV08', 'backend', 'error_titles_ARRAY_AV08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Voucher not found', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'fd_field_number', 'backend', 'fd_field_number', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Please enter a valid number.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'fd_field_required', 'backend', 'fd_field_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This field is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'fd_same_category', 'backend', 'fd_same_category', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Category name was already used.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'filter_ARRAY_active', 'backend', 'filter_ARRAY_active', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Active', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'filter_ARRAY_inactive', 'backend', 'filter_ARRAY_inactive', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Inactive', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'forgot_messages_ARRAY_100', 'backend', 'forgot_messages_ARRAY_100', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'There is no such account in the system.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'forgot_messages_ARRAY_101', 'backend', 'forgot_messages_ARRAY_101', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your account is not active yet.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'forgot_messages_ARRAY_200', 'backend', 'forgot_messages_ARRAY_200', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The password was sent to your mail box.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'frontend', 'backend', 'frontend', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Front-end titles', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_add', 'backend', 'front_add', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '+ ADD', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_address', 'backend', 'front_address', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_address1_required', 'backend', 'front_address1_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address line 1 is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_address2_required', 'backend', 'front_address2_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address line 2 is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_address_line_1', 'backend', 'front_address_line_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address line 1', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_address_line_2', 'backend', 'front_address_line_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address line 2', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_agree', 'backend', 'front_agree', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'I read and agree with', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_agree_required', 'backend', 'front_agree_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You need to agree with terms and conditions.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_asap', 'backend', 'front_asap', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'ASAP', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_button_apply', 'backend', 'front_button_apply', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Apply', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_button_back', 'backend', 'front_button_back', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Back', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_button_checkout', 'backend', 'front_button_checkout', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Checkout', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_button_confirm', 'backend', 'front_button_confirm', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Confirm', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_button_continue', 'backend', 'front_button_continue', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Continue', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_button_login', 'backend', 'front_button_login', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Login', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_button_save', 'backend', 'front_button_save', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Save', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_button_send', 'backend', 'front_button_send', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_captcha', 'backend', 'front_captcha', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Captcha', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_captcha_required', 'backend', 'front_captcha_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Captcha is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_cc_code', 'backend', 'front_cc_code', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC code', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_cc_code_required', 'backend', 'front_cc_code_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC code is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_cc_exp', 'backend', 'front_cc_exp', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC expiration', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_cc_exp_month_required', 'backend', 'front_cc_exp_month_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Expiration month is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_cc_exp_required', 'backend', 'front_cc_exp_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC expiration is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_cc_exp_year_required', 'backend', 'front_cc_exp_year_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Expiration year is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_cc_number', 'backend', 'front_cc_number', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC number', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_cc_num_required', 'backend', 'front_cc_num_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC number is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_cc_type', 'backend', 'front_cc_type', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC type', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_cc_type_required', 'backend', 'front_cc_type_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC type is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_change', 'backend', 'front_change', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Change', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_choose', 'backend', 'front_choose', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Choose', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_city', 'backend', 'front_city', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'City', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_city_required', 'backend', 'front_city_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'City is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_client_login', 'backend', 'front_client_login', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Client Login', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_close', 'backend', 'front_close', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Close', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_company', 'backend', 'front_company', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Company', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_company_required', 'backend', 'front_company_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Company is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_confirm_order', 'backend', 'front_confirm_order', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Confirm Order', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_continue', 'backend', 'front_continue', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Continue', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_country', 'backend', 'front_country', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_country_required', 'backend', 'front_country_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_date_time', 'backend', 'front_date_time', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Date / time', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_delivery', 'backend', 'front_delivery', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_delivery_address', 'backend', 'front_delivery_address', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery Address', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_delivery_area', 'backend', 'front_delivery_area', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery area', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_delivery_area_required', 'backend', 'front_delivery_area_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery area is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_delivery_datetime', 'backend', 'front_delivery_datetime', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery date / time', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_delivery_date_required', 'backend', 'front_delivery_date_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery date is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_delivery_fee', 'backend', 'front_delivery_fee', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery fee', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_delivery_info', 'backend', 'front_delivery_info', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'See delivery area for each of our locations and click on the area you live in.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_deposit', 'backend', 'front_deposit', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Deposit', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_discount', 'backend', 'front_discount', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Discount', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_do_not_have_account', 'backend', 'front_do_not_have_account', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Don''t have an account yet?', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_email', 'backend', 'front_email', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_email_address', 'backend', 'front_email_address', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email address', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_email_address_required', 'backend', 'front_email_address_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email address is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_email_not_valid', 'backend', 'front_email_not_valid', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email address is not valid.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_email_required', 'backend', 'front_email_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_empty_cart', 'backend', 'front_empty_cart', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your cart is empty.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_existing_email', 'backend', 'front_existing_email', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'There is client account for your email address. {STAG}Login{ETAG}.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_food_delivery', 'backend', 'front_food_delivery', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Food Delivery', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_forgot_password', 'backend', 'front_forgot_password', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Forgot your password?', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_from', 'backend', 'front_from', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'from', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_holder_month_year', 'backend', 'front_holder_month_year', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Month/Year', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_location', 'backend', 'front_location', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Location', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_location_required', 'backend', 'front_location_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Location is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_login_to_account', 'backend', 'front_login_to_account', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Login to your account', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_logout', 'backend', 'front_logout', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Logout', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_menu', 'backend', 'front_menu', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Menu', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_menu_items_ARRAY_1', 'backend', 'front_menu_items_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'step 1 - menu', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_menu_items_ARRAY_2', 'backend', 'front_menu_items_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'step 2 - my account', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_menu_items_ARRAY_3', 'backend', 'front_menu_items_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'step 3 - forgot password', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_menu_items_ARRAY_4', 'backend', 'front_menu_items_ARRAY_4', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'step 4 - shipping details', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_menu_items_ARRAY_5', 'backend', 'front_menu_items_ARRAY_5', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'step 5 - order total', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_menu_items_ARRAY_6', 'backend', 'front_menu_items_ARRAY_6', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'step 6 - payment', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_menu_items_ARRAY_7', 'backend', 'front_menu_items_ARRAY_7', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'step 7 - confirm order', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_menu_titles_ARRAY_1', 'backend', 'front_menu_titles_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'step 1 - menu', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_menu_titles_ARRAY_2', 'backend', 'front_menu_titles_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'step 2 - my account', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_menu_titles_ARRAY_3', 'backend', 'front_menu_titles_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'step 3 - order details', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_menu_titles_ARRAY_4', 'backend', 'front_menu_titles_ARRAY_4', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'step 4 - order total', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_menu_titles_ARRAY_5', 'backend', 'front_menu_titles_ARRAY_5', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'step 5 - payment', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_menu_titles_ARRAY_6', 'backend', 'front_menu_titles_ARRAY_6', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'step 6 - confirm order', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_messages_ARRAY_1', 'backend', 'front_messages_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your order is saved. Redirecting to PayPal...', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_messages_ARRAY_10', 'backend', 'front_messages_ARRAY_10', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Client address found, but Google return FALSE while trying to found out distance between client address and each point of given locations.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_messages_ARRAY_11', 'backend', 'front_messages_ARRAY_11', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your order will be delivered from {LOCATION}.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_messages_ARRAY_12', 'backend', 'front_messages_ARRAY_12', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your order is processing. Please wait...', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_messages_ARRAY_13', 'backend', 'front_messages_ARRAY_13', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Missing parameters. [STAG]Start over[ETAG]', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_messages_ARRAY_2', 'backend', 'front_messages_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your order is saved. Redirecting to Authorize...', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_messages_ARRAY_3', 'backend', 'front_messages_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your order is saved. [STAG]Start over[ETAG]', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_messages_ARRAY_4', 'backend', 'front_messages_ARRAY_4', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order failed to save. [STAG]Start over[ETAG]', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_messages_ARRAY_5', 'backend', 'front_messages_ARRAY_5', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Oops, the following error appears', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_messages_ARRAY_6', 'backend', 'front_messages_ARRAY_6', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address not found', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_messages_ARRAY_7', 'backend', 'front_messages_ARRAY_7', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'None of locations found make deliveries at this time', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_messages_ARRAY_8', 'backend', 'front_messages_ARRAY_8', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Distance not found', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_messages_ARRAY_9', 'backend', 'front_messages_ARRAY_9', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'None of locations found make deliveries at the distance', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_minimum_order_amount', 'backend', 'front_minimum_order_amount', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Minimum order amount is {AMOUNT}.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_name', 'backend', 'front_name', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Name', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_name_required', 'backend', 'front_name_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Name is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_new_client', 'backend', 'front_new_client', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'I am a new Client', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_next_day', 'backend', 'front_next_day', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'next day', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_notes', 'backend', 'front_notes', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notes', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_notes_required', 'backend', 'front_notes_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notes is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_order', 'backend', 'front_order', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'order', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_order_created', 'backend', 'front_order_created', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order created', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_order_details', 'backend', 'front_order_details', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order Details', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_order_id', 'backend', 'front_order_id', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order ID', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_order_now', 'backend', 'front_order_now', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order Now', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_order_total', 'backend', 'front_order_total', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order Total', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_password', 'backend', 'front_password', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Password', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_password_required', 'backend', 'front_password_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Password is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_payment', 'backend', 'front_payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_payment_medthod', 'backend', 'front_payment_medthod', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment method', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_payment_method_required', 'backend', 'front_payment_method_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment method is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_personal_details', 'backend', 'front_personal_details', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Personal Details', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_phone', 'backend', 'front_phone', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Phone', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_phone_required', 'backend', 'front_phone_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Phone is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_pickup', 'backend', 'front_pickup', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pickup', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_pickup_address', 'backend', 'front_pickup_address', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pick-up Address', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_pickup_datetime', 'backend', 'front_pickup_datetime', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pick-up date / time', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_pickup_date_required', 'backend', 'front_pickup_date_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pick-up date is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_price', 'backend', 'front_price', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Price', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_processed_on', 'backend', 'front_processed_on', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Processed on', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_product', 'backend', 'front_product', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Product', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_product_not_found', 'backend', 'front_product_not_found', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'There is no products available for the category.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_profile_updated', 'backend', 'front_profile_updated', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your profile has been updated.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_promo_code', 'backend', 'front_promo_code', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Promo code', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_qty', 'backend', 'front_qty', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Qty', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_save_changes', 'backend', 'front_save_changes', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Save changes to my profile', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_select_previous', 'backend', 'front_select_previous', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Select previously used address or change address below', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_send_password', 'backend', 'front_send_password', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send Password', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_shipping_details', 'backend', 'front_shipping_details', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Shipping Details', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_special_instructions', 'backend', 'front_special_instructions', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Special instructions', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_special_required', 'backend', 'front_special_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Special instructions is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_state', 'backend', 'front_state', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'State', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_state_required', 'backend', 'front_state_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'State is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_subtotal', 'backend', 'front_subtotal', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Subtotal', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_tax', 'backend', 'front_tax', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tax', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_terms_conditions', 'backend', 'front_terms_conditions', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'terms and conditions', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_title', 'backend', 'front_title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Title', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_title_required', 'backend', 'front_title_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Title is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_total', 'backend', 'front_total', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Total', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_txn_id', 'backend', 'front_txn_id', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Paypal Transaction ID', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_your_cart', 'backend', 'front_your_cart', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your Cart', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_zip', 'backend', 'front_zip', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Zip', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'front_zip_required', 'backend', 'front_zip_required', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Zip is required.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'frotn_incorrect_captcha', 'backend', 'frotn_incorrect_captcha', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Captcha is not correct.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'gridActionTitle', 'backend', 'gridActionTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Action confirmation', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'gridBtnCancel', 'backend', 'gridBtnCancel', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancel', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'gridBtnDelete', 'backend', 'gridBtnDelete', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'gridBtnOk', 'backend', 'gridBtnOk', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'OK', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'gridChooseAction', 'backend', 'gridChooseAction', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Choose Action', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'gridConfirmationTitle', 'backend', 'gridConfirmationTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Are you sure you want to delete selected record?', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'gridDeleteConfirmation', 'backend', 'gridDeleteConfirmation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete confirmation', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'gridEmptyBody', 'backend', 'gridEmptyBody', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You need to select at least a single record.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'gridEmptyResult', 'backend', 'gridEmptyResult', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No records found', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'gridEmptyTitle', 'backend', 'gridEmptyTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No records selected', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'gridGotoPage', 'backend', 'gridGotoPage', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Go to page:', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'gridItemsPerPage', 'backend', 'gridItemsPerPage', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Items per page', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'gridNext', 'backend', 'gridNext', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Next »', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'gridNextPage', 'backend', 'gridNextPage', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Next page', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'gridPrev', 'backend', 'gridPrev', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '« Prev', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'gridPrevPage', 'backend', 'gridPrevPage', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Prev page', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'gridTotalItems', 'backend', 'gridTotalItems', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Total items:', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoAddCategoryDesc', 'backend', 'infoAddCategoryDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use the form below to add new category to the system.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoAddCategoryTitle', 'backend', 'infoAddCategoryTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add new category', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoAddExtraDesc', 'backend', 'infoAddExtraDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use the form below to add new extras. Extra is an additional supplement to the meal which can be added to the order as per client preferences.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoAddExtraTitle', 'backend', 'infoAddExtraTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add new extra', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoAddLocationDesc', 'backend', 'infoAddLocationDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use the form below to add new pickup/delivery location. You can define latitude / longitude and the delivery area for this location.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoAddLocationTitle', 'backend', 'infoAddLocationTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add new location', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoAddOrderDesc', 'backend', 'infoAddOrderDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use the form below to add new order to the system.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoAddOrderTitle', 'backend', 'infoAddOrderTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add new order', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoAddProductDesc', 'backend', 'infoAddProductDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use the form below to add meals to the food delivery system. You can add description, image, meal size and optional extras.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoAddProductTitle', 'backend', 'infoAddProductTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add new product', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoAddVoucherDesc', 'backend', 'infoAddVoucherDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use the form below to create vouchers for discount.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoAddVoucherTitle', 'backend', 'infoAddVoucherTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add new voucher', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoCategoriesDesc', 'backend', 'infoCategoriesDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your menu is organized in categories. Below is a list of all categories added to the system. Use the tab above to add new category or edit one by clicking on the pencil icon of each row. You can organize categories with drag & drop.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoCategoriesTitle', 'backend', 'infoCategoriesTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Category List', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoClientsDesc', 'backend', 'infoClientsDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Below is a list of the people who have used the system to order food from your restaurant. Click on the pencil icon of each row to see and edit client details.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoClientsTitle', 'backend', 'infoClientsTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Client list', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoConfirmationDesc', 'backend', 'infoConfirmationDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'There are 4 types of email confirmations - one after order form is submitted , one after payment is made, one is new client account email and one when cancelled the order. Use the available tokens to personalize the email messages.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoConfirmationTitle', 'backend', 'infoConfirmationTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email Confirmations', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoCreateClientDesc', 'backend', 'infoCreateClientDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Fill in the form below and "save" to create new client.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoCreateClientTitle', 'backend', 'infoCreateClientTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New client', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoDeliveryFormDesc', 'backend', 'infoDeliveryFormDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Below you can enable and disable the delivery form fields that customers will have to complete. If you choose ''Yes (required)'' option then this field becomes mandatory and customers will not be able to proceed further without filling it in.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoDeliveryFormTitle', 'backend', 'infoDeliveryFormTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery form', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoDeliveryPricesDesc', 'backend', 'infoDeliveryPricesDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Click the button below to add different delivery fees depending on the order amount.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoDeliveryPricesTitle', 'backend', 'infoDeliveryPricesTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery fees', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoExtrasDesc', 'backend', 'infoExtrasDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Below is a list of all extras added to the system. To add new extra click on the above tab. To change one, click on the pencil icon of the row.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoExtrasTitle', 'backend', 'infoExtrasTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Lis of extras', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoInstallCodeTitle', 'backend', 'infoInstallCodeTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Install Code', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoInstallDesc', 'backend', 'infoInstallDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Follow the instructions below to install the script on your website.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoInstallTitle', 'backend', 'infoInstallTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Integration Code', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoListingAddressBody', 'backend', 'infoListingAddressBody', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You can show a map with the location of the listing accommodation on the listing details page. Submit the full address first and then click on ''Get coordinates from Google Maps API'' button. Save your data.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoListingAddressTitle', 'backend', 'infoListingAddressTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Location and address', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoListingBookingsBody', 'backend', 'infoListingBookingsBody', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Listing Bookings Body', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoListingBookingsTitle', 'backend', 'infoListingBookingsTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Listing Bookings Title', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoListingContactBody', 'backend', 'infoListingContactBody', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Listing Contact Body', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoListingContactTitle', 'backend', 'infoListingContactTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Listing Contact Title', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoListingExtendBody', 'backend', 'infoListingExtendBody', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Extend exp.date Body', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoListingExtendTitle', 'backend', 'infoListingExtendTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Extend exp.date Title', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoListingPricesBody', 'backend', 'infoListingPricesBody', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Listing Prices Body', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoListingPricesTitle', 'backend', 'infoListingPricesTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Listing Prices Title', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoLocalesArraysBody', 'backend', 'infoLocalesArraysBody', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Languages Array Body', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoLocalesArraysTitle', 'backend', 'infoLocalesArraysTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Languages Arrays Title', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoLocalesBackendBody', 'backend', 'infoLocalesBackendBody', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Languages Backend Body', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoLocalesBackendTitle', 'backend', 'infoLocalesBackendTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Languages Backend Title', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoLocalesBody', 'backend', 'infoLocalesBody', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Languages Body', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoLocalesFrontendBody', 'backend', 'infoLocalesFrontendBody', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Languages Frontend Body', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoLocalesFrontendTitle', 'backend', 'infoLocalesFrontendTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Languages Frontend Title', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoLocalesTitle', 'backend', 'infoLocalesTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Languages Title', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoLocationsDesc', 'backend', 'infoLocationsDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add your restaurant location by clicking on the above tab. A location is defined by the physical address of a restaurant, delivery range covered and working time. If you have added one or more restaurant locations you''ll see them below. You can edit location details, working time and delivery area covered by clicking on the pencil icon of each entry.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoLocationsTitle', 'backend', 'infoLocationsTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Location list', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoNotifications2Desc', 'backend', 'infoNotifications2Desc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set the automated email notifications sent to the script admins. You can use the available tokens to personalize the messages. Please note that if you wish to use the SMS notification you need to set SMS valid API Key at SMS tab. ', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoNotifications2Title', 'backend', 'infoNotifications2Title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notifications sent to script administrators', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoNotificationsDesc', 'backend', 'infoNotificationsDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Below you can create different types of auto-responders triggered by different events, such as new order notification, payment received and more. You can use the available tokens to personalize your message. Please note that if you wish to use the SMS notification you need to set SMS valid API Key at SMS tab.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoNotificationsTitle', 'backend', 'infoNotificationsTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notifications sent to customers', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoOrderFormDesc', 'backend', 'infoOrderFormDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use the drop-downs to select which form fields to be available at the checkout form. ', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoOrderFormTitle', 'backend', 'infoOrderFormTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order form', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoOrdersDesc', 'backend', 'infoOrdersDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use the form below to set your payment and order process options. It is important to define the deposit payment setting if you enable online payments, because this option will define the amount that customers will be charged online. You can choose between several online payment methods and/or enable cash payments. If customers choose Cash payment method then the order will be accepted without any online payment processing.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoOrdersListDesc', 'backend', 'infoOrdersListDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'See a list of all orders made. Click on the pencil icon of each entry to view and edit order details.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoOrdersListTitle', 'backend', 'infoOrdersListTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order List', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoOrdersTitle', 'backend', 'infoOrdersTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order Options', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoPaymentsDesc', 'backend', 'infoPaymentsDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Here you can choose your payment methods and set payment gateway accounts and payment preferences. Note that for cash payments the system will not be able to collect deposit amount online.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoPaymentsTitle', 'backend', 'infoPaymentsTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment Options', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoPreviewDesc', 'backend', 'infoPreviewDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'There are multiple color schemes available for the front end. Click on each of the thumbnails below to preview it. Click on "Use this theme" button for the theme you want to use.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoPreviewTitle', 'backend', 'infoPreviewTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Preview front end', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoPrintTemplateDesc', 'backend', 'infoPrintTemplateDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This is a print template for orders. You can create a customized order template using the editor and the tokens below. You can print orders from each order details page.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoPrintTemplateTitle', 'backend', 'infoPrintTemplateTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Print template', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoProductsDesc', 'backend', 'infoProductsDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Below is a list of all products added to the system. Click on the pencil icon of each entry to edit and see product details, or add new product by clicking on the tab above.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoProductsTitle', 'backend', 'infoProductsTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Product List', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoReportsDesc', 'backend', 'infoReportsDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Select date range and location that you wan to see the report.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoReportsTitle', 'backend', 'infoReportsTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reports', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoTermsDesc', 'backend', 'infoTermsDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use the form below to add terms and conditions to your system.  Note that the Terms and Conditions are visible at checkout and users must agree to the terms to continue with the order.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoTermsTitle', 'backend', 'infoTermsTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Terms and Conditions', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoUpdateCategoryDesc', 'backend', 'infoUpdateCategoryDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Edit category details and click on the ''Save'' button to update it.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoUpdateCategoryTitle', 'backend', 'infoUpdateCategoryTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update Category', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoUpdateClientDesc', 'backend', 'infoUpdateClientDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use the form below to make changes to client''s details.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoUpdateClientTitle', 'backend', 'infoUpdateClientTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Edit client', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoUpdateExtraDesc', 'backend', 'infoUpdateExtraDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Please make any change on the form below and click on ''Save'' button to update Extra information.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoUpdateExtraTitle', 'backend', 'infoUpdateExtraTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update Extra', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoUpdateLocationDesc', 'backend', 'infoUpdateLocationDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use the form below to make changes to this location. ', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoUpdateLocationTitle', 'backend', 'infoUpdateLocationTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Edit location', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoUpdateOrderDesc', 'backend', 'infoUpdateOrderDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Edit order details and click on the ''Save'' button to update it.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoUpdateOrderTitle', 'backend', 'infoUpdateOrderTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update Order', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoUpdateProductDesc', 'backend', 'infoUpdateProductDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Edit product details and click on the ''Save'' button to update it.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoUpdateProductTitle', 'backend', 'infoUpdateProductTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update Product', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoUpdateVoucherDesc', 'backend', 'infoUpdateVoucherDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Please make any change you want on the form below to update voucher information and click SAVE button.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoUpdateVoucherTitle', 'backend', 'infoUpdateVoucherTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update Voucher', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoUsersDesc', 'backend', 'infoUsersDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Below is a list of all users. You can add new users, edit user details and change user status. ', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoUsersTitle', 'backend', 'infoUsersTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Users', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoVoucherListDesc', 'backend', 'infoVoucherListDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Below is a list of all vouchers added to the system. Voucher is a series of numbers or letters that will grant your users a certain discount of the regular price if added during the checkout. To add  new voucher click on the tab above. To edit voucher click on the pencil icon of the row.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoVoucherListTitle', 'backend', 'infoVoucherListTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Voucher list', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoWTimeDesc', 'backend', 'infoWTimeDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use the drop-downs below to specify the available hours for order pick-up and delivery.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'infoWTimeTitle', 'backend', 'infoWTimeTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Working time ', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblAddCategory', 'backend', 'lblAddCategory', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add category', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblAddExtra', 'backend', 'lblAddExtra', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add extra', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblAddLocation', 'backend', 'lblAddLocation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add location', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblAddNewOrder', 'backend', 'lblAddNewOrder', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add new order', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblAddOrder', 'backend', 'lblAddOrder', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add order', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblAddProduct', 'backend', 'lblAddProduct', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add product', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblAddProductText', 'backend', 'lblAddProductText', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'There are no products added. Add {STAG}here{ETAG}.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblAddress', 'backend', 'lblAddress', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblAddress1', 'backend', 'lblAddress1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address 1', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblAddress2', 'backend', 'lblAddress2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address 2', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblAddressLine1', 'backend', 'lblAddressLine1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address line 1', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblAddressLine2', 'backend', 'lblAddressLine2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address line 2', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblAddressNotFound', 'backend', 'lblAddressNotFound', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address not found', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblAddUser', 'backend', 'lblAddUser', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add user', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblAddVoucher', 'backend', 'lblAddVoucher', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add voucher', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblAll', 'backend', 'lblAll', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblAllLocations', 'backend', 'lblAllLocations', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All locations', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblAsap', 'backend', 'lblAsap', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'ASAP', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblBackupDatabase', 'backend', 'lblBackupDatabase', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup database', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblBackupFiles', 'backend', 'lblBackupFiles', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup files', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblCategory', 'backend', 'lblCategory', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Category', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblCategoryName', 'backend', 'lblCategoryName', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Category name', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblCCCode', 'backend', 'lblCCCode', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC code', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblCCExp', 'backend', 'lblCCExp', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC expiration date', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblCCNum', 'backend', 'lblCCNum', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC number', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblCCType', 'backend', 'lblCCType', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC type', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblChangeImage', 'backend', 'lblChangeImage', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Change image', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblChoose', 'backend', 'lblChoose', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Choose', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblChooseTheme', 'backend', 'lblChooseTheme', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Choose color theme', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblCity', 'backend', 'lblCity', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'City', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblClient', 'backend', 'lblClient', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Client', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblClientCreated', 'backend', 'lblClientCreated', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Created', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblClientDetails', 'backend', 'lblClientDetails', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Form Fields', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblClientEmail', 'backend', 'lblClientEmail', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Client email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblClientLastOrder', 'backend', 'lblClientLastOrder', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Last order', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblClients', 'backend', 'lblClients', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Clients', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblClientTotalOrders', 'backend', 'lblClientTotalOrders', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Total orders', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblClosed', 'backend', 'lblClosed', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'closed', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblCompany', 'backend', 'lblCompany', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Company', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblConfirmationContent', 'backend', 'lblConfirmationContent', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Current address will be replaced with the new one.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblCountry', 'backend', 'lblCountry', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblCurrentlyInUse', 'backend', 'lblCurrentlyInUse', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Currently in use', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblCustom', 'backend', 'lblCustom', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Custom', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblCustomerWorkingTime', 'backend', 'lblCustomerWorkingTime', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Custom working time', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDashLastLogin', 'backend', 'lblDashLastLogin', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Last login', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDashNoLocation', 'backend', 'lblDashNoLocation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No locations added yet. Click [STAG]here[ETAG] to add a location.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDashNoOrder', 'backend', 'lblDashNoOrder', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No orders found', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDate', 'backend', 'lblDate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Date', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDateFrom', 'backend', 'lblDateFrom', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Date from', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDateTime', 'backend', 'lblDateTime', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Date & time', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDateTimeFrom', 'backend', 'lblDateTimeFrom', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'From date/time', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDateTimeTo', 'backend', 'lblDateTimeTo', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'To date/time', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDateTimeValid', 'backend', 'lblDateTimeValid', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Date/Time valid', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDateTo', 'backend', 'lblDateTo', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Date to', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDayOfWeek', 'backend', 'lblDayOfWeek', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Day of week', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDays', 'backend', 'lblDays', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'days', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDefault', 'backend', 'lblDefault', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Default', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDelete', 'backend', 'lblDelete', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDeleteCategoryConfirm', 'backend', 'lblDeleteCategoryConfirm', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Are you sure that you want to delete this category?', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDeleteCategoryTitle', 'backend', 'lblDeleteCategoryTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete category', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDeleteImage', 'backend', 'lblDeleteImage', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete image', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDeleteImageConfirm', 'backend', 'lblDeleteImageConfirm', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Are you sure that you want to delete this image?', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDelivery', 'backend', 'lblDelivery', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDeliveryAddress', 'backend', 'lblDeliveryAddress', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery address', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDeliveryDateTime', 'backend', 'lblDeliveryDateTime', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery date/time', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDeliveryFeeWarning', 'backend', 'lblDeliveryFeeWarning', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order amount from should not be less than Order amount to', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDeliveryOrdersToday', 'backend', 'lblDeliveryOrdersToday', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'delivery orders today', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDeliveryOrderToday', 'backend', 'lblDeliveryOrderToday', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'delivery order today', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDeposit', 'backend', 'lblDeposit', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Deposit', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDescription', 'backend', 'lblDescription', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Description', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDiscount', 'backend', 'lblDiscount', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Discount', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblDoNotAddTax', 'backend', 'lblDoNotAddTax', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Do not add tax to the delivery fee', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblEmail', 'backend', 'lblEmail', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblEmailNotificationNotSet', 'backend', 'lblEmailNotificationNotSet', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email notification has not been set yet.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblEmailSent', 'backend', 'lblEmailSent', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email has been sent.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblEndTime', 'backend', 'lblEndTime', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'End time', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblError', 'backend', 'lblError', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Error', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblEvery', 'backend', 'lblEvery', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Every', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblExistingClient', 'backend', 'lblExistingClient', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Existing client', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblExport', 'backend', 'lblExport', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Export', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblExtra', 'backend', 'lblExtra', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Extra', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblExtraName', 'backend', 'lblExtraName', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Extra name', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblExtras', 'backend', 'lblExtras', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Extras', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblFailedToSend', 'backend', 'lblFailedToSend', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email failed to send.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblFeaturedProduct', 'backend', 'lblFeaturedProduct', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Featured product', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblFilterByLocation', 'backend', 'lblFilterByLocation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Filter by location', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblForgot', 'backend', 'lblForgot', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Forgot password', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblFrom', 'backend', 'lblFrom', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'from', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblGetCoordsNotes', 'backend', 'lblGetCoordsNotes', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Click on the button to find location coordinates and pin location on the map. You can also enter latitude and longitude on your own.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblHere', 'backend', 'lblHere', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'here', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblImage', 'backend', 'lblImage', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Image', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblInfoMessage', 'backend', 'lblInfoMessage', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Message', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblInstallCode', 'backend', 'lblInstallCode', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Install code', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblInstallConfig', 'backend', 'lblInstallConfig', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Language configuration', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblInstallConfigHide', 'backend', 'lblInstallConfigHide', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Hide language selector', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblInstallConfigLocale', 'backend', 'lblInstallConfigLocale', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Select language', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblInstallJs1_body', 'backend', 'lblInstallJs1_body', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Copy the code below and put it on your web page. It will show the front end booking engine.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblInstallJs1_title', 'backend', 'lblInstallJs1_title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Preview front end and install on your website', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblInstallTheme', 'backend', 'lblInstallTheme', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Choose theme', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblIp', 'backend', 'lblIp', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'IP address', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblIpAddress', 'backend', 'lblIpAddress', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'IP address', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblIsActive', 'backend', 'lblIsActive', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Is confirmed', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblIsDayOff', 'backend', 'lblIsDayOff', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Is day off', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblIsOpen', 'backend', 'lblIsOpen', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Is open', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblIsPaid', 'backend', 'lblIsPaid', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Is paid', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblLatestDeliveryOrders', 'backend', 'lblLatestDeliveryOrders', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Latest Delivery Orders', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblLatestPickupOrders', 'backend', 'lblLatestPickupOrders', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Latest Pick-up Orders', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblLatitude', 'backend', 'lblLatitude', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Latitude', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblLegendEmails', 'backend', 'lblLegendEmails', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Emails', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblLegendSMS', 'backend', 'lblLegendSMS', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'SMS', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblLocation', 'backend', 'lblLocation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Location', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblLocationName', 'backend', 'lblLocationName', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Location name', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblLocationsWorkingStatus', 'backend', 'lblLocationsWorkingStatus', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Locations Working Status', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblLocationWorkingStatus', 'backend', 'lblLocationWorkingStatus', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Location Working Status', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblLongitude', 'backend', 'lblLongitude', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Longitude', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblMenu', 'backend', 'lblMenu', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Menu', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblMessage', 'backend', 'lblMessage', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Message', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblNA', 'backend', 'lblNA', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'n/a', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblName', 'backend', 'lblName', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Name', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblNewClient', 'backend', 'lblNewClient', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New client', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblNo', 'backend', 'lblNo', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblNoCategoriesFound', 'backend', 'lblNoCategoriesFound', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No categories found. Add a category', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblNoDeliveryFeesAdded', 'backend', 'lblNoDeliveryFeesAdded', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No delivery fees added.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblNoExtrasFound', 'backend', 'lblNoExtrasFound', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No extras found. Add an extra', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblNotes', 'backend', 'lblNotes', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notes', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblOneOrder', 'backend', 'lblOneOrder', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'order', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblOpened', 'backend', 'lblOpened', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'open', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblOption', 'backend', 'lblOption', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Option', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblOptionList', 'backend', 'lblOptionList', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Option list', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblOrder', 'backend', 'lblOrder', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblOrderDetails', 'backend', 'lblOrderDetails', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order Details', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblOrderID', 'backend', 'lblOrderID', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order ID', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblOrderIsPaid', 'backend', 'lblOrderIsPaid', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order is paid', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblOrders', 'backend', 'lblOrders', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Orders', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblOrdersThisWeek', 'backend', 'lblOrdersThisWeek', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'orders this week', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblOrderThisWeek', 'backend', 'lblOrderThisWeek', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'order this week', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPassword', 'backend', 'lblPassword', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Password', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPaymentMethod', 'backend', 'lblPaymentMethod', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment method', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPaymentsOtherDetails', 'backend', 'lblPaymentsOtherDetails', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payments and other details', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPhone', 'backend', 'lblPhone', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Phone', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPickerDateTime', 'backend', 'lblPickerDateTime', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pickup date/time', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPickup', 'backend', 'lblPickup', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pickup', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPickupAddress', 'backend', 'lblPickupAddress', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pickup address', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPickupOrdersToday', 'backend', 'lblPickupOrdersToday', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'pick-up orders today', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPickupOrderToday', 'backend', 'lblPickupOrderToday', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'pick-up order today', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPluralCategory', 'backend', 'lblPluralCategory', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'categories', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPluralClient', 'backend', 'lblPluralClient', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'clients', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPluralExtra', 'backend', 'lblPluralExtra', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'extras', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPluralProduct', 'backend', 'lblPluralProduct', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'products', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPluralVoucher', 'backend', 'lblPluralVoucher', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'vouchers', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPreviewMenu', 'backend', 'lblPreviewMenu', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Preview menu', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPrice', 'backend', 'lblPrice', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Price', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPriceBasedOnSize', 'backend', 'lblPriceBasedOnSize', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set different price based on size', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPriceFrom', 'backend', 'lblPriceFrom', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order amount from', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPricePrice', 'backend', 'lblPricePrice', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery price', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblPriceTo', 'backend', 'lblPriceTo', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order amount to', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblProduct', 'backend', 'lblProduct', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Product', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblProductPriceDesc', 'backend', 'lblProductPriceDesc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set single product price or multiple prices based on size. For example, if you add pizza you can add different sizes for small, medium, family pizzas.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblProducts', 'backend', 'lblProducts', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Products', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblProductsUsed', 'backend', 'lblProductsUsed', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Products used', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblQty', 'backend', 'lblQty', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Qty', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblQuickLinks', 'backend', 'lblQuickLinks', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Quick Links', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblReminderEmail', 'backend', 'lblReminderEmail', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reminder email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblRestaurantClosed', 'backend', 'lblRestaurantClosed', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Restaurant is closed at the selected data & time.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblRole', 'backend', 'lblRole', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Role', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblSelectImage', 'backend', 'lblSelectImage', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Select image', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblSetDifferentSizes', 'backend', 'lblSetDifferentSizes', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set different sizes', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblSetWorkingTime', 'backend', 'lblSetWorkingTime', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set Custom Working Time', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblSingularCategory', 'backend', 'lblSingularCategory', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'category', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblSingularClient', 'backend', 'lblSingularClient', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'client', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblSingularExtra', 'backend', 'lblSingularExtra', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'extra', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblSingularProduct', 'backend', 'lblSingularProduct', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'product', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblSingularVoucher', 'backend', 'lblSingularVoucher', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'voucher', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblSize', 'backend', 'lblSize', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Size', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblSizeAndPrice', 'backend', 'lblSizeAndPrice', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Size & Price', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblSpecialInstructions', 'backend', 'lblSpecialInstructions', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Special instructions', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblStartTime', 'backend', 'lblStartTime', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Start time', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblState', 'backend', 'lblState', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'State', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblStatus', 'backend', 'lblStatus', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Status', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblSubject', 'backend', 'lblSubject', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Subject', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblSubTotal', 'backend', 'lblSubTotal', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Sub-total', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblTax', 'backend', 'lblTax', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tax', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblTimeFrom', 'backend', 'lblTimeFrom', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Time from', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblTimeTo', 'backend', 'lblTimeTo', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Time to', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblTitle', 'backend', 'lblTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Title', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblTo', 'backend', 'lblTo', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'to', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblToAdministrators', 'backend', 'lblToAdministrators', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'To Administrators', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblToCustomers', 'backend', 'lblToCustomers', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'To Customers', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblTotal', 'backend', 'lblTotal', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Total', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblTotalOrders', 'backend', 'lblTotalOrders', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'total orders', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblType', 'backend', 'lblType', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Type', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblUpdate', 'backend', 'lblUpdate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblUpdateCategory', 'backend', 'lblUpdateCategory', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update category', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblUpdateClient', 'backend', 'lblUpdateClient', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Edit client', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblUpdateCustomWTime', 'backend', 'lblUpdateCustomWTime', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update Custom Working Time', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblUpdateExtra', 'backend', 'lblUpdateExtra', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update Extra', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblUpdateLocation', 'backend', 'lblUpdateLocation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Edit location', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblUpdateOrder', 'backend', 'lblUpdateOrder', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update order', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblUpdateProduct', 'backend', 'lblUpdateProduct', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update product', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblUpdateUser', 'backend', 'lblUpdateUser', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update user', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblUpdateVoucher', 'backend', 'lblUpdateVoucher', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update voucher', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblUserCreated', 'backend', 'lblUserCreated', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Registration date/time', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblValid', 'backend', 'lblValid', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Valid', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblValidateTime', 'backend', 'lblValidateTime', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'End time must be greater than start time.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblValidateVoucherDateTime', 'backend', 'lblValidateVoucherDateTime', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'From date/time must be greater than To date/time.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblValue', 'backend', 'lblValue', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Value', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblViewAll', 'backend', 'lblViewAll', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'view all', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblVoucher', 'backend', 'lblVoucher', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Voucher', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblVoucherCode', 'backend', 'lblVoucherCode', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Voucher code', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblVoucherCodeExist', 'backend', 'lblVoucherCodeExist', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The voucher code was already used.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblWarning', 'backend', 'lblWarning', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Warning!', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblWorkingTimeDelivery', 'backend', 'lblWorkingTimeDelivery', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Working Time / Delivery', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblWorkingTimePickup', 'backend', 'lblWorkingTimePickup', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Working Time / Pickup', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblWTimeError', 'backend', 'lblWTimeError', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Start time cannot be equal to or greater than end time.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblWTimeErrorTitle', 'backend', 'lblWTimeErrorTitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Time Error!', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblYes', 'backend', 'lblYes', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Yes', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lblZip', 'backend', 'lblZip', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Zip', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'lnkBack', 'backend', 'lnkBack', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Back', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'localeArrays', 'backend', 'localeArrays', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Arrays titles', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'locales', 'backend', 'locales', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Languages', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'locale_flag', 'backend', 'locale_flag', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Flag', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'locale_is_default', 'backend', 'locale_is_default', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Is default', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'locale_order', 'backend', 'locale_order', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'locale_title', 'backend', 'locale_title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Title', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'login_err_ARRAY_1', 'backend', 'login_err_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Wrong username or password', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'login_err_ARRAY_2', 'backend', 'login_err_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Access denied', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'login_err_ARRAY_3', 'backend', 'login_err_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Account is disabled', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'login_messages_ARRAY_100', 'backend', 'login_messages_ARRAY_100', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'There is no such account in the system.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'login_messages_ARRAY_101', 'backend', 'login_messages_ARRAY_101', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your account is not active yet.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'login_messages_ARRAY_102', 'backend', 'login_messages_ARRAY_102', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Incorrect password. Please try again.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuBackup', 'backend', 'menuBackup', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuCategories', 'backend', 'menuCategories', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Categories', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuClientDetails', 'backend', 'menuClientDetails', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Form Fields', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuClients', 'backend', 'menuClients', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Clients', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuDashboard', 'backend', 'menuDashboard', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Dashboard', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuDeliveryForm', 'backend', 'menuDeliveryForm', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery Form', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuDeliveryPrices', 'backend', 'menuDeliveryPrices', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery fees', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuDetails', 'backend', 'menuDetails', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Details', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuExtras', 'backend', 'menuExtras', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Extras', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuGeneral', 'backend', 'menuGeneral', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'General', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuInstall', 'backend', 'menuInstall', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Install & Preview', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuIntegrationCode', 'backend', 'menuIntegrationCode', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Integration Code', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuLang', 'backend', 'menuLang', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Multi Lang', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuLocales', 'backend', 'menuLocales', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Languages', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuLocations', 'backend', 'menuLocations', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Locations', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuLogout', 'backend', 'menuLogout', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Logout', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuMenu', 'backend', 'menuMenu', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Menu', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuNotifications', 'backend', 'menuNotifications', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notifications', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuOptions', 'backend', 'menuOptions', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Options', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuOrderForm', 'backend', 'menuOrderForm', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order Form', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuOrders', 'backend', 'menuOrders', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Orders ', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuPlugins', 'backend', 'menuPlugins', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Plugins', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuPreview', 'backend', 'menuPreview', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Preview', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuPrintOrder', 'backend', 'menuPrintOrder', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Print Order', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuProducts', 'backend', 'menuProducts', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Products', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuProfile', 'backend', 'menuProfile', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Profile', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuReports', 'backend', 'menuReports', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reports', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuTerms', 'backend', 'menuTerms', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Terms', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuUsers', 'backend', 'menuUsers', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Users', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuVouchers', 'backend', 'menuVouchers', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Vouchers', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'menuWorkingTime', 'backend', 'menuWorkingTime', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Working time', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'months_ARRAY_1', 'backend', 'months_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'January', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'months_ARRAY_10', 'backend', 'months_ARRAY_10', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'October', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'months_ARRAY_11', 'backend', 'months_ARRAY_11', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'November', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'months_ARRAY_12', 'backend', 'months_ARRAY_12', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'December', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'months_ARRAY_2', 'backend', 'months_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'February', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'months_ARRAY_3', 'backend', 'months_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'March', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'months_ARRAY_4', 'backend', 'months_ARRAY_4', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'April', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'months_ARRAY_5', 'backend', 'months_ARRAY_5', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'May', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'months_ARRAY_6', 'backend', 'months_ARRAY_6', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'June', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'months_ARRAY_7', 'backend', 'months_ARRAY_7', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'July', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'months_ARRAY_8', 'backend', 'months_ARRAY_8', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'August', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'months_ARRAY_9', 'backend', 'months_ARRAY_9', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'September', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'multilangTooltip', 'backend', 'multilangTooltip', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Click on the flag icon to choose which language version of the content you wish to edit.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_admin_email_cancel', 'backend', 'notifications_ARRAY_admin_email_cancel', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send Cancellation email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_admin_email_confirmation', 'backend', 'notifications_ARRAY_admin_email_confirmation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New order received email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_admin_email_payment', 'backend', 'notifications_ARRAY_admin_email_payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send payment confirmation email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_admin_sms_confirmation', 'backend', 'notifications_ARRAY_admin_sms_confirmation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New order received SMS', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_admin_sms_payment', 'backend', 'notifications_ARRAY_admin_sms_payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment confirmation SMS', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_client_email_account', 'backend', 'notifications_ARRAY_client_email_account', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New client account email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_client_email_cancel', 'backend', 'notifications_ARRAY_client_email_cancel', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send cancellation email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_client_email_confirmation', 'backend', 'notifications_ARRAY_client_email_confirmation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New order received email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_client_email_forgot', 'backend', 'notifications_ARRAY_client_email_forgot', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send forgot password email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_client_email_payment', 'backend', 'notifications_ARRAY_client_email_payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send payment confirmation email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_client_sms_confirmation', 'backend', 'notifications_ARRAY_client_sms_confirmation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New order received SMS', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_do_not_send', 'backend', 'notifications_do_not_send', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Do not send', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_is_active', 'backend', 'notifications_is_active', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send this message', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_main_subtitle', 'backend', 'notifications_main_subtitle', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Automated messages are sent both to client and administrator(s) on specific events. Select message type to edit it - enable/disable or just change message text. For SMS notifications you need to enable SMS service. See more here.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_main_title', 'backend', 'notifications_main_title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notifications', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_message', 'backend', 'notifications_message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Message', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_msg_to_admin', 'backend', 'notifications_msg_to_admin', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Messages sent to Admin', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_msg_to_client', 'backend', 'notifications_msg_to_client', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Messages sent to Clients', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_msg_to_default', 'backend', 'notifications_msg_to_default', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Messages sent', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_recipient', 'backend', 'notifications_recipient', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Recipient', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_send', 'backend', 'notifications_send', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_sms_na', 'backend', 'notifications_sms_na', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'SMS notifications are currently not available for your website. See details', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_sms_na_here', 'backend', 'notifications_sms_na_here', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'here', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_status', 'backend', 'notifications_status', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Status', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_subject', 'backend', 'notifications_subject', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Subject', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_admin_email_cancel', 'backend', 'notifications_subtitles_ARRAY_admin_email_cancel', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This message is sent to the administrator when a client cancels an order.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_admin_email_confirmation', 'backend', 'notifications_subtitles_ARRAY_admin_email_confirmation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This message is sent to the administrator when a new order is made.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_admin_email_payment', 'backend', 'notifications_subtitles_ARRAY_admin_email_payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This message is sent to the administrator when a payment for a new order is made.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_admin_sms_confirmation', 'backend', 'notifications_subtitles_ARRAY_admin_sms_confirmation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This SMS is sent to administrator when a new order is made.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_admin_sms_payment', 'backend', 'notifications_subtitles_ARRAY_admin_sms_payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This SMS is sent to administrator when a payment is made for a new order.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_client_email_account', 'backend', 'notifications_subtitles_ARRAY_client_email_account', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This message is sent to the client when new account is created.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_client_email_cancel', 'backend', 'notifications_subtitles_ARRAY_client_email_cancel', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This message is sent to the client when a client cancels an order.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_client_email_confirmation', 'backend', 'notifications_subtitles_ARRAY_client_email_confirmation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This message is sent to client when a new order is made.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_client_email_forgot', 'backend', 'notifications_subtitles_ARRAY_client_email_forgot', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This message is sent to client when he requests for password recovery.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_client_email_payment', 'backend', 'notifications_subtitles_ARRAY_client_email_payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This message is sent to the client when a payment is made for a new order.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_client_sms_confirmation', 'backend', 'notifications_subtitles_ARRAY_client_sms_confirmation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This SMS is sent to client when a new order is made.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_admin_email_cancel', 'backend', 'notifications_titles_ARRAY_admin_email_cancel', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send Cancellation email sent to Admin', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_admin_email_confirmation', 'backend', 'notifications_titles_ARRAY_admin_email_confirmation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New Order Received email sent to Admin', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_admin_email_payment', 'backend', 'notifications_titles_ARRAY_admin_email_payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send Payment Confirmation email sent to Admin', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_admin_sms_confirmation', 'backend', 'notifications_titles_ARRAY_admin_sms_confirmation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order Confirmation SMS sent to Admin', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_admin_sms_payment', 'backend', 'notifications_titles_ARRAY_admin_sms_payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment Confirmation SMS sent to Admin', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_client_email_account', 'backend', 'notifications_titles_ARRAY_client_email_account', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New client account email sent to Client', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_client_email_cancel', 'backend', 'notifications_titles_ARRAY_client_email_cancel', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order Cancellation email sent to Client', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_client_email_confirmation', 'backend', 'notifications_titles_ARRAY_client_email_confirmation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order Confirmation email sent to Client', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_client_email_forgot', 'backend', 'notifications_titles_ARRAY_client_email_forgot', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send forgot password email to Client', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_client_email_payment', 'backend', 'notifications_titles_ARRAY_client_email_payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment Confirmation email sent to Client', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_client_sms_confirmation', 'backend', 'notifications_titles_ARRAY_client_sms_confirmation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order Confirmation SMS sent to Client', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_tokens', 'backend', 'notifications_tokens', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Available tokens:', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'notifications_tokens_note', 'backend', 'notifications_tokens_note', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Personalize the message by including any of the available tokens and it will be replaced with corresponding data.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'option_themes_ARRAY_1', 'backend', 'option_themes_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Theme 1', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'option_themes_ARRAY_10', 'backend', 'option_themes_ARRAY_10', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Theme 10', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'option_themes_ARRAY_2', 'backend', 'option_themes_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Theme 2', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'option_themes_ARRAY_3', 'backend', 'option_themes_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Theme 3', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'option_themes_ARRAY_4', 'backend', 'option_themes_ARRAY_4', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Theme 4', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'option_themes_ARRAY_5', 'backend', 'option_themes_ARRAY_5', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Theme 5', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'option_themes_ARRAY_6', 'backend', 'option_themes_ARRAY_6', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Theme 6', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'option_themes_ARRAY_7', 'backend', 'option_themes_ARRAY_7', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Theme 7', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'option_themes_ARRAY_8', 'backend', 'option_themes_ARRAY_8', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Theme 8', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'option_themes_ARRAY_9', 'backend', 'option_themes_ARRAY_9', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Theme 9', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_admin_email_cancel_text', 'backend', 'opt_o_admin_email_cancel_text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Select ''Yes'' if you want to receive email notifications when customers cancel their order. Otherwise select ''No''.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_admin_email_confirmation_text', 'backend', 'opt_o_admin_email_confirmation_text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Select ''Yes'' if you want to receive email notifications when a new order has been made. Otherwise select ''No''. ', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_admin_email_payment_text', 'backend', 'opt_o_admin_email_payment_text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Select ''Yes'' if you want to receive email notifications when new payment is received. Otherwise select ''No''. ', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_admin_sms_confirmation_message', 'backend', 'opt_o_admin_sms_confirmation_message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New order sms', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_admin_sms_confirmation_message_text', 'backend', 'opt_o_admin_sms_confirmation_message_text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '<u>Available Tokens:</u><br/>{Name}<br/>{Phone}<br/>{Email}<br/>{DateTime}<br/>{Location}<br/>{OrderID}<br/>{OrderDetails}<br/>{Subtotal}<br/>{Delivery}<br/>{Discount}<br/>{Total}', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_admin_sms_payment_message', 'backend', 'opt_o_admin_sms_payment_message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment confirmation sms', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_admin_sms_payment_message_text', 'backend', 'opt_o_admin_sms_payment_message_text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '<u>Available Tokens:</u><br/>{Name}<br/>{Phone}<br/>{Email}<br/>{DateTime}<br/>{Location}<br/>{OrderID}<br/>{OrderDetails}<br/>{Subtotal}<br/>{Delivery}<br/>{Discount}<br/>{Total}', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_allow_authorize', 'backend', 'opt_o_allow_authorize', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Allow payments with Authorize.net', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_allow_bank', 'backend', 'opt_o_allow_bank', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Provide Bank account details for wire transfers', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_allow_cash', 'backend', 'opt_o_allow_cash', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Allow cash payments', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_allow_creditcard', 'backend', 'opt_o_allow_creditcard', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Collect Credit Card details for offline processing', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_allow_paypal', 'backend', 'opt_o_allow_paypal', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Allow payments with PayPal ', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_authorize_md5_hash', 'backend', 'opt_o_authorize_md5_hash', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Authorize.net MD5 hash', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_authorize_merchant_id', 'backend', 'opt_o_authorize_merchant_id', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Authorize.net merchant ID', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_authorize_timezone', 'backend', 'opt_o_authorize_timezone', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Authorize.net time zone', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_authorize_transkey', 'backend', 'opt_o_authorize_transkey', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Authorize.net transaction key', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_bank_account', 'backend', 'opt_o_bank_account', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Bank account', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_bf_include_address_1', 'backend', 'opt_o_bf_include_address_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address line 1', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_bf_include_address_2', 'backend', 'opt_o_bf_include_address_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address line 2', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_bf_include_captcha', 'backend', 'opt_o_bf_include_captcha', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Captcha', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_bf_include_city', 'backend', 'opt_o_bf_include_city', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'City', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_bf_include_company', 'backend', 'opt_o_bf_include_company', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Company', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_bf_include_country', 'backend', 'opt_o_bf_include_country', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_bf_include_email', 'backend', 'opt_o_bf_include_email', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_bf_include_name', 'backend', 'opt_o_bf_include_name', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Name', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_bf_include_notes', 'backend', 'opt_o_bf_include_notes', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notes', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_bf_include_phone', 'backend', 'opt_o_bf_include_phone', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Phone', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_bf_include_state', 'backend', 'opt_o_bf_include_state', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'State', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_bf_include_title', 'backend', 'opt_o_bf_include_title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Title', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_bf_include_zip', 'backend', 'opt_o_bf_include_zip', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Zip', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_booking_status', 'backend', 'opt_o_booking_status', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Status of new orders that are not paid yet ', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_currency', 'backend', 'opt_o_currency', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Currency', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_datetime_format', 'backend', 'opt_o_datetime_format', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Date/Time format', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_date_format', 'backend', 'opt_o_date_format', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Date format', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_deposit_payment', 'backend', 'opt_o_deposit_payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Deposit payment:<br>Percentage of the total order amount that will be charged during the online order.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_df_include_address_1', 'backend', 'opt_o_df_include_address_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address Line 1', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_df_include_address_2', 'backend', 'opt_o_df_include_address_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address Line 2', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_df_include_city', 'backend', 'opt_o_df_include_city', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'City', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_df_include_country', 'backend', 'opt_o_df_include_country', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_df_include_notes', 'backend', 'opt_o_df_include_notes', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Special instructions', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_df_include_state', 'backend', 'opt_o_df_include_state', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'County/Region/State', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_df_include_zip', 'backend', 'opt_o_df_include_zip', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Postcode/Zip code', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_account_message', 'backend', 'opt_o_email_account_message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New client account message', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_account_message_text', 'backend', 'opt_o_email_account_message_text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '<u>Available Tokens:</u><br/>{Title}<br/>{Name}<br/>{Email}<br/>{Password}<br/>{Phone}<br/>{Address1}<br/>{Address2}<br/>{Country}<br/>{State}<br/>{City}<br/>{Zip}', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_account_subject', 'backend', 'opt_o_email_account_subject', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New client account subject', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_cancel', 'backend', 'opt_o_email_cancel', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send cancellation email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_cancel_message', 'backend', 'opt_o_email_cancel_message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancel confirmation message', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_cancel_message_text', 'backend', 'opt_o_email_cancel_message_text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '<u>Available Tokens:</u><br/>{Name}<br/>{Email}<br/>{Phone}<br/>{Notes}<br/>{Country}<br/>{City}<br/>{State}<br/>{Zip}<br/>{Address1}<br/>{Address2}<br/>[Delivery]..[/Delivery]<br/>{dCountry}<br/>{dCity}<br/>{dState}<br/>{dZip}<br/>{dAddress1}<br/>{dAddress2}<br/>{dNotes}<br/>{DateTime}<br/>{Location}<br/>{OrderID}<br/>{OrderDetails}<br/>{Subtotal}<br/>{Delivery}<br/>{Discount}<br/>{Tax}<br/>{Total}<br/>{PaymentMethod}<br/>{CCType}<br/>{CCNum}<br/>{CCExp}<br/>{CCSec}<br/>{CancelURL}', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_cancel_subject', 'backend', 'opt_o_email_cancel_subject', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancel confirmation subject', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_cancel_text', 'backend', 'opt_o_email_cancel_text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Select ''Yes'' if you want to notify customers for canceling their order. ', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_confirmation', 'backend', 'opt_o_email_confirmation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New order received email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_confirmation_message', 'backend', 'opt_o_email_confirmation_message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order confirmation message', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_confirmation_message_text', 'backend', 'opt_o_email_confirmation_message_text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '<u>Available Tokens:</u><br/>{Name}<br/>{Email}<br/>{Phone}<br/>{Notes}<br/>{Country}<br/>{City}<br/>{State}<br/>{Zip}<br/>{Address1}<br/>{Address2}<br/>[Delivery]..[/Delivery]<br/>{dCountry}<br/>{dCity}<br/>{dState}<br/>{dZip}<br/>{dAddress1}<br/>{dAddress2}<br/>{dNotes}<br/>{DateTime}<br/>{Location}<br/>{OrderID}<br/>{OrderDetails}<br/>{Subtotal}<br/>{Delivery}<br/>{Discount}<br/>{Tax}<br/>{Total}<br/>{PaymentMethod}<br/>{CCType}<br/>{CCNum}<br/>{CCExp}<br/>{CCSec}<br/>{CancelURL}', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_confirmation_subject', 'backend', 'opt_o_email_confirmation_subject', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order confirmation subject', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_confirmation_text', 'backend', 'opt_o_email_confirmation_text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Select ''Yes'' if you''d like to let your customers know that you received their order. ', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_forgot_message', 'backend', 'opt_o_email_forgot_message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Forgot password message', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_forgot_message_text', 'backend', 'opt_o_email_forgot_message_text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '<u>Available tokens:</u><br/>{Name}<br/>{Email}<br/>{Password}', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_forgot_subject', 'backend', 'opt_o_email_forgot_subject', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Forgot password subject', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_payment', 'backend', 'opt_o_email_payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send payment confirmation email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_payment_message', 'backend', 'opt_o_email_payment_message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment confirmation message', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_payment_message_text', 'backend', 'opt_o_email_payment_message_text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '<u>Available Tokens:</u><br/>{Name}<br/>{Email}<br/>{Phone}<br/>{Notes}<br/>{Country}<br/>{City}<br/>{State}<br/>{Zip}<br/>{Address1}<br/>{Address2}<br/>[Delivery]..[/Delivery]<br/>{dCountry}<br/>{dCity}<br/>{dState}<br/>{dZip}<br/>{dAddress1}<br/>{dAddress2}<br/>{dNotes}<br/>{DateTime}<br/>{Location}<br/>{OrderID}<br/>{OrderDetails}<br/>{Subtotal}<br/>{Delivery}<br/>{Discount}<br/>{Tax}<br/>{Total}<br/>{PaymentMethod}<br/>{CCType}<br/>{CCNum}<br/>{CCExp}<br/>{CCSec}<br/>{CancelURL}', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_payment_subject', 'backend', 'opt_o_email_payment_subject', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment confirmation subject', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_email_payment_text', 'backend', 'opt_o_email_payment_text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Select ''Yes'' if you want to notify your customers for receiving their payment.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_google_map_api', 'backend', 'opt_o_google_map_api', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Google Map API key', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_minimum_order', 'backend', 'opt_o_minimum_order', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Minimum order amount for delivery', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_payment_disable', 'backend', 'opt_o_payment_disable', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Disable payments', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_payment_disable_text', 'backend', 'opt_o_payment_disable_text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Select "Yes" if you want to disable payments and only collect order details.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_payment_status', 'backend', 'opt_o_payment_status', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Status that orders (new and old) will get after they are paid online.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_paypal_address', 'backend', 'opt_o_paypal_address', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'PayPal business email address', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_pf_include_notes', 'backend', 'opt_o_pf_include_notes', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Special instructions', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_print_order', 'backend', 'opt_o_print_order', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Print template', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_print_order_text', 'backend', 'opt_o_print_order_text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '<u>Available Tokens:</u><br/>{Name}<br/>{Email}<br/>{Phone}<br/>{Notes}<br/>{Country}<br/>{City}<br/>{State}<br/>{Zip}<br/>{Address1}<br/>{Address2}<br/>[Delivery]..[/Delivery]<br/>{dCountry}<br/>{dCity}<br/>{dState}<br/>{dZip}<br/>{dAddress1}<br/>{dAddress2}<br/>{dNotes}<br/>{DateTime}<br/>{Location}<br/>{OrderID}<br/>{OrderDetails}<br/>{Subtotal}<br/>{Delivery}<br/>{Discount}<br/>{Tax}<br/>{Total}<br/>{PaymentMethod}<br/>{CCType}<br/>{CCNum}<br/>{CCExp}<br/>{CCSec}<br/>{CancelURL}', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_sender_email', 'backend', 'opt_o_sender_email', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Sender email (for email notifications)', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_send_email', 'backend', 'opt_o_send_email', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send email', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_sms_confirmation_message', 'backend', 'opt_o_sms_confirmation_message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order reminder SMS', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_sms_confirmation_message_text', 'backend', 'opt_o_sms_confirmation_message_text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '<u>Available Tokens:</u><br/>{Name}<br/>{Phone}<br/>{Email}<br/>{DateTime}<br/>{Location}<br/>{OrderID}<br/>{OrderDetails}<br/>{Subtotal}<br/>{Delivery}<br/>{Discount}<br/>{Total}', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_smtp_host', 'backend', 'opt_o_smtp_host', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'SMTP Host', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_smtp_pass', 'backend', 'opt_o_smtp_pass', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'SMTP Password', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_smtp_port', 'backend', 'opt_o_smtp_port', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'SMTP Port', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_smtp_user', 'backend', 'opt_o_smtp_user', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'SMTP Username', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_tax_payment', 'backend', 'opt_o_tax_payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tax payment', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_terms', 'backend', 'opt_o_terms', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Terms and Conditions', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_thankyou_page', 'backend', 'opt_o_thankyou_page', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Confirmation page', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_thankyou_page_text', 'backend', 'opt_o_thankyou_page_text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'URL for the web page where your clients will be redirected after online payment', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_timezone', 'backend', 'opt_o_timezone', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Timezone', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_time_format', 'backend', 'opt_o_time_format', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Time format', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'opt_o_week_start', 'backend', 'opt_o_week_start', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'First day of the week', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'order_statuses_ARRAY_cancelled', 'backend', 'order_statuses_ARRAY_cancelled', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancelled', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'order_statuses_ARRAY_confirmed', 'backend', 'order_statuses_ARRAY_confirmed', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Confirmed', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'order_statuses_ARRAY_pending', 'backend', 'order_statuses_ARRAY_pending', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pending', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pass', 'backend', 'pass', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Password', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'payment_methods_ARRAY_bank', 'backend', 'payment_methods_ARRAY_bank', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Bank account', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'payment_methods_ARRAY_cash', 'backend', 'payment_methods_ARRAY_cash', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cash', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'payment_methods_ARRAY_creditcard', 'backend', 'payment_methods_ARRAY_creditcard', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Credit card', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'payment_methods_ARRAY_paypal', 'backend', 'payment_methods_ARRAY_paypal', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'PayPal', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'personal_titles_ARRAY_dr', 'backend', 'personal_titles_ARRAY_dr', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Dr.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'personal_titles_ARRAY_miss', 'backend', 'personal_titles_ARRAY_miss', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Miss', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'personal_titles_ARRAY_mr', 'backend', 'personal_titles_ARRAY_mr', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Mr.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'personal_titles_ARRAY_mrs', 'backend', 'personal_titles_ARRAY_mrs', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Mrs.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'personal_titles_ARRAY_ms', 'backend', 'personal_titles_ARRAY_ms', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Ms.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'personal_titles_ARRAY_other', 'backend', 'personal_titles_ARRAY_other', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Other', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'personal_titles_ARRAY_prof', 'backend', 'personal_titles_ARRAY_prof', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Prof.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'personal_titles_ARRAY_rev', 'backend', 'personal_titles_ARRAY_rev', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Rev.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminCategories', 'backend', 'pjAdminCategories', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Categories Menu', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminCategories_pjActionCreateForm', 'backend', 'pjAdminCategories_pjActionCreateForm', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add categories', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminCategories_pjActionDeleteCategory', 'backend', 'pjAdminCategories_pjActionDeleteCategory', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete single product', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminCategories_pjActionDeleteCategoryBulk', 'backend', 'pjAdminCategories_pjActionDeleteCategoryBulk', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete multiple categories', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminCategories_pjActionIndex', 'backend', 'pjAdminCategories_pjActionIndex', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Categories List', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminCategories_pjActionUpdateForm', 'backend', 'pjAdminCategories_pjActionUpdateForm', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Edit categories', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminClients', 'backend', 'pjAdminClients', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Clients Menu', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminClients_pjActionCreate', 'backend', 'pjAdminClients_pjActionCreate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add clients', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminClients_pjActionDeleteClient', 'backend', 'pjAdminClients_pjActionDeleteClient', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete single client', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminClients_pjActionDeleteClientBulk', 'backend', 'pjAdminClients_pjActionDeleteClientBulk', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete multiple clients', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminClients_pjActionExportClient', 'backend', 'pjAdminClients_pjActionExportClient', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Export clients', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminClients_pjActionIndex', 'backend', 'pjAdminClients_pjActionIndex', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Clients List', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminClients_pjActionStatusClient', 'backend', 'pjAdminClients_pjActionStatusClient', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Revert clients status', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminClients_pjActionUpdate', 'backend', 'pjAdminClients_pjActionUpdate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Edit clients', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminExtras', 'backend', 'pjAdminExtras', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Extras Menu', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminExtras_pjActionCreateForm', 'backend', 'pjAdminExtras_pjActionCreateForm', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add extras', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminExtras_pjActionDeleteExtra', 'backend', 'pjAdminExtras_pjActionDeleteExtra', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete single extra', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminExtras_pjActionDeleteExtraBulk', 'backend', 'pjAdminExtras_pjActionDeleteExtraBulk', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete multiple extras', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminExtras_pjActionIndex', 'backend', 'pjAdminExtras_pjActionIndex', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Extras List', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminExtras_pjActionUpdateForm', 'backend', 'pjAdminExtras_pjActionUpdateForm', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Edit extras', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminLocations', 'backend', 'pjAdminLocations', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Locations Menu', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminLocations_pjActionCreate', 'backend', 'pjAdminLocations_pjActionCreate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add locations', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminLocations_pjActionDeleteLocation', 'backend', 'pjAdminLocations_pjActionDeleteLocation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete single location', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminLocations_pjActionDeleteLocationBulk', 'backend', 'pjAdminLocations_pjActionDeleteLocationBulk', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete multiple locations', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminLocations_pjActionIndex', 'backend', 'pjAdminLocations_pjActionIndex', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Locations List', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminLocations_pjActionPrice', 'backend', 'pjAdminLocations_pjActionPrice', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Manage Delivery fees', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminLocations_pjActionUpdate', 'backend', 'pjAdminLocations_pjActionUpdate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Edit locations', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminOptions', 'backend', 'pjAdminOptions', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Settings Menu', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionInstall', 'backend', 'pjAdminOptions_pjActionInstall', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Integration Code Menu', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionNotifications', 'backend', 'pjAdminOptions_pjActionNotifications', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notifications', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionOrderForm', 'backend', 'pjAdminOptions_pjActionOrderForm', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order Form', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionOrders', 'backend', 'pjAdminOptions_pjActionOrders', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Orders Options', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionPayments', 'backend', 'pjAdminOptions_pjActionPayments', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment Options', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionPreview', 'backend', 'pjAdminOptions_pjActionPreview', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Preview Menu', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionPrintOrder', 'backend', 'pjAdminOptions_pjActionPrintOrder', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Print Order', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionTerm', 'backend', 'pjAdminOptions_pjActionTerm', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Terms & Conditions', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminOrders', 'backend', 'pjAdminOrders', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Orders Menu', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminOrders_pjActionCreate', 'backend', 'pjAdminOrders_pjActionCreate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add orders', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminOrders_pjActionDeleteOrder', 'backend', 'pjAdminOrders_pjActionDeleteOrder', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete single order', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminOrders_pjActionDeleteOrderBulk', 'backend', 'pjAdminOrders_pjActionDeleteOrderBulk', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete multiple orders', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminOrders_pjActionExportOrder', 'backend', 'pjAdminOrders_pjActionExportOrder', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Export orders', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminOrders_pjActionIndex', 'backend', 'pjAdminOrders_pjActionIndex', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Orders List', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminOrders_pjActionUpdate', 'backend', 'pjAdminOrders_pjActionUpdate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Edit orders', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminProducts', 'backend', 'pjAdminProducts', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Products Menu', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminProducts_pjActionCreate', 'backend', 'pjAdminProducts_pjActionCreate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add products', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminProducts_pjActionDeleteProduct', 'backend', 'pjAdminProducts_pjActionDeleteProduct', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete single product', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminProducts_pjActionDeleteProductBulk', 'backend', 'pjAdminProducts_pjActionDeleteProductBulk', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete multiple products', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminProducts_pjActionIndex', 'backend', 'pjAdminProducts_pjActionIndex', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Products List', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminProducts_pjActionUpdate', 'backend', 'pjAdminProducts_pjActionUpdate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Edit products', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminReports_pjActionIndex', 'backend', 'pjAdminReports_pjActionIndex', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reports Menu', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdminTime_pjActionIndex', 'backend', 'pjAdminTime_pjActionIndex', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Manage pickup and delivery working time', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pjAdmin_pjActionIndex', 'backend', 'pjAdmin_pjActionIndex', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Dashboard', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'pj_email_taken', 'backend', 'pj_email_taken', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'User with such email address exists.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'promo_statuses_ARRAY_100', 'backend', 'promo_statuses_ARRAY_100', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Missing parameters', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'promo_statuses_ARRAY_101', 'backend', 'promo_statuses_ARRAY_101', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Promo code not found', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'promo_statuses_ARRAY_102', 'backend', 'promo_statuses_ARRAY_102', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Promo code is out of date', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'promo_statuses_ARRAY_103', 'backend', 'promo_statuses_ARRAY_103', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Date is empty', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'promo_statuses_ARRAY_200', 'backend', 'promo_statuses_ARRAY_200', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Promo code has been accepted', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'recipients_ARRAY_admin', 'backend', 'recipients_ARRAY_admin', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Administrator', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'recipients_ARRAY_client', 'backend', 'recipients_ARRAY_client', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Client', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'recipient_admin_note', 'backend', 'recipient_admin_note', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Go to <a href="index.php?controller=pjBaseUsers&action=pjActionIndex">Users menu</a> and edit each administrator profile to select if they should receive "Admin notifications" or not.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'report_category', 'backend', 'report_category', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Category', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'report_confirmed', 'backend', 'report_confirmed', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Confirmed', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'report_delivery', 'backend', 'report_delivery', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'report_delivery_fees', 'backend', 'report_delivery_fees', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery fees', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'report_discounts', 'backend', 'report_discounts', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Discounts', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'report_first_time_clients', 'backend', 'report_first_time_clients', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'First time clients', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'report_pickup', 'backend', 'report_pickup', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pick up', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'report_product', 'backend', 'report_product', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Product', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'report_products_ordered', 'backend', 'report_products_ordered', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Products ordered', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'report_quantity', 'backend', 'report_quantity', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Quantity', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'report_tax', 'backend', 'report_tax', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tax', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'report_total_amount', 'backend', 'report_total_amount', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Total amount', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'report_total_orders', 'backend', 'report_total_orders', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Total orders', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'report_total_products_ordered', 'backend', 'report_total_products_ordered', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Total products ordered', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'report_unique_clients', 'backend', 'report_unique_clients', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Unique clients', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'revert_status', 'backend', 'revert_status', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Revert status', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'script_change_labels', 'backend', 'script_change_labels', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Change Labels', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'script_install_your_website', 'backend', 'script_install_your_website', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Install your website', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'script_menu_payments', 'backend', 'script_menu_payments', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payments', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'script_menu_settings', 'backend', 'script_menu_settings', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Settings', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'script_name', 'backend', 'script_name', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Food Delivery', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'script_offline_payment', 'backend', 'script_offline_payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Offline payments', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'script_offline_payment_methods', 'backend', 'script_offline_payment_methods', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Offline Payment Methods', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'script_online_payment_gateway', 'backend', 'script_online_payment_gateway', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Online payments', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'script_preview_your_website', 'backend', 'script_preview_your_website', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Open in new window', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_days_ARRAY_0', 'backend', 'short_days_ARRAY_0', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Su', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_days_ARRAY_1', 'backend', 'short_days_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Mo', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_days_ARRAY_2', 'backend', 'short_days_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tu', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_days_ARRAY_3', 'backend', 'short_days_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_days_ARRAY_4', 'backend', 'short_days_ARRAY_4', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Th', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_days_ARRAY_5', 'backend', 'short_days_ARRAY_5', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Fr', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_days_ARRAY_6', 'backend', 'short_days_ARRAY_6', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Sa', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_1', 'backend', 'short_months_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Jan', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_10', 'backend', 'short_months_ARRAY_10', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Oct', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_11', 'backend', 'short_months_ARRAY_11', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Nov', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_12', 'backend', 'short_months_ARRAY_12', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Dec', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_2', 'backend', 'short_months_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Feb', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_3', 'backend', 'short_months_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Mar', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_4', 'backend', 'short_months_ARRAY_4', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Apr', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_5', 'backend', 'short_months_ARRAY_5', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'May', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_6', 'backend', 'short_months_ARRAY_6', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Jun', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_7', 'backend', 'short_months_ARRAY_7', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Jul', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_8', 'backend', 'short_months_ARRAY_8', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Aug', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_9', 'backend', 'short_months_ARRAY_9', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Sep', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'status_ARRAY_1', 'backend', 'status_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You are not loged in.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'status_ARRAY_123', 'backend', 'status_ARRAY_123', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your hosting account does not allow uploading such a large image.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'status_ARRAY_2', 'backend', 'status_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Access denied. You have not requisite rights to.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'status_ARRAY_3', 'backend', 'status_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Empty resultset.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'status_ARRAY_7', 'backend', 'status_ARRAY_7', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The operation is not allowed in demo mode.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'status_ARRAY_996', 'backend', 'status_ARRAY_996', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No property for the reservation found', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'status_ARRAY_997', 'backend', 'status_ARRAY_997', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No reservation found', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'status_ARRAY_998', 'backend', 'status_ARRAY_998', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No permisions to edit the reservation', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'status_ARRAY_999', 'backend', 'status_ARRAY_999', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No permisions to edit the property', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'status_ARRAY_9997', 'backend', 'status_ARRAY_9997', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'E-Mail address already exist', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'status_ARRAY_9998', 'backend', 'status_ARRAY_9998', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your registration was successfull. Your account needs to be approved.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'status_ARRAY_9999', 'backend', 'status_ARRAY_9999', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your registration was successfull.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'tabClientDetails', 'backend', 'tabClientDetails', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Client Details', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-10800', 'backend', 'timezones_ARRAY_-10800', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-03:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-14400', 'backend', 'timezones_ARRAY_-14400', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-04:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-18000', 'backend', 'timezones_ARRAY_-18000', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-05:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-21600', 'backend', 'timezones_ARRAY_-21600', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-06:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-25200', 'backend', 'timezones_ARRAY_-25200', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-07:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-28800', 'backend', 'timezones_ARRAY_-28800', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-08:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-32400', 'backend', 'timezones_ARRAY_-32400', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-09:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-3600', 'backend', 'timezones_ARRAY_-3600', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-01:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-36000', 'backend', 'timezones_ARRAY_-36000', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-10:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-39600', 'backend', 'timezones_ARRAY_-39600', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-11:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-43200', 'backend', 'timezones_ARRAY_-43200', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-12:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-7200', 'backend', 'timezones_ARRAY_-7200', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-02:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_0', 'backend', 'timezones_ARRAY_0', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_10800', 'backend', 'timezones_ARRAY_10800', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+03:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_14400', 'backend', 'timezones_ARRAY_14400', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+04:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_18000', 'backend', 'timezones_ARRAY_18000', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+05:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_21600', 'backend', 'timezones_ARRAY_21600', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+06:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_25200', 'backend', 'timezones_ARRAY_25200', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+07:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_28800', 'backend', 'timezones_ARRAY_28800', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+08:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_32400', 'backend', 'timezones_ARRAY_32400', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+09:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_3600', 'backend', 'timezones_ARRAY_3600', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+01:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_36000', 'backend', 'timezones_ARRAY_36000', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+10:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_39600', 'backend', 'timezones_ARRAY_39600', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+11:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_43200', 'backend', 'timezones_ARRAY_43200', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+12:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_46800', 'backend', 'timezones_ARRAY_46800', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+13:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_7200', 'backend', 'timezones_ARRAY_7200', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+02:00', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'types_ARRAY_delivery', 'backend', 'types_ARRAY_delivery', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delivery', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'types_ARRAY_pickup', 'backend', 'types_ARRAY_pickup', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pickup', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'type_err_ARRAY_0', 'backend', 'type_err_ARRAY_0', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Click on delivery area on the map.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'type_err_ARRAY_1', 'backend', 'type_err_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Restaurant is closed on the selected date.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'type_err_ARRAY_2', 'backend', 'type_err_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Please choose a date.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'type_err_ARRAY_3', 'backend', 'type_err_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Selected date working time is over. Please choose another date.', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'url', 'backend', 'url', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'URL', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'user', 'backend', 'user', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Username', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'u_statarr_ARRAY_F', 'backend', 'u_statarr_ARRAY_F', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Inactive', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'u_statarr_ARRAY_T', 'backend', 'u_statarr_ARRAY_T', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Active', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'voucher_days_ARRAY_friday', 'backend', 'voucher_days_ARRAY_friday', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Friday', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'voucher_days_ARRAY_monday', 'backend', 'voucher_days_ARRAY_monday', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Monday', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'voucher_days_ARRAY_saturday', 'backend', 'voucher_days_ARRAY_saturday', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Saturday', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'voucher_days_ARRAY_sunday', 'backend', 'voucher_days_ARRAY_sunday', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Sunday', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'voucher_days_ARRAY_thursday', 'backend', 'voucher_days_ARRAY_thursday', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Thursday', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'voucher_days_ARRAY_tuesday', 'backend', 'voucher_days_ARRAY_tuesday', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tuesday', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'voucher_days_ARRAY_wednesday', 'backend', 'voucher_days_ARRAY_wednesday', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Wednesday', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'voucher_types_ARRAY_amount', 'backend', 'voucher_types_ARRAY_amount', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Amount', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'voucher_types_ARRAY_percent', 'backend', 'voucher_types_ARRAY_percent', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Percent', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'voucher_valids_ARRAY_fixed', 'backend', 'voucher_valids_ARRAY_fixed', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Fixed', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'voucher_valids_ARRAY_period', 'backend', 'voucher_valids_ARRAY_period', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Period', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, 'voucher_valids_ARRAY_recurring', 'backend', 'voucher_valids_ARRAY_recurring', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Recurring', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, '_yesno_ARRAY_F', 'backend', '_yesno_ARRAY_F', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No', 'script');

INSERT INTO `food_delivery_plugin_base_fields` VALUES (NULL, '_yesno_ARRAY_T', 'backend', '_yesno_ARRAY_T', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `food_delivery_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Yes', 'script');