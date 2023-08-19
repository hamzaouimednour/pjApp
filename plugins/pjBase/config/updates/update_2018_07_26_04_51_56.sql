
START TRANSACTION;

UPDATE `plugin_base_options` SET `value`='Yes|No::No' WHERE `key`='o_secure_login_use_captcha';

COMMIT;