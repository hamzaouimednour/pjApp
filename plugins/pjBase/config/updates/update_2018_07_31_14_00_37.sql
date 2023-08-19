
START TRANSACTION;

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_menu_countries', 'backend', 'Plugin Base / Menu / Countries', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Countries', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_infobox_countries_title', 'backend', 'Plugin Base / Infobox / Countries', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Countries', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_infobox_countries_desc', 'backend', 'Plugin Base / Infobox / Countries', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use grid below to organize your country list.', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_infobox_add_country_title', 'backend', 'Plugin Base / Infobox / Add country', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add country', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_infobox_add_country_desc', 'backend', 'Plugin Base / Infobox / Add country desc', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use form below to add a country.', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_infobox_update_country_title', 'backend', 'Plugin Base / Infobox / Update country', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update country', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_infobox_update_country_desc', 'backend', 'Plugin Base / Infobox / Update country desc', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use form below to update a country.', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_error_titles_ARRAY_PCY01', 'arrays', 'plugin_base_error_titles_ARRAY_PCY01', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country updated', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_error_titles_ARRAY_PCY03', 'arrays', 'plugin_base_error_titles_ARRAY_PCY03', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country added', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_error_titles_ARRAY_PCY04', 'arrays', 'plugin_base_error_titles_ARRAY_PCY04', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country failed to add', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_error_titles_ARRAY_PCY08', 'arrays', 'plugin_base_error_titles_ARRAY_PCY08', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country not found', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_error_bodies_ARRAY_PCY01', 'arrays', 'plugin_base_error_bodies_ARRAY_PCY01', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country has been updated successfully.', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_error_bodies_ARRAY_PCY03', 'arrays', 'plugin_base_error_bodies_ARRAY_PCY03', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country has been added successfully.', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_error_bodies_ARRAY_PCY04', 'arrays', 'plugin_base_error_bodies_ARRAY_PCY04', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country has not been added successfully.', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_error_bodies_ARRAY_PCY08', 'arrays', 'plugin_base_error_bodies_ARRAY_PCY08', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country you are looking for has not been found.', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_btn_add_country', 'backend', 'Plugin Base / Buttons / Add country', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add country', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_country_name', 'backend', 'Plugin Base / Label / Country name', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country name', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_alpha_2', 'backend', 'Plugin Base / Label / Alpha 2', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Alpha 2', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_alpha_3', 'backend', 'Plugin Base / Label / Alpha 3', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Alpha 3', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_duplicated_alpha_2', 'backend', 'Plugin Base / Label / Duplicated alpha 2', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Duplicated alpha 2', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'plugin_base_duplicated_alpha_3', 'backend', 'Plugin Base / Label / Duplicated alpha 3', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Duplicated alpha 3', 'plugin');

COMMIT;