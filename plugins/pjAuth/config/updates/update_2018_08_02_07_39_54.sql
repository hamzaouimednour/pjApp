
START TRANSACTION;

ALTER TABLE `plugin_auth_permissions` ADD COLUMN `inherit_id` int(10) unsigned DEFAULT NULL AFTER `parent_id`;

SET @level_2_id := (SELECT `id` FROM `plugin_auth_permissions` WHERE `key` = 'pjBasePermissions_pjActionUserPermission' LIMIT 1);
INSERT INTO `plugin_auth_permissions` (`id`, `parent_id`, `key`, `inherit_id`) VALUES (NULL, NULL, 'pjBasePermissions_pjActionAjaxSet', @level_2_id);

INSERT INTO `plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjBaseCountries');
SET @level_1_id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @level_1_id, 'pjAuthPermission', '::LOCALE::', 'title', 'Countries Menu', 'data');

  INSERT INTO `plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjBaseCountries_pjActionCreate');
  SET @level_2_id := (SELECT LAST_INSERT_ID());
  INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @level_2_id, 'pjAuthPermission', '::LOCALE::', 'title', 'Create country', 'data');

  INSERT INTO `plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjBaseCountries_pjActionUpdate');
  SET @level_2_id := (SELECT LAST_INSERT_ID());
  INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @level_2_id, 'pjAuthPermission', '::LOCALE::', 'title', 'Update Country', 'data');

  INSERT INTO `plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjBaseCountries_pjActionIndex');
  SET @level_2_id := (SELECT LAST_INSERT_ID());
  INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @level_2_id, 'pjAuthPermission', '::LOCALE::', 'title', 'Countries List', 'data');
  
  	INSERT INTO `plugin_auth_permissions` (`id`, `parent_id`, `key`, `inherit_id`) VALUES (NULL, NULL, 'pjBaseCountries_pjActionGetCountry', @level_2_id);
	
    INSERT INTO `plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjBaseCountries_pjActionDeleteCountry');
    SET @level_3_id := (SELECT LAST_INSERT_ID());
    INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @level_3_id, 'pjAuthPermission', '::LOCALE::', 'title', 'Delete single country', 'data');

    INSERT INTO `plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjBaseCountries_pjActionDeleteCountryBulk');
    SET @level_3_id := (SELECT LAST_INSERT_ID());
    INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @level_3_id, 'pjAuthPermission', '::LOCALE::', 'title', 'Delete multiple countries', 'data');

    INSERT INTO `plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjBaseCountries_pjActionStatusCountry');
    SET @level_3_id := (SELECT LAST_INSERT_ID());
    INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @level_3_id, 'pjAuthPermission', '::LOCALE::', 'title', 'Revert country status', 'data');

COMMIT;