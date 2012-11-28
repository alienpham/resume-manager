-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 28, 2012 at 04:47 PM
-- Server version: 5.1.45-community
-- PHP Version: 5.3.17

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
-- Table structure for table `function_lookup`
--

CREATE TABLE IF NOT EXISTS `function_lookup` (
  `function_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `parent_function_id` tinyint(3) unsigned DEFAULT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`function_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=203 ;

--
-- Dumping data for table `function_lookup`
--

INSERT INTO `function_lookup` (`function_id`, `name`, `parent_function_id`, `sort_order`) VALUES
(136, 'Accounting/Finance/Banking', 0, 1),
(137, 'Banking', 0, 2),
(138, 'Accounting', 0, 3),
(139, 'Auditing', 0, 1),
(140, 'Finance/Investment', 0, 2),
(141, 'Securities & Trading', 0, 2),
(142, 'Insurance', 0, 3),
(143, 'Hospitality & Tourism', 1, 1),
(144, 'Airlines/Tourism/Hotel', 1, 2),
(145, 'Food/Beverage', 1, 3),
(146, 'Engineering', 2, 1),
(147, 'Electrical/Electronics', 2, 2),
(148, 'Mechanical', 2, 3),
(149, 'Chemical/Biochemical ', 2, 4),
(150, 'Environment/Waste Services', 2, 5),
(151, 'Services', 3, 1),
(152, 'Consulting', 3, 2),
(153, 'NGO/Non-Profit', 3, 3),
(154, 'Education/Training', 3, 4),
(155, 'Health/Medical Care', 3, 5),
(156, 'Supply chain service', 4, 1),
(157, 'Freight/Logistics', 4, 2),
(158, 'Warehouse', 4, 3),
(159, 'Back Office', 5, 1),
(160, 'Administrative/Clerical', 5, 2),
(161, 'Human Resources', 5, 3),
(162, 'Interpreter/Translator', 5, 4),
(163, 'Interpreter/Translator', 5, 5),
(164, 'Technology', 6, 1),
(165, 'IT - Hardware/Networking', 6, 2),
(166, 'IT - Software', 6, 3),
(167, 'Production', 7, 1),
(168, 'Export-Import', 7, 2),
(169, 'QA/QC', 7, 3),
(170, 'Production/Process', 7, 4),
(171, 'Purchasing/Supply Chain', 7, 5),
(172, 'Planning/Projects', 7, 6),
(173, 'Building & Construction', 8, 1),
(174, 'Civil/Construction', 8, 2),
(175, 'Architecture/Interior Design', 8, 3),
(176, 'Real Estate', 8, 4),
(177, 'Communications & Media', 9, 1),
(178, 'Telecommunications', 9, 2),
(179, 'TV/Media/Newspaper', 9, 3),
(180, 'Arts/Design', 9, 4),
(181, 'Internet/Online Media', 9, 5),
(182, 'Sales', 10, 1),
(183, 'Sales - Consumer Goods', 10, 2),
(184, 'Sales - Services', 10, 3),
(185, 'Sales - Technical', 10, 4),
(186, 'Sales Support / Assistance', 10, 5),
(187, 'Wholesale / Reselling Sales', 10, 6),
(188, 'Others', 10, 7),
(189, 'Advertising / Marketing / Product', 11, 1),
(190, 'Advertising', 11, 2),
(191, 'Copy Writing / Editing', 11, 3),
(192, 'Marketing', 11, 4),
(193, 'Media Planning and Buying', 11, 5),
(194, 'Public Relations', 11, 6),
(195, 'Others', 11, 7),
(196, 'Industrial', 12, 1),
(197, 'Oil/Gas', 12, 2),
(198, 'Textiles/Garments/Footwear', 12, 3),
(199, 'Pharmaceutical/Biotech', 12, 4),
(200, 'Automotive', 12, 5),
(201, 'Agriculture/Forestry', 12, 6),
(202, 'Others', 12, 7);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
