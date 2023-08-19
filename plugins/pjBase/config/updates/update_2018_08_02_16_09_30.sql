
START TRANSACTION;

INSERT INTO `plugin_base_multi_lang` VALUES (NULL, 1, 'pjBaseOption', '::LOCALE::', 'o_failed_login_send_email_subject', 'Your account has been locked!', 'data');
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, 1, 'pjBaseOption', '::LOCALE::', 'o_failed_login_send_email_message', '<p>Dear {Name},</p>\r\n<p>We''ve detected {LoginAttempts} unsuccessful attempts to login your account.</p>\r\n<p>For security reasons we locked down your account.</p>\r\n<p>To unlock your account please contact us.</p>\r\n<p>Regards!</p>', 'data');

INSERT INTO `plugin_base_multi_lang` VALUES (NULL, 1, 'pjBaseOption', '::LOCALE::', 'o_failed_login_send_sms_message', 'Dear {Name}, your account has been locked. For more details contact us.', 'data');

INSERT INTO `plugin_base_multi_lang` VALUES (NULL, 1, 'pjBaseOption', '::LOCALE::', 'o_forgot_email_subject', 'Password reminder', 'data');
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, 1, 'pjBaseOption', '::LOCALE::', 'o_forgot_email_message', '<p>Dear {Name},</p>\r\n<p>We''ve just received a request to reset your password.</p>\r\n<p>To confirm this process is initiated from you please click the following link:<br /><a href="{URL}">{URL}</a></p>\r\n<p>Otherwise, you don''t need to do anything and ignore this email.</p>\r\n<p>Regards!</p>', 'data');

INSERT INTO `plugin_base_multi_lang` VALUES (NULL, 1, 'pjBaseOption', '::LOCALE::', 'o_forgot_sms_message', 'Reset your password: {URL}', 'data');

INSERT INTO `plugin_base_multi_lang` VALUES (NULL, 1, 'pjBaseOption', '::LOCALE::', 'o_forgot_contact_admin_subject', 'Password reminder was used', 'data');
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, 1, 'pjBaseOption', '::LOCALE::', 'o_forgot_contact_admin_message', '<p>Password reminder was sent to {Name} with email {Email}.</p>', 'data');


INSERT INTO `plugin_base_fields` VALUES (NULL, 'opt_o_forgot_sms_message_text', 'backend', 'Plugin Base / Options / Forgot password SMS message text', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '<div class="col-xs-6"><p>{Name}</p><p>{Email}</p><p>{Phone}</p><p>{URL}</p></div>', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'opt_o_forgot_contact_admin_message_text', 'backend', 'Plugin Base / Options / Contact admin email message text', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '<div class="col-xs-6"><p>{Name}</p><p>{Email}</p><p>{Phone}</p><p>{URL}</p></div>', 'plugin');

COMMIT;