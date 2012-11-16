ALTER TABLE `consultant`
	ADD INDEX `email_index` (`email`),
	ADD UNIQUE INDEX `email_unique` (`email`),
	ADD INDEX `username_index` (`username`),
	ADD UNIQUE INDEX `username` (`username`);
	
ALTER TABLE `consultant`
	ADD COLUMN `is_admin` TINYINT(1) UNSIGNED NULL DEFAULT '0' AFTER `username`;
	
	
ALTER TABLE `res_expectation` ADD `note` TEXT NULL 

ALTER TABLE  `resume` CHANGE  `email_2`  `email_2` VARCHAR( 100 ) CHARACTER SET utf8 COLLATE utf8_general_ci NULL ,
CHANGE  `mobile_2`  `mobile_2` VARCHAR( 20 ) CHARACTER SET utf8 COLLATE utf8_general_ci NULL