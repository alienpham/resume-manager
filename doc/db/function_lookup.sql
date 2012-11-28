-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 28, 2012 at 06:59 PM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=68 ;

--
-- Dumping data for table `function_lookup`
--

INSERT INTO `function_lookup` (`function_id`, `name`, `parent_function_id`, `sort_order`) VALUES
(1, 'Accounting/Finance/Banking', 0, 1),
(2, 'Banking', 1, 2),
(3, 'Accounting', 1, 3),
(4, 'Auditing', 1, 4),
(5, 'Finance/Investment', 1, 5),
(6, 'Securities & Trading', 1, 6),
(7, 'Insurance', 1, 7),
(8, 'Hospitality & Tourism', 0, 8),
(9, 'Airlines/Tourism/Hotel', 8, 9),
(10, 'Food/Beverage', 8, 10),
(11, 'Engineering', 0, 11),
(12, 'Electrical/Electronics', 11, 12),
(13, 'Mechanical', 11, 13),
(14, 'Chemical/Biochemical', 11, 14),
(15, 'Environment/Waste Services', 11, 15),
(16, 'Services', 0, 16),
(17, 'NGO/Non-Profit', 16, 17),
(18, 'Education/Training', 16, 18),
(19, 'Health/Medical Care', 16, 19),
(20, 'Consulting', 16, 20),
(21, 'Supply chain service', 0, 21),
(22, 'Freight/Logistics', 21, 22),
(23, 'Warehouse', 21, 23),
(24, 'Back Office', 0, 24),
(25, 'Administrative/Clerical', 24, 25),
(26, 'Human Resources', 24, 26),
(27, 'Interpreter/Translator', 24, 27),
(28, 'Legal/Contracts', 24, 28),
(29, 'Technology', 0, 29),
(30, 'IT - Hardware/Networking', 29, 30),
(31, 'IT - Software', 29, 31),
(32, 'Production', 0, 32),
(33, 'Export-Import', 32, 33),
(34, 'QA/QC', 32, 34),
(35, 'Production/Process', 32, 35),
(36, 'Purchasing/Supply Chain', 32, 36),
(37, 'Planning/Projects', 32, 37),
(38, 'Building & Construction', 0, 38),
(39, 'Civil/Construction', 38, 39),
(40, 'Architecture/Interior Design', 38, 40),
(41, 'Real Estate', 38, 41),
(42, 'Communications & Media', 0, 42),
(43, 'Telecommunications', 42, 43),
(44, 'TV/Media/Newspaper', 42, 44),
(45, 'Arts/Design', 42, 45),
(46, 'Internet/Online Media', 42, 46),
(47, 'Sales', 0, 47),
(48, 'Sales - Consumer Goods', 47, 48),
(49, 'Sales - Services', 47, 49),
(50, 'Sales - Technical', 47, 50),
(51, 'Sales Support / Assistance', 47, 51),
(52, 'Wholesale / Reselling Sales', 47, 52),
(53, 'Others', 47, 53),
(54, 'Advertising / Marketing / Product', 0, 54),
(55, 'Advertising', 54, 55),
(56, 'Copy Writing / Editing', 54, 56),
(57, 'Marketing', 54, 57),
(58, 'Media Planning and Buying', 54, 58),
(59, 'Public Relations', 54, 59),
(60, 'Others', 54, 60),
(61, 'Industrial', 0, 61),
(62, 'Oil/Gas', 61, 62),
(63, 'Textiles/Garments/Footwear', 61, 63),
(64, 'Pharmaceutical/Biotech', 61, 64),
(65, 'Automotive', 61, 65),
(66, 'Agriculture/Forestry', 61, 66),
(67, 'Others', 61, 67);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
