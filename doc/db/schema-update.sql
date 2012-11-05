ALTER TABLE `consultant`
	ADD INDEX `email_index` (`email`),
	ADD UNIQUE INDEX `email_unique` (`email`),
	ADD INDEX `username_index` (`username`),
	ADD UNIQUE INDEX `username` (`username`);
	
ALTER TABLE `consultant`
	ADD COLUMN `is_admin` TINYINT(1) UNSIGNED NULL DEFAULT '0' AFTER `username`;