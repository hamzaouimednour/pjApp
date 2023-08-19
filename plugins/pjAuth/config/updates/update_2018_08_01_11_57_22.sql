
START TRANSACTION;

INSERT INTO `plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjBaseUsers_pjActionProfile');
SET @level_1_id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @level_1_id, 'pjAuthPermission', '::LOCALE::', 'title', 'Profile', 'data');

COMMIT;