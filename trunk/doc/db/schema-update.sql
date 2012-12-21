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



CREATE TABLE IF NOT EXISTS `company` (
  `company_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `full_name_en` varchar(100) DEFAULT NULL,
  `short_name_en` varchar(30) DEFAULT NULL,
  `full_name_vn` varchar(100) DEFAULT NULL,
  `short_name_vn` varchar(30) DEFAULT NULL,
  `busines_type_id` tinyint(3) unsigned NOT NULL,
  `industry_id` tinyint(3) unsigned NOT NULL,
  `tel` varchar(30) DEFAULT NULL,
  `fax` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  `website` varchar(100) DEFAULT NULL,
  `infomation` text,
  `status` enum('Active','Deleted') NOT NULL DEFAULT 'Active',
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;


--
-- Table structure for table `vacancy`
--

CREATE TABLE IF NOT EXISTS `vacancy` (
  `vacancy_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned NOT NULL,
  `job_title` varchar(100) NOT NULL,
  `min_salary` double(7,2) unsigned DEFAULT NULL,
  `max_salary` double(7,2) unsigned DEFAULT NULL,
  `priority` enum('Urgent','High','Meidum','Low') NOT NULL,
  `work_level_id` tinyint(3) unsigned NOT NULL,
  `function` varchar(255) DEFAULT NULL,
  `location` varchar(255) CHARACTER SET utf8 COLLATE utf8_hungarian_ci DEFAULT NULL,
  `applied_count` int(10) unsigned NOT NULL DEFAULT '0',
  `status` enum('Open','Hidden','Closed','Archived') NOT NULL,
  `desc_reqs` text,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  PRIMARY KEY (`vacancy_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8  ;

ALTER TABLE  `company` DROP FOREIGN KEY  `FK_busines_type_lookup_1` ;

ALTER TABLE  `company` DROP FOREIGN KEY  `FK_industry_lookup_1` ;

ALTER TABLE  `company` CHANGE  `busines_type_id`  `busines_type` VARCHAR( 255 ) NULL

ALTER TABLE  `company` CHANGE  `industry_id`  `industry` VARCHAR( 255 ) NULL


ALTER TABLE `company` CHANGE `updated_date` `updated_date` DATE NOT NULL 
ALTER TABLE `company` CHANGE `created_date` `created_date` DATE NOT NULL 

ALTER TABLE `company` ADD `assign_cons` VARCHAR( 100 ) NULL AFTER `information` 


CREATE TABLE IF NOT EXISTS `clients_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(10) NOT NULL,
  `consultant_id` int(11) NOT NULL,
  `content` text,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS `clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `birthday` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `email` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `phone` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `point` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `consultant` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;