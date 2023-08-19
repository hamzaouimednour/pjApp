
START TRANSACTION;

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_infobox_user_profile_title', 'backend', 'Plugin Base / Infobox / User Profile', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'User Profile', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_infobox_user_profile_desc', 'backend', 'Plugin Base / Infobox / User Profile', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reivew and update your profile.', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_menu_role_permissions', 'backend', 'Plugin Base / Menu / Role permissions', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Role permissions', 'plugin');

COMMIT;