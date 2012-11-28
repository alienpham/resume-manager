-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 28, 2012 at 03:51 PM
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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
