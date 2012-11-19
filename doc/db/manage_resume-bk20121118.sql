-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 18, 2012 at 11:47 PM
-- Server version: 5.1.30
-- PHP Version: 5.3.2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `manage_resume`
--

-- --------------------------------------------------------

--
-- Table structure for table `busines_type_lookup`
--

CREATE TABLE IF NOT EXISTS `busines_type_lookup` (
  `busines_type_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`busines_type_id`)
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

CREATE TABLE IF NOT EXISTS `candidate` (
  `candidate_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vacancy_id` int(10) unsigned NOT NULL,
  `resume_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`candidate_id`),
  KEY `FK_vacancy_5` (`vacancy_id`),
  KEY `FK_resume_1` (`resume_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `candidate_has_process`
--

CREATE TABLE IF NOT EXISTS `candidate_has_process` (
  `candidate_process_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `candidate_id` int(10) unsigned NOT NULL,
  `resume_process_id` tinyint(3) unsigned NOT NULL,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `action_date` date NOT NULL,
  `comment` varchar(300) NOT NULL,
  PRIMARY KEY (`candidate_process_id`),
  KEY `FK_candidate_1` (`candidate_id`),
  KEY `FK_resume_process_lookup_1` (`resume_process_id`),
  KEY `FK_consultant_3` (`consultant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE IF NOT EXISTS `company` (
  `company_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_code` varchar(11) NOT NULL,
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
  `status` enum('Active','Deleted') NOT NULL DEFAULT 'Active',
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  PRIMARY KEY (`company_id`),
  KEY `FK_busines_type_lookup_1` (`busines_type_id`),
  KEY `FK_industry_lookup_1` (`industry_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`company_id`, `company_code`, `full_name_en`, `short_name_en`, `full_name_vn`, `short_name_vn`, `busines_type_id`, `industry_id`, `tel`, `fax`, `email`, `address`, `website`, `status`, `created_date`, `updated_date`) VALUES
(1, 'C1', 'cty company', 'cty company', 'cty company', 'cty company', 4, 6, '4565767687', '565654', 'phanduycanh69@gmail.com', 'hcm', 'http://jqueryui.com/', 'Active', '2012-10-11 00:25:59', '2012-10-11 00:25:59'),
(2, 'C2', 'test', 'test', 'test', 'test', 1, 1, '848 38243 780', '848 38243 780', 'phanduycanh69@gmail.com', 'test', 'http://resume-manager.local', 'Active', '2012-11-07 21:52:33', '2012-11-07 21:52:33');

-- --------------------------------------------------------

--
-- Table structure for table `company_activity_lookup`
--

CREATE TABLE IF NOT EXISTS `company_activity_lookup` (
  `company_activity_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  `abbreviation` varchar(5) NOT NULL,
  PRIMARY KEY (`company_activity_id`)
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

CREATE TABLE IF NOT EXISTS `com_activity` (
  `com_activity_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned NOT NULL,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `company_activity_id` tinyint(3) unsigned NOT NULL,
  `action_date` date NOT NULL,
  `comment` varchar(300) NOT NULL,
  PRIMARY KEY (`com_activity_id`),
  KEY `FK_company_7` (`company_id`),
  KEY `FK_consultant_8` (`consultant_id`),
  KEY `FK_company_activity_lookup_1` (`company_activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `com_has_consultant_incharge`
--

CREATE TABLE IF NOT EXISTS `com_has_consultant_incharge` (
  `com_consultant_incharge_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned NOT NULL,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `action_date` date NOT NULL,
  `ranking` enum('A','B','C') NOT NULL,
  `status` enum('Active','Inactive') NOT NULL,
  PRIMARY KEY (`com_consultant_incharge_id`),
  KEY `FK_company_6` (`company_id`),
  KEY `FK_consultant_7` (`consultant_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `com_has_consultant_incharge`
--

INSERT INTO `com_has_consultant_incharge` (`com_consultant_incharge_id`, `company_id`, `consultant_id`, `action_date`, `ranking`, `status`) VALUES
(1, 1, 1, '2012-10-11', 'A', 'Active'),
(2, 2, 1, '2012-11-07', 'A', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `com_information`
--

CREATE TABLE IF NOT EXISTS `com_information` (
  `com_information_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned NOT NULL,
  `apply_to` enum('Internal','Public') NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`com_information_id`),
  KEY `FK_company_5` (`company_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `com_information`
--

INSERT INTO `com_information` (`com_information_id`, `company_id`, `apply_to`, `content`) VALUES
(1, 2, 'Internal', 'test');

-- --------------------------------------------------------

--
-- Table structure for table `com_ranking_history`
--

CREATE TABLE IF NOT EXISTS `com_ranking_history` (
  `com_ranking_history_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned NOT NULL,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `action_date` date NOT NULL,
  `ranking` enum('A','B','C') NOT NULL,
  PRIMARY KEY (`com_ranking_history_id`),
  KEY `FK_company_4` (`company_id`),
  KEY `FK_consultant_5` (`consultant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `consultant`
--

CREATE TABLE IF NOT EXISTS `consultant` (
  `consultant_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` enum('Mr.','Mrs.','Ms.') NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `job_title` varchar(100) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `username` varchar(50) NOT NULL,
  `is_admin` tinyint(1) unsigned DEFAULT '0',
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `status` enum('Active','Inactive','Deleted') NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  PRIMARY KEY (`consultant_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `consultant`
--

INSERT INTO `consultant` (`consultant_id`, `title`, `full_name`, `job_title`, `phone`, `username`, `is_admin`, `email`, `password`, `status`, `created_date`, `updated_date`) VALUES
(1, 'Mr.', 'Phan Duy Canh1122', 'Admin', '0939693990', 'duycanh', 1, 'phanduycanh69@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 'Active', '2012-10-05 11:31:25', '2012-10-05 11:31:25'),
(2, 'Mr.', 'Phạm Thanh Long', 'Admin', '0939693990', 'longpham', 0, 'longpt0310@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 'Active', '2012-10-05 11:31:25', '2012-10-05 11:31:25'),
(3, 'Mr.', 'Phan Thang Giang', 'Account manager', '848 38243 780', 'thanhgiang', 0, '', 'd41d8cd98f00b204e9800998ecf8427e', 'Deleted', '2012-11-16 23:30:49', '2012-11-16 23:30:49'),
(4, 'Mr.', 'Nguyen van A', 'Account manager', '848 38243 780', 'VanA', 0, 'test@mail.com', 'd41d8cd98f00b204e9800998ecf8427e', 'Deleted', '2012-11-16 23:31:23', '2012-11-16 23:31:23'),
(5, 'Mr.', 'Nguyen van B11', 'Call Center Manager Vietnam11', '848 38243 7803', 'VanB', 0, '', '098f6bcd4621d373cade4e832627b4f6', 'Deleted', '2012-11-16 23:33:45', '2012-11-16 23:33:45'),
(6, 'Mr.', 'Phan Duy Canh1122', 'HR Consultant Manager2', '0939693990', 'duycanh122', 0, 'phanduycanh69@gmail.com', 'd41d8cd98f00b204e9800998ecf8427e', 'Deleted', '2012-11-17 00:33:35', '2012-11-17 00:33:35'),
(7, 'Mr.', 'my test', 'Account manager', '848 38243 780', 'test', 0, 'test@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'Inactive', '2012-11-17 02:03:00', '2012-11-17 02:03:00');

-- --------------------------------------------------------

--
-- Table structure for table `consultant_has_role`
--

CREATE TABLE IF NOT EXISTS `consultant_has_role` (
  `consultant_role_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` tinyint(3) unsigned NOT NULL,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `is_main` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`consultant_role_id`),
  KEY `FK_role_lookup_1` (`role_id`),
  KEY `FK_consultant_16` (`consultant_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `consultant_has_role`
--

INSERT INTO `consultant_has_role` (`consultant_role_id`, `role_id`, `consultant_id`, `is_main`) VALUES
(1, 13, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `contact_person`
--

CREATE TABLE IF NOT EXISTS `contact_person` (
  `contact_person_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned NOT NULL,
  `title` enum('Mr.','Mrs.','Ms.') NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `job_title` varchar(100) NOT NULL,
  `tel_1` varchar(30) DEFAULT NULL,
  `tel_2` varchar(30) DEFAULT NULL,
  `fax` varchar(30) DEFAULT NULL,
  `mobile_1` varchar(30) DEFAULT NULL,
  `mobile_2` varchar(30) DEFAULT NULL,
  `email_1` varchar(100) DEFAULT NULL,
  `email_2` varchar(100) DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`contact_person_id`),
  KEY `FK_company_3` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `country_lookup`
--

CREATE TABLE IF NOT EXISTS `country_lookup` (
  `country_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`country_id`)
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

CREATE TABLE IF NOT EXISTS `department_lookup` (
  `department_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(5) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`department_id`)
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

CREATE TABLE IF NOT EXISTS `feature_lookup` (
  `feature_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `module_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `sort_order` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`feature_id`),
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

CREATE TABLE IF NOT EXISTS `function_lookup` (
  `function_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `parent_function_id` tinyint(3) unsigned DEFAULT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`function_id`)
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

CREATE TABLE IF NOT EXISTS `industry_lookup` (
  `industry_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `abbreviation` varchar(3) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `parent_industry_id` tinyint(3) unsigned DEFAULT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`industry_id`)
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

CREATE TABLE IF NOT EXISTS `module_lookup` (
  `module_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `sort_order` tinyint(4) NOT NULL,
  PRIMARY KEY (`module_id`)
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

CREATE TABLE IF NOT EXISTS `nationality_lookup` (
  `nationality_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`nationality_id`)
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

CREATE TABLE IF NOT EXISTS `program_level_lookup` (
  `program_level_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`program_level_id`)
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

CREATE TABLE IF NOT EXISTS `province_lookup` (
  `province_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`province_id`)
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

CREATE TABLE IF NOT EXISTS `resume` (
  `resume_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `resume_code` varchar(11) NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `birthday` varchar(30) DEFAULT NULL,
  `gender` enum('Male','Female') DEFAULT NULL,
  `marital_status` enum('Single','Married','Divorced') DEFAULT NULL,
  `status` enum('Active','Deleted','Closed','Archived') NOT NULL,
  `email_1` varchar(100) NOT NULL,
  `email_2` varchar(100) DEFAULT NULL,
  `mobile_1` varchar(20) NOT NULL,
  `mobile_2` varchar(20) DEFAULT NULL,
  `tel` varchar(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `view_count` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `created_date` date NOT NULL,
  `created_consultant_id` smallint(5) unsigned DEFAULT NULL,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_consultant_id` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`resume_id`),
  KEY `FK_consultant_17` (`created_consultant_id`),
  KEY `FK_consultant_18` (`updated_consultant_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Dumping data for table `resume`
--

INSERT INTO `resume` (`resume_id`, `resume_code`, `full_name`, `birthday`, `gender`, `marital_status`, `status`, `email_1`, `email_2`, `mobile_1`, `mobile_2`, `tel`, `address`, `view_count`, `created_date`, `created_consultant_id`, `updated_date`, `updated_consultant_id`) VALUES
(1, 'R1', 'phan duy canh676767', '1985-07-25', 'Male', 'Single', 'Active', 'phanduycanha4@mail.com', 'phanduycanh@mail.com', '4534654366', '07898765', '09876543', 'Lac Long Quan2222', 4, '2012-10-01', 1, '2012-09-30 17:18:08', 1),
(2, 'R2', 'phan duy canh', '1985-07-25', 'Male', 'Single', 'Active', 'phanduycanha4@mail.com', 'phanduycanh@mail.com', '123456789', '45645645', '09876543', 'Lac Long Quan', 4, '2012-08-08', 1, '2012-10-14 14:46:25', 1),
(3, 'R3', 'phan duy canh2222', '2012-05-16', 'Male', 'Single', 'Active', 'phanduycanh@mail.com', '', '4368659589856', '', '', 'thanh pho ho chi minh', 0, '2012-09-26', 1, '2012-10-19 16:56:21', 1),
(4, 'R-01', 'Phan Thanh Giang', '2012-04-17', 'Male', 'Single', 'Active', 'phanthanggiang@mail.com', '', '0989333988', '', '', 'Phường 8 - Cà Mau', 0, '2012-09-26', 1, '2012-09-26 15:21:52', 1),
(5, 'R5', 'Nguyen Han Thien Ly', '1985-07-25', 'Male', 'Single', 'Active', 'thienly@mail.com', 'nguyenhanthienly@mail.com', '4534654366', '07898765', '09876543', 'Lac Long Quan111', 0, '2012-09-30', 1, '2012-10-15 12:40:35', 1),
(6, 'R6', 'Nguyen Han Van Lam', '1985-07-25', 'Male', 'Single', 'Active', 'phanduycanha4@mail.com', 'phanduycanh@mail.com', '4534654366', '07898765', '09876543', 'Lac Long Quan 1111', 0, '2012-09-30', 1, '2012-10-08 14:04:10', 1),
(7, 'R7', 'Nguyễn thị bích Đào44', '2012-05-15', 'Female', 'Married', 'Active', 'bichdao@mail.com', 'bichdao222@mail.com', '4368659589856', '', '', 'Lac Long Quan 1111', 0, '2012-09-27', 1, '2012-09-26 18:12:07', 1),
(8, 'R8', 'Pham Thanh Long', '2012-05-01', 'Male', 'Single', 'Active', 'phanthanggiang@mail.com', '', '4368659589856', '', '', 'thanh pho ho chi minh', 0, '2012-09-30', 1, '2012-09-30 17:22:28', 1),
(9, 'R9', 'Pham Thanh Long', '2012-05-15', 'Male', 'Single', 'Active', 'phanthanggiang@mail.com', 'bichdao222@mail.com', '4368659589856', '', '4565767687', 'Lac Long Quan 1111', 0, '2012-09-30', 1, '2012-09-30 16:06:31', 1),
(10, 'R10', 'Nguyen Han Thien Ly 22', '2008-03-05', 'Female', 'Married', 'Active', 'thienly@mail.com', '', '5756786587', '', '', 'hcm', 0, '2012-10-14', 1, '2012-10-13 19:25:15', 1),
(11, 'R11', 'Tang Thanh Ha', '2013-10-01', 'Female', 'Single', 'Active', 'thanhha@mail.com', 'ha.tang@mail.com', '454365656', '78679678967', '5666565463', 'Pham Ngọc Thạch', 0, '2012-10-16', 1, '2012-10-28 01:43:48', 1),
(12, 'R12', 'Tieu Van Tieng', '1987-10-09', 'Male', 'Single', 'Active', 'tien@mail.com', '', '3435452332', '', '', 'Lac Long Quan 1111', 0, '2012-10-19', 1, '2012-10-28 01:54:35', 1),
(13, 'R13', 'Nguyen Van Long', '2012-10-09', 'Male', 'Single', 'Active', 'long@mail.com', '', '3435452332', '', '', 'thanh pho ho chi minh', 0, '2012-10-19', 1, '2012-11-16 18:15:23', 1),
(15, 'R', 'phan duy canh555', '2012-05-16', 'Male', 'Single', 'Active', 'phanduycanh@mail.com', '', '4368659589856', '', '', 'Lac Long Quan 1111', 0, '2012-10-19', 1, '2012-10-25 17:49:27', 1),
(16, 'R16', 'phan durr7776666555', '2012-10-02', 'Male', 'Single', 'Active', 'phanthanggiang@mail.com', '', '3435452332', '', '', 'thanh pho ho chi minh', 0, '2012-10-19', 1, '2012-10-28 01:44:55', 1),
(17, 'R', 'Huynh Van Banh', '2012-10-01', 'Male', 'Single', 'Active', 'long@mail.com', '', '123456789', '', '', 'thanh pho ho chi minh', 0, '2012-10-19', 1, '2012-10-28 01:41:06', 1),
(18, 'R18', 'Han Thai Tu', '2002-10-01', 'Male', 'Single', 'Active', 'thaitu@mail.com', '', '4368659589856', '', '', 'Lac Long Quan 1111', 0, '2012-10-28', 1, '2012-10-28 03:38:01', 2),
(19, 'R19', 'Trần Văn Đang', '1985-07-25', 'Male', 'Single', 'Active', 'dang@mail.com', '', '09009888999', '', '', 'Lac Long Quan ', 0, '2012-10-28', 1, '2012-11-04 17:53:39', 1),
(20, 'R20', 'test', 'fsdfsdf', 'Male', 'Single', 'Active', 'long@mail.com', '', '3435452332', '', '', 'thanh pho ho chi minh', 0, '2012-11-05', 1, '2012-11-05 16:30:45', 1),
(21, 'R21', 'Nguyen van A', '02-09-2009', 'Male', 'Single', 'Active', 'anguyen@mail.com', '', '3435452332', '', '', 'thanh pho ho chi minh', 0, '2012-11-11', 1, '2012-11-11 13:16:13', 1),
(22, 'R1', 'phan duy canh676767', '1985-07-25', 'Male', 'Single', 'Active', 'phanduycanha4@mail.com', 'phanduycanh@mail.com', '4534654366', '07898765', '09876543', 'Lac Long Quan2222', 4, '2012-10-01', 1, '2012-09-30 17:18:08', 1),
(23, 'R1', 'phan duy canh676767', '1985-07-25', 'Male', 'Single', 'Active', 'phanduycanha4@mail.com', 'phanduycanh@mail.com', '4534654366', '07898765', '09876543', 'Lac Long Quan2222', 4, '2012-10-01', 1, '2012-09-30 17:18:08', 1);

-- --------------------------------------------------------

--
-- Table structure for table `resume_process_lookup`
--

CREATE TABLE IF NOT EXISTS `resume_process_lookup` (
  `resume_process_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `complete_percentage` tinyint(3) unsigned NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`resume_process_id`)
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
-- Table structure for table `res_comment`
--

CREATE TABLE IF NOT EXISTS `res_comment` (
  `res_comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `resume_id` int(10) unsigned NOT NULL,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `content` varchar(500) NOT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`res_comment_id`),
  KEY `FK_resume_12` (`resume_id`),
  KEY `FK_consultant_21` (`consultant_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=83 ;

--
-- Dumping data for table `res_comment`
--

INSERT INTO `res_comment` (`res_comment_id`, `resume_id`, `consultant_id`, `content`, `created_date`) VALUES
(1, 6, 1, 'THis is testing for today', NULL),
(4, 1, 1, 'This is tetfdmsfk ndsf dfk asdfsdaf  g fgfdg fdg fsdg fg fsdgfdh h dfg fdgfdgfgfg', NULL),
(5, 6, 1, 'This is tetfdmsfk ndsf dfk asdfsdaf  tgh dfghtgf hshs dgrftgrt retr tytr ytu yuyuytutyuyu ryy y ty', '2012-10-06 03:00:00'),
(6, 1, 1, ' fdg fg dfgfg', NULL),
(8, 1, 1, 'Canh da test function nay', NULL),
(9, 1, 1, 'test', '2012-10-05 17:43:29'),
(10, 6, 1, 'hfgdf sdfgfd', '2012-10-05 17:45:57'),
(11, 6, 1, 'fdfdsfsadf', '2012-10-05 17:47:11'),
(12, 6, 1, 'dfdsfd', '2012-10-05 17:50:09'),
(13, 6, 1, 'fdsfds fgsfdg', '2012-10-05 17:50:58'),
(14, 6, 1, 'new  commment\n', '2012-10-05 18:02:22'),
(15, 6, 1, 'kjhgfdsrt ty th tfgh', '2012-10-05 18:04:30'),
(16, 6, 1, 'kjhgfdsrt ty th tfghfgfg fg', '2012-10-05 18:05:02'),
(17, 2, 1, 'This is testing for comment\n', '2012-10-06 05:47:17'),
(18, 8, 1, 'good job\n', '2012-10-06 05:47:30'),
(19, 6, 1, 'This is testing comment for nguyen han van lam', '2012-10-06 05:49:37'),
(20, 6, 1, 'tesing comment', '2012-10-06 05:50:58'),
(21, 2, 1, 'Yes testing successful', '2012-10-06 05:51:15'),
(22, 7, 1, 'testing', '2012-10-06 05:58:25'),
(23, 3, 1, 'testing\n', '2012-10-06 05:58:32'),
(24, 5, 1, 'good job\n', '2012-10-06 06:07:25'),
(25, 6, 1, 'tran khin', '2012-10-08 14:05:38'),
(26, 6, 1, 'testttttt', '2012-10-09 15:45:16'),
(27, 6, 1, '', '2012-10-09 16:01:21'),
(28, 6, 1, 'test', '2012-10-09 16:04:00'),
(30, 6, 1, '', '2012-10-09 16:08:38'),
(31, 6, 1, '', '2012-10-09 16:08:41'),
(32, 6, 1, '', '2012-10-09 16:08:43'),
(33, 6, 1, 'fgsfdg dfg sdfg sdfgsdf', '2012-10-09 16:08:48'),
(34, 6, 1, '', '2012-10-09 16:08:58'),
(35, 6, 1, '', '2012-10-09 16:11:55'),
(36, 6, 1, 'fgf g fgsfdg sdfg ggggggggggg dfg sfdgfdg sfg sfgsfdg', '2012-10-09 16:13:10'),
(37, 6, 1, 'uuuuuuuuuuuu uuuuuuuu uuuu', '2012-10-10 17:44:47'),
(38, 10, 1, 'test', '2012-10-13 19:30:08'),
(39, 10, 1, 'test', '2012-10-13 19:30:19'),
(40, 10, 1, 'test', '2012-10-13 19:30:19'),
(41, 10, 1, 'fgfdgsdfgf', '2012-10-13 19:32:05'),
(42, 10, 1, 'testsstttttttttttttt', '2012-10-13 19:32:30'),
(43, 10, 1, 'uuuu', '2012-10-13 19:33:03'),
(44, 10, 1, 'iuytrđg g fhg dfhfg', '2012-10-13 19:39:15'),
(45, 10, 1, 'gfgfgfdg', '2012-10-13 19:39:57'),
(46, 10, 1, 'ffffdfdf', '2012-10-13 19:40:29'),
(47, 10, 1, 'ffffdfdf', '2012-10-13 19:40:29'),
(48, 6, 1, ' sdf aldsf hnjkads hfjkd hjf dsjfs hfjk hdfj jjghf jgfkjgh sdflkghfsdgj s fghkfg  fgfg  fg fg g fgfdg dfg f hfg hhj hjk hfgh gsfd gdfg dfgfgdfg sd gdfgsdgdfgf df gfg dfg', '2012-10-15 05:34:41'),
(49, 6, 1, 'Lượng lớn dầu bị đổ ra đường Hồ Tùng Mậu (Hà Nội) đã khiến hàng chục xe máy bị trơn trượt, ngã ra đường đầu giờ sáng. Nhiều người phải muộn giờ học, giờ làm vì quần áo lấm lem dầu mỡ.', '2012-10-15 05:45:01'),
(50, 2, 1, 'Lượng lớn dầu bị đổ ra đường Hồ Tùng Mậu (Hà Nội) đã khiến hàng chục xe máy bị trơn trượt, ngã ra đường đầu giờ sáng. Nhiều người phải muộn giờ học, giờ làm vì quần áo lấm lem dầu mỡ.', '2012-10-15 05:45:31'),
(51, 2, 1, 'Cùng lúc đó, thị trường vàng thế giới tiếp tục rơi xuống mức đáy của hai tuần rưỡi trong sáng thứ hai sau khi đã giảm từ tuần trước. Tính ', '2012-10-15 05:47:53'),
(52, 10, 1, 'testt', '2012-10-15 06:02:57'),
(53, 10, 1, 'testttttt', '2012-10-15 06:03:19'),
(54, 10, 1, 'testttttt555', '2012-10-15 06:03:51'),
(55, 10, 1, 'testtttttt fnal', '2012-10-15 06:06:54'),
(56, 5, 1, 'test', '2012-10-15 11:35:35'),
(57, 5, 1, 'This is testing', '2012-10-15 11:39:25'),
(58, 5, 1, 'blacklist,ko duoc contact', '2012-10-15 12:35:29'),
(59, 11, 1, 'this is testing for comment\n', '2012-10-17 13:59:43'),
(60, 15, 1, 'this is test for comment', '2012-10-25 17:54:31'),
(61, 15, 1, 'test comment 22', '2012-10-25 17:55:26'),
(62, 15, 1, 'test comment 333', '2012-10-25 17:56:50'),
(63, 17, 1, 'This is testing for comment', '2012-10-25 18:00:49'),
(64, 17, 1, 'test comment5', '2012-10-25 18:13:57'),
(65, 17, 1, 'Test comment final', '2012-10-25 18:14:36'),
(66, 17, 1, 'test', '2012-10-25 18:17:45'),
(67, 15, 1, 'test666', '2012-10-25 18:17:57'),
(68, 15, 1, 'ttettt77', '2012-10-25 18:22:08'),
(69, 15, 1, 'test888', '2012-10-25 18:22:33'),
(70, 15, 1, 'tset999', '2012-10-25 18:22:54'),
(71, 17, 1, 'test33', '2012-10-25 18:25:12'),
(72, 15, 1, 'test1000', '2012-10-25 18:26:31'),
(73, 17, 1, 'test66', '2012-10-25 18:27:06'),
(74, 17, 1, 'tetettttttttt tttt', '2012-10-25 18:33:06'),
(75, 11, 1, 'test final', '2012-10-25 18:33:25'),
(76, 12, 1, 'test', '2012-10-28 01:40:26'),
(77, 12, 1, 'test1111', '2012-10-28 01:40:36'),
(78, 18, 1, 'test', '2012-10-28 16:35:51'),
(79, 19, 1, 'tetstttt', '2012-10-30 16:19:03'),
(80, 19, 1, 'test 2222', '2012-10-30 16:19:19'),
(81, 13, 1, 'tet', '2012-11-18 15:39:23'),
(82, 13, 1, 'anh giang', '2012-11-18 15:39:36');

-- --------------------------------------------------------

--
-- Table structure for table `res_education`
--

CREATE TABLE IF NOT EXISTS `res_education` (
  `res_education_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `resume_id` int(10) unsigned NOT NULL,
  `start_date` varchar(30) DEFAULT NULL,
  `end_date` varchar(30) DEFAULT NULL,
  `school_name` varchar(100) DEFAULT NULL,
  `program_name` varchar(100) DEFAULT NULL,
  `program_info` varchar(200) DEFAULT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`res_education_id`),
  KEY `FK_resume_5` (`resume_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `res_education`
--

INSERT INTO `res_education` (`res_education_id`, `resume_id`, `start_date`, `end_date`, `school_name`, `program_name`, `program_info`, `sort_order`) VALUES
(2, 11, '2007-10-31', '2012-10-10', 'DH Khoa Hoc Tu nhien TPHCM', 'Thach Si chuyên nghàng Công nghệ Thông tin', 'Học ở đây rất tốt, có nhiều điều kiện nghiên cứu và phát triển, có nhiều giáo viên giỏi.', 1),
(3, 11, '2005-01-12', '2007-10-01', 'DH Khoa Hoc Tu nhien TPHCM 1', 'Thach Si chuyên nghàng Công nghệ Thông tin 2', 'Học ở đây rất tốt, có nhiều điều kiện nghiên cứu và phát triển, có nhiều giáo viên giỏi.  3', 1),
(4, 17, '2010-01-01', '2012-02-01', 'DH Khoa Hoc Tu nhien TPHCM', 'Infomation Technology', 'test', 1),
(5, 15, '2004-02-06', '2007-04-10', 'Mekong University', 'Infomation Technology', 'test', 1),
(6, 19, '09-1998', '07-2003', 'Mekong University', 'Infomation Technology', 'this is testing', 1),
(7, 21, '09-1999', '03-2011', 'Mekong University', 'Infomation Technology', 'testttt', 1);

-- --------------------------------------------------------

--
-- Table structure for table `res_expectation`
--

CREATE TABLE IF NOT EXISTS `res_expectation` (
  `res_expectation_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `resume_id` int(10) unsigned NOT NULL,
  `estimated_salary_to` double(7,2) unsigned DEFAULT NULL,
  `estimated_salary_from` double(7,2) unsigned DEFAULT NULL,
  `current_salary` double(7,2) unsigned DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`res_expectation_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `res_expectation`
--

INSERT INTO `res_expectation` (`res_expectation_id`, `resume_id`, `estimated_salary_to`, `estimated_salary_from`, `current_salary`, `note`) VALUES
(1, 3, 3000.00, 2000.00, 1000.00, NULL),
(2, 4, 3000.00, 2000.00, 1000.00, NULL),
(5, 1, 30044.00, 20044.00, 10044.00, NULL),
(6, 7, 3000.00, 2000.00, 10033.00, NULL),
(7, 8, 2000.00, 1000.00, 100.00, NULL),
(8, 9, 30044.00, 2000.00, 1000.00, NULL),
(9, 5, 3000.00, 2000.00, 1000.00, NULL),
(10, 6, 2000.00, 2000.00, 100.00, NULL),
(11, 10, 600.00, 200.00, 100.00, NULL),
(12, 11, 4000.00, 3000.00, 1000.00, NULL),
(13, 15, 3000.00, 2000.00, 1000.00, NULL),
(14, 17, 3000.00, 2000.00, 1000.00, NULL),
(15, 16, 3000.00, 2000.00, 1000.00, NULL),
(16, 12, 3000.00, 2000.00, 1000.00, NULL),
(17, 19, 2700.00, 2000.00, 100.00, NULL),
(18, 21, 3000.00, 2000.00, 1000.00, 'testtt'),
(19, 13, 3000.00, 2000.00, 1000.00, 'test');

-- --------------------------------------------------------

--
-- Table structure for table `res_expectation_has_location`
--

CREATE TABLE IF NOT EXISTS `res_expectation_has_location` (
  `res_expectation_location_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `res_expectation_id` int(10) unsigned NOT NULL,
  `province_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`res_expectation_location_id`),
  KEY `FK_res_expectation_1` (`res_expectation_id`),
  KEY `FK_province_lookup_4` (`province_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=74 ;

--
-- Dumping data for table `res_expectation_has_location`
--

INSERT INTO `res_expectation_has_location` (`res_expectation_location_id`, `res_expectation_id`, `province_id`) VALUES
(6, 6, 1),
(7, 6, 2),
(8, 6, 3),
(9, 6, 3),
(10, 6, 4),
(13, 7, 3),
(14, 7, 4),
(25, 5, 1),
(26, 5, 22),
(27, 5, 23),
(28, 5, 24),
(29, 5, 25),
(30, 8, 30),
(31, 8, 31),
(32, 8, 58),
(40, 10, 1),
(41, 10, 5),
(46, 11, 22),
(47, 11, 23),
(58, 9, 2),
(59, 9, 5),
(60, 9, 6),
(61, 9, 22),
(62, 12, 29),
(63, 13, 38),
(64, 13, 39),
(65, 14, 1),
(66, 14, 2),
(67, 15, 22),
(68, 16, 2),
(70, 17, 1),
(71, 18, 22),
(72, 18, 23),
(73, 19, 22);

-- --------------------------------------------------------

--
-- Table structure for table `res_experience`
--

CREATE TABLE IF NOT EXISTS `res_experience` (
  `res_experience_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `resume_id` int(10) unsigned NOT NULL,
  `start_date` varchar(30) DEFAULT NULL,
  `end_date` varchar(30) DEFAULT NULL,
  `job_title` varchar(100) DEFAULT NULL,
  `company_name` varchar(100) DEFAULT NULL,
  `duties` text,
  `experience_other` text,
  `sort_order` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`res_experience_id`),
  KEY `resume_id` (`resume_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=43 ;

--
-- Dumping data for table `res_experience`
--

INSERT INTO `res_experience` (`res_experience_id`, `resume_id`, `start_date`, `end_date`, `job_title`, `company_name`, `duties`, `experience_other`, `sort_order`) VALUES
(2, 2, '2012-07-01', '2012-06-03', 'Call Center Manager ', 'VIETNAMESE JOINT VENTURE INTERIORS COMPANY', 'VIETNAMESE JOINT VENTURE INTERIORS COMPANY\r\nVIETNAMESE JOINT VENTURE INTERIORS COMPANY', '0', 1),
(3, 2, '2011-07-01', '2011-12-01', 'Tester manager', 'IBM Solution', 'adgh ạgbâtiảhtvrtiẻtv ịutieqrtjv rtjụetbẻỷweiy', '0', 1),
(4, 3, '2012-05-15', '2012-07-12', 'Account manager', 'Bảo Hiểm AAA', ' fsdg fdh fghg jdfghfghf\r\nhdihidf l\r\nlkdfkljldk \r\ndjhfdklk \r\n', '0', 1),
(5, 4, '2011-11-14', '2012-01-08', 'Account manager', 'IBM Solution Vietnam', 'dfd fád fa sdgf gfdgh fgh gfhgfh \r\n ghfg h fghfg h fghgfhfg', '0', 1),
(6, 3, '2012-05-15', '2012-07-12', 'Account manager', 'Bảo Hiểm AAA', ' fsdg fdh fghg jdfghfghf ghgfhghgfh dgfhgh ghfghf', '0', 1),
(8, 1, '2012-03-01', '2012-02-07', 'Call Center Manager Vietnam', 'VIETNAMESE JOINT VENTURE INTERIORS COMPANY', ' dfd g fdg gffg', '0', 1),
(9, 7, '2012-06-04', '2012-06-04', 'Call Center Manager Vietnam', 'VIETNAMESE JOINT VENTURE INTERIORS COMPANY', 'thí ì dsf ádgf dssgfd gfgsfdgfdg', '0', 1),
(10, 7, '2012-08-01', '2012-09-01', 'IT Center Manager22', 'IBM Solution Vietnam22', 'g fdgsdfgsfd gf gfdg sdfgsfdgdf', '0', 1),
(11, 1, '2012-04-01', '2012-07-01', 'Account manager', 'IBM Solution Vietnam22', 'sdfa dfasd fa sdf dsf sdfsdf', '0', 1),
(12, 8, '2012-02-01', '2012-06-02', 'Call Center Manager Vietnam', 'VIETNAMESE JOINT VENTURE INTERIORS COMPANY', 'fg fdg sdfg fdgfd g sdg sfdg', '0', 1),
(13, 8, '2012-08-01', '2012-09-29', 'Account manager', 'VIETNAMESE JOINT VENTURE INTERIORS COMPANY', ' rgttsd gsdg dfg dfg sdfg fdg', '0', 1),
(14, 9, '2012-01-01', '2012-04-16', 'Call Center Manager Vietnam', 'VIETNAMESE JOINT VENTURE INTERIORS COMPANY', 'fgh fgh fdg', '0', 1),
(15, 9, '2012-05-01', '2012-08-20', 'IT Center Manager', 'Daiichi Life VietNam', 'f hfgh fgh dfg', '0', 1),
(16, 5, '2011-12-01', '2012-02-06', 'Analytics Bussness', 'Techcombank Vietnam', 'hg fdgs fdgfd gdsfgdf trgtfr', '0', 1),
(17, 5, '2012-05-01', '2012-09-04', 'Call Center Manager Vietnam', 'VIETNAMESE JOINT VENTURE INTERIORS COMPANY', 'gdfg fdg sfdgsfgsdfgsfdggfg ', '0', 1),
(18, 6, '2012-04-02', '2012-05-06', 'Call Center Manager Vietnam', 'Daiichi Life VietNam', 'dfgfsdg fdg sfgs fgfd gf', '0', 1),
(19, 6, '2012-07-04', '2012-09-12', 'HR Consultant Manager', 'IBM Solution Vietnam', 'd f dgfdg dfgh ghd ghgfhgh', '0', 1),
(20, 1, '2012-07-01', '2012-07-10', 'Call Center Manager Vietnam', 'Daiichi Life VietNam', 'fgff g fdg fdg sfg', '0', 1),
(21, 1, '2012-07-01', '2012-08-08', 'Analytics Bussness', 'Techcombank Vietnam', ' gfdgfg', '0', 1),
(22, 10, '2004-03-03', '2005-10-04', 'Account manager', 'IBM Solution Vietnam', 'test', '0', 1),
(23, 5, '2012-10-09', '2005-03-10', 'Call Center Manager Vietnam', 'Daiichi Life VietNam', 'test', '0', 1),
(24, 11, '1995-02-02', '1997-10-08', 'Call Center Manager Vietnam Call Center Manager Vietnam', 'IBM Solution Vietnam22', 'đánh giá cao kết quả của Hội nghị trung ương 6 vừa qua, song cử tri Lương Minh Nguyệt lo lắng: "Sau Hội nghị Trung ương, Tổng bí thư đã thay mặt Bộ Chính trị nhận khuyết điểm trước toàn dân. Nhưng bước tiếp theo sẽ là gì, bằng biện pháp nào để xử lý những lỗi đó để người dân tin tưởng vào Đảng?".\r\n\r\nChủ tịch nước Trương Tấn Sang hoan nghênh những góp ý rất thẳng thắn của cử tri về Hội nghị trung ương 6 vừa qua. Chủ tịch nước khẳng định: "Báo cáo của Bộ Chính trị chỉ là bước đầu, còn nhiều việc phải làm. Chúng tôi còn nhiều lỗi lớn, chúng tôi hiểu người dân hy vọng vào Đảng rất lớn. Những gì Đảng làm được vẫn chưa tương xứng vào sự mong đợi của bà con".\r\n\r\nChủ tịch nước nhấn mạnh, trong kỳ họp Quốc hội sắp tới sẽ thông qua quy chế Quốc hội bỏ phiếu tín nhiệm. Những người giữ chức vụ quan trọng thì Ban chấp hành Trung ương cũng sẽ làm tương tự. "Công tác phòng chống tham nhũng kỳ này cũng sẽ chuyển sang để Đảng tập trung lãnh đạo. Từ giờ đến cuối năm Ban Phòng chống tham nhũng sẽ được tổ chức và đi vào hoạt động, đồng thời cũng sẽ công bố nhân sự Ban Nội chính Trung ương. ', '0', 1),
(25, 11, '2010-10-12', '2012-10-02', 'Analytics Bussness', 'IBM Solution Vietnam', 'đánh giá cao kết quả của Hội nghị trung ương 6 vừa qua, song cử tri Lương Minh Nguyệt lo lắng: "Sau Hội nghị Trung ương, Tổng bí thư đã thay mặt Bộ Chính trị nhận khuyết điểm trước toàn dân. Nhưng bước tiếp theo sẽ là gì, bằng biện pháp nào để xử lý những lỗi đó để người dân tin tưởng vào Đảng?".\r\n\r\nChủ tịch nước Trương Tấn Sang hoan nghênh những góp ý rất thẳng thắn của cử tri về Hội nghị trung ương 6 vừa qua. Chủ tịch nước khẳng định: "Báo cáo của Bộ Chính trị chỉ là bước đầu, còn nhiều việc phải làm. Chúng tôi còn nhiều lỗi lớn, chúng tôi hiểu người dân hy vọng vào Đảng rất lớn. Những gì Đảng làm được vẫn chưa tương xứng vào sự mong đợi của bà con".\r\n\r\nChủ tịch nước nhấn mạnh, trong kỳ họp Quốc hội sắp tới sẽ thông qua quy chế Quốc hội bỏ phiếu tín nhiệm. Những người giữ chức vụ quan trọng thì Ban chấp hành Trung ương cũng sẽ làm tương tự. "Công tác phòng chống tham nhũng kỳ này cũng sẽ chuyển sang để Đảng tập trung lãnh đạo. Từ giờ đến cuối năm Ban Phòng chống tham nhũng sẽ được tổ chức và đi vào hoạt động, đồng thời cũng sẽ công bố nhân sự Ban Nội chính Trung ương. ', '0', 1),
(26, 16, NULL, NULL, NULL, NULL, NULL, 'this is teting', NULL),
(27, 17, NULL, NULL, NULL, NULL, NULL, 'test tt', NULL),
(28, 11, NULL, NULL, NULL, NULL, NULL, 'test', NULL),
(29, 15, NULL, NULL, NULL, NULL, NULL, 'this is other experience', NULL),
(30, 17, '2003-03-01', '2007-01-01', 'Call Center Manager Vietnam', 'Techcombank Vietnam', 'this is duties ', NULL, 1),
(31, 16, '2006-02-01', '2009-01-01', 'Call Center Manager Vietnam', 'IBM Solution Vietnam', 'test', NULL, 1),
(32, 16, NULL, NULL, NULL, NULL, NULL, 'This is testing for function experience other', NULL),
(33, 13, NULL, NULL, NULL, NULL, NULL, 'Cũng theo ông Tiệp, kiểm tra cho thấy 55% mẫu nhiễm histamine đều xuất phát từ các chợ bán lẻ, chủ yếu trên cá thu, cá ngừ. Do là chất có yếu tố nội sinh nên thời gian bảo quản càng lâu, nhiệt độ càng tăng thì tồn dư histamine trong cá sinh ra càng lớn. 54/60 mẫu cá qua kiểm tra cũng phát hiện chất urê trong cá. Hàm lượng phát hiện ở mức rất thấp nên khả năng cũng do nội sinh bởi nếu người kinh doanh dùng ure ướp cá thì hàm lượng cao hơn rất nhiều.', NULL),
(35, 18, NULL, NULL, NULL, NULL, NULL, 'test thiis ting', NULL),
(36, 19, '05-2010', '08-2012', 'Account manager', 'VIETNAMESE JOINT VENTURE INTERIORS COMPANY', 'this is ttesting', NULL, 1),
(37, 19, '03-2003', '05-2007', 'IT Center Manager', 'IBM Solution Vietnam', 'téttt', NULL, 1),
(38, 19, NULL, NULL, NULL, NULL, NULL, 'Run: khi click, run câu l?nh search.\r\nRename: khi click, m? form trên lu?i cho phép edit. Xem hình giao di?n.\r\nEdit Criteria: khi click, m? trang Advanced Search, load thông tin Saved Search cho phép di?u ch?nh. Khi user b?m nút “Search” s? luu (update) Saved Search, d?ng th?i ch?y câu l?nh search.\r\nDelete: khi click, hi?n popup confirm: “Are you sure to delete?” Btn: Yes/ No. N?u ch?n Yes, delete và refresh.\r\n', NULL),
(39, 19, NULL, NULL, NULL, NULL, NULL, 'Run: khi click, run câu l?nh search.\r\nRename: khi click, m? form trên lu?i cho phép edit. Xem hình giao di?n.\r\nEdit Criteria: khi click, m? trang Advanced Search, load thông tin Saved Search cho phép di?u ch?nh. Khi user b?m nút “Search” s? luu (update) Saved Search, d?ng th?i ch?y câu l?nh search.\r\nDelete: khi click, hi?n popup confirm: “Are you sure to delete?” Btn: Yes/ No. N?u ch?n Yes, delete và refresh.\r\n\r\n\r\ntình yêu đó chỉ vừa hôm qua', NULL),
(40, 19, NULL, NULL, NULL, NULL, NULL, 'Run: khi click, run câu l?nh search.\r\nRename: khi click, m? form trên lu?i cho phép edit. Xem hình giao di?n.\r\nEdit Criteria: khi click, m? trang Advanced Search, load thông tin Saved Search cho phép di?u ch?nh. Khi user b?m nút “Search” s? luu (update) Saved Search, d?ng th?i ch?y câu l?nh search.\r\nDelete: khi click, hi?n popup confirm: “Are you sure to delete?” Btn: Yes/ No. N?u ch?n Yes, delete và refresh. test\r\n', NULL),
(41, 21, '03-2008', '09-2011', 'Call Center Manager Vietnam', 'Daiichi Life VietNam', 'tset', NULL, 1),
(42, 21, '03-2011', '09-present', 'Call Center Manager Vietnam', 'IBM Solution Vietnam', 'tsttt', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `res_experience_has_function`
--

CREATE TABLE IF NOT EXISTS `res_experience_has_function` (
  `res_experience_function_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `res_experience_id` int(10) unsigned NOT NULL,
  `function_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`res_experience_function_id`),
  KEY `FK_res_experience_2` (`res_experience_id`),
  KEY `FK_function_lookup_2` (`function_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=36 ;

--
-- Dumping data for table `res_experience_has_function`
--

INSERT INTO `res_experience_has_function` (`res_experience_function_id`, `res_experience_id`, `function_id`) VALUES
(9, 2, 44),
(10, 2, 45),
(11, 2, 46),
(12, 2, 47),
(13, 19, 1),
(14, 19, 2),
(15, 18, 48),
(16, 18, 49),
(17, 22, 44),
(18, 23, 44),
(19, 23, 45),
(20, 17, 1),
(21, 17, 2),
(22, 6, 44),
(25, 25, 49),
(26, 25, 50),
(27, 30, 1),
(28, 30, 2),
(29, 31, 1),
(30, 31, 2),
(31, 36, 1),
(32, 36, 2),
(33, 37, 1),
(34, 41, 1),
(35, 42, 1);

-- --------------------------------------------------------

--
-- Table structure for table `res_file`
--

CREATE TABLE IF NOT EXISTS `res_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resume_id` int(11) NOT NULL,
  `bin_data` longblob NOT NULL,
  `filename` varchar(255) NOT NULL,
  `filetype` varchar(255) NOT NULL,
  `filesize` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `res_file`
--

INSERT INTO `res_file` (`id`, `resume_id`, `bin_data`, `filename`, `filetype`, `filesize`) VALUES
(1, 13, 0xd0cf11e0a1b11ae15c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c303e5c30035c30feff095c30065c305c305c305c305c305c305c305c305c305c305c30015c305c305c30605c305c305c305c305c305c305c305c30105c305c30625c305c305c30015c305c305c30feffffff5c305c305c305c305f5c305c305c30ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeca5c15c305b8009045c305c30f812bf5c305c305c305c305c305c30105c305c305c305c305c30085c305c3012375c305c300e5c30626a626aacfaacfa5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c300904165c302e405c305c30ce90015c30ce90015c30a7105c305c305c305c305c305c30135c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c302e5c305c305c30ffff0f5c305c305c305c305c305c305c305c305c30ffff0f5c305c305c305c305c305c305c305c305c30ffff0f5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30b75c305c305c305c305c3094215c305c305c305c305c305c3094215c305c30d72e5c305c305c305c305c305c30d72e5c305c305c305c305c305c305c272f5c305c305c305c305c305c305c272f5c305c305c305c305c305c305c272f5c305c30145c305c305c305c305c305c305c305c305c305c305c30ffffffff5c305c305c305c303b2f5c305c305c305c305c305c303b2f5c305c305c305c305c305c303b2f5c305c30385c305c305c30732f5c305c30545c305c305c30c72f5c305c30345c305c305c303b2f5c305c305c305c305c305c308e445c305c30ee035c305c30fb2f5c305c3012015c305c300d315c305c305c305c305c305c300d315c305c305c305c305c305c300d315c305c305c305c305c305c3035315c305c305c305c305c305c3051335c305c307a035c305c30cb365c305c3034015c305c30ff375c305c309c5c305c305c303f435c305c30885c305c305c30c7435c305c305c305c305c305c30c7435c305c305c305c305c305c30c7435c305c305c305c305c305c30c7435c305c305c305c305c305c30c7435c305c305c305c305c305c30c7435c305c30245c305c305c307c485c305c30a2025c305c301e4b5c305c305c5c5c305c305c30eb435c305c305d5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c272f5c305c305c305c305c305c309b385c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c302b335c305c30045c305c305c302f335c305c305c225c305c305c309b385c305c305c305c305c305c309b385c305c305c305c305c305c30eb435c305c305c305c305c305c305c305c305c305c305c305c305c305c30d72e5c305c305c305c305c305c30d72e5c305c305c305c305c305c300d315c305c305c305c305c305c305c305c305c305c305c305c305c305c3035315c305c30f6015c305c3048445c305c30165c305c305c306b3e5c305c305c305c305c305c306b3e5c305c305c305c305c305c306b3e5c305c305c305c305c305c309b385c305c3076035c305c30d72e5c305c305c305c305c305c300d315c305c305c305c305c305c30d72e5c305c30385c305c305c300d315c305c30285c305c305c303f435c305c305c305c305c305c305c305c305c305c305c305c305c305c306b3e5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c309b385c305c305c305c305c305c303f435c305c305c305c305c305c305c305c305c305c305c305c305c305c306b3e5c305c305c305c305c305c306b3e5c305c308e5c305c305c30e7415c305c30685c305c305c305c305c305c305c305c305c305c305c300f2f5c305c30185c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30a7425c305c305c305c305c305c300d315c305c305c305c305c305c30ffffffff5c305c305c305c3070d1bd30ffa6cd015c305c305c305c305c305c305c305c303b2f5c305c305c305c305c305c30113c5c305c30ca5c305c305c304f425c305c30485c305c305c305c305c305c305c305c305c305c305c302b435c305c30145c305c305c305e445c305c30305c305c305c308e445c305c305c305c305c305c3097425c305c30105c305c305c307a4b5c305c305c305c305c305c30db3c5c305c3090015c305c307a4b5c305c30205c305c305c30a7425c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c307a4b5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c272f5c305c305c305c305c305c30a7425c305c30845c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c306b3e5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c309b385c305c305c305c305c305c309b385c305c305c305c305c305c309b385c305c305c305c305c305c30eb435c305c305c305c305c305c30eb435c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c306b3e5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c309b385c305c305c305c305c305c309b385c305c305c305c305c305c309b385c305c305c305c305c305c308e445c305c305c305c305c305c309b385c305c305c305c305c305c309b385c305c305c305c305c305c309b385c305c305c305c305c305c309b385c305c305c305c305c305c305c305c305c305c305c305c305c305c30ffffffff5c305c305c305c30ffffffff5c305c305c305c30ffffffff5c305c305c305c305c305c305c305c305c305c305c305c30ffffffff5c305c305c305c30ffffffff5c305c305c305c30ffffffff5c305c305c305c30ffffffff5c305c305c305c30ffffffff5c305c305c305c30ffffffff5c305c305c305c30ffffffff5c305c305c305c30ffffffff5c305c305c305c30ffffffff5c305c305c305c30ffffffff5c305c305c305c30ffffffff5c305c305c305c30ffffffff5c305c305c305c30ffffffff5c305c305c305c30ffffffff5c305c305c305c307a4b5c305c305c305c305c305c309b385c305c305c305c305c305c309b385c305c305c305c305c305c309b385c305c305c305c305c305c309b385c305c305c305c305c305c309b385c305c305c305c305c305c309b385c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c309b385c305c305c305c305c305c309b385c305c305c305c305c305c309b385c305c305c305c305c305c3094215c305c30090c5c305c309d2d5c305c303a015c305c30055c3012015c305c3009045c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30525c30455c30535c30555c304d5c30455c30205c300d5c30205c300d5c30505c30455c30525c30535c304f5c304e5c30415c304c5c30205c30445c30455c30545c30415c30495c304c5c30535c30205c300d5c30435c30615c306e5c30645c30695c30645c30615c30745c30655c30205c304e5c30615c306d5c30655c303a5c30095c30095c30505c30485c30415c304e5c30205c30445c30555c30595c30205c30435c30a21e4e5c30485c300d5c30445c30615c30745c30655c30205c306f5c30665c30205c30425c30695c30725c30745c30685c303a5c30205c30095c30095c30095c304a5c30755c306c5c30205c30325c30355c302c5c30205c30315c30395c30385c30355c300d5c30475c30655c306e5c30645c30655c30725c303a5c30205c30095c30095c30095c304d5c30615c306c5c30655c300d5c304d5c30615c30725c30695c30745c30615c306c5c30205c30535c30745c30615c30745c30755c30735c303a5c30205c30095c30095c30095c30535c30695c306e5c30675c306c5c30655c30205c300d5c30435c30695c30745c30695c307a5c30655c306e5c30205c306f5c30665c303a5c30205c30095c30095c30095c304c5c306f5c30635c30615c306c5c30205c30565c30695c30655c30745c306e5c30615c306d5c30655c30735c30655c30205c300d5c30415c30645c30645c30725c30655c30735c30735c303a5c30095c30485c306f5c30205c30435c30685c30695c30205c304d5c30695c306e5c30685c302c5c30205c30565c30695c30655c30745c306e5c30615c306d5c300d5c30455c306d5c30615c30695c306c5c303a5c30095c30135c30205c30485c30595c30505c30455c30525c304c5c30495c304e5c304b5c30205c305c225c306d5c30615c30695c306c5c30745c306f5c303a5c30705c30685c30615c306e5c30645c30755c30795c30635c30615c306e5c30685c30365c30395c30405c30675c306d5c30615c30695c306c5c302e5c30635c306f5c306d5c305c225c30015c30145c30705c30685c30615c306e5c30645c30755c30795c3063616e68363940676d61696c2e636f6d150d50686f6e653a09303933392036393320393930090d434152454552204f424a454354495645530d46757475726520676f616c3a0950726f6a656374204d616e616765720d0d48617665206d6f7265203520796561727320657870657269656e636520696e207068702070726f6772616d6d696e672e200d556e6465727374616e64696e67206d616e79204672616d65776f726b7320616e6420434d532e0d4861766520657870657269656e636520776f726b696e67207769746820666f726569676e20636c69656e74732e0d576562736974657320637265617465643a2020132048595045524c494e4b205c22687474703a2f2f69646d2e766e2f616e616c79746963732f5c222014687474703a2f2f69646d2e766e2f616e616c79746963732f152c20132048595045524c494e4b205c22687474703a2f2f7777772e6e766d67726f75702e636f6d2f5c220114687474703a2f2f7777772e6e766d67726f75702e636f6d152c20132048595045524c494e4b205c22687474703a2f2f7669707365617263682e636f6d2f5c220114687474703a2f2f7669707365617263682e636f6d152c20132048595045524c494e4b205c22687474703a2f2f676f6c662d66616972776179732e636f6d2f5c220114687474703a2f2f676f6c662d66616972776179732e636f6d152c20132048595045524c494e4b205c22687474703a2f2f7777772e736f6661636f6e636570742e66722f5c220114687474703a2f2f7777772e736f6661636f6e636570742e6672152c20132048595045524c494e4b205c22687474703a2f2f646f646f67726f75702e766e2f5c220114687474703a2f2f646f646f67726f75702e766e152c2020132048595045524c494e4b205c22687474703a2f2f333630646f63756f692e766e2f5c220114687474703a2f2f333630646f63756f692e766e152c20132048595045524c494e4b205c22687474703a2f2f737175656564792e636f6d5c222014687474703a2f2f737175656564792e636f6d1520850d0d4341524545522053554d4d415259200d4e6f76203230313120962050726573656e742020094374792049444d20566965744e616d2028205c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30375c30305c30205c30505c30685c30a11e6d5c30205c304e5c30675c30cd1e635c30205c30545c30685c30a11e635c302c5c30205c30515c302e5c30335c302c5c30205c30485c30435c304d5c30435c30205c30295c300d5c300d5c304a5c30615c306e5c30205c30325c30305c30315c30315c30205c301320205c304e5c306f5c30765c30205c30325c30305c30315c30315c30205c30205c30095c30435c30745c30795c30205c30635c30f45c306e5c30675c30205c30745c30795c30205c30635c30d51e205c30705c30685c30a71e6e5c30205c30505c30485c304f5c304e5c30475c30205c30505c30485c30da5c30205c30535c30ae1e435c30205c30565c30495c30c61e545c30205c30285c30205c30345c30335c30525c302f5c30315c30305c30205c30485c306f5c30205c30565c30615c306e5c30205c30485c30755c30655c302c5c30205c30505c302e5c30395c302c5c30205c30515c302e5c30505c30685c30755c30205c304e5c30685c30755c30615c306e5c302c5c30205c30485c30435c304d5c30435c30205c30295c300d5c300d5c304d5c30615c30795c30205c30325c30305c30315c30305c30205c301320205c304a5c30615c306e5c30205c30325c30305c30315c30315c30095c30435c30745c30795c30205c30545c304e5c30485c30485c30205c30435c306f5c30645c30655c30735c306f5c30755c30725c30635c30695c306e5c30675c30205c30285c30425c30755c30695c306c5c30645c30695c306e5c30675c30205c30385c30205c301320205c30515c30755c30615c306e5c30675c30205c30545c30725c30755c306e5c30675c30205c30505c30615c30725c30745c30205c30735c306f5c30665c30745c30775c30615c30725c30655c30205c301320205c30425c30695c306e5c30685c30205c30435c30685c30615c306e5c30685c30205c30645c30695c30735c30745c30725c30695c30635c30745c30205c302d5c30205c30485c30435c304d5c30435c30295c300d5c30445c30655c30765c30655c306c6f706572205048500d4f637420323030392096204d61792032303130094e48414e56494554204d414e4147454d454e542047524f555020284c6576656c203520414e444558204275696c64696e67202d20333039202d33313142204e677579656e2056616e2054726f692073747265657420962054616e2042696e68206469737472696374202d2048434d43290d446576656c6f70657220504850200d536570203230303720962053657020323030380932323820434f4d50414e59202832323820486f616e672056616e205468752073747265657420962054616e2042696e68206469637472696374202d2048434d43290d446576656c6f70657220504850200d0d50524f46455353494f4e414c20455850455249454e43450d4e6f76203230313120962050726573656e742020094374792063f46e672074792049444d20566965744e616d0d53656e696f7220446576656c6f70657220504850200d0d09090d094d61696e204475746965733a200d43726561746520616e64206d616e6167656d656e742070726f6a6563742049444d20416e616c79746963732e0d687474703a2f2f69646d2e766e2f616e616c79746963732f0d0d4a616e20323031302096204e6f7620323031312020095c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30435c30745c30795c30205c30635c30f45c306e5c30675c30205c30745c30795c30205c30635c30d51e205c30705c30685c30a71e6e5c30205c30505c30485c304f5c304e5c30475c30205c30505c30485c30da5c30205c30535c30ae1e435c30205c30565c30495c30c61e545c300d5c30535c30655c306e5c30695c306f5c30725c30205c30205c30445c30655c30765c30655c306c5c306f5c30705c30655c30725c30205c30505c30485c30505c30205c300d5c30095c300d5c30095c304d5c30615c30695c306e5c30205c30445c30755c30745c30695c30655c30735c303a5c30205c300d5c30435c30725c30655c30615c30745c30655c30205c30615c306e5c30645c30205c306d5c30615c306e5c30615c30675c30655c306d5c30655c306e5c30745c30205c30735c30795c30735c30745c30655c306d5c30205c30735c306d5c30735c302e5c300d5c304d5c30615c306e5c30615c30675c30655c306d5c30655c306e5c30745c30205c30645c30615c30745c30615c300d5c30435c30725c30655c30615c30745c30655c30205c30775c30655c30625c30735c30695c30745c30655c30205c30615c306e5c30645c30205c30775c30615c30705c30735c30695c30745c30655c30205c30675c30615c306d5c30655c30205c30135c30205c30485c30595c30505c30455c30525c304c5c30495c304e5c304b5c30205c305c225c30685c30745c30745c30705c303a5c302f5c302f5c30675c30615c306d5c30655c302e5c30705c306f5c30705c30735c302e5c30765c306e5c305c225c30205c30145c30685c30745c30745c30705c303a5c302f5c302f5c30675c30615c306d5c30655c302e5c30705c306f5c30705c30735c302e5c30765c306e5c30155c30205c302c5c30205c30135c30205c30485c30595c30505c30455c30525c304c5c30495c304e5c304b5c30205c305c225c30685c30745c30745c30705c303a5c302f5c302f5c306d5c30675c30615c306d5c30655c302e5c30705c306f5c30705c30735c302e5c30765c306e5c305c225c30205c30145c30685c307474703a2f2f6d67616d652e706f70732e766e15200d0d4d6179202d20323031302096204a616e20323031312020200943747920544e484820636f6465736f757263696e670d446576656c6f70657220504850200d4d61696e204475746965733a200d437265617465207765627369746520636f6465736f757263696e672d646174696e672c2074686973206973207369746520646174696e6720616e6420636861740d4d61696e7461696e207765627369746520132048595045524c494e4b205c22687474703a2f2f7777772e736f6661636f6e636570742e66722f5c220114687474703a2f2f7777772e736f6661636f6e636570742e6672152c2074686973206973207369746520652d636f6d657263652061626f75742070726f6475637420736f66612e0d4d61696e7461696e20736974652020132048595045524c494e4b205c22687474703a2f2f736f7274697273616e73616c636f6f6c2e636f6d2f5c220114687474703a2f2f736f7274697273616e73616c636f6f6c2e636f6d2f152054686973206973207369746520646174696e672e0d0d4f637420323030382096204d61792032303130094e48414e56494554204d414e4147454d454e542047524f55500d446576656c6f70657220504850200d4d61696e204475746965733a200d437265617465207765627369746520132048595045524c494e4b205c22687474703a2f2f7777772e6e68616e766965742e636f6d2f5c220114687474703a2f2f7777772e6e68616e766965742e636f6d152e20576562736974652069732064656469636174656420746f2074686f736520286129205370656369616c6973747320696e20485220696e64757374727920286229204f7267616e697a6174696f6e732074686174207365656b20666f72206265747465722048756d616e205265736f7572636520536f6c7574696f6e7320286329205265706f72746572732077686f207365656b20666f72206c617465737420696e647573747279206e6577732028642954686f73652077686f2066696e64207472757374656420736f757263657320666f72207265736561726368206f72207374756479206f6e2048522072656c61746564206973737565732e2054686520776562736974652069732062692d6c696e6775616c2c20456e676c69736820616e6420566965746e616d6573650d437265617465207765627369746520132048595045524c494e4b205c22687474703a2f2f7777772e7669707365617263682e636f6d2f5c220114687474703a2f2f7777772e7669707365617263682e636f6d152e205649507365617263682c206265696e672070726f61637469766520696e207468652061726561206f662065786563757469766520736561726368202620726563727569746d656e742e0d416e6420206120776562206170706c69636174696f6e20285649504f2920666f7220636f6d70616e792e205649504f20416e20696e2d686f75736520726573756d65202620726563727569746d656e74206d616e6167656d656e742c2073797374656d2e5649504f202069732061207472756c792068656c7066756c20746f6f6c20666f72206578656375746976652073656172636820636f6e73756c74616e74732e0d416e6420737570706f727420666f7220736f6d65206f746865722070726f6a6563742e0d5365702032303037202d2041756720323030380932323820434f4d50414e59200d446576656c6f70657220504850200d0d546865206d6f7374206f7574736f757263696e6720666f7220666f726569676e20637573746f6d6572732028207573696e6720434d53206d616d626f2c206a6f6f6d6c612e20290d0d41434144454d49430d32303030202d20323030330948494748205343484f4f4c2047524144554154494f4e0d484f20544849204b592048696768205363686f6f6c0d32303033202d20323030370942414348454c4f52204445475245450d4d454b4f4e4720554e49564552534954590d416363756d756c6174697665206176657261676520706f696e74203a362e38350d50524f46455353494f4e414c20444556454c4f504d454e540d5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30085c305c3010085c305c3014085c305c3038085c305c305a085c305c3076085c305c3096095c305c3098095c305c30ee095c305c30f0095c305c30f2095c305c30100a5c305c30110a5c305c305c270a5c305c30390a5c305c30460a5c305c30550a5c305c30570a5c305c30610a5c305c30620a5c305c30ee0a5c305c30f10a5c305c30efe1cce1bde1b5b1a6b59ab5e1cce18ce1745c5c74455c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c302d1568b36c645c301668ba18475c30304a635c304f4a025c30514a025c305e4a025c3066485c300171ca0a5c305c305c30ffffffff5c305c305c302f16685830935c30304a635c30434a145c304f4a025c30514a025c305e4a025c30614a145c3066485c300171ca0a5c305c305c30ffffffff5c305c305c302f1668ba18475c30304a635c30434a145c304f4a025c30514a025c305e4a025c30614a145c3066485c300171ca0a5c305c305c30ffffffff5c305c305c301a1668b025b95c30434a145c304f4a025c30504a035c30514a025c30614a165c305c30161668ba18475c30304a595c304f4a025c30504a035c30514a025c305c3015020881036a5c305c305c305c300608011668ba18475c30550801061668ba18475c305c300f036a5c305c305c305c301668ba18475c305508011d1668ba18475c30350881434a145c304f4a025c30504a035c30514a025c30614a165c30291668ba18475c30350881422a08434a1a5c304f4a025c30514a025c305c5c08815e4a025c30614a1a5c307068ffffff5c301a1668ba18475c30434a145c304f4a025c30504a035c30514a025c30614a165c305c30201668ba18475c30350881434a245c304f4a025c30514a025c305c5c08815e4a025c30614a245c30155c30085c305c3010085c305c3014085c305c3038085c305c3076085c305c30b4085c305c30d4085c305c300a095c305c304c095c305c3088095c305c30120a5c305c305c270a5c305c30390a5c305c30560a5c305c30570a5c305c30890a5c305c30b00a5c305c30de0a5c305c30e90c5c305c30ea0c5c305c30fa0c5c305c303e0e5c305c30f85c305c305c305c305c305c305c305c305c305c305c305c30f45c305c305c305c305c305c305c305c305c305c305c305c30e45c305c305c305c305c305c305c305c305c305c305c305c30f45c305c305c305c305c305c305c305c305c305c305c305c30f45c305c305c305c305c305c305c305c305c305c305c305c30f45c305c305c305c305c305c305c305c305c305c305c305c30f45c305c305c305c305c305c305c305c305c305c305c305c30f45c305c305c305c305c305c305c305c305c305c305c305c30d45c305c305c305c305c305c305c305c305c305c305c305c30d45c305c305c305c305c305c305c305c305c305c305c305c30d45c305c305c305c305c305c305c305c305c305c305c305c30e45c305c305c305c305c305c305c305c305c305c305c305c30f45c305c305c305c305c305c305c305c305c305c305c305c30f45c305c305c305c305c305c305c305c305c305c305c305c30cd5c305c305c305c305c305c305c305c305c305c305c305c30cd5c305c305c305c305c305c305c305c305c305c305c305c30cd5c305c305c305c305c305c305c305c305c305c305c305c30cd5c305c305c305c305c305c305c305c305c305c305c305c30c65c305c305c305c305c305c305c305c305c305c305c305c30e45c305c305c305c305c305c305c305c305c305c305c305c30b95c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c300c5c305c300f84400b1184c0f45e84400b6084c0f467648a066b5c305c30066d5c3014a4785c3067643173e65c30076d5c300a265c300b46025c3014a4785c305c300f5c305c300dc6055c3001f825020f84400b1184c0f414a4785c305e84400b6084c0f4105c305c301184680114a4f05c302d44e0014dc60a5c305c305c30ff8c8c8c5c305c305c30608468015c30035c305c3014a4785c305c30065c305c3003240114a4785c306124015c3015f10a5c305c30f20a5c305c30180b5c305c30190b5c305c30310b5c305c30320b5c305c30340b5c305c30350b5c305c305a0b5c305c305b0b5c305c305c5c0b5c305c30730b5c305c30740b5c305c30760b5c305c30770b5c305c30990b5c305c309a0b5c305c309b0b5c305c30af0b5c305c30b00b5c305c30b20b5c305c30b30b5c305c30d90b5c305c30da0b5c305c30db0b5c305c30f30b5c305c30f40b5c305c30f60b5c305c30f70b5c305c301e0c5c305c30e4cde4b6e49e969287967d966596925a967d966596924f967d966596925c305c305c305c305c305c305c305c305c3015020881036aef015c305c300608011668ba18475c3055080115020881036a52015c305c300608011668ba18475c305508012f1668ba18475c30304a635c30434a145c304f4a025c30514a025c305e4a025c30614a145c3066485c300171ca0a5c305c305c30ffffffff5c305c305c30121668ba18475c30304a595c304f4a025c30514a025c305c3015020881036aaf5c305c305c300608011668ba18475c30550801061668ba18475c305c300f036a5c305c305c305c301668ba18475c305508012f1668b36c645c30304a635c30434a145c304f4a025c30514a025c305e4a025c30614a145c3066485c300171ca0a5c305c305c30ffffffff5c305c305c302d1568b36c645c301668b36c645c30304a595c304f4a025c30514a025c305e4a025c3066485c300171ca0a5c305c305c30ffffffff5c305c305c302d1568b36c645c301668b36c645c30304a635c304f4a025c30514a025c305e4a025c3066485c300171ca0a5c305c305c30ffffffff5c305c305c3036036a5c305c305c305c301568b36c645c301668b36c645c30304a635c304f4a025c30514a025c305508015e4a025c3066485c300171ca0a5c305c305c30ffffffff5c305c305c301d1e0c5c305c301f0c5c305c30200c5c305c30390c5c305c303a0c5c305c303c0c5c305c303d0c5c305c305e0c5c305c305f0c5c305c30600c5c305c30730c5c305c30740c5c305c30770c5c305c30780c5c305c30990c5c305c309a0c5c305c309b0c5c305c30ae0c5c305c30af0c5c305c30b10c5c305c30b20c5c305c30d20c5c305c30d30c5c305c30e50c5c305c30e60c5c305c30f4ece0ecc6ecc2b7ece0ecc6ecc2acece0ecc68c718c568c5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c303515683173e65c3016683173e65c30304a595c304f4a025c30504a035c30514a025c305e4a025c30614a165c3066485c300171ca0a5c305c305c30ffffffff5c305c305c303515683173e65c3016683173e65c30304a635c304f4a025c30504a035c30514a025c305e4a025c30614a165c3066485c300171ca0a5c305c305c30ffffffff5c305c305c303e036a5c305c305c305c3015683173e65c3016683173e65c30304a635c304f4a025c30504a035c30514a025c305508015e4a025c30614a165c3066485c300171ca0a5c305c305c30ffffffff5c305c305c305c3015020881036ad6035c305c300608011668ba18475c3055080115020881036a3b035c305c300608011668ba18475c30550801061668ba18475c305c30331668ba18475c30304a635c30434a145c304f4a025c30504a035c30514a025c305e4a025c30614a165c3066485c300171ca0a5c305c305c30ffffffff5c305c305c30161668ba18475c30304a595c304f4a025c30504a035c30514a025c305c300f036a5c305c305c305c301668ba18475c3055080115020881036a94025c305c300608011668ba18475c305508015c3018e60c5c305c30e80c5c305c30e90c5c305c30ea0c5c305c30fa0c5c305c30120d5c305c30130d5c305c301e0d5c305c301f0d5c305c305c300e5c305c30200e5c305c30260e5c305c302c0e5c305c303e0e5c305c30400e5c305c30560e5c305c30e7cdb39e8f807180635547556380385c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c301d1668ba18475c30350881434a145c304f4a025c30504a035c30514a025c30614a165c301a166869483a5c30434a145c304f4a025c30504a035c30514a025c30614a165c305c301a16682647615c30434a145c304f4a025c30504a035c30514a025c30614a165c305c301a16688a066b5c30434a145c304f4a025c30504a035c30514a025c30614a165c305c301d16682647615c30350881434a145c304f4a025c30504a035c30514a025c30614a165c301d16688a066b5c30350881434a145c304f4a025c30504a035c30514a025c30614a165c301d1668fe132f5c30350881434a145c304f4a025c30504a035c30514a025c30614a165c30291668ba18475c30350881422a08434a1a5c304f4a025c30514a025c305c5c08815e4a025c30614a1a5c307068ffffff5c303316683173e65c30304a635c30434a145c304f4a025c30504a035c30514a025c305e4a025c30614a165c3066485c300171ca0a5c305c305c30ffffffff5c305c305c30331668ba18475c30304a635c30434a145c304f4a025c30504a035c30514a025c305e4a025c30614a165c3066485c300171ca0a5c305c305c30ffffffff5c305c305c302f1668b84e4b5c30304a635c304f4a025c30504a035c30514a025c305e4a025c30614a165c3066485c300171ca0a5c305c305c30ffffffff5c305c305c305c300f3e0e5c305c30400e5c305c30160f5c305c30180f5c305c30f80f5c305c300a105c305c308f105c305c309e105c305c30f4105c305c3003115c305c3004115c305c301c115c305c3049115c305c305f115c305c3060115c305c3063115c305c3072115c305c309f115c305c30b8115c305c30b9115c305c304e125c305c30f55c305c305c305c305c305c305c305c305c305c305c305c30f55c305c305c305c305c305c305c305c305c305c305c305c30f55c305c305c305c305c305c305c305c305c305c305c305c30f55c305c305c305c305c305c305c305c305c305c305c305c30ed5c305c305c305c305c305c305c305c305c305c305c305c30f55c305c305c305c305c305c305c305c305c305c305c305c30ed5c305c305c305c305c305c305c305c305c305c305c305c30f55c305c305c305c305c305c305c305c305c305c305c305c30ed5c305c305c305c305c305c305c305c305c305c305c305c30ed5c305c305c305c305c305c305c305c305c305c305c305c30dd5c305c305c305c305c305c305c305c305c305c305c305c30d05c305c305c305c305c305c305c305c305c305c305c305c30c55c305c305c305c305c305c305c305c305c305c305c305c30d05c305c305c305c305c305c305c305c305c305c305c305c30d05c305c305c305c305c305c305c305c305c305c305c305c30d05c305c305c305c305c305c305c305c305c305c305c305c30b75c305c305c305c305c305c305c305c305c305c305c305c30b75c305c305c305c305c305c305c305c305c305c305c305c30f55c305c305c305c305c305c305c305c305c305c305c305c30f55c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c300e6d5c300a265c300b46035c300f84400b14a4785c305e84400b6764d358be5c305c300a5c305c300f84400b14a4785c305e84400b6764d358be5c305c300c5c305c300f84400b1184c0f45e84400b6084c0f46764d358be5c30105c305c301184680114a4f05c302d44e0014dc60a5c305c305c30ff8c8c8c5c305c305c30608468015c30075c305c300f84400b14a4785c305e84400b5c30095c305c300f84400b1184c0f45e84400b6084c0f45c3014560e5c305c30660e5c305c30ba0e5c305c30160f5c305c30180f5c305c30200f5c305c306c0f5c305c300a105c305c3038105c305c309e105c305c30be105c305c3004115c305c301c115c305c3031115c305c3049115c305c3064115c305c3072115c305c3088115c305c309d115c305c309e115c305c309f115c305c30b7115c305c30b8115c305c30b9115c305c30c4115c305c30f0e1d3cfc0e1d3e1d3e1d3ab9c8e809c6f616f8050429ce15c305c305c305c305c305c305c305c301a1668a639985c30434a145c304f4a025c30504a035c30514a025c30614a165c305c30201568a639985c301668a639985c30434a145c304f4a025c30504a035c30514a025c30614a165c305c301a16687205565c30434a145c304f4a025c30504a035c30514a025c30614a165c305c30201568b84e4b5c301668d358be5c30434a145c304f4a025c30504a035c30514a025c30614a165c305c301a1668d358be5c30434a145c304f4a025c30504a035c30514a025c30614a165c305c301b1568fe132f5c301668d358be5c303508814f4a025c30504a035c30514a025c301d1668d358be5c30350881434a145c304f4a025c30504a035c30514a025c30614a165c30291668ba18475c30350881422a08434a1a5c304f4a025c30514a025c305c5c08815e4a025c30614a1a5c307068ffffff5c301d16683173e65c30350881434a145c304f4a025c30504a035c30514a025c30614a165c30061668ba18475c305c301a1668ba18475c30434a145c304f4a025c30504a035c30514a025c30614a165c305c301d1668ba18475c30350881434a145c304f4a025c30504a035c30514a025c30614a165c301d16688144905c30350881434a145c304f4a025c30504a035c30514a025c30614a165c305c3018c4115c305c30ce115c305c305c30125c305c304c125c305c304e125c305c305e125c305c307c125c305c3082125c305c309e125c305c30e0125c305c30e2125c305c3042135c305c3044135c305c3086135c305c3088135c305c30ae135c305c30b0135c305c30b6135c305c30b8135c305c30fc135c305c30fe135c305c3013145c305c3014145c305c3015145c305c3016145c305c3017145c305c301b145c305c302f145c305c30f0e1d3e1c5b7a9e198a9b786b7867386b786b7867386b762e153e15c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c301d1668b84e4b5c30350881434a145c304f4a025c30504a035c30514a025c30614a165c30201568b84e4b5c301668b84e4b5c30434a145c304f4a025c30504a035c30514a025c30614a165c305c302415686f245e5c301668b84e4b5c30304a595c30434a145c304f4a025c30504a035c30514a025c30614a165c305c3023036a5c305c305c305c301668b84e4b5c30434a145c304f4a025c30504a035c30514a025c30550801614a165c30201568b84e4b5c301668ba18475c30434a145c304f4a025c30504a035c30514a025c30614a165c305c301a1668ba18475c30434a145c304f4a025c30504a035c30514a025c30614a165c305c301a1668b84e4b5c30434a145c304f4a025c30504a035c30514a025c30614a165c305c301a1668d358be5c30434a145c304f4a025c30504a035c30514a025c30614a165c305c301b1568fe132f5c301668ba18475c303508814f4a025c30504a035c30514a025c301d1668ba18475c30350881434a145c304f4a025c30504a035c30514a025c30614a165c301d166845113e5c30350881434a145c304f4a025c30504a035c30514a025c30614a165c305c301b4e125c305c307c125c305c3080125c305c309e125c305c30e2125c305c3002135c305c3016145c305c3017145c305c3046145c305c3055145c305c3063145c305c30a4145c305c3026155c305c3094155c305c3095155c305c30c3155c305c30d2155c305c30e0155c305c305e175c305c30fb175c305c309f185c305c30c3185c305c30e4185c305c30f3185c305c30f45c305c305c305c305c305c305c305c305c305c305c305c30ef5c305c305c305c305c305c305c305c305c305c305c305c30e55c305c305c305c305c305c305c305c305c305c305c305c30da5c305c305c305c305c305c305c305c305c305c305c305c30da5c305c305c305c305c305c305c305c305c305c305c305c30da5c305c305c305c305c305c305c305c305c305c305c305c30e55c305c305c305c305c305c305c305c305c305c305c305c30e55c305c305c305c305c305c305c305c305c305c305c305c30d25c305c305c305c305c305c305c305c305c305c305c305c30d25c305c305c305c305c305c305c305c305c305c305c305c30da5c305c305c305c305c305c305c305c305c305c305c305c30da5c305c305c305c305c305c305c305c305c305c305c305c30da5c305c305c305c305c305c305c305c305c305c305c305c30e55c305c305c305c305c305c305c305c305c305c305c305c30e55c305c305c305c305c305c305c305c305c305c305c305c30d25c305c305c305c305c305c305c305c305c305c305c305c30d25c305c305c305c305c305c305c305c305c305c305c305c30cb5c305c305c305c305c305c305c305c305c305c305c305c30cb5c305c305c305c305c305c305c305c305c305c305c305c30cb5c305c305c305c305c305c305c305c305c305c305c305c30cb5c305c305c305c305c305c305c305c305c305c305c305c30e55c305c305c305c305c305c305c305c305c305c305c305c30d25c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30076d5c300a265c300b46035c3014a4785c305c30075c305c300f84400b14a4785c305e84400b0b6d5c300a265c300b46035c300f84400b14a4785c305e84400b5c30095c305c300f84400b1184c0f45e84400b6084c0f45c30045c305c306764b36c645c305c300a5c305c300f84400b14a4785c305e84400b6764b84e4b5c305c30172f145c305c3030145c305c3046145c305c3055145c305c3063145c305c30b5145c305c30b6145c305c30dd145c305c30de145c305c30df145c305c30f8145c305c30f9145c305c3035155c305c3036155c305c305f155c305c3060155c305c3061155c305c307d155c305c307e155c305c3094155c305c30c3155c305c30d2155c305c30e0155c305c30ef155c305c30f0155c305c3015165c305c3016165c305c3017165c305c302e165c305c302f165c305c3032165c305c30f0e2d4c5b4a9a294a985a9b4a9a277a985a9b4c5d4c5d46f6b606f546fd45c305c305c305c305c305c305c305c305c305c305c305c305c305c30161668ba18475c30304a595c304f4a025c30504a035c30514a025c305c3015020881036ac3055c305c300608011668ba18475c30550801061668ba18475c305c300f036a5c305c305c305c301668ba18475c305508011b020881036a18055c305c300608011568cc3adf5c301668ba18475c305508011c1568cc3adf5c301668ba18475c30304a595c304f4a025c30504a035c30514a025c305c301b020881036a71045c305c300608011568cc3adf5c301668ba18475c305508010c1568cc3adf5c301668ba18475c305c3015036a5c305c305c305c301568cc3adf5c301668ba18475c30550801201568cc3adf5c301668ba18475c30434a145c304f4a025c30504a035c30514a025c30614a165c305c301d1668ba18475c30350881434a145c304f4a025c30504a035c30514a025c30614a165c301a1668ba18475c30434a145c304f4a025c30504a035c30514a025c30614a165c305c301b1568fe132f5c301668ba18475c303508814f4a025c30504a035c30514a025c301d1668fe132f5c30350881434a145c304f4a025c30504a035c30514a025c30614a165c305c301e32165c305c305e175c305c306d175c305c306e175c305c3094175c305c3095175c305c3096175c305c30ae175c305c30af175c305c30b1175c305c30fb175c305c3026185c305c302b185c305c305e185c305c309f185c305c30c3185c305c30e4185c305c30f3185c305c303d195c305c3046195c305c3069195c305c307f195c305c309b195c305c30ce195c305c30e7195c305c305c30345c305c3021345c305c3028345c305c3066345c305c306f345c305c30f2e4dcd8cddcc1dcb1f2e4a195f2e486e4776286e486e46260e462e4525c305c305c305c305c305c305c305c305c305c305c305c305c305c305c301a1668cc3adf5c30434a145c304f4a025c30504a035c30514a025c30614a165c305c3003550801291668ba18475c30350881422a08434a1a5c304f4a025c30514a025c305c5c08815e4a025c30614a1a5c307068ffffff5c301d1668ba18475c30360881434a145c304f4a025c30504a035c30514a025c30614a165c301d1668ba18475c30350881434a145c304f4a025c30504a035c30514a025c30614a165c30161668ba18475c30434a145c304f4a025c30514a025c305e4a025c305c301e1668ba18475c30434a145c304f4a025c30504a035c30514a025c305e4a025c30614a165c305c301e1668ba18475c30434a145c304f4a025c30504a035c30514a025c305e4a025c30614a145c305c30161668ba18475c30304a595c304f4a025c30504a035c30514a025c305c3015020881036a66065c305c300608011668ba18475c30550801061668ba18475c305c300f036a5c305c305c305c301668ba18475c305508011a1668ba18475c30434a145c304f4a025c30504a035c30514a025c30614a165c305c301a1668ba18475c30434a145c304f4a025c30514a025c305e4a025c30614a145c301df3185c305c30f4185c305c303c195c305c303d195c305c3046195c305c3069195c305c307f195c305c309b195c305c30ad195c305c30ce195c305c30e7195c305c3021345c305c3028345c305c3032345c305c3033345c305c3066345c305c3091345c305c30b9345c305c30ef345c305c3019355c305c3051355c305c3066355c305c30a0355c305c30c8355c305c30d7355c305c30f75c305c305c305c305c305c305c305c305c305c305c305c30f75c305c305c305c305c305c305c305c305c305c305c305c30f75c305c305c305c305c305c305c305c305c305c305c305c30e75c305c305c305c305c305c305c305c305c305c305c305c30db5c305c305c305c305c305c305c305c305c305c305c305c30f75c305c305c305c305c305c305c305c305c305c305c305c30db5c305c305c305c305c305c305c305c305c305c305c305c30f75c305c305c305c305c305c305c305c305c305c305c305c30f75c305c305c305c305c305c305c305c305c305c305c305c30e75c305c305c305c305c305c305c305c305c305c305c305c30db5c305c305c305c305c305c305c305c305c305c305c305c30e75c305c305c305c305c305c305c305c305c305c305c305c30f75c305c305c305c305c305c305c305c305c305c305c305c30f75c305c305c305c305c305c305c305c305c305c305c305c30d45c305c305c305c305c305c305c305c305c305c305c305c30d45c305c305c305c305c305c305c305c305c305c305c305c30d45c305c305c305c305c305c305c305c305c305c305c305c30d45c305c305c305c305c305c305c305c305c305c305c305c30d45c305c305c305c305c305c305c305c305c305c305c305c30d45c305c305c305c305c305c305c305c305c305c305c305c30d45c305c305c305c305c305c305c305c305c305c305c305c30d45c305c305c305c305c305c305c305c305c305c305c305c30d45c305c305c305c305c305c305c305c305c305c305c305c30d45c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30076d5c300a265c300b46045c3014a4785c305c300b5c305c300f84400b1184c0f414a4785c305e84400b6084c0f4105c305c301184680114a4f05c302d44e0014dc60a5c305c305c30ff8c8c8c5c305c305c30608468015c30075c305c300f84400b14a4785c305e84400b5c30185c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c303230303709454e474c495348204345525449464943415445204c4556454c20420d534b494c4c530d4162696c6974793a090d0d476f6f64205068702c204d7973716c2c2048746d6c2c204a6176617363726970742c2043737320616e64204a71756572792e0d4b6e6f776c6564676520576562736572766963652c2041504920676f6f676c652c2046616365626f6f6b0d4b6e6f776c65646765204a6f6f6d6c612c2044727570616c2c2050726573746173686f702e20200d4b6e6f776c656764652061626f75742046616d65776f726b205a656e642c20436f646549676e697465722c2053796d666f6e7985200d4b6e6f776c656764652061626f75742074656d706c61746520656e67696e652028536d6172747929200d4b6e6f776c656764652061626f757420504850204f626a6563742052656c6174696f6e616c204d61707065722028446f637472696e65290d4b6e6f776c656764652061626f7574204f4f502e0d4b6e6f776c656764652061626f7574204c696e757820686f7374696e672c204654502c204370616e656c2c20506c65736b2c2053564e2e2e2e0d4b6e6f776c656764652061626f7574206f7065726174696e672073797374656d205562756e74750d4b6e6f776c65646765205641532e0d0d5175616c696669636174696f6e3a090d0d48617665206d6f72652035207965617220657870657269656e636520696e207068702070726f6772616d6d696e670d576f726b20696e646570656e64656e746c7920756e6465722070726573737572652e0d416c7761797320626520666c657869626c652e0d476f6f64205265616420616e642057726974696e6720736b696c6c7320696e20456e676c6973682e0d4144444954494f4e414c20494e464f524d4154494f4e200d496e746572657374733a20666f6f7462616c6c2c206d757369632c2066696c6d0d52454d554e45524154494f4e0d45787065637465642053616c6172793a090d030d0d040d0d030d0d040d0d080d0d0d0d0d0d506167652013205041474520143315206f662013204e554d5041474553205c5c2a417261626963201434150d0d0d0d0d5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c306f345c305c3090345c305c3091345c305c30b0355c305c30c0355c305c30c1355c305c30c8355c305c30d6355c305c30d7355c305c30f3355c305c30f4355c305c3078365c305c3090365c305c30b1365c305c30be365c305c30d0365c305c30d1365c305c30d3365c305c30d4365c305c30d6365c305c30d7365c305c30d9365c305c30da365c305c30dc365c305c30dd365c305c30de365c305c30e2365c305c30e3365c305c30f2e4d6c0aea4e49ad68cd677d677d66f6b6f6b6f6b6f6b634f4b6b5c305c305c305c305c305c305c305c305c305c305c30061668ba18475c305c30261668ba18475c30434a145c304f4a025c30514a025c305e4a025c30614a145c306d485c30046e485c300473485c30045c300f036a5c305c305c305c301668ba18475c30550801061668b262c65c305c300f036a5c305c305c305c301668b262c65c30550801291668ba18475c30350881422a08434a1a5c304f4a025c30514a025c305c5c08815e4a025c30614a1a5c307068ffffff5c301a16685d68485c30434a145c304f4a025c30504a035c30514a025c30614a165c305c30121668cc3adf5c304f4a025c30504a035c30514a025c305c30121668ba18475c304f4a025c30504a035c30514a025c305c30231668ba18475c30304a635c304f4a025c30514a025c3066485c300171ca0a5c305c305c30ffffffff5c305c305c302b1668ba18475c30304a635c30434a145c304f4a025c30514a025c30614a145c3066485c300171ca0a5c305c305c30ffffffff5c305c305c301a1668ba18475c30434a145c304f4a025c30504a035c30514a025c30614a165c305c301a1668cc3adf5c30434a145c304f4a025c30504a035c30514a025c30614a165c305c301a1668b84e4b5c30434a145c304f4a025c30504a035c30514a025c30614a165c301bd7355c305c30d8355c305c30e8355c305c30e9355c305c3018365c305c303b365c305c304f365c305c3078365c305c3090365c305c30b1365c305c30be365c305c30d0365c305c30d2365c305c30d3365c305c30d5365c305c30d6365c305c30d8365c305c30d9365c305c30db365c305c30dc365c305c30de365c305c30df365c305c30e0365c305c30e1365c305c30e2365c305c30f75c305c305c305c305c305c305c305c305c305c305c305c30f75c305c305c305c305c305c305c305c305c305c305c305c30f75c305c305c305c305c305c305c305c305c305c305c305c30f05c305c305c305c305c305c305c305c305c305c305c305c30f05c305c305c305c305c305c305c305c305c305c305c305c30f05c305c305c305c305c305c305c305c305c305c305c305c30f05c305c305c305c305c305c305c305c305c305c305c305c30e05c305c305c305c305c305c305c305c305c305c305c305c30f75c305c305c305c305c305c305c305c305c305c305c305c30e05c305c305c305c305c305c305c305c305c305c305c305c30dc5c305c305c305c305c305c305c305c305c305c305c305c30da5c305c305c305c305c305c305c305c305c305c305c305c30da5c305c305c305c305c305c305c305c305c305c305c305c30da5c305c305c305c305c305c305c305c305c305c305c305c30da5c305c305c305c305c305c305c305c305c305c305c305c30da5c305c305c305c305c305c305c305c305c305c305c305c30da5c305c305c305c305c305c305c305c305c305c305c305c30da5c305c305c305c305c305c305c305c305c305c305c305c30da5c305c305c305c305c305c305c305c305c305c305c305c30d55c305c305c305c305c305c305c305c305c305c305c305c30d55c305c305c305c305c305c305c305c305c305c305c305c30d55c305c305c305c305c305c305c305c305c305c305c305c30d55c305c305c305c305c305c305c305c305c305c305c305c30da5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30046a5c300324026124025c30015c305c305c30035c305c3014a4785c30105c305c301184680114a4f05c302d44e0014dc60a5c305c305c30ff8c8c8c5c305c305c3060846801076d5c300a265c300b46055c3014a4785c305c30075c305c300f84400b14a4785c305e84400b5c3018e2365c305c30e3365c305c300e375c305c300f375c305c3010375c305c3011375c305c3012375c305c30fd5c305c305c305c305c305c305c305c305c305c305c305c30f85c305c305c305c305c305c305c305c305c305c305c305c30f35c305c305c305c305c305c305c305c305c305c305c305c30fd5c305c305c305c305c305c305c305c305c305c305c305c30fd5c305c305c305c305c305c305c305c305c305c305c305c30ef5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30035c305c3014a4785c305c30045c305c300324026124025c30046a5c300324026124025c30015c305c305c3006e3365c305c30e8365c305c30e9365c305c30ef365c305c30f0365c305c30f1365c305c30f2365c305c30f6365c305c30f7365c305c300a375c305c300b375c305c300c375c305c300d375c305c300f375c305c3011375c305c3012375c305c30f2e4dae4cbe4f2e4dae4cbe4c5c1b35c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c301a1668ba18475c30434a145c304f4a025c30504a035c30514a025c30614a165c305c30061668ba18475c305c300a1668ba18475c30614a105c305c301d1668a639985c30434a105c305e4a035c30614a105c306d485c30046e485c3004750801121668ba18475c30434a105c305e4a035c30614a105c305c301b036a5c305c305c305c301668ba18475c30434a105c305508015e4a035c30614a105c301a1668ba18475c30434a105c304f4a035c30514a035c305e4a035c30614a105c300f2c5c30319068011fb0822e20b0c64121b038045c22b038042390c3072490360825b05c305c3017b0d00218b032020c90d0025c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30af5c305c305c30445c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30d0c9ea79f9bace118c825c30aa5c304ba90b025c305c305c30035c305c305c30e0c9ea79f9bace118c825c30aa5c304ba90b3e5c305c305c306d5c30615c30695c306c5c30745c306f5c303a5c30705c30685c30615c306e5c30645c30755c30795c30635c30615c306e5c30685c30365c30395c30405c30675c306d5c30615c30695c306c5c302e5c30635c306f5c306d5c305c305c30a35c305c305c30445c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30d0c9ea79f9bace118c825c30aa5c304ba90b025c305c305c30035c305c305c30e0c9ea79f9bace118c825c30aa5c304ba90b325c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30775c30775c30775c302e5c306e5c30765c306d5c30675c30725c306f5c30755c30705c302e5c30635c306f5c306d5c302f5c305c305c309d5c305c305c30445c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30d0c9ea79f9bace118c825c30aa5c304ba90b025c305c305c30035c305c305c30e0c9ea79f9bace118c825c30aa5c304ba90b2c5c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30765c30695c30705c30735c30655c30615c30725c30635c30685c302e5c30635c306f5c306d5c302f5c305c305c30a55c305c305c30445c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30d0c9ea79f9bace118c825c30aa5c304ba90b025c305c305c30035c305c305c30e0c9ea79f9bace118c825c30aa5c304ba90b345c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30675c306f5c306c5c30665c302d5c30665c30615c30695c30725c30775c30615c30795c30735c302e5c30635c306f5c306d5c302f5c305c305c30a75c305c305c30445c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30d0c9ea79f9bace118c825c30aa5c304ba90b025c305c305c30035c305c305c30e0c9ea79f9bace118c825c30aa5c304ba90b365c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30775c30775c30775c302e5c30735c306f5c30665c30615c30635c306f5c306e5c30635c30655c30705c30745c302e5c30665c30725c302f5c305c305c309b5c305c305c30445c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30d0c9ea79f9bace118c825c30aa5c304ba90b025c305c305c30035c305c305c30e0c9ea79f9bace118c825c30aa5c304ba90b2a5c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30645c306f5c30645c306f5c30675c30725c306f5c30755c30705c302e5c30765c306e5c302f5c305c305c309b5c305c305c30445c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30d0c9ea79f9bace118c825c30aa5c304ba90b025c305c305c30035c305c305c30e0c9ea79f9bace118c825c30aa5c304ba90b2a5c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30335c30365c30305c30645c306f5c30635c30755c306f5c30695c302e5c30765c306e5c302f5c305c305c30a75c305c305c30445c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30d0c9ea79f9bace118c825c30aa5c304ba90b025c305c305c30035c305c305c30e0c9ea79f9bace118c825c30aa5c304ba90b365c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30775c30775c30775c302e5c30735c306f5c30665c30615c30635c306f5c306e5c30635c30655c30705c30745c302e5c30665c30725c302f5c305c305c30ab5c305c305c30445c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30d0c9ea79f9bace118c825c30aa5c304ba90b025c305c305c30035c305c305c30e0c9ea79f9bace118c825c30aa5c304ba90b3a5c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30735c306f5c30725c30745c30695c30725c30735c30615c306e5c30735c30615c306c5c30635c306f5c306f5c306c5c302e5c30635c306f5c306d5c302f5c305c305c30a35c305c305c30445c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30d0c9ea79f9bace118c825c30aa5c304ba90b025c305c305c30035c305c305c30e0c9ea79f9bace118c825c30aa5c304ba90b325c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30775c30775c30775c302e5c306e5c30685c30615c306e5c30765c30695c30655c30745c302e5c30635c306f5c306d5c302f5c305c305c30a55c305c305c30445c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30d0c9ea79f9bace118c825c30aa5c304ba90b025c305c305c30035c305c305c30e0c9ea79f9bace118c825c30aa5c304ba90b345c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30775c30775c30775c302e5c30765c30695c30705c30735c30655c30615c30725c30635c30685c302e5c30635c306f5c306d5c302f5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305e047a5c30125c30015c300b010f5c30075c305c305c305c305c305c305c305c305c30045c30085c305c305c30985c305c305c30985c305c305c309e5c305c305c30985c305c305c309e5c305c305c309e5c305c305c309e5c305c305c309e5c305c305c309e5c305c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3076025c305c3076025c305c3076025c305c3076025c305c3076025c305c3076025c305c3076025c305c3076025c305c3076025c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3038025c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c30a85c305c305c3036065c305c3036065c305c30165c305c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c30b85c305c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3068015c305c3048015c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c3036065c305c30b0035c305c3036065c305c3032065c305c30185c305c305c30c0035c305c30d0035c305c30e0035c305c30f0035c305c305c30045c305c3010045c305c3020045c305c3030045c305c3040045c305c3050045c305c3060045c305c3070045c305c3080045c305c3090045c305c30c0035c305c30d0035c305c30e0035c305c30f0035c305c305c30045c305c3010045c305c3032065c305c3028025c305c30d8015c305c30e8015c305c3020045c305c3030045c305c3040045c305c3050045c305c3060045c305c3070045c305c3080045c305c3090045c305c30c0035c305c30d0035c305c30e0035c305c30f0035c305c305c30045c305c3010045c305c3020045c305c3030045c305c3040045c305c3050045c305c3060045c305c3070045c305c3080045c305c3090045c305c30c0035c305c30d0035c305c30e0035c305c30f0035c305c305c30045c305c3010045c305c3020045c305c3030045c305c3040045c305c3050045c305c3060045c305c3070045c305c3080045c305c3090045c305c30c0035c305c30d0035c305c30e0035c305c30f0035c305c305c30045c305c3010045c305c3020045c305c3030045c305c3040045c305c3050045c305c3060045c305c3070045c305c3080045c305c3090045c305c30c0035c305c30d0035c305c30e0035c305c30f0035c305c305c30045c305c3010045c305c3020045c305c3030045c305c3040045c305c3050045c305c3060045c305c3070045c305c3080045c305c3090045c305c30c0035c305c30d0035c305c30e0035c305c30f0035c305c305c30045c305c3010045c305c3020045c305c3030045c305c3040045c305c3050045c305c3060045c305c3070045c305c3080045c305c3090045c305c3038015c305c3058015c305c30f8015c305c3008025c305c3018025c305c3056025c305c307e025c305c30145c305c305c305f4801046d4809046e48090473480904744809045c305c305c305c30445c305c3060f1ff025c30445c300c105c305c305c305c305c305c305c305c30065c304e5c306f5c30725c306d5c30615c306c5c305c305c30055c305c305c302a24015c30185c30434a185c305f480104614a185c306d4809047348090474480104685c30015c30015c30025c30685c300c105c305c305c305c305c305c305c305c30095c30485c30655c30615c30645c30695c306e5c30675c30205c30315c305c305c301e5c30015c3040265c300a265c300b46015c300a265c300b46015c3013a4f05c3014a43c5c300624011e5c304f4a025c30514a025c30434a205c303508014b48015c305e4a025c30614a205c305c5c08017c5c30025c30015c30025c307c5c300c105c305c305c305c305c305c305c305c30095c30485c30655c30615c30645c30695c306e5c30675c30205c30325c305c305c301e5c30025c304026010a26010b46015c300a26010b46015c3013a4f05c3014a43c5c30062401315c30422a016d48090870685c305c305c305c304f4a025c30514a025c30434a1c5c30734809083608013508015e4a025c30614a1c5c305d08015c5c08015c305c305c306a5c30045c30015c30025c306a5c300c105c305c305c305c305c305c305c305c30095c30485c30655c30615c30645c30695c306e5c30675c30205c30345c305c305c301e5c30045c304026030a26030b46015c300a26030b46015c3013a4f05c3014a43c5c300624011f5c30422a016d48090870685c305c305c305c30434a1c5c3073480908350801614a1c5c305c5c08015c305c305c305c305c305c305c305c305c305c305c30445c304160f2ffa15c30445c300c5c305c305c305c305c305c305c305c305c30165c30445c30655c30665c30615c30755c306c5c30745c30205c30505c30615c30725c30615c30675c30725c30615c30705c30685c30205c30465c306f5c306e5c30745c305c305c305c305c30565c30695c30f3ffb35c30565c300c0d5c305c305c305c305c305c3030060c5c30545c30615c30625c306c5c30655c30205c304e5c306f5c30725c306d5c30615c306c5c305c305c30205c303a560b5c3017f6035c305c3034d6065c300105035c305c3034d6065c30010a036c5c3061f6035c305c30025c300b5c305c305c30285c306b20f4ffc15c30285c305c300d5c305c305c305c305c305c303006075c304e5c306f5c30205c304c5c30695c30735c30745c305c305c30025c300c5c305c305c305c305c303a5c30fe2ff2fff15c303a5c300c5c305c305c305c305c305c305c305c305c30095c30575c30575c30385c304e5c30755c306d5c30325c307a5c30305c305c305c30105c304f4a025c30504a5c305c30514a025c305e4a045c30365c30fe2ff2ff0101365c300c5c305c305c305c305c305c305c305c305c30095c30575c30575c30385c304e5c30755c306d5c30335c307a5c30305c305c305c300c5c30434a185c304f4a055c30514a055c30325c30fe2ff2ff1101325c300c5c305c305c305c305c305c305c305c305c30095c30575c30575c30385c304e5c30755c306d5c30345c307a5c30305c305c305c30085c304f4a055c30514a055c30325c30fe2ff2ff2101325c300c5c305c305c305c305c305c305c305c305c30095c30575c30575c30385c304e5c30755c306d5c30355c307a5c30305c305c305c30085c304f4a015c30514a015c304a5c30fe2ff2ff31014a5c300c5c305c305c305c305c305c305c305c305c30195c30415c30625c30735c30615c30745c307a5c302d5c30535c30745c30615c306e5c30645c30615c30725c30645c30735c30635c30685c30725c30695c30665c30745c30615c30725c30745c305c305c305c305c30505c30fe2ff2ff4101505c300c5c305c305c305c305c305c305c305c305c301c5c30575c30575c302d5c30415c30625c30735c30615c30745c307a5c302d5c30535c30745c30615c306e5c30645c30615c30725c30645c30735c30635c30685c30725c30695c30665c30745c30615c30725c30745c305c305c305c305c30525c30fe2ff2ff5101525c300c5c305c305c305c305c305c305c305c305c301d5c30575c30575c302d5c30415c30625c30735c30615c30745c307a5c302d5c30535c30745c30615c306e5c30645c30615c30725c30645c30735c30635c30685c30725c30695c30665c30745c30615c30725c30745c30315c305c305c305c305c30545c30fe2ff2ff6101545c300c5c305c305c305c305c305c305c305c305c301e5c30575c30575c302d5c30415c30625c30735c30615c30745c307a5c302d5c30535c30745c30615c306e5c30645c30615c30725c30645c30735c30635c30685c30725c30695c30665c30745c30615c30725c30745c30315c30315c305c305c305c305c30565c30fe2ff2ff7101565c300c5c305c305c305c305c305c305c305c305c301f5c30575c30575c302d5c30415c30625c30735c30615c30745c307a5c302d5c30535c30745c30615c306e5c30645c30615c30725c30645c30735c30635c30685c30725c30695c30665c30745c30615c30725c30745c30315c30315c30315c305c305c305c305c30585c30fe2ff2ff8101585c300c5c305c305c305c305c305c305c305c305c30205c30575c30575c302d5c30415c30625c30735c30615c30745c307a5c302d5c30535c30745c30615c306e5c30645c30615c30725c30645c30735c30635c30685c30725c30695c30665c30745c30615c30725c30745c30315c30315c30315c30315c305c305c305c305c305a5c30fe2ff2ff91015a5c300c5c305c305c305c305c305c305c305c305c30215c30575c30575c302d5c30415c30625c30735c30615c30745c307a5c302d5c30535c30745c30615c306e5c30645c30615c30725c30645c30735c30635c30685c30725c30695c30665c30745c30615c30725c30745c30315c30315c30315c30315c30315c305c305c305c305c305c5c5c30fe2ff2ffa1015c5c5c300c5c305c305c305c305c305c305c305c305c305c225c30575c30575c302d5c30415c30625c30735c30615c30745c307a5c302d5c30535c30745c30615c306e5c30645c30615c30725c30645c30735c30635c30685c30725c30695c30665c30745c30615c30725c30745c30315c30315c30315c30315c30315c30315c305c305c305c305c305e5c30fe2ff2ffb1015e5c300c5c305c305c305c305c305c305c305c305c30235c30575c30575c302d5c30415c30625c30735c30615c30745c307a5c302d5c30535c30745c30615c306e5c30645c30615c30725c30645c30735c30635c30685c30725c30695c30665c30745c30615c30725c30745c30315c30315c30315c30315c30315c30315c30315c305c305c305c305c30605c30fe2ff2ffc101605c300c5c305c305c305c305c305c305c305c305c30245c30575c30575c302d5c30415c30625c30735c30615c30745c307a5c302d5c30535c30745c30615c306e5c30645c30615c30725c30645c30735c30635c30685c30725c30695c30665c30745c30615c30725c30745c30315c30315c30315c30315c30315c30315c30315c30315c305c305c305c305c30625c30fe2ff2ffd101625c300c5c305c305c305c305c305c305c305c305c30255c30575c30575c302d5c30415c30625c30735c30615c30745c307a5c302d5c30535c30745c30615c306e5c30645c30615c30725c30645c30735c30635c30685c30725c30695c30665c30745c30615c30725c30745c30315c30315c30315c30315c30315c30315c30315c30315c30315c305c305c305c305c30645c30fe2ff2ffe101645c300c5c305c305c305c305c305c305c305c305c30265c30575c30575c302d5c30415c30625c30735c30615c30745c307a5c302d5c30535c30745c30615c306e5c30645c30615c30725c30645c30735c30635c30685c30725c30695c30665c30745c30615c30725c30745c30315c30315c30315c30315c30315c30315c30315c30315c30315c30315c305c305c305c305c30665c30fe2ff2fff101665c300c5c305c305c305c305c305c305c305c305c305c275c30575c30575c302d5c30415c30625c30735c30615c30745c307a5c302d5c30535c30745c30615c306e5c30645c30615c30725c30645c30735c30635c30685c30725c30695c30665c30745c30615c30725c30745c30315c30315c30315c30315c30315c30315c30315c30315c30315c30315c30315c305c305c305c305c30325c30fe2ff2ff0102325c300c5c305c305c305c305c305c305c305c305c30095c30575c30575c30385c304e5c30755c306d5c30325c307a5c30315c305c305c30085c304f4a065c30514a065c30325c30fe2ff2ff1102325c300c5c305c305c305c305c305c305c305c305c30095c30575c30575c30385c304e5c30755c306d5c30325c307a5c30325c305c305c30085c304f4a055c30514a055c30325c30fe2ff2ff2102325c300c5c305c305c305c305c305c305c305c305c30095c30575c30575c30385c304e5c30755c306d5c30325c307a5c30335c305c305c30085c304f4a015c30514a015c30325c30fe2ff2ff3102325c300c5c305c305c305c305c305c305c305c305c30095c30575c30575c30385c304e5c30755c306d5c30335c307a5c30315c305c305c30085c304f4a065c30514a065c30325c30fe2ff2ff4102325c300c5c305c305c305c305c305c305c305c305c30095c30575c30575c30385c304e5c30755c306d5c30335c307a5c30325c305c305c30085c304f4a055c30514a055c30325c30fe2ff2ff5102325c300c5c305c305c305c305c305c305c305c305c30095c30575c30575c30385c304e5c30755c306d5c30335c307a5c30335c305c305c30085c304f4a015c30514a015c30365c30fe2ff2ff6102365c300c5c305c305c305c305c305c305c305c305c30095c30575c30575c30385c304e5c30755c306d5c30355c307a5c30315c305c305c300c5c304f4a065c30514a065c305e4a065c30325c30fe2ff2ff7102325c300c5c305c305c305c305c305c305c305c305c30095c30575c30575c30385c304e5c30755c306d5c30355c307a5c30325c305c305c30085c304f4a055c30514a055c303a5c30fe2ff2ff81023a5c300c5c305c305c305c305c305c305c305c305c30095c30575c30575c30385c304e5c30755c306d5c30375c307a5c30305c305c305c30105c304f4a025c30504a5c305c30514a025c305e4a025c30325c30fe2ff2ff9102325c300c5c305c305c305c305c305c305c305c305c30095c30575c30575c30385c304e5c30755c306d5c30385c307a5c30305c305c305c30085c304f4a055c30514a055c30325c30fe2ff2ffa102325c300c5c305c305c305c305c305c305c305c305c30095c30575c30575c30385c304e5c30755c306d5c30395c307a5c30305c305c305c30085c304f4a025c30514a025c30365c30fe2ff2ffb102365c300c5c305c305c305c305c305c305c305c305c30095c30575c30575c30385c304e5c30755c306d5c30395c307a5c30315c305c305c300c5c304f4a065c30514a065c305e4a065c30325c30fe2ff2ffc102325c300c5c305c305c305c305c305c305c305c305c30095c30575c30575c30385c304e5c30755c306d5c30395c307a5c30325c305c305c30085c304f4a055c30514a055c30325c30fe2ff2ffd102325c300c5c305c305c305c305c305c305c305c305c30095c30575c30575c30385c304e5c30755c306d5c30395c307a5c30335c305c305c30085c304f4a015c30514a015c30345c30fe2ff2ffe102345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30315c307a5c30305c305c305c30085c304f4a015c30514a015c30385c30fe2ff2fff102385c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30315c307a5c30315c305c305c300c5c304f4a065c30514a065c305e4a065c30345c30fe2ff2ff0103345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30315c307a5c30325c305c305c30085c304f4a055c30514a055c30345c30fe2ff2ff1103345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30325c307a5c30305c305c305c30085c304f4a015c30514a015c30385c30fe2ff2ff2103385c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30325c307a5c30315c305c305c300c5c304f4a065c30514a065c305e4a065c30345c30fe2ff2ff3103345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30325c307a5c30325c305c305c30085c304f4a055c30514a055c30345c30fe2ff2ff4103345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30335c307a5c30305c305c305c30085c304f4a015c30514a015c30385c30fe2ff2ff5103385c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30335c307a5c30315c305c305c300c5c304f4a065c30514a065c305e4a065c30345c30fe2ff2ff6103345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30335c307a5c30325c305c305c30085c304f4a055c30514a055c30345c30fe2ff2ff7103345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30345c307a5c30305c305c305c30085c304f4a055c30514a055c30385c30fe2ff2ff8103385c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30345c307a5c30315c305c305c300c5c304f4a065c30514a065c305e4a065c30345c30fe2ff2ff9103345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30345c307a5c30335c305c305c30085c304f4a015c30514a015c303c5c30fe2ff2ffa1033c5c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30355c307a5c30305c305c305c30105c304f4a025c30504a5c305c30514a025c305e4a025c303c5c30fe2ff2ffb1033c5c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30365c307a5c30305c305c305c30105c304f4a025c30504a5c305c30514a025c305e4a025c30385c30fe2ff2ffc103385c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30365c307a5c30315c305c305c300c5c304f4a065c30514a065c305e4a065c30345c30fe2ff2ffd103345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30365c307a5c30325c305c305c30085c304f4a055c30514a055c30345c30fe2ff2ffe103345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30365c307a5c30335c305c305c30085c304f4a015c30514a015c30345c30fe2ff2fff103345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30375c307a5c30305c305c305c30085c304f4a015c30514a015c30385c30fe2ff2ff0104385c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30375c307a5c30315c305c305c300c5c304f4a065c30514a065c305e4a065c30345c30fe2ff2ff1104345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30375c307a5c30325c305c305c30085c304f4a055c30514a055c30325c30fe2ff2ff2104325c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30385c307a5c30305c305c305c30065c30350801360801345c30fe2ff2ff3104345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30395c307a5c30305c305c305c30085c304f4a055c30514a055c30385c30fe2ff2ff4104385c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30395c307a5c30315c305c305c300c5c304f4a065c30514a065c305e4a065c30345c30fe2ff2ff5104345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30315c30395c307a5c30335c305c305c30085c304f4a015c30514a015c30345c30fe2ff2ff6104345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30325c30305c307a5c30305c305c305c30085c304f4a055c30514a055c30385c30fe2ff2ff7104385c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30325c30305c307a5c30315c305c305c300c5c304f4a065c30514a065c305e4a065c30345c30fe2ff2ff8104345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30325c30305c307a5c30335c305c305c30085c304f4a015c30514a015c30345c30fe2ff2ff9104345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30325c30315c307a5c30305c305c305c30085c304f4a055c30514a055c30385c30fe2ff2ffa104385c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30325c30315c307a5c30315c305c305c300c5c304f4a065c30514a065c305e4a065c30345c30fe2ff2ffb104345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30325c30315c307a5c30335c305c305c30085c304f4a015c30514a015c303c5c30fe2ff2ffc1043c5c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30325c30325c307a5c30305c305c305c30105c304f4a075c30504a5c305c30514a075c305e4a5c305c30385c30fe2ff2ffd104385c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30325c30325c307a5c30315c305c305c300c5c304f4a065c30514a065c305e4a065c30345c30fe2ff2ffe104345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30325c30325c307a5c30325c305c305c30085c304f4a055c30514a055c30345c30fe2ff2fff104345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30325c30325c307a5c30335c305c305c30085c304f4a015c30514a015c30345c30fe2ff2ff0105345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30325c30335c307a5c30305c305c305c30085c304f4a015c30514a015c30385c30fe2ff2ff1105385c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30325c30335c307a5c30315c305c305c300c5c304f4a065c30514a065c305e4a065c30345c30fe2ff2ff2105345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30325c30335c307a5c30325c305c305c30085c304f4a055c30514a055c30345c30fe2ff2ff3105345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30325c30345c307a5c30305c305c305c30085c304f4a015c30514a015c30385c30fe2ff2ff4105385c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30325c30345c307a5c30315c305c305c300c5c304f4a065c30514a065c305e4a065c30345c30fe2ff2ff5105345c300c5c305c305c305c305c305c305c305c305c300a5c30575c30575c30385c304e5c30755c306d5c30325c30345c307a5c30325c305c305c30085c304f4a055c30514a055c30365c30fe2ff2ff6105365c300c5c305c305c305c305c305c305c305c305c300b5c30575c30575c30385c304e5c30755c306d5c30535c30745c30345c307a5c30305c305c305c30085c304f4a015c30514a015c30365c30fe2ff2ff7105365c300c5c305c305c305c305c305c305c305c305c300b5c30575c30575c30385c304e5c30755c306d5c30535c30745c30385c307a5c30305c305c305c30085c304f4a055c30514a055c30445c304160f2ff8105445c300c5c305c305c305c305c305c305c305c305c30165c30445c30655c30665c30615c30755c306c5c30745c30205c30505c30615c30725c30615c30675c30725c30615c30705c30685c30205c30465c306f5c306e5c30745c305c305c305c305c30365c30554082059105365c300c5c305c305c305c305c305c305c305c305c30095c30485c30795c30705c30655c30725c306c5c30695c306e5c306b5c305c305c300c5c30422a0270685c305c30ff5c303e2a012e5c30295c308205a1052e5c300c5c305c305c305c305c305c305c305c305c300b5c30505c30615c30675c30655c30205c304e5c30755c306d5c30625c30655c30725c305c305c305c305c30545c30fe0f8205b105545c300c5c305c305c305c305c305c305c305c305c300e5c30485c30655c30615c30645c30695c306e5c30675c30205c30345c30205c30435c30685c30615c30725c305c305c301f5c30422a016d48090870685c305c305c305c30434a1c5c3073480908350801614a1c5c305c5c08015c30605c30fe0f8205c105605c300c5c305c305c305c305c305c305c305c305c300d5c30455c306d5c30615c30695c306c5c30535c30745c30795c306c5c30655c30325c30305c30315c305c305c302e5c30422a0970685c305c30805c30532a5c3037085c304f4a085c30514a085c30434a145c3036085c303e2a5c3035085c30614a145c305d085c305c5c085c30405c30fe0f8205d105405c300c5c305c305c305c305c305c305c305c305c30105c30425c306f5c30645c30795c30205c30545c30655c30785c30745c30205c30335c30205c30435c30685c30615c30725c305c305c30085c30434a105c30614a105c304e5c30fe0f8205e1054e5c300c5c305c305c305c305c305c305c305c305c30115c30425c30615c306c5c306c5c306f5c306f5c306e5c30205c30545c30655c30785c30745c30205c30435c30685c30615c30725c305c305c30145c304f4a095c30514a095c30434a105c305e4a095c30614a105c30365c30fe0f8205f105365c300c5c305c305c305c305c305c305c305c305c300b5c30485c30655c30615c30645c30655c30725c30205c30435c30685c30615c30725c305c305c30085c30434a185c30614a185c30365c30fe0f82050106365c300c5c305c305c305c305c305c305c305c305c300b5c30465c306f5c306f5c30745c30655c30725c30205c30435c30685c30615c30725c305c305c30085c30434a185c30614a185c302a5c30575c30820511062a5c300c105c305c305c305c305c305c305c305c30065c30535c30745c30725c306f5c306e5c30675c305c305c30065c303508015c5c08012e5c30585c30820521062e5c300c105c305c305c305c305c305c305c305c30085c30455c306d5c30705c30685c30615c30735c30695c30735c305c305c30065c303608015d08012c5c30fe4f820531062c5c300c5c305c305c305c305c305c305c305c305c300a5c30735c30685c306f5c30725c30745c305f5c30745c30655c30785c30745c305c305c305c305c304e5c30fe0f015c3052064e5c300c5c305c305c305c305c305c305c305c305c30075c30485c30655c30615c30645c30695c306e5c30675c305c305c300d5c30645c3013a4f05c3014a4785c300624015c30185c304f4a0a5c30514a0a5c30434a1c5c30504a0b5c305e4a0b5c30614a1c5c30545c30425c30015c305206545c300c5c305c305c305c305c305c305c305c305c30095c30425c306f5c30645c30795c30205c30545c30655c30785c30745c305c305c300a5c30655c3013a45c305c3014a4785c301d5c30422a016d48090870685c305c305c305c304f4a0c5c30514a0c5c3073480908614a145c305c30245c302f5c3051066206245c300c5c305c305c305c305c305c305c305c305c30045c304c5c30695c30735c30745c305c305c30025c30665c305c305c30445c305c225c30015c307206445c300c105c305c305c305c305c305c305c305c30075c30435c30615c30705c30745c30695c306f5c306e5c305c305c300d5c30675c3013a4785c3014a4785c300c24015c300e5c30434a185c30360801614a185c305d08012a5c30fe0f015c3082062a5c300c5c305c305c305c305c305c305c305c305c30055c30495c306e5c30645c30655c30785c305c305c30055c30685c300c24015c305c305c30285c301f5c30015c309206285c300c5c305c305c305c305c305c305c305c305c30065c30485c30655c30615c30645c30655c30725c305c305c30025c30695c305c305c30285c302040015c30a206285c300c5c305c305c305c305c305c305c305c305c30065c30465c306f5c306f5c30745c30655c30725c305c305c30025c306a5c305c305c30665c30435c30015c30b206665c300c5c305c305c305c305c305c305c305c305c30105c30425c306f5c30645c30795c30205c30545c30655c30785c30745c30205c30495c306e5c30645c30655c306e5c30745c305c305c300e5c306b5c305e84d0025d845c305c3060845c305c301d5c30422a096d48090870685c305c30805c304f4a0d5c30514a0d5c3073480908614a145c305c304e5c30fe0f015c30c2064e5c300c5c305c305c305c305c305c305c305c305c300f5c30535c30745c30615c306e5c30645c30615c30725c30645c30205c30285c30575c30655c30625c30295c30315c305c305c300a5c306c5c3013a4180114a418010c5c306d480704734807045e4a045c304c5c30b340015c30d2064c5c300c105c305c305c305c305c305c305c305c300e5c304c5c30695c30735c30745c30205c30505c30615c30725c30615c30675c30725c30615c30705c30685c305c305c300e5c306d5c305e84d0025d845c305c3060845c305c30085c304f4a0c5c30514a0c5c30585c309d20f1ffe206585c300c105c305c305c305c305c305c305c305c300a5c304e5c306f5c30205c30535c30705c30615c30635c30695c306e5c30675c305c305c30055c306e5c302a24015c30245c30434a165c304f4a035c30504a035c30514a035c305f480104614a165c306d48090473480904744801046c5c30fe0f5106f2066c5c300c5c305c305c305c305c305c305c305c305c300b5c30415c30635c30685c30695c30655c30765c30655c306d5c30655c306e5c30745c305c305c305c225c306f5c301264dc5c305c305c300324036124035e8468015d845c305c30608498fe13a4505c3014a4505c30195c30422a016d48090470685c305c305c30ff4f4a5c305c30514a5c305c30734809045c30465c30fe0f015c300207465c300c5c305c305c305c305c305c305c305c305c300b5c30485c30655c30615c30645c30655c30725c30205c30425c30615c30735c30655c305c305c300e5c30705c305e845c305c305d8498fe60845c305c30085c30434a145c30614a145c30605c30fe2ff1fff206605c300c5c305c305c305c305c305c305c305c305c30095c304a5c306f5c30625c30205c30545c30695c30745c306c5c30655c305c305c300f5c30715c301264dc5c305c305c3014a4285c302a24015c30235c303508814088f6ff4f4a025c30504a025c30514a025c305f4801046d48090473480904744801045c30425c30515c30015c305c2207425c300c5c305c305c305c305c305c305c305c305c300b5c30425c306f5c30645c30795c30205c30545c30655c30785c30745c30205c30335c305c305c300a5c30725c3013a45c305c3014a4785c30085c30434a105c30614a105c30585c30545c30015c303207585c300c5c305c305c305c305c305c305c305c305c300a5c30425c306c5c306f5c30635c306b5c30205c30545c30655c30785c30745c305c305c301a5c30735c301264f05c305c305c300524015e84285c305d84285c3060845c305c30062401105c304f4a025c30514a025c30434a105c30614a145c305e5c30fe0f015c30025c305e5c300c5c305c305c305c305c305c305c305c305c30105c30435c306f5c306d5c30705c30615c306e5c30795c30205c304e5c30615c306d5c30655c30205c304f5c306e5c30655c305c305c301c5c30745c301264dc5c305c305c305e845c305c305d8498fe60845c305c3013a4dc5c3014a4285c30085c30434a145c30614a145c30485c30995c30015c305207485c300c5c305c305c305c305c305c305c305c305c300c5c30425c30615c306c5c306c5c306f5c306f5c306e5c30205c30545c30655c30785c30745c305c305c30025c30755c30145c304f4a095c30514a095c30434a105c305e4a095c30614a105c303c5c305e5c30015c3062073c5c300c5c305c305c305c305c305c305c305c305c300c5c304e5c306f5c30725c306d5c30615c306c5c30205c30285c30575c30655c30625c30295c305c305c300a5c30765c3013a4180114a418015c305c30445c30fe0f015c307207445c300c5c305c305c305c305c305c305c305c305c30085c30625c306f5c30645c30795c30745c30655c30785c30745c305c305c300a5c30775c3013a4180114a41801105c304f4a0e5c30514a0e5c30504a0e5c305e4a0e5c302c5c30fe0f015c3082072c5c300c5c305c305c305c305c305c305c305c305c30045c306e5c30655c30775c30735c305c305c300a5c30785c3013a4180114a418015c305c30385c30fe0f51069207385c300c5c305c305c305c305c305c305c305c305c300e5c30465c30725c30615c306d5c30655c30205c30635c306f5c306e5c30745c30655c306e5c30745c30735c305c305c30025c30795c305c305c30504b0304145c30065c30085c305c305c30215c30828abc13fa5c305c305c301c025c305c30135c305c305c305b436f6e74656e745f54797065735d2e786d6cac91cb6ac3301045f785fe83d0b6d872ba28a5d8cea249777d2cd20f18e4b12d6a8f843409c9df77ecb850ba082d74231062ce997b55ae8fe3a00e1893f354e9555e6885647de3a8abf4fbee29bbd72a315003835c27acf409935ed7d757e5ee14302999a654e99e393c18936c8f23a4dc072479697d1c81e51a3b13c07e4087e6b628ee8cf5c4489cf1c4d075f92a0b44d7a07a83c82f308ac7b0a0f0fbf90c2480980b58abc733615aa2d210c2e02cb04430076a7ee833dfb6ce62e3ed7e14693e8317d8cd0433bf5c5c60f53fea2fe7065bd80facb647e9e25c5c7fc421fd2ddb526b2e9373fed4bb902e182e97b7b461e6bfad3f015c305c30ffff035c30504b0304145c30065c30085c305c305c30215c30a5d6a7e7c05c305c305c3036015c305c300b5c305c305c305f72656c732f2e72656c73848fcf6ac3300c87ef85bd83d17d51d2c31825762fa590432fa37d5c30e1287f685c221bdb1bebdb4fc7060abb0884a4eff7a93dfeae8bf9e194e720169aaa06c3e2433fcb68e1763dbf7f82c985a4a725085b787086a37bdbb55fbc50d1a33ccd311ba548b63095120f88d94fbc52ae4264d1c910d24a45db3462247fa791715fd71f989e19e0364cd3f51652d73760ae8fa8c9ffb3c330cc9e4fc17faf2ce545046e37944c69e462a1a82fe353bd90a865aad41ed0b5b8f9d6fd015c305c30ffff035c30504b0304145c30065c30085c305c305c30215c306b799616835c305c305c308a5c305c305c301c5c305c305c307468656d652f7468656d652f7468656d654d616e616765722e786d6c0ccc4d0ac3201040e17da17790d93763bb284562b2cbaebbf65c30439c1a41c7a0d29fdbd7e5e38337cedf14d59b4b0d592c9c070d8a65cd2e88b7f07c2ca71ba8da481cc52c6ce1c715e6e97818c9b48d13df49c873517d23d59085adb5dd20d6b52bd521ef2cdd5eb9246a3d8b4757e8d3f729e245eb2b260a0238fd015c305c30ffff035c30504b0304145c30065c30085c305c305c30215c3096b5ade296065c305c30501b5c305c30165c305c305c307468656d652f7468656d652f7468656d65312e786d6cec594f6fdb3614bf0fd87720746f635c27761a07758ad8b19b2d4d1bc46e871e698996d850a240d2497d1bdae38001c3ba618715d86d87615b8116d8a5fb34d93a6c1dd0afb0475292c5585e9236d88aad3e2412f9e3fbff1e1fa9abd7eec70c1d1221294fda5efd72cd4324f1794093b0eddd1ef62fad79482a9c0498f184b4bd2991deb58df7dfbb8ad755446282607d5c22d771db8b944ad79796a40fc3585ee62949606ecc458c15bc8a702910f808e8c66c69b9565b5d8a314d3c94e018c8de1a8fa94fd05093f43672e23d06af89927ac06762a049136785c10607758d9053d965021d62d6f6804fc08f86e4bef210c352c144dbab999fb7b4717509af678b985ab0b6b4ae6f7ed9ba6c4170b06c788a705430adf71bad2b5b057d03606a1ed7ebf5babd7a41cf5c30b0ef83a6569632cd467faddec9699640f6719e76b7d6ac355c5c7c89feca9cccad4ea7d36c65b258a206641f1b73f8b5da6a6373d9c11b90c537e7f08dce66b7bbeae00dc8e257e7f0fd2badd5868b37a088d1e4600ead1ddaef67d40bc898b3ed4af81ac0d76a197c86826828a24bb318f3442d8ab518dfe3a20f5c300d6458d104a9694ac6d88728eee2782428d60cf03ac1a5193be4cbb921cd0b495fd054b5bd0f530c1931a3f7eaf9f7af9e3f45c70f9e1d3ff8e9f8e1c3e3073f5a42ceaa6d9c84e5552fbffdeccfc71fa33f9e7ef3f2d117d57859c6fffac35c27bffcfc793510d26726ce8b2f9ffcf6ecc98baf3efdfdbb4715f04d814765f890c644a29be408edf31814335671255c272371be15c308d3f28acd249438c19a4b05fd9e8a1cf4cd296699771c393ac4b5e01d01e5a30a787d72cf1178108989a2159c77a2d801ee72ce3a5c5c545a6147f32a99793849c26ae66252c6ed637c58c5bb8b13c7bfbd490a75330f4b47f16e441c31f7184e140e494214d273fc80900aedee52ead87597fa824b3e56e82e451d4c2b4d32a4235c279a668bb6690c7e9956e90cfe766cb37b077538abd27a8b1cba48c80acc2a841f12e698f13a9e281c57911ce298950d7e03aba84ac8c154f8655c5c4f2af074481847bd804859b5e6965c307d4b4edfc150b12addbecba6b18b148a1e54d1bc81392f23b7f84137c2715a851dd0242a633f900710a218ed715505dfe56e86e877f0034e16bafb0e258ebb4faf06b769e888340b103d3311da9750aa9d0a1cd3e4efca31a3508f6d0c5c5c5c5c398602f8e2ebc71591f5b616e24dd893aa3261fb44f95d843b5974bb5c5c04f4edafb95b7892ec1108f3f98de75dc97d5772bdff7cc95d94cf672db4b3da0a6557f70db629362d72bcb0431e53c6066acac80d699a6409fb44d08741bdce9c0e4971624a2378cceaba830b05366b90e0ea23aaa241845368b0eb9e2612ca8c742851ca251ceccc70256d8d87265dd96361531f186c3d9058edf2c00eafe8e1fc5c5c509031bb4d680e9f39a3154de0accc56ae644441edd76156d7429d995bdd88664a9dc3ad50197c38af1a0c16d684060441db02565e85f3b9660d0713cc48a0ed6ef7dedc2dc60b17e95c2219e180643ed27acffba86e9c94c78ab90980d8a9f0913ee49d62b512b79626fb06dccee2a432bbc60276b9f7dec44b7904cfbca4f3f6443ab2a49c9c2c41476dafd55c5c6e7ac8c769db1bc399161ee314bc2e75cf8759081743be1236ec4f4d6693e5336fb672c5dc24a8c33585b5fb9cc24e1d4885545b58463634cc5416022cd19cacfccb4d30eb45296023fd35a458598360f8d7a45c303bbaae25e331f155d9d9a5116d3bfb9a95523e51440ca2e0088dd844ec6370bf0e55d05c27a012ae264c45d02f708fa6ad6da6dce29c255df9f6cae0ec38666984b372ab5334cf640b37795c5cc860de4ae2816e95b21be5ceaf8a49f90b52a51cc6ff3355f47e0237052b81f6800fd7b802239daf6d8f0b1571a8426944fdbe80c6c1d40e8816b88b8569082ab84c36ff0539d4ff6dce591a26ade1c0a7f669880485fd484582903d284b26fa4e2156cff62e4b9265844c4495c495a9157b440e091bea1ab8aaf7760f4510eaa69a6465c0e04ec69ffb9e65d028d44d4e39df9c1a52ecbd3607fee9cec7263328e5d661d3d0e4f62f44acd855ed7ab33cdf7bcb8ae889599bd5c8b3029895b6825696f6af29c239b75a5bb1e6345e6ee6c28117e73586c1a2214ae1be07e93fb0ff51e133fb65426fa843be0fb515c187064d0cc206a2fa926d3c902e907670048d931db4c1a44959d366ad93b65abe595f70a75bf03d616c2dd959fc7d4e6317cd99cbcec9c58b34766661c7d6766ca1a9c1b35c27531486c6f941c638c67cd22a7f75e2a37be0e82db8df9f30254d30c1372581a1f51c983c80e4b71ccdd28dbf5c305c305c30ffff035c30504b0304145c30065c30085c305c305c30215c300dd1909fb65c305c305c301b015c305c305c275c305c305c307468656d652f7468656d652f5f72656c732f7468656d654d616e616765722e786d6c2e72656c73848f4d0ac2301484f78277086f6fd3ba109126dd88d0add40384e4350d363f2451eced0dae2c082e8761be9969bb979dc9136332de3168aa1a083ae995719ac16db8ec8e4052164e89d93b64b060828e6f37ed1567914b284d262452282e3198720e5c274a939cd08a54f980ae38a38f56e45c22a3a641c8bbd048f7757da0f19b017cc524bd62107bd55c301996509affb3fd381a89672f1f165dfe514173d9850528a2c6cce0239baa4c04ca5bbabac4df5c305c305c30ffff035c30504b01022d5c30145c30065c30085c305c305c30215c30828abc13fa5c305c305c301c025c305c30135c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305b436f6e74656e745f54797065735d2e786d6c504b01022d5c30145c30065c30085c305c305c30215c30a5d6a7e7c05c305c305c3036015c305c300b5c305c305c305c305c305c305c305c305c305c305c305c305c302b015c305c305f72656c732f2e72656c73504b01022d5c30145c30065c30085c305c305c30215c306b799616835c305c305c308a5c305c305c301c5c305c305c305c305c305c305c305c305c305c305c305c305c3014025c305c307468656d652f7468656d652f7468656d654d616e616765722e786d6c504b01022d5c30145c30065c30085c305c305c30215c3096b5ade296065c305c30501b5c305c30165c305c305c305c305c305c305c305c305c305c305c305c305c30d1025c305c307468656d652f7468656d652f7468656d65312e786d6c504b01022d5c30145c30065c30085c305c305c30215c300dd1909fb65c305c305c301b015c305c305c275c305c305c305c305c305c305c305c305c305c305c305c305c309b095c305c307468656d652f7468656d652f5f72656c732f7468656d654d616e616765722e786d6c2e72656c73504b05065c305c305c305c30055c30055c305d015c305c30960a5c305c305c305c303c3f786d6c2076657273696f6e3d5c22312e305c2220656e636f64696e673d5c225554462d385c22207374616e64616c6f6e653d5c227965735c223f3e0d0a3c613a636c724d617020786d6c6e733a613d5c22687474703a2f2f736368656d61732e6f70656e786d6c666f726d6174732e6f72672f64726177696e676d6c2f323030362f6d61696e5c22206267313d5c226c74315c22207478313d5c22646b315c22206267323d5c226c74325c22207478323d5c22646b325c2220616363656e74313d5c22616363656e74315c2220616363656e74323d5c22616363656e74325c2220616363656e74333d5c22616363656e74335c2220616363656e74343d5c22616363656e74345c2220616363656e74353d5c22616363656e74355c2220616363656e74363d5c22616363656e74365c2220686c696e6b3d5c22686c696e6b5c2220666f6c486c696e6b3d5c22666f6c486c696e6b5c222f3e5c305c305c305c302d5c305c305c30e9105c305c30015c305c305c305c305c305c305c305c305c30ffffffff01045c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30ffffffff5c305c305c305c305c305c305c305c305c305c305c305c302d5c305c305c30305c305c305c305c305c305c305c305c305c30ffff5c305c305c305c305c305c305c305c30e9105c305c300d5c305c30405c305c305c305c30ffffffff5c305c305c305c30035c305c305c30065c305c305c30065c305c305c30095c305c305c300c5c305c305c300c5c305c305c300c5c305c305c300c5c305c305c300c5c305c305c30125c305c305c30125c305c305c30125c305c305c30155c305c305c305c30085c305c30f10a5c305c301e0c5c305c30e60c5c305c30560e5c305c30c4115c305c302f145c305c3032165c305c306f345c305c30e3365c305c3012375c305c300d5c305c305c300f5c305c305c30105c305c305c30115c305c305c30135c305c305c30145c305c305c30165c305c305c30175c305c305c301c5c305c305c301f5c305c305c305c30085c305c303e0e5c305c304e125c305c30f3185c305c30d7355c305c30e2365c305c3012375c305c300e5c305c305c30125c305c305c30155c305c305c30185c305c305c301d5c305c305c301e5c305c305c30cb5c305c305c30f85c305c305c3010015c305c30f1015c305c3018025c305c3031025c305c3034025c305c305b025c305c3073025c305c3076025c305c309a025c305c30af025c305c30b2025c305c30da025c305c30f3025c305c30f6025c305c301f035c305c3039035c305c303c035c305c305f035c305c3073035c305c3077035c305c309a035c305c30ae035c305c30b1035c305c30d2035c305c30e5035c305c3091075c305c30b3075c305c30c7075c305c30cb075c305c30ee075c305c3003085c305c30a5085c305c30ce085c305c30e8085c305c3025095c305c3050095c305c306d095c305c30df095c305c30060a5c305c301e0a5c305c305d0b5c305c30850b5c305c309e0b5c305c30e9105c305c30135814ff1580135814ff1584135814ff1580135814ff1580135814ff1580135814ff1580135814ff1580135814ff1580135814ff1584135814ff1580135814ff1580135814ff1584135814ff1584135814ff1580135814ff1580055c305c305c300c5c305c305c300e5c305c305c30135c305c305c305c275c305c305c30295c305c305c30305c305c305c30132114ff1580131a14ff15800f5c305c30f0745c305c305c305c305c3006f0205c305c305c30020c5c305c30035c305c305c30045c305c305c30025c305c305c30025c305c305c30025c305c305c30015c305c305c30035c305c305c301f5c3001f02c5c305c305c30525c3007f0245c305c305c30050587b37ae35c305c305c305c3025161797795c305c3010ff5c30730c5c305c305c305c305c305c30ffffffff5c305c305c305c30405c301ef1105c305c305c30045c305c3008015c305c3008025c305c3008f75c305c3010010f5c3002f0e25c305c305c30205c3008f0085c305c305c30025c305c305c3001045c305c300f5c3003f0ca5c305c305c300f5c3004f0285c305c305c30015c3009f0105c305c305c305c305c305c305c305c305c305c305c300180ffff0180ffff025c300af0085c305c305c305c30045c305c30055c305c305c300f5c3004f0925c305c305c30a20c0af0085c305c305c3001045c305c305c300a5c305c30c35c300bf0485c305c305c30805c305c305c30015c30815c305c305c305c305c30825c305c305c305c305c30835c305c305c305c305c30845c305c305c305c305c3082015c305c305c305c3083015c305c305c305c30bf01105c30105c30ff015c305c30085c308403f7c0015c308603f7c0015c30bf03205c30205c30135c305c22f1065c305c305c303f055c305c30015c305c305c3010f0045c305c305c305c305c305c305c305c305c3011f0045c305c305c30015c305c305c305c305c300df0045c305c305c305c305c30015c305c300f5c3002f0865c305c305c30105c3008f0085c305c305c30015c305c305c3002085c305c300f5c3003f0305c305c305c300f5c3004f0285c305c305c30015c3009f0105c305c305c305c305c305c305c305c305c305c305c300180ffff0180ffff025c300af0085c305c305c305c30085c305c30055c305c305c300f5c3004f0365c305c305c30125c300af0085c305c305c3001085c305c305c300e5c305c30335c300bf0125c305c305c30cb015c305c305c305c30ff015c305c30085c3001025c305c305c305c305c305c3011f0045c305c305c30015c305c305c30e9105c305c300c5c305c305c30155c305c305c3001045c305c3033215c305c3008ffffff26265c305c30cc5c305c305c3074405c305c305c305c30ffff265c305c305c300a5c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30315c30375c300e5c30635c30615c306e5c30645c30695c30645c30615c30745c30655c305f5c306e5c30615c306d5c30655c30085c30625c30695c30725c30745c30685c30645c30615c30795c30065c30675c30655c306e5c30645c30655c30725c300e5c306d5c30615c30725c30695c30745c30615c306c5c305f5c30735c30745c30615c30745c30755c30735c300b5c306e5c30615c30745c30695c306f5c306e5c30615c306c5c30695c30745c30795c30075c30615c30645c30645c30725c30655c30735c30735c30055c30705c30685c306f5c30745c306f5c30115c30635c30615c30725c30655c30655c30725c305f5c306f5c30625c306a5c30655c30635c30745c30695c30765c30655c30735c300a5c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30325c30355c300a5c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30325c30365c300e5c30635c30615c30725c30655c30655c30725c305f5c30735c30755c306d5c306d5c30615c30725c30795c30095c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30335c30095c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30345c30095c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30355c30095c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30365c30095c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30395c300a5c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30315c30305c300a5c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30315c30315c300a5c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30315c30325c30115c30635c30615c30725c30655c30655c30725c305f5c30735c30755c306d5c306d5c30615c30725c30795c30315c30315c30315c300a5c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30315c30385c300a5c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30325c30335c30085c30615c30635c30615c30645c30655c306d5c30695c30635c30095c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30315c30095c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30325c30185c30705c30725c306f5c30665c30655c30735c30735c30695c306f5c306e5c30615c306c5c305f5c30645c30655c30765c30655c306c5c306f5c30705c306d5c30655c306e5c30745c30065c30735c306b5c30695c306c5c306c5c30735c300a5c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30325c30315c300a5c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30325c30325c300a5c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30315c30345c300a5c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30315c30355c300a5c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30315c30365c300a5c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30315c30395c300a5c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30325c30305c30095c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30375c30095c304f5c304c5c30455c305f5c304c5c30495c304e5c304b5c30385c30165c30615c30645c30645c30695c30745c30695c306f5c306e5c30615c306c5c305f5c30695c306e5c30665c306f5c30725c306d5c30615c30745c30695c306f5c306e5c305c305c305c305c302d5c305c305c304d5c305c305c30655c305c305c307d5c305c305c30945c305c305c30a65c305c305c3026015c305c3039015c305c3061015c305c3061015c305c302b055c305c303f055c305c303f055c305c30b0055c305c30b0055c305c30d3055c305c30d3055c305c3015065c305c3015065c305c303d065c305c301e0a5c305c301e0a5c305c30360d5c305c307b0d5c305c307b0d5c305c30d70d5c305c30ff0d5c305c30ff0d5c305c30ff0d5c305c300a0e5c305c300a0e5c305c300a0e5c305c30900e5c305c30900e5c305c30af0f5c305c30af0f5c305c3067105c305c30ea105c305c305c305c305c305c30015c305c305c30025c305c305c30035c305c305c30045c305c305c30055c305c305c30065c305c305c30075c305c305c30085c305c305c30095c305c305c300a5c305c305c300b5c305c305c300c5c305c305c300d5c305c305c300e5c305c305c300f5c305c305c30105c305c305c30115c305c305c30125c305c305c30135c305c305c30145c305c305c30155c305c305c30165c305c305c30175c305c305c30185c305c305c30195c305c305c301a5c305c305c30255c305c305c301b5c305c305c301c5c305c305c301d5c305c305c301e5c305c305c301f5c305c305c30205c305c305c30215c305c305c305c225c305c305c30235c305c305c30245c305c305c30085c305c305c302d5c305c305c304d5c305c305c30655c305c305c307d5c305c305c30945c305c305c30a65c305c305c3026015c305c3039015c305c3089015c305c3089015c305c302b055c305c3058055c305c3058055c305c30bf055c305c30bf055c305c30df055c305c30df055c305c3025065c305c3025065c305c30db065c305c304e0b5c305c304e0b5c305c30360d5c305c30be0d5c305c30be0d5c305c30d70d5c305c30060e5c305c30990e5c305c30ae0f5c305c30ae0f5c305c30ae0f5c305c30ae0f5c305c30ae0f5c305c3067105c305c3067105c305c3067105c305c30a6105c305c30ea105c305c305c305c305c305c3077015c305c307a015c305c300f045c305c3012045c305c3017045c305c301e045c305c3024045c305c3028045c305c3029045c305c302d045c305c302e045c305c3032045c305c3057045c305c305a045c305c305b045c305c305f045c305c3060045c305c3062045c305c3063045c305c3065045c305c3066045c305c306a045c305c3098045c305c309d045c305c309e045c305c30a3045c305c30c1045c305c30c4045c305c30ca045c305c30d6045c305c30e5045c305c30ea045c305c3001055c305c3005055c305c3006055c305c300b055c305c3088055c305c308c055c305c309a055c305c309e055c305c30ff055c305c3003065c305c3004065c305c300c065c305c3052065c305c3055065c305c3056065c305c305a065c305c305b065c305c305d065c305c3062065c305c3069065c305c30f0065c305c30f3065c305c30f4065c305c30f8065c305c30f9065c305c30fb065c305c30fc065c305c30fe065c305c30ff065c305c3003075c305c305c5c075c305c305f075c305c3084075c305c308b075c305c3020085c305c3023085c305c3029085c305c3035085c305c3062085c305c306e085c305c30fa085c305c3001095c305c30a10b5c305c30aa0b5c305c30480c5c305c30530c5c305c305c220d5c305c30280d5c305c300f0e5c305c30120e5c305c30140e5c305c30190e5c305c30210e5c305c302b0e5c305c302d0e5c305c30300e5c305c30350e5c305c303b0e5c305c30470e5c305c30510e5c305c30570e5c305c305d0e5c305c305f0e5c305c30670e5c305c30720e5c305c30780e5c305c307a0e5c305c30800e5c305c30820e5c305c308c0e5c305c30900e5c305c30990e5c305c30a00e5c305c30a80e5c305c30a90e5c305c30ad0e5c305c30af0e5c305c30ba0e5c305c30bc0e5c305c30c30e5c305c30c60e5c305c30cf0e5c305c30f00e5c305c30f90e5c305c30160f5c305c301c0f5c305c30280f5c305c30310f5c305c303d0f5c305c30460f5c305c30610f5c305c30670f5c305c30690f5c305c306e0f5c305c30770f5c305c30800f5c305c30980f5c305c309e0f5c305c30df0f5c305c30e20f5c305c30a7105c305c30a7105c305c30a9105c305c30a9105c305c30aa105c305c30aa105c305c30ac105c305c30ad105c305c30af105c305c30b0105c305c30b2105c305c30b3105c305c30b9105c305c30ba105c305c30ea105c305c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c301c5c30075c30045c30075c30045c30025c30045c30075c30045c30075c30045c30075c30045c30075c30025c30075c305c305c305c305c301f045c305c3023045c305c307e045c305c3083045c305c30f2055c305c30f8055c305c3017075c305c3028075c305c301f095c305c3025095c305c30eb0b5c305c30f10b5c305c30480c5c305c30570c5c305c300f0d5c305c30160d5c305c30b20d5c305c30bd0d5c305c30a7105c305c30a7105c305c30a9105c305c30a9105c305c30aa105c305c30aa105c305c30ac105c305c30ad105c305c30af105c305c30b0105c305c30b2105c305c30b3105c305c30b9105c305c30ba105c305c30ea105c305c30075c30335c30075c30335c30075c30335c30075c30335c30075c30335c30075c30335c30075c30335c30075c30335c30075c30335c30075c30045c30075c30045c30025c30045c30075c30045c30075c30045c30075c30045c30075c30025c30075c305c305c305c305c300a5c305c305c300a5c305c305c30cb5c305c305c3011015c305c3046015c305c3055015c305c3061015c305c3062015c305c30f1015c305c3074025c305c3076025c305c30b0025c305c30b2025c305c30f4025c305c30f6025c305c303a035c305c303c035c305c3074035c305c3077035c305c30af035c305c30b1035c305c30e9035c305c30fa035c305c3041045c305c304c045c305c3054045c305c30ad045c305c30b1045c305c302b055c305c302b055c305c303d065c305c30da065c305c30e5065c305c30ef065c305c3017075c305c302e075c305c3031075c305c3031075c305c3060075c305c3005085c305c3007085c305c300b085c305c301f085c305c3020085c305c3036085c305c3036085c305c303f085c305c303f085c305c30a5085c305c30e9085c305c3025095c305c306e095c305c3084095c305c3084095c305c30df095c305c301f0a5c305c305d0b5c305c309f0b5c305c303c0e5c305c30670e5c305c309e0f5c305c30ad0f5c305c30ca0f5c305c30cb0f5c305c30a6105c305c30ea105c305c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30035c30045c30055c30015c305c305c30015c305c305c30ff0fff0fff0fff0fff0fff0fff0fff0fff0f5c305c30025c305c305c30025c305c305c30ff0fff0fff0fff0fff0fff0fff0fff0fff0f015c30035c305c305c30035c305c305c30ff0fff0fff0fff0fff0fff0fff0fff0fff0f015c30045c305c305c30045c305c305c30ff0fff0fff0fff0fff0fff0fff0fff0fff0f015c30055c305c305c30055c305c305c30ff0fff0fff0fff0fff0fff0fff0fff0fff0f015c30015c305c305c30ff5c305c305c305c305c305c305c305c305c305c30025c305c305c305c305c305c305c305c305c30185c305c300f84b001118450fe15c6055c30015c305c30065e84b001608450fe5c305c30015c305c305c30ff5c305c305c305c305c305c305c305c305c305c30025c305c305c305c305c305c305c305c305c30185c305c300f8440021184c0fd15c6055c30015c305c30065e8440026084c0fd5c305c30015c305c305c30ff5c305c305c305c305c305c305c305c305c305c30025c305c305c305c305c305c305c305c305c30185c305c300f84d002118430fd15c6055c30015c305c30065e84d002608430fd5c305c30015c305c305c30ff5c305c305c305c305c305c305c305c305c305c30025c305c305c305c305c305c305c305c305c30185c305c300f8460031184a0fc15c6055c30015c305c30065e8460036084a0fc5c305c30015c305c305c30ff5c305c305c305c305c305c305c305c305c305c30025c305c305c305c305c305c305c305c305c30185c305c300f84f003118410fc15c6055c30015c305c30065e84f003608410fc5c305c30015c305c305c30ff5c305c305c305c305c305c305c305c305c305c30025c305c305c305c305c305c305c305c305c30185c305c300f848004118480fb15c6055c30015c305c30065e848004608480fb5c305c30015c305c305c30ff5c305c305c305c305c305c305c305c305c305c30025c305c305c305c305c305c305c305c305c30185c305c300f8410051184f0fa15c6055c30015c305c30065e8410056084f0fa5c305c30015c305c305c30ff5c305c305c305c305c305c305c305c305c305c30025c305c305c305c305c305c305c305c305c30185c305c300f84a005118460fa15c6055c30015c305c30065e84a005608460fa5c305c30015c305c305c30ff5c305c305c305c305c305c305c305c305c305c30025c305c305c305c305c305c305c305c305c30185c305c300f8430061184d0f915c6055c30015c305c30065e8430066084d0f95c305c30015c305c305c30175c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c300c185c305c300f84d002118498fe15c6055c30015c305c30065e84d002608498fe4f4a015c30514a015c305e4a045c30015c30b7f0015c305c305c30175c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c300c185c305c300f84100e118498fe15c6055c30015c305c30065e84100e608498fe4f4a015c30514a015c30434a185c30015c30b7f0015c305c305c30175c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c3008185c305c300f84100e118498fe15c6055c30015c305c30065e84100e608498fe4f4a015c30514a015c30015c30b7f05c305c305c305c30175c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c3008185c305c300f84100e118498fe15c6055c30015c305c30065e84100e608498fe4f4a015c30514a015c30015c30b7f0055c305c305c30015c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30025c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30035c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30045c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30055c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30ffffffffffffffffffffffffffffffffffffffffffff055c305c305c305c305c30075c30575c30575c30385c304e5c30755c306d5c30325c30075c30575c30575c30385c304e5c30755c306d5c30335c30075c30575c30575c30385c304e5c30755c306d5c30345c30075c30575c30575c30385c304e5c30755c306d5c30355c30ffff055c305c305c305c305c305c305c305c305c305c305c305c305c301b5c305c305c30045c305c305c30085c305c305c30e55c305c305c305c305c305c305c301a5c305c305c30a66f055c30fe132f5c303f17375c3069483a5c305a0a3e5c3045113e5c30e839465c30ba18475c305d68485c30b84e4b5c307205565c302647615c30b36c645c308a066b5c308144905c305830935c30a639985c30b025b95c30a363bb5c308424bd5c30d358be5c30b262c65c30101dcc5c30bb46da5c30994dde5c30cc3adf5c303173e65c305c305c305c305c30a7105c305c30a9105c305c305c305c305c305c30015c305c305c30ff125c305c3007065c300c5c30125c30015c305c5c5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30255c305c305c305c305c30015c305c3008f91e5c305c30f91e5c305c3050435c305c30015c305c5c5c30400180015c303f075c305c303f075c305c305c30c8d905015c30015c303f075c305c305c305c305c305c303f075c305c305c305c305c305c3002585c305c305c305c305c305c305c305c30015c305c3021045c305c3021055c305c30f0065c305c30f0075c305c30d70d5c305c30e9105c305c30685c305c30085c305c305c305c30685c305c30145c30405c305c30685c305c300e5c305c305c305c30685c305c30205c30405c305c30685c305c30125c305c305c305c30685c305c30285c30405c305c30685c305c30685c30405c305c30ffff015c305c305c30075c30555c306e5c306b5c306e5c306f5c30775c306e5c30ffff015c30085c305c305c305c305c305c305c305c305c305c305c30ffff015c305c305c305c305c30ffff5c305c30025c30ffff5c305c305c305c30ffff5c305c30025c30ffff5c305c305c305c30105c305c305c30471e90015c305c3002020603050405020304ff2a5c30e041785c30c0095c305c305c305c305c305c305c30ff015c305c305c305c305c305c30545c30695c306d5c30655c30735c30205c304e5c30655c30775c30205c30525c306f5c306d5c30615c306e5c305c305c30351e9001025c30050501020107060205075c305c305c305c305c305c305c30105c305c305c305c305c305c305c305c305c305c305c30805c305c305c305c30535c30795c306d5c30625c306f5c306c5c305c305c30332e90015c305c30020b0604020202020204ff2a5c30e043785c30c0095c305c305c305c305c305c305c30ff015c305c305c305c305c305c30415c30725c30695c30615c306c5c305c305c30372e90015c305c30020f0502020204030204ff025c30e1ffac5c3040095c305c305c305c305c305c305c309f015c305c305c305c305c305c30435c30615c306c5c30695c30625c30725c30695c305c305c303f1e90015c305c3002020603050405020304035c305c30815c305c305c305c305c305c305c305c305c305c305c305c30015c30015c305c305c305c305c30415c306e5c30675c30735c30615c306e5c30615c30205c304e5c30655c30775c305c305c303b0e9001025c30055c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30105c305c305c305c305c305c305c305c305c305c305c30805c305c305c305c30575c30695c306e5c30675c30645c30695c306e5c30675c30735c305c305c303f3d90015c305c3002070309020205020404ff2a5c30e043785c30c0095c305c305c305c305c305c305c30ff015c305c305c305c305c305c30435c306f5c30755c30725c30695c30655c30725c30205c304e5c30655c30775c305c305c30372e90015c305c30020b0604030504040204ff065c30a15b205c3040105c305c305c305c305c305c305c309f015c305c305c305c305c305c30565c30655c30725c30645c30615c306e5c30615c305c305c30412e90015c305c30020b060302020202020487025c305c305c305c305c305c305c305c305c305c305c305c305c305c309f5c305c305c305c305c305c305c30545c30725c30655c30625c30755c30635c30685c30655c30745c30205c304d5c30535c305c305c30352e90015c305c30020b0604030504040204ff2e5c30e15b605c30c0295c305c305c305c305c305c305c30ff01015c305c305c305c305c30545c30615c30685c306f5c306d5c30615c305c305c305326900180105c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c304c5c30695c30625c30655c30725c30615c30745c30695c306f5c306e5c30205c30535c30615c306e5c30735c305c305c30415c30725c30695c30615c306c5c305c305c303f069001805c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30445c30655c306a5c30615c30565c30755c30205c30535c30615c306e5c30735c305c305c303b0690015c305c305c305c305c305c305c305c305c305c305c305c30075c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30135c305c305c305c305c305c305c30565c304e5c30495c302d5c30545c30695c306d5c30655c30735c305c305c30371e90015c305c300204060405050502030487025c305c305c305c305c305c305c305c305c305c305c305c305c305c309f5c305c305c305c305c305c305c30435c30655c306e5c30745c30755c30725c30795c305c305c30492e9001805c30020b0604020202020204ffaffff7ffffdfe93f5c305c305c305c305c305c305c30ff013f5c305c305c305c305c30415c30725c30695c30615c306c5c30205c30555c306e5c30695c30635c306f5c30645c30655c30205c304d5c30535c305c305c30411e90015c305c3002040503050406030204ef025c30a0eb205c30425c305c305c305c305c305c305c305c309f015c305c305c305c305c305c30435c30615c306d5c30625c30725c30695c30615c30205c304d5c30615c30745c30685c305c305c305c225c30045c30010888185c30f0d0025c305c3068015c305c305c305c30bb35fa86b4550a67580bc746125c30145c305c305c307c025c305c302b0e5c305c30045c30085c305c305c30045c3083901e5c305c305c307c025c305c302b0e5c305c30045c30085c305c305c301e5c305c305c305c305c305c305c3021035c30f0105c305c305c30015c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c3012305c305c305c305c305c305c305c305c305c305c305c305c305c305c309f105c305c309f105c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30025c305c305c305c305c305c305c305c305c305c303283515c30f0105c30085c30fffd015c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c300808505c305c305c305c305c30f05c305c3001085c305c305c305c305c305c305c305c30ffffff7fffffff7fffffff7fffffff7fffffff7fffffff7fffffff7f3173e65c305c30045c305c30b25c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c3021045c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30101c5c305c300f5c305c305c305c305c305c305c305c305c30785c305c305c30785c305c305c305c305c305c305c305c305c305c305c30a0055c305c30ffff125c305c305c305c305c305c305c30115c30455c30585c30455c30435c30555c30545c30495c30565c30455c30205c30505c30525c304f5c30465c30495c304c5c30455c305c305c305c305c305c305c30045c30555c30735c30655c30725c30045c30435c30615c306e5c30685c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30205c305c305c30065c305c305c30055c305c305c305c305c300c5c30015c300c5c30025c300c5c30035c300c5c30045c300c5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30feff5c305c300601025c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30015c305c305c30e0859ff2f94f6810ab91085c302b5c27b3d9305c305c305c307c015c305c30115c305c305c30015c305c305c30905c305c305c30025c305c305c30985c305c305c30035c305c305c30b45c305c305c30045c305c305c30c05c305c305c30055c305c305c30d05c305c305c30075c305c305c30dc5c305c305c30085c305c305c30f05c305c305c30095c305c305c305c30015c305c30125c305c305c300c015c305c300a5c305c305c302c015c305c300b5c305c305c3038015c305c300c5c305c305c3044015c305c300d5c305c305c3050015c305c300e5c305c305c305c5c015c305c300f5c305c305c3064015c305c30105c305c305c306c015c305c30135c305c305c3074015c305c30025c305c305c30e4045c305c301e5c305c305c30145c305c305c304558454355544956452050524f46494c455c305c305c301e5c305c305c30045c305c305c305c305c305c305c301e5c305c305c30085c305c305c30557365725c305c305c305c301e5c305c305c30045c305c305c305c305c305c305c301e5c305c305c300c5c305c305c304e6f726d616c2e646f746d5c301e5c305c305c30085c305c305c3043616e685c305c305c305c301e5c305c305c30045c305c305c3031385c305c301e5c305c305c30185c305c305c304d6963726f736f6674204f666669636520576f72645c305c305c30405c305c305c305c307841cb025c305c305c30405c305c305c305c30408e0c43dbc801405c305c305c305c307a8edc4084cc01405c305c305c305c30100f2fffa6cd01035c305c305c30045c305c305c30035c305c305c307c025c305c30035c305c305c302b0e5c305c30035c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30feff5c305c300601025c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30025c305c305c3002d5cdd59c2e1b109397085c302b2cf9ae445c305c305c3005d5cdd59c2e1b109397085c302b2cf9ae40015c305c30fc5c305c305c300c5c305c305c30015c305c305c30685c305c305c300f5c305c305c30705c305c305c30055c305c305c30805c305c305c30065c305c305c30885c305c305c30115c305c305c30905c305c305c30175c305c305c30985c305c305c300b5c305c305c30a05c305c305c30105c305c305c30a85c305c305c30135c305c305c30b05c305c305c30165c305c305c30b85c305c305c300d5c305c305c30c05c305c305c300c5c305c305c30de5c305c305c30025c305c305c30e4045c305c301e5c305c305c30085c305c305c30504f50535c305c305c305c30035c305c305c301e5c305c305c30035c305c305c30085c305c305c30035c305c305c309f105c305c30035c305c305c305c305c300c5c300b5c305c305c305c305c305c305c300b5c305c305c305c305c305c305c300b5c305c305c305c305c305c305c300b5c305c305c305c305c305c305c301e105c305c30015c305c305c30125c305c305c304558454355544956452050524f46494c455c300c105c305c30025c305c305c301e5c305c305c30065c305c305c305469746c655c30035c305c305c30015c305c305c304c065c305c30035c305c305c305c305c305c305c30205c305c305c30015c305c305c30385c305c305c30025c305c305c30405c305c305c30015c305c305c30025c305c305c300c5c305c305c305f5049445f484c494e4b535c30025c305c305c30e4045c305c30415c305c305c3004065c305c305a5c305c305c30035c305c305c30095c305c5c5c30035c305c305c302a5c305c305c30035c305c305c305c305c305c305c30035c305c305c30055c305c305c301f5c305c305c301a5c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30775c30775c30775c302e5c30765c30695c30705c30735c30655c30615c30725c30635c30685c302e5c30635c306f5c306d5c302f5c305c305c301f5c305c305c30015c305c305c305c305c302508035c305c305c30455c30595c30035c305c305c305c275c305c305c30035c305c305c305c305c305c305c30035c305c305c30055c305c305c301f5c305c305c30195c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30775c30775c30775c302e5c306e5c30685c30615c306e5c30765c30695c30655c30745c302e5c30635c306f5c306d5c302f5c305c305c305c305c301f5c305c305c30015c305c305c305c305c302508035c305c305c30135c305d5c30035c305c305c30245c305c305c30035c305c305c305c305c305c305c30035c305c305c30055c305c305c301f5c305c305c301d5c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30735c306f5c30725c30745c30695c30725c30735c30615c306e5c30735c30615c306c5c30635c306f5c306f5c306c5c302e5c30635c306f5c306d5c302f5c305c305c305c305c301f5c305c305c30015c305c305c305c305c302508035c305c305c307e5c306b5c30035c305c305c30215c305c305c30035c305c305c305c305c305c305c30035c305c305c30055c305c305c301f5c305c305c301b5c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30775c30775c30775c302e5c30735c306f5c30665c30615c30635c306f5c306e5c30635c30655c30705c30745c302e5c30665c30725c302f5c305c305c305c305c301f5c305c305c30015c305c305c305c305c302508035c305c305c30475c30025c30035c305c305c301e5c305c305c30035c305c305c305c305c305c305c30035c305c305c30055c305c305c301f5c305c305c30165c305c305c30685c30745c30745c30705c303a5c302f5c302f5c306d5c30675c30615c306d5c30655c302e5c30705c306f5c30705c30735c302e5c30765c306e5c302f5c305c305c301f5c305c305c30015c305c305c305c305c302508035c305c305c304d5c304a5c30035c305c305c301b5c305c305c30035c305c305c305c305c305c305c30035c305c305c30055c305c305c301f5c305c305c30155c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30675c30615c306d5c30655c302e5c30705c306f5c30705c30735c302e5c30765c306e5c302f5c305c305c305c305c301f5c305c305c30015c305c305c305c305c302508035c305c305c30385c303f5c30035c305c305c30185c305c305c30035c305c305c305c305c305c305c30035c305c305c30055c305c305c301f5c305c305c30145c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30735c30715c30755c30655c30655c30645c30795c302e5c30635c306f5c306d5c302f5c305c305c301f5c305c305c30015c305c305c305c305c302508035c305c305c30175c30025c30035c305c305c30155c305c305c30035c305c305c305c305c305c305c30035c305c305c30055c305c305c301f5c305c305c30155c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30335c30365c30305c30645c306f5c30635c30755c306f5c30695c302e5c30765c306e5c302f5c305c305c305c305c301f5c305c305c30015c305c305c305c305c302508035c305c305c304e5c300a5c30035c305c305c30125c305c305c30035c305c305c305c305c305c305c30035c305c305c30055c305c305c301f5c305c305c30155c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30645c306f5c30645c306f5c30675c30725c306f5c30755c30705c302e5c30765c306e5c302f5c305c305c305c305c301f5c305c305c30015c305c305c305c305c302508035c305c305c307e5c306b5c30035c305c305c300f5c305c305c30035c305c305c305c305c305c305c30035c305c305c30055c305c305c301f5c305c305c301b5c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30775c30775c30775c302e5c30735c306f5c30665c30615c30635c306f5c306e5c30635c30655c30705c30745c302e5c30665c30725c302f5c305c305c305c305c301f5c305c305c30015c305c305c305c305c302508035c305c305c30405c30025c30035c305c305c300c5c305c305c30035c305c305c305c305c305c305c30035c305c305c30055c305c305c301f5c305c305c301a5c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30675c306f5c306c5c30665c302d5c30665c30615c30695c30725c30775c30615c30795c30735c302e5c30635c306f5c306d5c302f5c305c305c301f5c305c305c30015c305c305c305c305c302508035c305c305c30505c305c5c5c30035c305c305c30095c305c305c30035c305c305c305c305c305c305c30035c305c305c30055c305c305c301f5c305c305c30165c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30765c30695c30705c30735c30655c30615c30725c30635c30685c302e5c30635c306f5c306d5c302f5c305c305c301f5c305c305c30015c305c305c305c305c302508035c305c305c30505c30415c30035c305c305c30065c305c305c30035c305c305c305c305c305c305c30035c305c305c30055c305c305c301f5c305c305c30195c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30775c30775c30775c302e5c306e5c30765c306d5c30675c30725c306f5c30755c30705c302e5c30635c306f5c306d5c302f5c305c305c305c305c301f5c305c305c30015c305c305c305c305c302508035c305c305c304e5c304c5c30035c305c305c30035c305c305c30035c305c305c305c305c305c305c30035c305c305c30055c305c305c301f5c305c305c30195c305c305c30685c30745c30745c30705c303a5c302f5c302f5c30695c30645c306d5c302e5c30765c306e5c302f5c30615c306e5c30615c306c5c30795c30745c30695c30635c30735c302f5c305c305c305c305c301f5c305c305c30015c305c305c305c305c302508035c305c305c30075c303a5c30035c305c305c305c305c305c305c30035c305c305c305c305c305c305c30035c305c305c30055c305c305c301f5c305c305c301f5c305c305c306d5c30615c30695c306c5c30745c306f5c303a5c30705c30685c30615c306e5c30645c30755c30795c30635c30615c306e5c30685c30365c30395c30405c30675c306d5c30615c30695c306c5c302e5c30635c306f5c306d5c305c305c305c305c301f5c305c305c30015c305c305c305c305c3025085c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30015c305c305c30025c305c305c30035c305c305c30045c305c305c30055c305c305c30065c305c305c30075c305c305c30085c305c305c30095c305c305c300a5c305c305c300b5c305c305c300c5c305c305c300d5c305c305c300e5c305c305c300f5c305c305c30105c305c305c30115c305c305c30125c305c305c30135c305c305c30145c305c305c30155c305c305c30165c305c305c30175c305c305c30185c305c305c30195c305c305c301a5c305c305c301b5c305c305c301c5c305c305c301d5c305c305c301e5c305c305c301f5c305c305c30205c305c305c30feffffff5c225c305c305c30235c305c305c30245c305c305c30255c305c305c30265c305c305c305c275c305c305c30285c305c305c30feffffff2a5c305c305c302b5c305c305c302c5c305c305c302d5c305c305c302e5c305c305c302f5c305c305c30305c305c305c30315c305c305c30325c305c305c30335c305c305c30345c305c305c30355c305c305c30365c305c305c30375c305c305c30385c305c305c30395c305c305c303a5c305c305c303b5c305c305c303c5c305c305c303d5c305c305c303e5c305c305c303f5c305c305c30405c305c305c30415c305c305c30425c305c305c30435c305c305c30445c305c305c30455c305c305c30465c305c305c30475c305c305c30485c305c305c30495c305c305c304a5c305c305c304b5c305c305c304c5c305c305c304d5c305c305c304e5c305c305c30feffffff505c305c305c30515c305c305c30525c305c305c30535c305c305c30545c305c305c30555c305c305c30565c305c305c30feffffff585c305c305c30595c305c305c305a5c305c305c305b5c305c305c305c5c5c305c305c305d5c305c305c305e5c305c305c30fefffffffdffffff615c305c305c30fefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff525c306f5c306f5c30745c30205c30455c306e5c30745c30725c30795c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30165c300501ffffffffffffffff035c305c305c300609025c305c305c305c305c30c05c305c305c305c305c305c30465c305c305c305c305c305c305c305c305c305c305c305c30606ec730ffa6cd01635c305c305c30805c305c305c305c305c305c305c30445c30615c30745c30615c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c300a5c300201ffffffffffffffffffffffff5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30215c305c305c305c30105c305c305c305c305c305c30315c30545c30615c30625c306c5c30655c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c300e5c300201015c305c305c30065c305c305c30ffffffff5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30295c305c305c309a4b5c305c305c305c305c305c30575c306f5c30725c30645c30445c306f5c30635c30755c306d5c30655c306e5c30745c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c301a5c300201025c305c305c30055c305c305c30ffffffff5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c302e405c305c305c305c305c305c30055c30535c30755c306d5c306d5c30615c30725c30795c30495c306e5c30665c306f5c30725c306d5c30615c30745c30695c306f5c306e5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30285c300201ffffffffffffffffffffffff5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c304f5c305c305c305c30105c305c305c305c305c305c30055c30445c306f5c30635c30755c306d5c30655c306e5c30745c30535c30755c306d5c306d5c30615c30725c30795c30495c306e5c30665c306f5c30725c306d5c30615c30745c30695c306f5c306e5c305c305c305c305c305c305c305c305c305c305c30385c300201045c305c305c30ffffffffffffffff5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30575c305c305c305c30105c305c305c305c305c305c30015c30435c306f5c306d5c30705c304f5c30625c306a5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30125c30025c30ffffffffffffffffffffffff5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30795c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30ffffffffffffffffffffffff5c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30015c305c305c30feffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff015c30feff030a5c305c30ffffffff0609025c305c305c305c305c30c05c305c305c305c305c305c30465c275c305c305c304d6963726f736f6674204f666669636520576f72642039372d3230303320446f63756d656e745c300a5c305c305c304d53576f7264446f635c30105c305c305c30576f72642e446f63756d656e742e385c30f439b2715c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c305c30, 'Phan Duy Canh.doc', 'application/msword', 51712);

-- --------------------------------------------------------

--
-- Table structure for table `role_lookup`
--

CREATE TABLE IF NOT EXISTS `role_lookup` (
  `role_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `department_id` tinyint(3) unsigned NOT NULL,
  `role_type` enum('Consultant','Operation') DEFAULT NULL,
  `level` tinyint(3) unsigned DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`role_id`),
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
-- Table structure for table `session`
--

CREATE TABLE IF NOT EXISTS `session` (
  `id` char(32) NOT NULL DEFAULT '',
  `modified` int(11) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `data` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `session`
--

INSERT INTO `session` (`id`, `modified`, `lifetime`, `data`) VALUES
('asal8u3eblhn3ih35a9j2jlrh1', 1352470411, 900, ''),
('4hsm7hs7vpmmfg5fjt7idn7fn5', 1353254223, 900, 'zs_User|a:7:{s:13:"consultant_id";s:1:"1";s:8:"username";s:7:"duycanh";s:5:"email";s:23:"phanduycanh69@gmail.com";s:5:"phone";s:10:"0939693990";s:7:"isAdmin";s:1:"1";s:7:"islogin";i:1;s:8:"fullname";s:21:"Mr. Phan Duy Canh1122";}export-email|s:130:"SELECT r.*, f.id as file_resume FROM resume as r LEFT JOIN res_file as f ON r.resume_id = f.resume_id  ORDER BY  updated_date DESC";'),
('jgbm4rd6cav6bg8rkfbeoi7mv4', 1353121465, 900, 'zs_User|a:7:{s:13:"consultant_id";s:1:"1";s:8:"username";s:7:"duycanh";s:5:"email";s:23:"phanduycanh69@gmail.com";s:5:"phone";s:10:"0939693990";s:7:"isAdmin";s:1:"1";s:7:"islogin";i:1;s:8:"fullname";s:21:"Mr. Phan Duy Canh1122";}export-email|s:130:"SELECT r.*, f.id as file_resume FROM resume as r LEFT JOIN res_file as f ON r.resume_id = f.resume_id  ORDER BY  updated_date DESC";');

-- --------------------------------------------------------

--
-- Table structure for table `short_list`
--

CREATE TABLE IF NOT EXISTS `short_list` (
  `short_list_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`short_list_id`),
  KEY `FK_consultant_20` (`consultant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sl_has_resume`
--

CREATE TABLE IF NOT EXISTS `sl_has_resume` (
  `sl_resume_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `short_list_id` int(10) unsigned NOT NULL,
  `resume_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sl_resume_id`),
  KEY `FK_short_list_1` (`short_list_id`),
  KEY `FK_resume_11` (`resume_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `vacancy`
--

CREATE TABLE IF NOT EXISTS `vacancy` (
  `vacancy_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned NOT NULL,
  `vacancy_code` varchar(11) NOT NULL,
  `job_title` varchar(100) NOT NULL,
  `no_of_vacancies` tinyint(3) unsigned DEFAULT NULL,
  `displayed_salary` enum('Negotiable','Around','Up to','Above','Range') NOT NULL,
  `min_salary` double(7,2) unsigned DEFAULT NULL,
  `max_salary` double(7,2) unsigned DEFAULT NULL,
  `estimated_salary` double(7,2) unsigned NOT NULL,
  `priority` enum('Urgent','High','Meidum','Low') NOT NULL,
  `work_level_id` tinyint(3) unsigned NOT NULL,
  `public` enum('Yes','No') NOT NULL,
  `online_view_count` int(10) unsigned NOT NULL DEFAULT '0',
  `applied_count` int(10) unsigned NOT NULL DEFAULT '0',
  `status` enum('Open','Hidden','Closed','Archived') NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  PRIMARY KEY (`vacancy_id`),
  KEY `FK_work_level_lookup_1` (`work_level_id`),
  KEY `FK_company_1` (`company_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `vacancy`
--

INSERT INTO `vacancy` (`vacancy_id`, `company_id`, `vacancy_code`, `job_title`, `no_of_vacancies`, `displayed_salary`, `min_salary`, `max_salary`, `estimated_salary`, `priority`, `work_level_id`, `public`, `online_view_count`, `applied_count`, `status`, `created_date`, `updated_date`) VALUES
(1, 1, 'V1', 'Call Center Manager Vietnam', 1, 'Negotiable', 1000.00, 2000.00, 500.00, 'Urgent', 1, 'Yes', 0, 0, 'Open', '2012-11-15 22:57:42', '2012-11-15 22:57:42'),
(2, 1, 'V2', 'Analytics Bussness', 4, 'Negotiable', 1000.00, 2000.00, 1000.00, 'Urgent', 1, 'Yes', 0, 0, 'Open', '2012-11-15 23:47:48', '2012-11-15 23:47:48');

-- --------------------------------------------------------

--
-- Table structure for table `va_details`
--

CREATE TABLE IF NOT EXISTS `va_details` (
  `va_va_details_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vacancy_id` int(10) unsigned NOT NULL,
  `desc_reqs` text NOT NULL,
  PRIMARY KEY (`va_va_details_id`),
  KEY `FK_vacancy_6` (`vacancy_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `va_details`
--

INSERT INTO `va_details` (`va_va_details_id`, `vacancy_id`, `desc_reqs`) VALUES
(1, 1, 'tétt'),
(2, 2, 'tréyyyi bjhkjb');

-- --------------------------------------------------------

--
-- Table structure for table `va_has_consultant`
--

CREATE TABLE IF NOT EXISTS `va_has_consultant` (
  `va_consultant_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vacancy_id` int(10) unsigned NOT NULL,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `inchange_type` enum('Main','Supporting') NOT NULL,
  `status` enum('Active','Inactive') NOT NULL,
  PRIMARY KEY (`va_consultant_id`),
  KEY `FK_consultant_2` (`consultant_id`),
  KEY `FK_vacancy_1` (`vacancy_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `va_has_consultant`
--

INSERT INTO `va_has_consultant` (`va_consultant_id`, `vacancy_id`, `consultant_id`, `inchange_type`, `status`) VALUES
(1, 1, 1, 'Main', 'Active'),
(2, 2, 1, 'Main', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `va_has_function`
--

CREATE TABLE IF NOT EXISTS `va_has_function` (
  `va_function_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `function_id` tinyint(3) unsigned NOT NULL,
  `vacancy_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`va_function_id`),
  KEY `FK_function_lookup_1` (`function_id`),
  KEY `FK_vacancy_3` (`vacancy_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `va_has_function`
--

INSERT INTO `va_has_function` (`va_function_id`, `function_id`, `vacancy_id`) VALUES
(1, 2, 2),
(2, 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `va_has_location`
--

CREATE TABLE IF NOT EXISTS `va_has_location` (
  `va_location_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vacancy_id` int(10) unsigned NOT NULL,
  `province_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`va_location_id`),
  KEY `FK_vacancy_4` (`vacancy_id`),
  KEY `FK_province_lookup_1` (`province_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `va_has_location`
--

INSERT INTO `va_has_location` (`va_location_id`, `vacancy_id`, `province_id`) VALUES
(1, 2, 1),
(2, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `va_process_history`
--

CREATE TABLE IF NOT EXISTS `va_process_history` (
  `va_process_history_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vacancy_id` int(10) unsigned NOT NULL,
  `consultant_id` smallint(5) unsigned NOT NULL,
  `action_date` date NOT NULL,
  `status` enum('Open','Hidden','Closed') NOT NULL,
  PRIMARY KEY (`va_process_history_id`),
  KEY `FK_vacancy_2` (`vacancy_id`),
  KEY `FK_consultant_6` (`consultant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `work_level_lookup`
--

CREATE TABLE IF NOT EXISTS `work_level_lookup` (
  `work_level_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`work_level_id`)
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
-- Constraints for table `contact_person`
--
ALTER TABLE `contact_person`
  ADD CONSTRAINT `FK_company_3` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`) ON DELETE CASCADE;

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
-- Constraints for table `res_comment`
--
ALTER TABLE `res_comment`
  ADD CONSTRAINT `FK_consultant_21` FOREIGN KEY (`consultant_id`) REFERENCES `consultant` (`consultant_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_resume_12` FOREIGN KEY (`resume_id`) REFERENCES `resume` (`resume_id`) ON DELETE CASCADE;

--
-- Constraints for table `res_experience`
--
ALTER TABLE `res_experience`
  ADD CONSTRAINT `res_experience_ibfk_1` FOREIGN KEY (`resume_id`) REFERENCES `resume` (`resume_id`);

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
