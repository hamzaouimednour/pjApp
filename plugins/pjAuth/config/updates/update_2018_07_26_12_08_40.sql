
START TRANSACTION;

ALTER TABLE `plugin_auth_roles` ADD COLUMN `is_backend` enum('T','F') NOT NULL DEFAULT 'T' AFTER `role`;

COMMIT;