
DROP TABLE IF EXISTS `res_experience_has_function`;
CREATE TABLE IF NOT EXISTS `res_experience_has_function` (
  `res_experience_function_id` int(10) unsigned NOT NULL auto_increment,
  `res_experience_id` int(10) unsigned NOT NULL,
  `function_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`res_experience_function_id`),
  KEY `FK_res_experience_2` (`res_experience_id`),
  KEY `FK_function_lookup_2` (`function_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;