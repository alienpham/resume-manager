-- phpMyAdmin SQL Dump
-- version 2.11.11
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 04, 2012 at 12:00 AM
-- Server version: 5.0.91
-- PHP Version: 5.2.14

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `managedocument`
--

-- --------------------------------------------------------

--
-- Table structure for table `busines_type_lookup`
--

DROP TABLE IF EXISTS `busines_type_lookup`;
CREATE TABLE IF NOT EXISTS `busines_type_lookup` (
  `busines_type_id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`busines_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `busines_type_lookup`
--

INSERT INTO `busines_type_lookup` (`busines_type_id`, `name`, `sort_order`) VALUES
(1, 'Joint-Venture', 1),
(2, 'Multinational', 2),
(3, 'Pte. Ltd.', 3),
(4, 'Public-Listed', 4),
(5, 'Rep Office', 5),
(6, 'State-Owned', 6),
(7, 'Others', 7);

-- --------------------------------------------------------

--
-- Table structure for table `candidate`
--

DROP TABLE IF EXISTS `candidate`;
CREATE TABLE IF NOT EXISTS `candidate` (
  `candidate_id` int(10) unsigned NOT NULL auto_increment,
  `vacancy_id` int(10) unsigned NOT NULL,
  `resume_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`candidate_id`),
  KEY `FK_vacancy_5` (`vacancy_id`),
  KEY `FK_resume_1` (`resume_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `candidate`
--


-- --------------------------------------------------------

--
-- Table structure for table `candidate_has_process`
--

DROP TABLE IF EXISTS `candidate_has_process`;
CREATE TABLE IF NOT EXISTS `candidate_has_process` (
  `candidate_process_id` int(10) unsigned NOT NULL auto_increment,
  `candidate_id` int(10) unsigned NOT NULL,
  `resume_process_id` tinyint(3) unsigned NOT NULL,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `action_date` date NOT NULL,
  `comment` varchar(300) NOT NULL,
  PRIMARY KEY  (`candidate_process_id`),
  KEY `FK_candidate_1` (`candidate_id`),
  KEY `FK_resume_process_lookup_1` (`resume_process_id`),
  KEY `FK_consultant_3` (`consultant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `candidate_has_process`
--


-- --------------------------------------------------------

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
CREATE TABLE IF NOT EXISTS `company` (
  `company_id` int(10) unsigned NOT NULL auto_increment,
  `company_code` varchar(11) NOT NULL,
  `full_name_en` varchar(100) default NULL,
  `short_name_en` varchar(30) default NULL,
  `full_name_vn` varchar(100) default NULL,
  `short_name_vn` varchar(30) default NULL,
  `busines_type_id` tinyint(3) unsigned NOT NULL,
  `industry_id` tinyint(3) unsigned NOT NULL,
  `tel` varchar(30) default NULL,
  `fax` varchar(30) default NULL,
  `email` varchar(100) default NULL,
  `address` varchar(150) default NULL,
  `website` varchar(100) default NULL,
  `status` enum('Active','Deleted') NOT NULL default 'Active',
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  PRIMARY KEY  (`company_id`),
  KEY `FK_busines_type_lookup_1` (`busines_type_id`),
  KEY `FK_industry_lookup_1` (`industry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `company`
--


-- --------------------------------------------------------

--
-- Table structure for table `company_activity_lookup`
--

DROP TABLE IF EXISTS `company_activity_lookup`;
CREATE TABLE IF NOT EXISTS `company_activity_lookup` (
  `company_activity_id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  `abbreviation` varchar(5) NOT NULL,
  PRIMARY KEY  (`company_activity_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `company_activity_lookup`
--

INSERT INTO `company_activity_lookup` (`company_activity_id`, `name`, `sort_order`, `abbreviation`) VALUES
(1, 'Called', 1, 'CL'),
(2, 'Client visit', 2, 'CV'),
(3, 'Proposal sent', 3, 'PS');

-- --------------------------------------------------------

--
-- Table structure for table `com_activity`
--

DROP TABLE IF EXISTS `com_activity`;
CREATE TABLE IF NOT EXISTS `com_activity` (
  `com_activity_id` int(10) unsigned NOT NULL auto_increment,
  `company_id` int(10) unsigned NOT NULL,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `company_activity_id` tinyint(3) unsigned NOT NULL,
  `action_date` date NOT NULL,
  `comment` varchar(300) NOT NULL,
  PRIMARY KEY  (`com_activity_id`),
  KEY `FK_company_7` (`company_id`),
  KEY `FK_consultant_8` (`consultant_id`),
  KEY `FK_company_activity_lookup_1` (`company_activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `com_activity`
--


-- --------------------------------------------------------

--
-- Table structure for table `com_has_consultant_incharge`
--

DROP TABLE IF EXISTS `com_has_consultant_incharge`;
CREATE TABLE IF NOT EXISTS `com_has_consultant_incharge` (
  `com_consultant_incharge_id` int(10) unsigned NOT NULL auto_increment,
  `company_id` int(10) unsigned NOT NULL,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `action_date` date NOT NULL,
  `ranking` enum('A','B','C') NOT NULL,
  `status` enum('Active','Inactive') NOT NULL,
  PRIMARY KEY  (`com_consultant_incharge_id`),
  KEY `FK_company_6` (`company_id`),
  KEY `FK_consultant_7` (`consultant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `com_has_consultant_incharge`
--


-- --------------------------------------------------------

--
-- Table structure for table `com_information`
--

DROP TABLE IF EXISTS `com_information`;
CREATE TABLE IF NOT EXISTS `com_information` (
  `com_information_id` int(10) unsigned NOT NULL auto_increment,
  `company_id` int(10) unsigned NOT NULL,
  `apply_to` enum('Internal','Public') NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY  (`com_information_id`),
  KEY `FK_company_5` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `com_information`
--


-- --------------------------------------------------------

--
-- Table structure for table `com_ranking_history`
--

DROP TABLE IF EXISTS `com_ranking_history`;
CREATE TABLE IF NOT EXISTS `com_ranking_history` (
  `com_ranking_history_id` int(10) unsigned NOT NULL auto_increment,
  `company_id` int(10) unsigned NOT NULL,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `action_date` date NOT NULL,
  `ranking` enum('A','B','C') NOT NULL,
  PRIMARY KEY  (`com_ranking_history_id`),
  KEY `FK_company_4` (`company_id`),
  KEY `FK_consultant_5` (`consultant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `com_ranking_history`
--


-- --------------------------------------------------------

--
-- Table structure for table `consultant`
--

DROP TABLE IF EXISTS `consultant`;
CREATE TABLE IF NOT EXISTS `consultant` (
  `consultant_id` smallint(5) unsigned NOT NULL auto_increment,
  `title` enum('Mr.','Mrs.','Ms.') NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `abbreviated_name` varchar(10) NOT NULL,
  `job_title` varchar(100) NOT NULL,
  `office_phone` varchar(30) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `join_date` date default NULL,
  `resign_date` date default NULL,
  `status` enum('Active','Inactive','Deleted') NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  PRIMARY KEY  (`consultant_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `consultant`
--

INSERT INTO `consultant` (`consultant_id`, `title`, `full_name`, `abbreviated_name`, `job_title`, `office_phone`, `email`, `password`, `join_date`, `resign_date`, `status`, `created_date`, `updated_date`) VALUES
(1, 'Mr.', 'Nguyen Hoang Van', 'Van N', 'VIPO Admin', '3 8117 900 Ext 119', 'van.nguyen@nvmgroup.com', '763a4ae7c1654b764eea4eb3c988dec8', '2011-08-17', NULL, 'Active', '2012-08-15 11:31:25', '2012-08-15 11:31:25'),
(2, 'Mrs.', 'Pham Thi Diem Chau', 'Chau P', 'Deputy Managing Consultant', '3 8117 900 Ext 112', 'chau.pham@nvmgroup.com', '763a4ae7c1654b764eea4eb3c988dec8', '2011-08-17', NULL, 'Active', '2012-08-15 11:31:25', '2012-08-15 11:31:25'),
(3, 'Ms.', 'Nguyen Thi Phuong Thao', 'Thao N', 'ESS Senior Consultant', '3 8117 900 Ext 115', 'thao.nguyen@nvmgroup.com', '763a4ae7c1654b764eea4eb3c988dec8', '2011-08-17', NULL, 'Active', '2012-08-15 11:31:25', '2012-08-15 11:31:25'),
(4, 'Ms.', 'Do Thi My Duyen', 'Duyen D', 'ESS Consultant', '3 8117 900 Ext 109', 'duyen.do@nvmgroup.com', '763a4ae7c1654b764eea4eb3c988dec8', '2011-08-17', NULL, 'Active', '2012-08-15 11:31:25', '2012-08-15 11:31:25'),
(5, 'Ms.', 'Nguyen Thi Kim Yen', 'Yen N', 'ESS Consultant', '3 8117 900 Ext 111', 'yen.nguyen@nvmgroup.com', '763a4ae7c1654b764eea4eb3c988dec8', '2011-08-17', NULL, 'Active', '2012-08-15 11:31:25', '2012-08-15 11:31:25'),
(6, 'Ms.', 'Ly Thi Bich Nga', 'Nga L', 'ESS Consultant', '3 8117 900 Ext 113', 'nga.ly@nvmgroup.com', '763a4ae7c1654b764eea4eb3c988dec8', '2011-08-17', NULL, 'Active', '2012-08-15 11:31:25', '2012-08-15 11:31:25'),
(7, 'Ms.', 'Nguyen Doan Trang', 'Trang N', 'ESS Researcher', '3 8117 900 Ext 100', 'trang.nguyen@nvmgroup.com', '763a4ae7c1654b764eea4eb3c988dec8', '2011-08-17', NULL, 'Active', '2012-08-15 11:31:25', '2012-08-15 11:31:25'),
(8, 'Ms.', 'Phan Thanh Thuy Nguyen', 'Nguyen P', 'Data Input Staff', '3 8117 900 Ext 106', 'nguyen.phan@nvmgroup.com', '763a4ae7c1654b764eea4eb3c988dec8', '2011-08-17', NULL, 'Active', '2012-08-15 11:31:25', '2012-08-15 11:31:25'),
(9, 'Mr.', 'Phan Thanh Binh', 'Binh P', 'Operation Manager', '3 8117 900 Ext 118', 'binh.phan@nvmgroup.com', '763a4ae7c1654b764eea4eb3c988dec8', '2011-08-17', NULL, 'Active', '2012-08-15 11:31:25', '2012-08-15 11:31:25');

-- --------------------------------------------------------

--
-- Table structure for table `consultant_has_role`
--

DROP TABLE IF EXISTS `consultant_has_role`;
CREATE TABLE IF NOT EXISTS `consultant_has_role` (
  `consultant_role_id` smallint(5) unsigned NOT NULL auto_increment,
  `role_id` tinyint(3) unsigned NOT NULL,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `is_main` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`consultant_role_id`),
  KEY `FK_role_lookup_1` (`role_id`),
  KEY `FK_consultant_16` (`consultant_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `consultant_has_role`
--

INSERT INTO `consultant_has_role` (`consultant_role_id`, `role_id`, `consultant_id`, `is_main`) VALUES
(1, 13, 1, 0),
(2, 2, 2, 0),
(3, 4, 3, 0),
(4, 4, 4, 0),
(5, 4, 5, 0),
(6, 4, 6, 0),
(7, 5, 7, 0),
(8, 7, 8, 0),
(9, 3, 9, 0);

-- --------------------------------------------------------

--
-- Table structure for table `country_lookup`
--

DROP TABLE IF EXISTS `country_lookup`;
CREATE TABLE IF NOT EXISTS `country_lookup` (
  `country_id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`country_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=234 ;

--
-- Dumping data for table `country_lookup`
--

INSERT INTO `country_lookup` (`country_id`, `name`, `sort_order`) VALUES
(1, 'Afghanistan', 1),
(2, 'Albania', 2),
(3, 'Algeria', 3),
(4, 'American Samoa', 4),
(5, 'Andorra', 5),
(6, 'Angola', 6),
(7, 'Anguilla', 7),
(8, 'Antigua And Barbuda', 8),
(9, 'Argentina', 9),
(10, 'Armenia', 10),
(11, 'Aruba', 11),
(12, 'Australia', 12),
(13, 'Austria', 13),
(14, 'Azerbaijan', 14),
(15, 'Bahamas', 15),
(16, 'Bahrain', 16),
(17, 'Bangladesh', 17),
(18, 'Barbados', 18),
(19, 'Belarus', 19),
(20, 'Belgium', 20),
(21, 'Belize', 21),
(22, 'Benin', 22),
(23, 'Bermuda', 23),
(24, 'Bhutan', 24),
(25, 'Bolivia', 25),
(26, 'Bosnia and Herzegowina', 26),
(27, 'Botswana', 27),
(28, 'Brazil', 28),
(29, 'British Virgin Islands', 29),
(30, 'Brunei', 30),
(31, 'Bulgaria', 31),
(32, 'Burkina Faso', 32),
(33, 'Burma', 33),
(34, 'Burundi', 34),
(35, 'Cambodia', 35),
(36, 'Cameroon', 36),
(37, 'Canada', 37),
(38, 'Cape Verde', 38),
(39, 'Cayman Islands', 39),
(40, 'Central African Republic', 40),
(41, 'Chad', 41),
(42, 'Chile', 42),
(43, 'China', 43),
(44, 'Christmas Island', 44),
(45, 'Cocos(Keeling) Islands', 45),
(46, 'Colombia', 46),
(47, 'Comoros', 47),
(48, 'Congo, Democratic Republic of The', 48),
(49, 'Congo, Republic of The', 49),
(50, 'Cook Islands', 50),
(51, 'Costa Rica', 51),
(52, 'Cote D''voire', 52),
(53, 'Croatia', 53),
(54, 'Cuba', 54),
(55, 'Cyprus', 55),
(56, 'Czech Republic', 56),
(57, 'Denmark', 57),
(58, 'Djibouti', 58),
(59, 'Dominica', 59),
(60, 'Dominican Republic', 60),
(61, 'Ecuador', 61),
(62, 'Egypt', 62),
(63, 'El Salvador', 63),
(64, 'Equatorial Guinea', 64),
(65, 'Eritrea', 65),
(66, 'Estonia', 66),
(67, 'Ethiopia', 67),
(68, 'Falkland Islands', 68),
(69, 'Faroe Islands', 69),
(70, 'Fiji', 70),
(71, 'Finland', 71),
(72, 'France', 72),
(73, 'French Polynesia', 73),
(74, 'Gabon', 74),
(75, 'Gambia, The', 75),
(76, 'GazaStrip', 76),
(77, 'Georgia', 77),
(78, 'Germany', 78),
(79, 'Ghana', 79),
(80, 'Gibraltar', 80),
(81, 'Greece', 81),
(82, 'Greenland', 82),
(83, 'Grenada', 83),
(84, 'Guam', 84),
(85, 'Guatemala', 85),
(86, 'Guernsey', 86),
(87, 'Guinea', 87),
(88, 'Guinea-Bissau', 88),
(89, 'Guyana', 89),
(90, 'Haiti', 90),
(91, 'Holy See (VaticanCity)', 91),
(92, 'Honduras', 92),
(93, 'Hong Kong', 93),
(94, 'Hungary', 94),
(95, 'Iceland', 95),
(96, 'India', 96),
(97, 'Indonesia', 97),
(98, 'Iran', 98),
(99, 'Iraq', 99),
(100, 'Ireland', 100),
(101, 'Isle of Man', 101),
(102, 'Israel', 102),
(103, 'Italy', 103),
(104, 'Jamaica', 104),
(105, 'Japan', 105),
(106, 'Jersey', 106),
(107, 'Jordan', 107),
(108, 'Kazakhstan', 108),
(109, 'Kenya', 109),
(110, 'Kiribati', 110),
(111, 'Korea, North', 111),
(112, 'Korea, South', 112),
(113, 'Kosovo', 113),
(114, 'Kuwait', 114),
(115, 'Kyrgyzstan', 115),
(116, 'Laos', 116),
(117, 'Latvia', 117),
(118, 'Lebanon', 118),
(119, 'Lesotho', 119),
(120, 'Liberia', 120),
(121, 'Libya', 121),
(122, 'Liechtenstein', 122),
(123, 'Lithuania', 123),
(124, 'Luxembourg', 124),
(125, 'Macau', 125),
(126, 'Macedonia', 126),
(127, 'Madagascar', 127),
(128, 'Malawi', 128),
(129, 'Malaysia', 129),
(130, 'Maldives', 130),
(131, 'Mali', 131),
(132, 'Malta', 132),
(133, 'Marshall Islands', 133),
(134, 'Mauritania', 134),
(135, 'Mauritius', 135),
(136, 'Mayotte', 136),
(137, 'Mexico', 137),
(138, 'Micronesia, Federated States of', 138),
(139, 'Moldova', 139),
(140, 'Monaco', 140),
(141, 'Mongolia', 141),
(142, 'Montenegro', 142),
(143, 'Montserrat', 143),
(144, 'Morocco', 144),
(145, 'Mozambique', 145),
(146, 'Namibia', 146),
(147, 'Nauru', 147),
(148, 'Nepal', 148),
(149, 'Netherlands', 149),
(150, 'New Caledonia', 150),
(151, 'New Zealand', 151),
(152, 'Nicaragua', 152),
(153, 'Niger', 153),
(154, 'Nigeria', 154),
(155, 'Niue', 155),
(156, 'Norfolk Island', 156),
(157, 'Northern Mariana Islands', 157),
(158, 'Norway', 158),
(159, 'Oman', 159),
(160, 'Pakistan', 160),
(161, 'Palau', 161),
(162, 'Panama', 162),
(163, 'Papua New Guinea', 163),
(164, 'Paraguay', 164),
(165, 'Peru', 165),
(166, 'Philippines', 166),
(167, 'Pitcairn Islands', 167),
(168, 'Poland', 168),
(169, 'Portugal', 169),
(170, 'Puerto Rico', 170),
(171, 'Qatar', 171),
(172, 'Romania', 172),
(173, 'Russia', 173),
(174, 'Rwanda', 174),
(175, 'Saint Helena, Ascension, and Tristanda Cunha', 175),
(176, 'Saint Kitts And Nevis', 176),
(177, 'Saint Lucia', 177),
(178, 'SaintPierreandMiquelon', 178),
(179, 'Saint Vincent And The Grenadines', 179),
(180, 'Samoa', 180),
(181, 'San Marino', 181),
(182, 'Sao Tome And Principe', 182),
(183, 'Saudi Arabia', 183),
(184, 'Senegal', 184),
(185, 'Serbia', 185),
(186, 'Seychelles', 186),
(187, 'Sierra Leone', 187),
(188, 'Singapore', 188),
(189, 'Slovakia', 189),
(190, 'Slovenia', 190),
(191, 'Solomon Islands', 191),
(192, 'Somalia', 192),
(193, 'South Africa', 193),
(194, 'Spain', 194),
(195, 'Sri Lanka', 195),
(196, 'Sudan', 196),
(197, 'Suriname', 197),
(198, 'Swaziland', 198),
(199, 'Sweden', 199),
(200, 'Switzerland', 200),
(201, 'Syria', 201),
(202, 'Taiwan', 202),
(203, 'Tajikistan', 203),
(204, 'Tanzania', 204),
(205, 'Thailand', 205),
(206, 'Timor-Leste', 206),
(207, 'Togo', 207),
(208, 'Tokelau', 208),
(209, 'Tonga', 209),
(210, 'Trinidad And Tobago', 210),
(211, 'Tunisia', 211),
(212, 'Turkey', 212),
(213, 'Turkmenistan', 213),
(214, 'Turks And Caicos Islands', 214),
(215, 'Tuvalu', 215),
(216, 'Uganda', 216),
(217, 'Ukraine', 217),
(218, 'United Arab Emirates', 218),
(219, 'United Kingdom', 219),
(220, 'United States', 220),
(221, 'Uruguay', 221),
(222, 'Uzbekistan', 222),
(223, 'Vanuatu', 223),
(224, 'Venezuela', 224),
(225, 'Vietnam', 225),
(226, 'Virgin Islands', 226),
(227, 'Wallis And Futuna Islands', 227),
(228, 'Western Sahara', 228),
(229, 'Yemen', 229),
(230, 'Zaire', 230),
(231, 'Zambia', 231),
(232, 'Zimbabwe', 232),
(233, 'Other', 232);

-- --------------------------------------------------------

--
-- Table structure for table `department_lookup`
--

DROP TABLE IF EXISTS `department_lookup`;
CREATE TABLE IF NOT EXISTS `department_lookup` (
  `department_id` tinyint(3) unsigned NOT NULL auto_increment,
  `code` varchar(5) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`department_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `department_lookup`
--

INSERT INTO `department_lookup` (`department_id`, `code`, `name`, `sort_order`) VALUES
(1, 'ESS', 'VIPsearch', 1),
(2, 'PAY', 'Payroll', 2),
(3, 'HRA', 'HR Advisory', 3),
(4, 'HRI', 'HR Insight', 4),
(5, 'MKT', 'Marketing', 5),
(6, 'HRM', 'HR & Admin', 6),
(7, 'TEC', 'Technology', 7),
(8, 'BOM', 'BOM', 8),
(9, 'ACC', 'Accounting', 9);

-- --------------------------------------------------------

--
-- Table structure for table `feature_lookup`
--

DROP TABLE IF EXISTS `feature_lookup`;
CREATE TABLE IF NOT EXISTS `feature_lookup` (
  `feature_id` tinyint(3) unsigned NOT NULL auto_increment,
  `module_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `link` varchar(255) default NULL,
  `sort_order` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`feature_id`),
  KEY `FK_module_lookup_1` (`module_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=41 ;

--
-- Dumping data for table `feature_lookup`
--

INSERT INTO `feature_lookup` (`feature_id`, `module_id`, `name`, `link`, `sort_order`) VALUES
(1, 1, 'Comapany', 'company_crm', 1),
(2, 1, 'Activity', 'activity_crm', 2),
(3, 1, 'Contract', 'contract_crm', 3),
(4, 1, 'Contact Person', 'contact_person_crm', 4),
(5, 2, 'Company', 'company', 5),
(6, 2, 'Activity', 'activity', 6),
(7, 2, 'Contract', 'contract', 7),
(8, 2, 'Contact Person', 'contact_person', 8),
(9, 3, 'Vacancy', 'vacancy', 9),
(10, 3, 'Candidate', 'candidate_va', 10),
(11, 3, 'Payment', 'payment_va', 11),
(12, 3, 'Revenue', 'revenue_va', 12),
(13, 4, 'Database', 'database_rs', 13),
(14, 4, 'Contact', 'contact_rs', 14),
(15, 4, 'Industry Mapping', 'industry_mapping_rs', 15),
(16, 5, 'Company Master', 'company_master', 16),
(17, 5, 'Vacancy Master', 'vacancy_master', 17),
(18, 5, 'Candidate Master', 'candidate_master', 18),
(19, 5, 'Invoice Master', 'invoice_master', 19),
(20, 6, 'Input Resume', 'input_resume', 20),
(21, 6, 'Process Duplicate', 'process_duplicate', 21),
(22, 6, 'Classify Resume', 'classify_resume', 22),
(23, 6, 'Contact', 'contact_data_entry', 23),
(24, 7, 'Manage Teams', 'manage_teams', 24),
(25, 7, 'Manage Transfers', 'manage_transfers', 25),
(26, 7, 'Transfer Policy', 'transfer_policy', 26),
(27, 7, 'Commission Policy', 'commission_policy', 27),
(28, 8, 'Customized Reports', 'customized_reports', 28),
(29, 8, 'Revenue', 'revenue_rpt', 29),
(30, 8, 'Vacancy', 'vacancy_rpt', 30),
(31, 8, 'Candidate', 'candidate_rpt', 31),
(32, 8, 'Company', 'company_rpt', 32),
(33, 8, 'Database', 'database_rpt', 33),
(34, 9, 'Access Monitor', 'access_monitor', 34),
(35, 9, 'Schedule Tasks', 'schedule_tasks', 35),
(36, 9, 'Manage Users', 'manage_users', 36),
(37, 9, 'Manage Roles', 'manage_roles', 37),
(38, 9, 'Dropdown Lists', 'drop_down_lists', 38),
(39, 9, 'Settings', 'settings', 39),
(40, 9, 'Admin Notice', 'admin_notice', 40);

-- --------------------------------------------------------

--
-- Table structure for table `function_lookup`
--

DROP TABLE IF EXISTS `function_lookup`;
CREATE TABLE IF NOT EXISTS `function_lookup` (
  `function_id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `parent_function_id` tinyint(3) unsigned default NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`function_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=136 ;

--
-- Dumping data for table `function_lookup`
--

INSERT INTO `function_lookup` (`function_id`, `name`, `parent_function_id`, `sort_order`) VALUES
(1, 'Accounting / Finance / Banking', 0, 1),
(2, 'Accounts Payable / Receivable', 1, 2),
(3, 'Audit', 1, 3),
(4, 'Banking', 1, 4),
(5, 'Chief Accountant', 1, 5),
(6, 'Coasting', 1, 6),
(7, 'Financial Analysis / Research', 1, 7),
(8, 'Financial Control / CFO', 1, 8),
(9, 'Financial Planning / Advising', 1, 9),
(10, 'General Accounting', 1, 10),
(11, 'General Finance', 1, 11),
(12, 'Insurance', 1, 12),
(13, 'Investment', 1, 13),
(14, 'Real Estate', 1, 14),
(15, 'Securities', 1, 15),
(16, 'Others', 1, 16),
(17, 'Administrative / Clerical', 0, 17),
(18, 'Administrative Support', 17, 18),
(19, 'Data Entry / Order Processing', 17, 19),
(20, 'Office Management', 17, 20),
(21, 'Property Management', 17, 21),
(22, 'Reception', 17, 22),
(23, 'Secretary / Executive Assistant', 17, 23),
(24, 'Others', 17, 24),
(25, 'R&D / Science', 0, 25),
(26, 'Biological / Chemical Research', 25, 26),
(27, 'Clinical Research', 25, 27),
(28, 'Materials / Physical Research', 25, 28),
(29, 'Mathematical / Statistical Research', 25, 29),
(30, 'New Product R&D', 25, 30),
(31, 'Pharmaceutical Research', 25, 31),
(32, 'Others', 25, 32),
(33, 'Business / Strategic Management', 0, 33),
(34, 'Business Analysis / Research', 33, 34),
(35, 'Business Unit Management', 33, 35),
(36, 'CEO / General Management', 33, 36),
(37, 'Others', 33, 37),
(38, 'Creative / Design', 0, 38),
(39, 'Architecture / Interior Design', 38, 39),
(40, 'Computer Animation & Multimedia', 38, 40),
(41, 'Graphic Design', 38, 41),
(42, 'Industrial Design', 38, 42),
(43, 'Others', 38, 43),
(44, 'Editorial / Writing', 0, 44),
(45, 'Digital Content Development', 44, 45),
(46, 'Documentation / Technical Writing', 44, 46),
(47, 'Editing & Proofreading', 44, 47),
(48, 'Journalism', 44, 48),
(49, 'Translation / Interpretation', 44, 49),
(50, 'Others', 44, 50),
(51, 'Engineering', 0, 51),
(52, 'Aeronautic / Avionic Engineering', 51, 52),
(53, 'Bio-Engineering', 51, 53),
(54, 'CAD / Drafting', 51, 54),
(55, 'Chemical Engineering', 51, 55),
(56, 'Civil & Structural Engineering', 51, 56),
(57, 'Electrical / Electronics Engineering', 51, 57),
(58, 'Energy / Nuclear Engineering', 51, 58),
(59, 'Environmental and Geological Engineering', 51, 59),
(60, 'Industrial / Manufacturing Engineering', 51, 60),
(61, 'Mechanical Engineering', 51, 61),
(62, 'Systems / Process Engineering', 51, 62),
(63, 'Others', 51, 63),
(64, 'Human Resources', 0, 64),
(65, 'Compensation & Benefits', 64, 65),
(66, 'General HR', 64, 66),
(67, 'HR Assistant', 64, 67),
(68, 'HR Compliance', 64, 68),
(69, 'Payroll ', 64, 69),
(70, 'Recruiting / Sourcing', 64, 70),
(71, 'Training & Development', 64, 71),
(72, 'Others', 64, 72),
(73, 'Information Technology', 0, 73),
(74, 'CIO / IT Manager', 73, 74),
(75, 'Computer / Network Security', 73, 75),
(76, 'Database Development / Administration', 73, 76),
(77, 'IT Project Management', 73, 77),
(78, 'Network and Server Administration', 73, 78),
(79, 'Software - Programming', 73, 79),
(80, 'Software - System Architecture', 73, 80),
(81, 'Software - QA', 73, 81),
(82, 'Systems Analysis - IT', 73, 82),
(83, 'Telecommunications', 73, 83),
(84, 'Others', 73, 84),
(85, 'Legal', 0, 85),
(86, 'Intelligent Property Law', 85, 86),
(87, 'Lawyer', 85, 87),
(88, 'Labor & Employment Law', 85, 88),
(89, 'Real Estate Law', 85, 89),
(90, 'Others', 85, 90),
(91, 'Supply Chain', 0, 91),
(92, 'Import / Export', 91, 92),
(93, 'Logistics ', 91, 93),
(94, 'Purchasing', 91, 94),
(95, 'Supply Chain ', 91, 95),
(96, 'Transportation', 91, 96),
(97, 'Warehousing', 91, 97),
(98, 'Others', 91, 98),
(99, 'Manufacturing / Production / Operations', 0, 99),
(100, 'Operations / Plant Management', 99, 100),
(101, 'Production / Operations Planning', 99, 101),
(102, 'Production Supervisor', 99, 102),
(103, 'Others', 99, 103),
(104, 'Advertising / Marketing / Product', 0, 104),
(105, 'Advertising ', 104, 105),
(106, 'Brand / Product', 104, 106),
(107, 'Copy Writing / Editing', 104, 107),
(108, 'Market Research', 104, 108),
(109, 'Marketing', 104, 109),
(110, 'Marketing Assistant', 104, 110),
(111, 'Marketing Communications', 104, 111),
(112, 'Media Planning and Buying', 104, 112),
(113, 'Public Relations', 104, 113),
(114, 'Telemarketing', 104, 114),
(115, 'Others', 104, 115),
(116, 'Quality Assurance / Safety', 0, 116),
(117, 'Building / Construction Inspection', 116, 117),
(118, 'Environmental Health & Safety', 116, 118),
(119, 'ISO Certification', 116, 119),
(120, 'Quality Assurance', 116, 120),
(121, 'Others', 116, 121),
(122, 'Sales / Retail / Business Development', 0, 122),
(123, 'Business Development', 122, 123),
(124, 'Customer Service', 122, 124),
(125, 'Merchandise Planning and Buying', 122, 125),
(126, 'Sales - Consumer Goods', 122, 126),
(127, 'Sales - Services', 122, 127),
(128, 'Sales - Technical', 122, 128),
(129, 'Sales Support / Assistance', 122, 129),
(130, 'Store / Branch Management', 122, 130),
(131, 'Trade Marketing', 122, 131),
(132, 'Wholesale / Reselling Sales', 122, 132),
(133, 'Others', 122, 133),
(134, 'Other Functions', 0, 134),
(135, 'Others', 134, 135);

-- --------------------------------------------------------

--
-- Table structure for table `industry_lookup`
--

DROP TABLE IF EXISTS `industry_lookup`;
CREATE TABLE IF NOT EXISTS `industry_lookup` (
  `industry_id` tinyint(3) unsigned NOT NULL auto_increment,
  `abbreviation` varchar(3) default NULL,
  `name` varchar(50) NOT NULL,
  `parent_industry_id` tinyint(3) unsigned default NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`industry_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=57 ;

--
-- Dumping data for table `industry_lookup`
--

INSERT INTO `industry_lookup` (`industry_id`, `abbreviation`, `name`, `parent_industry_id`, `sort_order`) VALUES
(1, 'FNB', 'Finance & Banking', NULL, 1),
(2, NULL, 'Accounting & Audit ', 1, 2),
(3, NULL, 'Financial & Banking ', 1, 3),
(4, NULL, 'Insurance ', 1, 4),
(5, NULL, 'Securities ', 1, 5),
(6, 'CON', 'Consumer Goods', NULL, 6),
(7, NULL, 'Consumer Goods ', 6, 7),
(8, NULL, 'Food & Beverages ', 6, 8),
(9, NULL, 'Import & Export ', 6, 9),
(10, NULL, 'Pharmaceuticals ', 6, 10),
(11, NULL, 'Retail & Wholesale ', 6, 11),
(12, NULL, 'Tobacco ', 6, 12),
(13, 'IND', 'Industrial', NULL, 13),
(14, NULL, 'Agriculture & Forestry ', 13, 14),
(15, NULL, 'Aquaculture ', 13, 15),
(16, NULL, 'Automotive ', 13, 16),
(17, NULL, 'Chemical & Biochemical ', 13, 17),
(18, NULL, 'Construction ', 13, 18),
(19, NULL, 'Electrical & Electronics ', 13, 19),
(20, NULL, 'Garments & Textitles ', 13, 20),
(21, NULL, 'Machinery & Heavy Industrial ', 13, 21),
(22, NULL, 'Manufacturing ', 13, 22),
(23, NULL, 'Mechanical & Industrial Engineering ', 13, 23),
(24, NULL, 'Medical Devices ', 13, 24),
(25, NULL, 'Oil & Energy ', 13, 25),
(26, NULL, 'Paper & Wood ', 13, 26),
(27, NULL, 'Science & Technology ', 13, 27),
(28, 'ICT', 'Information & Communicaton Technology', NULL, 28),
(29, NULL, 'Computer Hardware & Networking ', 28, 29),
(30, NULL, 'Computer Software ', 28, 30),
(31, NULL, 'Consulting (Technology)', 28, 31),
(32, NULL, 'Telecommunication ', 28, 32),
(33, 'SER', 'Services', NULL, 33),
(34, NULL, 'Advertising & PR ', 33, 34),
(35, NULL, 'Airlines & Aviation ', 33, 35),
(36, NULL, 'Architecture ', 33, 36),
(37, NULL, 'Arts & Design ', 33, 37),
(38, NULL, 'Consulting (Business & Management) ', 33, 38),
(39, NULL, 'Consumer Services ', 33, 39),
(40, NULL, 'Education ', 33, 40),
(41, NULL, 'Entertainment & Media ', 33, 41),
(42, NULL, 'Environment Health & Safety ', 33, 42),
(43, NULL, 'Furniture & Interior Design ', 33, 43),
(44, NULL, 'Hospital & Health Care', 33, 44),
(45, NULL, 'Hospitality & Tourism ', 33, 45),
(46, NULL, 'Human Resources ', 33, 46),
(47, NULL, 'Legal Services ', 33, 47),
(48, NULL, 'Logistics & Supply Chain ', 33, 48),
(49, NULL, 'Marketing ', 33, 49),
(50, NULL, 'Non-Profit Organization ', 33, 50),
(51, NULL, 'Professional Training ', 33, 51),
(52, NULL, 'Property & Real Estate ', 33, 52),
(53, NULL, 'Security Services ', 33, 53),
(54, NULL, 'Writing & Publishing ', 33, 54),
(55, 'OTH', 'Others', NULL, 55),
(56, NULL, 'Others', 55, 56);

-- --------------------------------------------------------

--
-- Table structure for table `module_lookup`
--

DROP TABLE IF EXISTS `module_lookup`;
CREATE TABLE IF NOT EXISTS `module_lookup` (
  `module_id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `sort_order` tinyint(4) NOT NULL,
  PRIMARY KEY  (`module_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `module_lookup`
--

INSERT INTO `module_lookup` (`module_id`, `name`, `sort_order`) VALUES
(1, 'Company - CRM', 1),
(2, 'Company', 2),
(3, 'Vacancy', 3),
(4, 'Resume', 4),
(5, 'Master List', 5),
(6, 'Data Entry', 6),
(7, 'Operation', 7),
(8, 'Report', 8),
(9, 'VIPO Admin', 9);

-- --------------------------------------------------------

--
-- Table structure for table `nationality_lookup`
--

DROP TABLE IF EXISTS `nationality_lookup`;
CREATE TABLE IF NOT EXISTS `nationality_lookup` (
  `nationality_id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`nationality_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `nationality_lookup`
--

INSERT INTO `nationality_lookup` (`nationality_id`, `name`, `sort_order`) VALUES
(1, 'Local Vietnamese', 1),
(2, 'Overseas Vietnamese', 2),
(3, 'Foreigner', 3);

-- --------------------------------------------------------

--
-- Table structure for table `program_level_lookup`
--

DROP TABLE IF EXISTS `program_level_lookup`;
CREATE TABLE IF NOT EXISTS `program_level_lookup` (
  `program_level_id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`program_level_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `program_level_lookup`
--

INSERT INTO `program_level_lookup` (`program_level_id`, `name`, `sort_order`) VALUES
(1, 'Skill Training', 1),
(2, 'High School', 2),
(3, '2 yrs Technical School', 3),
(4, 'College Degree', 4),
(5, 'Bachelor’s Degree', 5),
(6, 'Master’s Degree', 6),
(7, 'Doctorate', 7);

-- --------------------------------------------------------

--
-- Table structure for table `province_lookup`
--

DROP TABLE IF EXISTS `province_lookup`;
CREATE TABLE IF NOT EXISTS `province_lookup` (
  `province_id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`province_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=65 ;

--
-- Dumping data for table `province_lookup`
--

INSERT INTO `province_lookup` (`province_id`, `name`, `sort_order`) VALUES
(1, 'An Giang', 1),
(2, 'Ba Ria - Vung Tau', 2),
(3, 'Bac Can', 3),
(4, 'Bac Giang', 4),
(5, 'Bac Lieu', 5),
(6, 'Bac Ninh', 6),
(7, 'Ben Tre', 7),
(8, 'Binh Dinh', 8),
(9, 'Binh Duong', 9),
(10, 'Binh Phuoc', 10),
(11, 'Binh Thuan', 11),
(12, 'Ca Mau', 12),
(13, 'Can Tho', 13),
(14, 'Cao Bang', 14),
(15, 'Da Nang', 15),
(16, 'Dak Nong', 16),
(17, 'Daklak', 17),
(18, 'Dien Bien', 18),
(19, 'Dong Nai', 19),
(20, 'Dong Thap', 20),
(21, 'Gia Lai', 21),
(22, 'Ha Giang', 22),
(23, 'Ha Nam', 23),
(24, 'Ha Noi', 24),
(25, 'Ha Tinh', 25),
(26, 'Hai Duong', 26),
(27, 'Hai Phong', 27),
(28, 'Hau Giang', 28),
(29, 'Ho Chi Minh City', 29),
(30, 'Hoa Binh', 30),
(31, 'Hung Yen', 31),
(32, 'Khanh Hoa', 32),
(33, 'Kien Giang', 33),
(34, 'Kon Tum', 34),
(35, 'Lai Chau', 35),
(36, 'Lam Dong', 36),
(37, 'Lang Son', 37),
(38, 'Lao Cai', 38),
(39, 'Long An', 39),
(40, 'Nam Dinh', 40),
(41, 'Nghe An', 41),
(42, 'Ninh Binh', 42),
(43, 'Ninh Thuan', 43),
(44, 'Phu Tho', 44),
(45, 'Phu Yen', 45),
(46, 'Quang Binh', 46),
(47, 'Quang Nam', 47),
(48, 'Quang Ngai', 48),
(49, 'Quang Ninh', 49),
(50, 'Quang Tri', 50),
(51, 'Soc Trang', 51),
(52, 'Son La', 52),
(53, 'Tay Ninh', 53),
(54, 'Thai Binh', 54),
(55, 'Thai Nguyen', 55),
(56, 'Thanh Hoa', 56),
(57, 'Thua Thien - Hue', 57),
(58, 'Tien Giang', 58),
(59, 'Tra Vinh', 59),
(60, 'Tuyen Quang', 60),
(61, 'Vinh Long', 61),
(62, 'Vinh Phuc', 62),
(63, 'Yen Bai', 63),
(64, 'Overseas', 64);

-- --------------------------------------------------------

--
-- Table structure for table `resume`
--

DROP TABLE IF EXISTS `resume`;
CREATE TABLE IF NOT EXISTS `resume` (
  `resume_id` int(10) unsigned NOT NULL auto_increment,
  `resume_code` varchar(11) NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `birthday` date default NULL,
  `gender` enum('Male','Female') default NULL,
  `marital_status` enum('Single','Married','Divorced') default NULL,
  `status` enum('Active','Deleted','Closed','Archived') NOT NULL,
  `view_count` mediumint(8) unsigned NOT NULL default '0',
  `created_date` datetime NOT NULL,
  `created_consultant_id` smallint(5) unsigned default NULL,
  `updated_date` datetime NOT NULL,
  `updated_consultant_id` smallint(5) unsigned default NULL,
  PRIMARY KEY  (`resume_id`),
  KEY `FK_consultant_17` (`created_consultant_id`),
  KEY `FK_consultant_18` (`updated_consultant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `resume`
--


-- --------------------------------------------------------

--
-- Table structure for table `resume_process_lookup`
--

DROP TABLE IF EXISTS `resume_process_lookup`;
CREATE TABLE IF NOT EXISTS `resume_process_lookup` (
  `resume_process_id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `complete_percentage` tinyint(3) unsigned NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`resume_process_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `resume_process_lookup`
--

INSERT INTO `resume_process_lookup` (`resume_process_id`, `name`, `complete_percentage`, `sort_order`) VALUES
(1, 'Resume sent', 30, 1),
(2, 'Client interview 1 ', 50, 2),
(3, 'Client interview 2 ', 50, 3),
(4, 'Client interview 3 ', 60, 4),
(5, 'Client interview 4', 60, 5),
(6, 'Client interview 5', 70, 6),
(7, 'Client interview 6', 70, 7),
(8, 'Negotiating', 80, 8),
(9, 'Offer made ', 80, 9),
(10, 'Offer accepted', 90, 10),
(11, 'Joined ', 99, 11),
(12, 'Successful ', 100, 12),
(13, 'Resume rejected ', 0, 13),
(14, 'Resume duplicate ', 0, 14),
(15, 'Not pass interview', 0, 15),
(16, 'Rejected offer ', 0, 16),
(17, 'Probation failed', 0, 17),
(18, 'End process ', 0, 18);

-- --------------------------------------------------------

--
-- Table structure for table `resume_saved_search`
--

DROP TABLE IF EXISTS `resume_saved_search`;
CREATE TABLE IF NOT EXISTS `resume_saved_search` (
  `resume_saved_search_id` int(10) unsigned NOT NULL auto_increment,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `xml_content` text NOT NULL,
  `saved_date` datetime NOT NULL,
  PRIMARY KEY  (`resume_saved_search_id`),
  KEY `FK_consultant_22` (`consultant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `resume_saved_search`
--


-- --------------------------------------------------------

--
-- Table structure for table `res_addition`
--

DROP TABLE IF EXISTS `res_addition`;
CREATE TABLE IF NOT EXISTS `res_addition` (
  `res_addition_id` int(10) unsigned NOT NULL auto_increment,
  `resume_id` int(10) unsigned NOT NULL,
  `add_addition` mediumint(9) NOT NULL,
  PRIMARY KEY  (`res_addition_id`),
  KEY `FK_resume_6` (`resume_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `res_addition`
--


-- --------------------------------------------------------

--
-- Table structure for table `res_assessment`
--

DROP TABLE IF EXISTS `res_assessment`;
CREATE TABLE IF NOT EXISTS `res_assessment` (
  `res_assessment_id` int(10) unsigned NOT NULL auto_increment,
  `candidate_id` int(10) unsigned NOT NULL,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `content` varchar(500) NOT NULL,
  `added_date` date NOT NULL,
  PRIMARY KEY  (`res_assessment_id`),
  KEY `FK_consultant_23` (`consultant_id`),
  KEY `FK_candidate_4` (`candidate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `res_assessment`
--


-- --------------------------------------------------------

--
-- Table structure for table `res_comment`
--

DROP TABLE IF EXISTS `res_comment`;
CREATE TABLE IF NOT EXISTS `res_comment` (
  `res_comment_id` int(10) unsigned NOT NULL auto_increment,
  `resume_id` int(10) unsigned NOT NULL,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `comment_type` enum('Comment','Inform') default NULL,
  `content` varchar(500) NOT NULL,
  `added_date` date default NULL,
  PRIMARY KEY  (`res_comment_id`),
  KEY `FK_resume_12` (`resume_id`),
  KEY `FK_consultant_21` (`consultant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `res_comment`
--


-- --------------------------------------------------------

--
-- Table structure for table `res_contact_info`
--

DROP TABLE IF EXISTS `res_contact_info`;
CREATE TABLE IF NOT EXISTS `res_contact_info` (
  `res_contact_info_id` int(10) unsigned NOT NULL auto_increment,
  `resume_id` int(10) unsigned NOT NULL,
  `email_1` varchar(100) default NULL,
  `email_2` varchar(100) default NULL,
  `mobile_1` varchar(30) default NULL,
  `mobile_2` varchar(30) default NULL,
  `tel` varchar(30) default NULL,
  `address` varchar(200) default NULL,
  `province_id` tinyint(3) unsigned default NULL,
  `nationality_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`res_contact_info_id`),
  KEY `FK_nationality_lookup_1` (`nationality_id`),
  KEY `FK_resume_3` (`resume_id`),
  KEY `FK_province_lookup_2` (`province_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `res_contact_info`
--


-- --------------------------------------------------------

--
-- Table structure for table `res_document`
--

DROP TABLE IF EXISTS `res_document`;
CREATE TABLE IF NOT EXISTS `res_document` (
  `res_document_id` int(10) unsigned NOT NULL auto_increment,
  `resume_id` int(10) unsigned NOT NULL,
  `file_name` varchar(25) NOT NULL,
  `file_type` varchar(255) NOT NULL,
  `file_size` mediumint(8) unsigned NOT NULL,
  `file_content` mediumblob NOT NULL,
  PRIMARY KEY  (`res_document_id`),
  KEY `FK_resume_8` (`resume_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `res_document`
--


-- --------------------------------------------------------

--
-- Table structure for table `res_education`
--

DROP TABLE IF EXISTS `res_education`;
CREATE TABLE IF NOT EXISTS `res_education` (
  `res_education_id` int(10) unsigned NOT NULL auto_increment,
  `resume_id` int(10) unsigned NOT NULL,
  `program_type` enum('A','P') NOT NULL,
  `start_date` date default NULL,
  `end_date` date default NULL,
  `school_name` varchar(100) default NULL,
  `program_name` varchar(100) default NULL,
  `program_info` varchar(200) default NULL,
  `program_level_id` tinyint(3) unsigned default NULL,
  `country_id` tinyint(3) unsigned default NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`res_education_id`),
  KEY `FK_country_lookup_2` (`country_id`),
  KEY `FK_resume_5` (`resume_id`),
  KEY `FK_program_level_lookup_1` (`program_level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `res_education`
--


-- --------------------------------------------------------

--
-- Table structure for table `res_expectation`
--

DROP TABLE IF EXISTS `res_expectation`;
CREATE TABLE IF NOT EXISTS `res_expectation` (
  `res_expectation_id` int(10) unsigned NOT NULL auto_increment,
  `resume_id` int(10) unsigned NOT NULL,
  `estimated_salary_to` double(7,2) unsigned default NULL,
  `estimated_salary_from` double(7,2) unsigned default NULL,
  `current_salary` double(7,2) unsigned default NULL,
  PRIMARY KEY  (`res_expectation_id`),
  KEY `FK_resume_7` (`resume_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `res_expectation`
--


-- --------------------------------------------------------

--
-- Table structure for table `res_expectation_details`
--

DROP TABLE IF EXISTS `res_expectation_details`;
CREATE TABLE IF NOT EXISTS `res_expectation_details` (
  `res_expectation_details_id` int(10) unsigned NOT NULL auto_increment,
  `res_expectation_id` int(10) unsigned NOT NULL,
  `career_objective` text,
  `cover_letter` text,
  PRIMARY KEY  (`res_expectation_details_id`),
  KEY `FK_res_expectation_2` (`res_expectation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `res_expectation_details`
--


-- --------------------------------------------------------

--
-- Table structure for table `res_expectation_has_location`
--

DROP TABLE IF EXISTS `res_expectation_has_location`;
CREATE TABLE IF NOT EXISTS `res_expectation_has_location` (
  `res_expectation_location_id` int(10) unsigned NOT NULL auto_increment,
  `res_expectation_id` int(10) unsigned NOT NULL,
  `province_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`res_expectation_location_id`),
  KEY `FK_res_expectation_1` (`res_expectation_id`),
  KEY `FK_province_lookup_4` (`province_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `res_expectation_has_location`
--


-- --------------------------------------------------------

--
-- Table structure for table `res_experience`
--

DROP TABLE IF EXISTS `res_experience`;
CREATE TABLE IF NOT EXISTS `res_experience` (
  `res_experience_id` int(10) unsigned NOT NULL auto_increment,
  `resume_id` int(10) unsigned NOT NULL,
  `start_date` date default NULL,
  `end_date` date default NULL,
  `job_title` varchar(100) default NULL,
  `company_name` varchar(100) default NULL,
  `company_info` varchar(1000) default NULL,
  `province_id` tinyint(3) unsigned default NULL,
  `country_id` tinyint(3) unsigned default NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  `work_level_id` tinyint(3) unsigned default NULL,
  PRIMARY KEY  (`res_experience_id`),
  KEY `FK_resume_4` (`resume_id`),
  KEY `FK_country_lookup_1` (`country_id`),
  KEY `FK_province_lookup_3` (`province_id`),
  KEY `FK_work_level_lookup_2` (`work_level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `res_experience`
--


-- --------------------------------------------------------

--
-- Table structure for table `res_experience_details`
--

DROP TABLE IF EXISTS `res_experience_details`;
CREATE TABLE IF NOT EXISTS `res_experience_details` (
  `res_experience_details_id` int(10) unsigned NOT NULL auto_increment,
  `res_experience_id` int(10) unsigned NOT NULL,
  `duties` text NOT NULL,
  PRIMARY KEY  (`res_experience_details_id`),
  KEY `FK_res_experience_1` (`res_experience_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `res_experience_details`
--


-- --------------------------------------------------------

--
-- Table structure for table `res_experience_has_function`
--

DROP TABLE IF EXISTS `res_experience_has_function`;
CREATE TABLE IF NOT EXISTS `res_experience_has_function` (
  `res_experience_function_id` int(10) unsigned NOT NULL auto_increment,
  `res_experience_id` int(10) unsigned NOT NULL,
  `function_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`res_experience_function_id`),
  KEY `FK_res_experience_2` (`res_experience_id`),
  KEY `FK_function_lookup_2` (`function_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `res_experience_has_function`
--


-- --------------------------------------------------------

--
-- Table structure for table `res_experience_has_industry`
--

DROP TABLE IF EXISTS `res_experience_has_industry`;
CREATE TABLE IF NOT EXISTS `res_experience_has_industry` (
  `res_experience_industry_id` int(10) unsigned NOT NULL auto_increment,
  `res_experience_id` int(10) unsigned NOT NULL,
  `industry_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`res_experience_industry_id`),
  KEY `FK_res_experience_3` (`res_experience_id`),
  KEY `FK_industry_lookup_2` (`industry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `res_experience_has_industry`
--


-- --------------------------------------------------------

--
-- Table structure for table `res_photo`
--

DROP TABLE IF EXISTS `res_photo`;
CREATE TABLE IF NOT EXISTS `res_photo` (
  `res_photo_id` int(10) unsigned NOT NULL auto_increment,
  `resume_id` int(10) unsigned NOT NULL,
  `photo_name` varchar(255) NOT NULL,
  `photo_size` mediumint(8) unsigned NOT NULL,
  `photo_type` varchar(255) NOT NULL,
  `photo_content` mediumblob NOT NULL,
  `photo_width` smallint(5) unsigned NOT NULL,
  `photo_height` smallint(5) unsigned NOT NULL,
  PRIMARY KEY  (`res_photo_id`),
  KEY `FK_resume_2` (`resume_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `res_photo`
--


-- --------------------------------------------------------

--
-- Table structure for table `res_unsubcribe`
--

DROP TABLE IF EXISTS `res_unsubcribe`;
CREATE TABLE IF NOT EXISTS `res_unsubcribe` (
  `res_unsubcribe_id` int(10) unsigned NOT NULL auto_increment,
  `resume_id` int(10) unsigned NOT NULL,
  `consultant_id` smallint(5) unsigned default NULL,
  `unsubcribe_date` date NOT NULL,
  PRIMARY KEY  (`res_unsubcribe_id`),
  KEY `FK_resume_13` (`resume_id`),
  KEY `FK_consultant_28` (`consultant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `res_unsubcribe`
--


-- --------------------------------------------------------

--
-- Table structure for table `role_has_permission`
--

DROP TABLE IF EXISTS `role_has_permission`;
CREATE TABLE IF NOT EXISTS `role_has_permission` (
  `role_permission_id` smallint(5) unsigned NOT NULL auto_increment,
  `feature_id` tinyint(3) unsigned NOT NULL,
  `role_id` tinyint(3) unsigned NOT NULL,
  `ae` tinyint(1) unsigned NOT NULL default '0',
  `v` tinyint(1) unsigned NOT NULL default '0',
  `d` tinyint(1) unsigned NOT NULL default '0',
  `ex` tinyint(1) unsigned NOT NULL default '0',
  `data_access` enum('Own','All') NOT NULL,
  PRIMARY KEY  (`role_permission_id`),
  KEY `FK_feature_lookup_1` (`feature_id`),
  KEY `FK_role_lookup_6` (`role_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=227 ;

--
-- Dumping data for table `role_has_permission`
--

INSERT INTO `role_has_permission` (`role_permission_id`, `feature_id`, `role_id`, `ae`, `v`, `d`, `ex`, `data_access`) VALUES
(1, 1, 13, 1, 1, 1, 0, 'All'),
(2, 2, 13, 1, 1, 1, 0, 'All'),
(3, 3, 13, 1, 1, 1, 0, 'All'),
(4, 4, 13, 1, 1, 1, 0, 'All'),
(5, 5, 13, 1, 1, 1, 0, 'All'),
(6, 6, 13, 1, 1, 1, 0, 'All'),
(7, 7, 13, 1, 1, 1, 0, 'All'),
(8, 8, 13, 1, 1, 1, 0, 'All'),
(9, 9, 13, 1, 1, 1, 0, 'All'),
(10, 10, 13, 1, 1, 1, 0, 'All'),
(11, 11, 13, 1, 1, 1, 0, 'All'),
(12, 12, 13, 1, 1, 1, 0, 'All'),
(13, 13, 13, 1, 1, 1, 0, 'All'),
(14, 14, 13, 1, 1, 1, 0, 'All'),
(15, 15, 13, 1, 1, 1, 0, 'All'),
(16, 16, 13, 1, 1, 1, 0, 'All'),
(17, 17, 13, 1, 1, 1, 0, 'All'),
(18, 18, 13, 1, 1, 1, 0, 'All'),
(19, 19, 13, 1, 1, 1, 0, 'All'),
(20, 20, 13, 1, 1, 1, 0, 'All'),
(21, 21, 13, 1, 1, 1, 0, 'All'),
(22, 22, 13, 1, 1, 1, 0, 'All'),
(23, 23, 13, 1, 1, 1, 0, 'All'),
(24, 24, 13, 1, 1, 1, 0, 'All'),
(25, 25, 13, 1, 1, 1, 0, 'All'),
(26, 26, 13, 1, 1, 1, 0, 'All'),
(27, 27, 13, 1, 1, 1, 0, 'All'),
(28, 28, 13, 1, 1, 1, 0, 'All'),
(29, 29, 13, 1, 1, 1, 0, 'All'),
(30, 30, 13, 1, 1, 1, 0, 'All'),
(31, 31, 13, 1, 1, 1, 0, 'All'),
(32, 32, 13, 1, 1, 1, 0, 'All'),
(33, 33, 13, 1, 1, 1, 0, 'All'),
(34, 34, 13, 1, 1, 1, 0, 'All'),
(35, 35, 13, 1, 1, 1, 0, 'All'),
(36, 36, 13, 1, 1, 1, 0, 'All'),
(37, 37, 13, 1, 1, 1, 0, 'All'),
(38, 38, 13, 1, 1, 1, 0, 'All'),
(39, 39, 13, 1, 1, 1, 0, 'All'),
(40, 40, 13, 1, 1, 1, 0, 'All'),
(41, 1, 14, 1, 1, 1, 0, 'All'),
(42, 2, 14, 1, 1, 1, 0, 'All'),
(43, 3, 14, 1, 1, 1, 0, 'All'),
(44, 4, 14, 1, 1, 1, 0, 'All'),
(45, 5, 14, 1, 1, 1, 0, 'All'),
(46, 6, 14, 1, 1, 1, 0, 'All'),
(47, 7, 14, 1, 1, 1, 0, 'All'),
(48, 8, 14, 1, 1, 1, 0, 'All'),
(49, 9, 14, 1, 1, 1, 0, 'All'),
(50, 10, 14, 1, 1, 1, 0, 'All'),
(51, 11, 14, 1, 1, 1, 0, 'All'),
(52, 12, 14, 0, 1, 0, 0, 'All'),
(53, 13, 14, 0, 1, 0, 0, 'All'),
(54, 14, 14, 1, 1, 1, 0, 'All'),
(55, 15, 14, 0, 1, 0, 0, 'All'),
(56, 16, 14, 0, 1, 0, 0, 'All'),
(57, 17, 14, 0, 1, 0, 0, 'All'),
(58, 18, 14, 0, 1, 0, 0, 'All'),
(59, 19, 14, 0, 1, 0, 0, 'All'),
(60, 20, 14, 0, 1, 0, 0, 'All'),
(61, 21, 14, 0, 1, 0, 0, 'All'),
(62, 22, 14, 0, 1, 0, 0, 'All'),
(63, 23, 14, 0, 1, 0, 0, 'All'),
(64, 24, 14, 0, 1, 0, 0, 'All'),
(65, 25, 14, 0, 1, 0, 0, 'All'),
(66, 26, 14, 0, 1, 0, 0, 'All'),
(67, 27, 14, 0, 1, 0, 0, 'All'),
(68, 28, 14, 1, 1, 1, 0, 'All'),
(69, 29, 14, 0, 1, 0, 0, 'All'),
(70, 30, 14, 0, 1, 0, 0, 'All'),
(71, 31, 14, 0, 1, 0, 0, 'All'),
(72, 32, 14, 0, 1, 0, 0, 'All'),
(73, 33, 14, 0, 1, 0, 0, 'All'),
(74, 34, 14, 0, 1, 0, 0, 'All'),
(75, 35, 14, 0, 1, 0, 0, 'All'),
(76, 36, 14, 0, 1, 0, 0, 'All'),
(77, 37, 14, 0, 1, 0, 0, 'All'),
(78, 38, 14, 0, 1, 0, 0, 'All'),
(79, 39, 14, 0, 1, 0, 0, 'All'),
(80, 40, 14, 1, 1, 1, 0, 'All'),
(81, 13, 7, 1, 1, 1, 0, 'All'),
(82, 14, 7, 1, 1, 1, 0, 'All'),
(83, 15, 7, 0, 1, 0, 0, 'All'),
(84, 20, 7, 1, 1, 1, 0, 'All'),
(85, 21, 7, 1, 1, 1, 0, 'All'),
(86, 22, 7, 1, 1, 1, 0, 'All'),
(87, 23, 7, 1, 1, 1, 0, 'All'),
(88, 33, 7, 0, 1, 0, 0, 'All'),
(89, 5, 6, 1, 1, 1, 0, 'All'),
(90, 6, 6, 1, 1, 1, 0, 'All'),
(91, 7, 6, 1, 1, 1, 0, 'All'),
(92, 8, 6, 1, 1, 1, 0, 'All'),
(93, 9, 6, 1, 1, 1, 0, 'All'),
(94, 10, 6, 1, 1, 1, 0, 'All'),
(95, 11, 6, 1, 1, 1, 0, 'All'),
(96, 12, 6, 1, 1, 1, 0, 'All'),
(97, 13, 6, 0, 1, 0, 0, 'All'),
(98, 14, 6, 1, 1, 1, 0, 'All'),
(99, 15, 6, 0, 1, 0, 0, 'All'),
(100, 16, 6, 1, 1, 1, 0, 'All'),
(101, 17, 6, 1, 1, 1, 0, 'All'),
(102, 18, 6, 1, 1, 1, 0, 'All'),
(103, 19, 6, 1, 1, 1, 0, 'All'),
(104, 20, 6, 1, 1, 1, 0, 'All'),
(105, 21, 6, 1, 1, 1, 0, 'All'),
(106, 22, 6, 1, 1, 1, 0, 'All'),
(107, 23, 6, 1, 1, 1, 0, 'All'),
(108, 28, 6, 0, 1, 0, 0, 'Own'),
(109, 29, 6, 0, 1, 0, 0, 'Own'),
(110, 30, 6, 0, 1, 0, 0, 'All'),
(111, 31, 6, 0, 1, 0, 0, 'All'),
(112, 32, 6, 0, 1, 0, 0, 'All'),
(113, 33, 6, 0, 1, 0, 0, 'All'),
(114, 5, 1, 1, 1, 1, 0, 'Own'),
(115, 6, 1, 1, 1, 1, 0, 'Own'),
(116, 7, 1, 1, 1, 1, 0, 'Own'),
(117, 8, 1, 1, 1, 1, 0, 'Own'),
(118, 9, 1, 1, 1, 1, 0, 'Own'),
(119, 10, 1, 1, 1, 1, 0, 'Own'),
(120, 11, 1, 1, 1, 1, 0, 'Own'),
(121, 12, 1, 1, 1, 1, 0, 'Own'),
(122, 13, 1, 0, 1, 0, 0, 'All'),
(123, 14, 1, 1, 1, 1, 0, 'All'),
(124, 15, 1, 0, 1, 0, 0, 'All'),
(125, 16, 1, 0, 1, 0, 0, 'All'),
(126, 17, 1, 0, 1, 0, 0, 'All'),
(127, 18, 1, 0, 1, 0, 0, 'All'),
(128, 28, 1, 1, 1, 1, 0, 'Own'),
(129, 29, 1, 0, 1, 0, 0, 'Own'),
(130, 30, 1, 0, 1, 0, 0, 'Own'),
(131, 31, 1, 0, 1, 0, 0, 'Own'),
(132, 32, 1, 0, 1, 0, 0, 'Own'),
(133, 33, 1, 0, 1, 0, 0, 'Own'),
(134, 5, 3, 1, 1, 1, 0, 'Own'),
(135, 6, 3, 1, 1, 1, 0, 'Own'),
(136, 7, 3, 1, 1, 1, 0, 'Own'),
(137, 8, 3, 1, 1, 1, 0, 'Own'),
(138, 9, 3, 1, 1, 1, 0, 'Own'),
(139, 10, 3, 1, 1, 1, 0, 'Own'),
(140, 11, 3, 1, 1, 1, 0, 'Own'),
(141, 12, 3, 1, 1, 1, 0, 'Own'),
(142, 13, 3, 0, 1, 0, 0, 'All'),
(143, 14, 3, 1, 1, 1, 0, 'All'),
(144, 15, 3, 0, 1, 0, 0, 'All'),
(145, 16, 3, 0, 1, 0, 0, 'All'),
(146, 17, 3, 0, 1, 0, 0, 'All'),
(147, 18, 3, 0, 1, 0, 0, 'All'),
(148, 19, 3, 0, 1, 0, 0, 'All'),
(149, 20, 3, 1, 1, 1, 0, 'All'),
(150, 21, 3, 1, 1, 1, 0, 'All'),
(151, 22, 3, 1, 1, 1, 0, 'All'),
(152, 24, 3, 1, 1, 1, 1, 'All'),
(153, 25, 3, 1, 1, 1, 1, 'All'),
(154, 26, 3, 1, 1, 1, 1, 'All'),
(155, 27, 3, 1, 1, 1, 1, 'All'),
(156, 28, 3, 1, 1, 1, 0, 'Own'),
(157, 29, 3, 0, 1, 0, 0, 'Own'),
(158, 30, 3, 0, 1, 0, 0, 'Own'),
(159, 31, 3, 0, 1, 0, 0, 'Own'),
(160, 32, 3, 0, 1, 0, 0, 'Own'),
(161, 33, 3, 0, 1, 0, 0, 'Own'),
(162, 36, 3, 0, 1, 0, 0, 'All'),
(163, 40, 3, 1, 1, 1, 0, 'Own'),
(164, 5, 4, 1, 1, 1, 0, 'Own'),
(165, 6, 4, 1, 1, 1, 0, 'Own'),
(166, 7, 4, 1, 1, 1, 0, 'Own'),
(167, 8, 4, 1, 1, 1, 0, 'Own'),
(168, 9, 4, 1, 1, 1, 0, 'Own'),
(169, 10, 4, 1, 1, 1, 0, 'Own'),
(170, 11, 4, 1, 1, 1, 0, 'Own'),
(171, 12, 4, 1, 1, 1, 0, 'Own'),
(172, 13, 4, 0, 1, 0, 0, 'All'),
(173, 14, 4, 1, 1, 1, 0, 'All'),
(174, 15, 4, 0, 1, 0, 0, 'All'),
(175, 16, 4, 0, 1, 0, 0, 'All'),
(176, 17, 4, 0, 1, 0, 0, 'All'),
(177, 18, 4, 0, 1, 0, 0, 'All'),
(178, 28, 4, 1, 1, 1, 0, 'Own'),
(179, 29, 4, 0, 1, 0, 0, 'Own'),
(180, 30, 4, 0, 1, 0, 0, 'Own'),
(181, 31, 4, 0, 1, 0, 0, 'Own'),
(182, 32, 4, 0, 1, 0, 0, 'Own'),
(183, 33, 4, 0, 1, 0, 0, 'Own'),
(184, 5, 5, 1, 1, 1, 0, 'Own'),
(185, 6, 5, 1, 1, 1, 0, 'Own'),
(186, 7, 5, 1, 1, 1, 0, 'Own'),
(187, 8, 5, 1, 1, 1, 0, 'Own'),
(188, 9, 5, 1, 1, 1, 0, 'Own'),
(189, 10, 5, 1, 1, 1, 0, 'Own'),
(190, 11, 5, 1, 1, 1, 0, 'Own'),
(191, 12, 5, 1, 1, 1, 0, 'Own'),
(192, 13, 5, 0, 1, 0, 0, 'All'),
(193, 14, 5, 1, 1, 1, 0, 'All'),
(194, 15, 5, 0, 1, 0, 0, 'All'),
(195, 16, 5, 0, 1, 0, 0, 'All'),
(196, 17, 5, 0, 1, 0, 0, 'All'),
(197, 18, 5, 0, 1, 0, 0, 'All'),
(198, 20, 5, 1, 1, 1, 0, 'Own'),
(199, 21, 5, 1, 1, 1, 0, 'Own'),
(200, 22, 5, 1, 1, 1, 0, 'Own'),
(201, 23, 5, 1, 1, 1, 0, 'Own'),
(202, 28, 5, 1, 1, 1, 0, 'Own'),
(203, 30, 5, 0, 1, 0, 0, 'Own'),
(204, 31, 5, 0, 1, 0, 0, 'Own'),
(205, 32, 5, 0, 1, 0, 0, 'Own'),
(206, 33, 5, 0, 1, 0, 0, 'Own'),
(207, 5, 2, 1, 1, 1, 0, 'Own'),
(208, 6, 2, 1, 1, 1, 0, 'Own'),
(209, 7, 2, 1, 1, 1, 0, 'Own'),
(210, 8, 2, 1, 1, 1, 0, 'Own'),
(211, 9, 2, 1, 1, 1, 0, 'Own'),
(212, 10, 2, 1, 1, 1, 0, 'Own'),
(213, 11, 2, 1, 1, 1, 0, 'Own'),
(214, 12, 2, 1, 1, 1, 0, 'Own'),
(215, 13, 2, 0, 1, 0, 0, 'All'),
(216, 14, 2, 1, 1, 1, 0, 'All'),
(217, 15, 2, 0, 1, 0, 0, 'All'),
(218, 16, 2, 0, 1, 0, 0, 'All'),
(219, 17, 2, 0, 1, 0, 0, 'All'),
(220, 18, 2, 0, 1, 0, 0, 'All'),
(221, 28, 2, 1, 1, 1, 0, 'Own'),
(222, 29, 2, 0, 1, 0, 0, 'Own'),
(223, 30, 2, 0, 1, 0, 0, 'Own'),
(224, 31, 2, 0, 1, 0, 0, 'Own'),
(225, 32, 2, 0, 1, 0, 0, 'Own'),
(226, 33, 2, 0, 1, 0, 0, 'Own');

-- --------------------------------------------------------

--
-- Table structure for table `role_lookup`
--

DROP TABLE IF EXISTS `role_lookup`;
CREATE TABLE IF NOT EXISTS `role_lookup` (
  `role_id` tinyint(3) unsigned NOT NULL auto_increment,
  `department_id` tinyint(3) unsigned NOT NULL,
  `role_type` enum('Consultant','Operation') default NULL,
  `level` tinyint(3) unsigned default NULL,
  `name` varchar(50) NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`role_id`),
  KEY `FK_department_lookup_1` (`department_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `role_lookup`
--

INSERT INTO `role_lookup` (`role_id`, `department_id`, `role_type`, `level`, `name`, `created_date`, `updated_date`, `sort_order`) VALUES
(1, 1, 'Consultant', 4, 'Managing Consultant', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1),
(2, 1, 'Consultant', 3, 'Deputy Managing Consultant', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 2),
(3, 1, 'Operation', NULL, 'Operation Manager', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 3),
(4, 1, 'Consultant', 2, 'ESS Consultant', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 4),
(5, 1, 'Consultant', 1, 'Researcher', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 5),
(6, 1, 'Operation', NULL, 'Sales Admin', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 6),
(7, 1, 'Operation', NULL, 'Data Input', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 7),
(8, 2, NULL, NULL, 'PAY Consultant', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 8),
(9, 3, NULL, NULL, 'HRA Consultant', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 9),
(10, 4, NULL, NULL, 'HRI Consultant', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 10),
(11, 5, NULL, NULL, 'Marketing Staff', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 11),
(12, 6, NULL, NULL, 'HR Staff', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 12),
(13, 7, NULL, NULL, 'VIPO Admin', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 13),
(14, 8, NULL, NULL, 'Board of Management', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 14),
(15, 9, NULL, NULL, 'Accounting Staff', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 15);

-- --------------------------------------------------------

--
-- Table structure for table `short_list`
--

DROP TABLE IF EXISTS `short_list`;
CREATE TABLE IF NOT EXISTS `short_list` (
  `short_list_id` int(10) unsigned NOT NULL auto_increment,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY  (`short_list_id`),
  KEY `FK_consultant_20` (`consultant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `short_list`
--


-- --------------------------------------------------------

--
-- Table structure for table `sl_has_resume`
--

DROP TABLE IF EXISTS `sl_has_resume`;
CREATE TABLE IF NOT EXISTS `sl_has_resume` (
  `sl_resume_id` int(10) unsigned NOT NULL auto_increment,
  `short_list_id` int(10) unsigned NOT NULL,
  `resume_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`sl_resume_id`),
  KEY `FK_short_list_1` (`short_list_id`),
  KEY `FK_resume_11` (`resume_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `sl_has_resume`
--


-- --------------------------------------------------------

--
-- Table structure for table `vacancy`
--

DROP TABLE IF EXISTS `vacancy`;
CREATE TABLE IF NOT EXISTS `vacancy` (
  `vacancy_id` int(10) unsigned NOT NULL auto_increment,
  `company_id` int(10) unsigned NOT NULL,
  `vacancy_code` varchar(11) NOT NULL,
  `job_title` varchar(100) NOT NULL,
  `no_of_vacancies` tinyint(3) unsigned default NULL,
  `displayed_salary` enum('Negotiable','Around','Up to','Above','Range') NOT NULL,
  `min_salary` double(7,2) unsigned default NULL,
  `max_salary` double(7,2) unsigned default NULL,
  `estimated_salary` double(7,2) unsigned NOT NULL,
  `priority` enum('Urgent','High','Meidum','Low') NOT NULL,
  `work_level_id` tinyint(3) unsigned NOT NULL,
  `public` enum('Yes','No') NOT NULL,
  `online_view_count` int(10) unsigned NOT NULL default '0',
  `applied_count` int(10) unsigned NOT NULL default '0',
  `status` enum('Open','Hidden','Closed','Archived') NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  PRIMARY KEY  (`vacancy_id`),
  KEY `FK_work_level_lookup_1` (`work_level_id`),
  KEY `FK_company_1` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `vacancy`
--


-- --------------------------------------------------------

--
-- Table structure for table `va_details`
--

DROP TABLE IF EXISTS `va_details`;
CREATE TABLE IF NOT EXISTS `va_details` (
  `va_va_details_id` int(10) unsigned NOT NULL auto_increment,
  `vacancy_id` int(10) unsigned NOT NULL,
  `desc_reqs` text NOT NULL,
  PRIMARY KEY  (`va_va_details_id`),
  KEY `FK_vacancy_6` (`vacancy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `va_details`
--


-- --------------------------------------------------------

--
-- Table structure for table `va_has_consultant`
--

DROP TABLE IF EXISTS `va_has_consultant`;
CREATE TABLE IF NOT EXISTS `va_has_consultant` (
  `va_consultant_id` int(10) unsigned NOT NULL auto_increment,
  `vacancy_id` int(10) unsigned NOT NULL,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `inchange_type` enum('Main','Supporting') NOT NULL,
  `status` enum('Active','Inactive') NOT NULL,
  PRIMARY KEY  (`va_consultant_id`),
  KEY `FK_consultant_2` (`consultant_id`),
  KEY `FK_vacancy_1` (`vacancy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `va_has_consultant`
--


-- --------------------------------------------------------

--
-- Table structure for table `va_has_function`
--

DROP TABLE IF EXISTS `va_has_function`;
CREATE TABLE IF NOT EXISTS `va_has_function` (
  `va_function_id` int(10) unsigned NOT NULL auto_increment,
  `function_id` tinyint(3) unsigned NOT NULL,
  `vacancy_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`va_function_id`),
  KEY `FK_function_lookup_1` (`function_id`),
  KEY `FK_vacancy_3` (`vacancy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `va_has_function`
--


-- --------------------------------------------------------

--
-- Table structure for table `va_has_location`
--

DROP TABLE IF EXISTS `va_has_location`;
CREATE TABLE IF NOT EXISTS `va_has_location` (
  `va_location_id` int(10) unsigned NOT NULL auto_increment,
  `vacancy_id` int(10) unsigned NOT NULL,
  `province_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`va_location_id`),
  KEY `FK_vacancy_4` (`vacancy_id`),
  KEY `FK_province_lookup_1` (`province_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `va_has_location`
--


-- --------------------------------------------------------

--
-- Table structure for table `va_process_history`
--

DROP TABLE IF EXISTS `va_process_history`;
CREATE TABLE IF NOT EXISTS `va_process_history` (
  `va_process_history_id` int(10) unsigned NOT NULL auto_increment,
  `vacancy_id` int(10) unsigned NOT NULL,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `action_date` date NOT NULL,
  `status` enum('Open','Hidden','Closed') NOT NULL,
  PRIMARY KEY  (`va_process_history_id`),
  KEY `FK_vacancy_2` (`vacancy_id`),
  KEY `FK_consultant_6` (`consultant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `va_process_history`
--


-- --------------------------------------------------------

--
-- Table structure for table `work_level_lookup`
--

DROP TABLE IF EXISTS `work_level_lookup`;
CREATE TABLE IF NOT EXISTS `work_level_lookup` (
  `work_level_id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`work_level_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `work_level_lookup`
--

INSERT INTO `work_level_lookup` (`work_level_id`, `name`, `sort_order`) VALUES
(1, 'Student/Intern', 1),
(2, 'Entry Level', 2),
(3, 'Experienced (Non-manager)', 3),
(4, 'Team Leader/Supervisor', 4),
(5, 'Manager', 5),
(6, 'Director', 6),
(7, 'Vice President/Senior Vice Presendent', 7),
(8, 'C Level (CEO, CFO, CTO, President...)', 8);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `candidate`
--
ALTER TABLE `candidate`
  ADD CONSTRAINT `FK_resume_1` FOREIGN KEY (`resume_id`) REFERENCES `resume` (`resume_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_vacancy_5` FOREIGN KEY (`vacancy_id`) REFERENCES `vacancy` (`vacancy_id`) ON DELETE CASCADE;

--
-- Constraints for table `candidate_has_process`
--
ALTER TABLE `candidate_has_process`
  ADD CONSTRAINT `FK_candidate_1` FOREIGN KEY (`candidate_id`) REFERENCES `candidate` (`candidate_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_consultant_3` FOREIGN KEY (`consultant_id`) REFERENCES `consultant` (`consultant_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_resume_process_lookup_1` FOREIGN KEY (`resume_process_id`) REFERENCES `resume_process_lookup` (`resume_process_id`);

--
-- Constraints for table `company`
--
ALTER TABLE `company`
  ADD CONSTRAINT `FK_busines_type_lookup_1` FOREIGN KEY (`busines_type_id`) REFERENCES `busines_type_lookup` (`busines_type_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_industry_lookup_1` FOREIGN KEY (`industry_id`) REFERENCES `industry_lookup` (`industry_id`);

--
-- Constraints for table `com_activity`
--
ALTER TABLE `com_activity`
  ADD CONSTRAINT `FK_company_7` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_company_activity_lookup_1` FOREIGN KEY (`company_activity_id`) REFERENCES `company_activity_lookup` (`company_activity_id`),
  ADD CONSTRAINT `FK_consultant_8` FOREIGN KEY (`consultant_id`) REFERENCES `consultant` (`consultant_id`);

--
-- Constraints for table `com_has_consultant_incharge`
--
ALTER TABLE `com_has_consultant_incharge`
  ADD CONSTRAINT `FK_company_6` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_consultant_7` FOREIGN KEY (`consultant_id`) REFERENCES `consultant` (`consultant_id`);

--
-- Constraints for table `com_information`
--
ALTER TABLE `com_information`
  ADD CONSTRAINT `FK_company_5` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`) ON DELETE CASCADE;

--
-- Constraints for table `com_ranking_history`
--
ALTER TABLE `com_ranking_history`
  ADD CONSTRAINT `FK_company_4` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_consultant_5` FOREIGN KEY (`consultant_id`) REFERENCES `consultant` (`consultant_id`);

--
-- Constraints for table `consultant_has_role`
--
ALTER TABLE `consultant_has_role`
  ADD CONSTRAINT `FK_consultant_16` FOREIGN KEY (`consultant_id`) REFERENCES `consultant` (`consultant_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_role_lookup_1` FOREIGN KEY (`role_id`) REFERENCES `role_lookup` (`role_id`);

--
-- Constraints for table `feature_lookup`
--
ALTER TABLE `feature_lookup`
  ADD CONSTRAINT `FK_module_lookup_1` FOREIGN KEY (`module_id`) REFERENCES `module_lookup` (`module_id`);

--
-- Constraints for table `resume`
--
ALTER TABLE `resume`
  ADD CONSTRAINT `FK_consultant_17` FOREIGN KEY (`created_consultant_id`) REFERENCES `consultant` (`consultant_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_consultant_18` FOREIGN KEY (`updated_consultant_id`) REFERENCES `consultant` (`consultant_id`) ON DELETE SET NULL;

--
-- Constraints for table `resume_saved_search`
--
ALTER TABLE `resume_saved_search`
  ADD CONSTRAINT `FK_consultant_22` FOREIGN KEY (`consultant_id`) REFERENCES `consultant` (`consultant_id`) ON DELETE CASCADE;

--
-- Constraints for table `res_addition`
--
ALTER TABLE `res_addition`
  ADD CONSTRAINT `FK_resume_6` FOREIGN KEY (`resume_id`) REFERENCES `resume` (`resume_id`) ON DELETE CASCADE;

--
-- Constraints for table `res_assessment`
--
ALTER TABLE `res_assessment`
  ADD CONSTRAINT `FK_candidate_4` FOREIGN KEY (`candidate_id`) REFERENCES `candidate` (`candidate_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_consultant_23` FOREIGN KEY (`consultant_id`) REFERENCES `consultant` (`consultant_id`) ON DELETE CASCADE;

--
-- Constraints for table `res_comment`
--
ALTER TABLE `res_comment`
  ADD CONSTRAINT `FK_consultant_21` FOREIGN KEY (`consultant_id`) REFERENCES `consultant` (`consultant_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_resume_12` FOREIGN KEY (`resume_id`) REFERENCES `resume` (`resume_id`) ON DELETE CASCADE;

--
-- Constraints for table `res_contact_info`
--
ALTER TABLE `res_contact_info`
  ADD CONSTRAINT `FK_nationality_lookup_1` FOREIGN KEY (`nationality_id`) REFERENCES `nationality_lookup` (`nationality_id`),
  ADD CONSTRAINT `FK_province_lookup_2` FOREIGN KEY (`province_id`) REFERENCES `province_lookup` (`province_id`),
  ADD CONSTRAINT `FK_resume_3` FOREIGN KEY (`resume_id`) REFERENCES `resume` (`resume_id`) ON DELETE CASCADE;

--
-- Constraints for table `res_document`
--
ALTER TABLE `res_document`
  ADD CONSTRAINT `FK_resume_8` FOREIGN KEY (`resume_id`) REFERENCES `resume` (`resume_id`) ON DELETE CASCADE;

--
-- Constraints for table `res_education`
--
ALTER TABLE `res_education`
  ADD CONSTRAINT `FK_country_lookup_2` FOREIGN KEY (`country_id`) REFERENCES `country_lookup` (`country_id`),
  ADD CONSTRAINT `FK_program_level_lookup_1` FOREIGN KEY (`program_level_id`) REFERENCES `program_level_lookup` (`program_level_id`),
  ADD CONSTRAINT `FK_resume_5` FOREIGN KEY (`resume_id`) REFERENCES `resume` (`resume_id`) ON DELETE CASCADE;

--
-- Constraints for table `res_expectation`
--
ALTER TABLE `res_expectation`
  ADD CONSTRAINT `FK_resume_7` FOREIGN KEY (`resume_id`) REFERENCES `resume` (`resume_id`) ON DELETE CASCADE;

--
-- Constraints for table `res_expectation_details`
--
ALTER TABLE `res_expectation_details`
  ADD CONSTRAINT `FK_res_expectation_2` FOREIGN KEY (`res_expectation_id`) REFERENCES `res_expectation` (`res_expectation_id`) ON DELETE CASCADE;

--
-- Constraints for table `res_expectation_has_location`
--
ALTER TABLE `res_expectation_has_location`
  ADD CONSTRAINT `FK_province_lookup_4` FOREIGN KEY (`province_id`) REFERENCES `province_lookup` (`province_id`),
  ADD CONSTRAINT `FK_res_expectation_1` FOREIGN KEY (`res_expectation_id`) REFERENCES `res_expectation` (`res_expectation_id`) ON DELETE CASCADE;

--
-- Constraints for table `res_experience`
--
ALTER TABLE `res_experience`
  ADD CONSTRAINT `FK_country_lookup_1` FOREIGN KEY (`country_id`) REFERENCES `country_lookup` (`country_id`),
  ADD CONSTRAINT `FK_province_lookup_3` FOREIGN KEY (`province_id`) REFERENCES `province_lookup` (`province_id`),
  ADD CONSTRAINT `FK_resume_4` FOREIGN KEY (`resume_id`) REFERENCES `resume` (`resume_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_work_level_lookup_2` FOREIGN KEY (`work_level_id`) REFERENCES `work_level_lookup` (`work_level_id`);

--
-- Constraints for table `res_experience_details`
--
ALTER TABLE `res_experience_details`
  ADD CONSTRAINT `FK_res_experience_1` FOREIGN KEY (`res_experience_id`) REFERENCES `res_experience` (`res_experience_id`) ON DELETE CASCADE;

--
-- Constraints for table `res_experience_has_function`
--
ALTER TABLE `res_experience_has_function`
  ADD CONSTRAINT `FK_function_lookup_2` FOREIGN KEY (`function_id`) REFERENCES `function_lookup` (`function_id`),
  ADD CONSTRAINT `FK_res_experience_2` FOREIGN KEY (`res_experience_id`) REFERENCES `res_experience` (`res_experience_id`) ON DELETE CASCADE;

--
-- Constraints for table `res_experience_has_industry`
--
ALTER TABLE `res_experience_has_industry`
  ADD CONSTRAINT `FK_industry_lookup_2` FOREIGN KEY (`industry_id`) REFERENCES `industry_lookup` (`industry_id`),
  ADD CONSTRAINT `FK_res_experience_3` FOREIGN KEY (`res_experience_id`) REFERENCES `res_experience` (`res_experience_id`) ON DELETE CASCADE;

--
-- Constraints for table `res_photo`
--
ALTER TABLE `res_photo`
  ADD CONSTRAINT `FK_resume_2` FOREIGN KEY (`resume_id`) REFERENCES `resume` (`resume_id`) ON DELETE CASCADE;

--
-- Constraints for table `res_unsubcribe`
--
ALTER TABLE `res_unsubcribe`
  ADD CONSTRAINT `FK_consultant_28` FOREIGN KEY (`consultant_id`) REFERENCES `consultant` (`consultant_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_resume_13` FOREIGN KEY (`resume_id`) REFERENCES `resume` (`resume_id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permission`
--
ALTER TABLE `role_has_permission`
  ADD CONSTRAINT `FK_feature_lookup_1` FOREIGN KEY (`feature_id`) REFERENCES `feature_lookup` (`feature_id`),
  ADD CONSTRAINT `FK_role_lookup_6` FOREIGN KEY (`role_id`) REFERENCES `role_lookup` (`role_id`) ON DELETE CASCADE;

--
-- Constraints for table `role_lookup`
--
ALTER TABLE `role_lookup`
  ADD CONSTRAINT `FK_department_lookup_1` FOREIGN KEY (`department_id`) REFERENCES `department_lookup` (`department_id`);

--
-- Constraints for table `short_list`
--
ALTER TABLE `short_list`
  ADD CONSTRAINT `FK_consultant_20` FOREIGN KEY (`consultant_id`) REFERENCES `consultant` (`consultant_id`) ON DELETE CASCADE;

--
-- Constraints for table `sl_has_resume`
--
ALTER TABLE `sl_has_resume`
  ADD CONSTRAINT `FK_resume_11` FOREIGN KEY (`resume_id`) REFERENCES `resume` (`resume_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_short_list_1` FOREIGN KEY (`short_list_id`) REFERENCES `short_list` (`short_list_id`) ON DELETE CASCADE;

--
-- Constraints for table `vacancy`
--
ALTER TABLE `vacancy`
  ADD CONSTRAINT `FK_company_1` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_work_level_lookup_1` FOREIGN KEY (`work_level_id`) REFERENCES `work_level_lookup` (`work_level_id`);

--
-- Constraints for table `va_details`
--
ALTER TABLE `va_details`
  ADD CONSTRAINT `FK_vacancy_6` FOREIGN KEY (`vacancy_id`) REFERENCES `vacancy` (`vacancy_id`) ON DELETE CASCADE;

--
-- Constraints for table `va_has_consultant`
--
ALTER TABLE `va_has_consultant`
  ADD CONSTRAINT `FK_consultant_2` FOREIGN KEY (`consultant_id`) REFERENCES `consultant` (`consultant_id`),
  ADD CONSTRAINT `FK_vacancy_1` FOREIGN KEY (`vacancy_id`) REFERENCES `vacancy` (`vacancy_id`) ON DELETE CASCADE;

--
-- Constraints for table `va_has_function`
--
ALTER TABLE `va_has_function`
  ADD CONSTRAINT `FK_function_lookup_1` FOREIGN KEY (`function_id`) REFERENCES `function_lookup` (`function_id`),
  ADD CONSTRAINT `FK_vacancy_3` FOREIGN KEY (`vacancy_id`) REFERENCES `vacancy` (`vacancy_id`) ON DELETE CASCADE;

--
-- Constraints for table `va_has_location`
--
ALTER TABLE `va_has_location`
  ADD CONSTRAINT `FK_province_lookup_1` FOREIGN KEY (`province_id`) REFERENCES `province_lookup` (`province_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_vacancy_4` FOREIGN KEY (`vacancy_id`) REFERENCES `vacancy` (`vacancy_id`) ON DELETE CASCADE;

--
-- Constraints for table `va_process_history`
--
ALTER TABLE `va_process_history`
  ADD CONSTRAINT `FK_consultant_6` FOREIGN KEY (`consultant_id`) REFERENCES `consultant` (`consultant_id`),
  ADD CONSTRAINT `FK_vacancy_2` FOREIGN KEY (`vacancy_id`) REFERENCES `vacancy` (`vacancy_id`) ON DELETE CASCADE;
