-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 13, 2012 at 05:08 PM
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
-- Table structure for table `contact_person`
--

CREATE TABLE IF NOT EXISTS `contact_person` (
  `contact_person_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned NOT NULL,
  `title` enum('Mr.','Mrs.','Ms.') NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `job_title` varchar(100) NOT NULL,
  `tel` varchar(30) DEFAULT NULL,
  `fax` varchar(30) DEFAULT NULL,
  `mobile` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`contact_person_id`),
  KEY `FK_company_3` (`company_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `contact_person`
--

INSERT INTO `contact_person` (`contact_person_id`, `company_id`, `title`, `full_name`, `job_title`, `tel`, `fax`, `mobile`, `email`, `address`) VALUES
(1, 1, 'Mr.', '', '', '', '', '', '', ''),
(2, 1, 'Mr.', 'eqeq', 'eqeqwe', '', '', '', '', ''),
(3, 1, 'Mr.', 'dwadwa', 'dadwadwa', '', '', '', '', ''),
(4, 1, 'Mr.', 'dawdwa', 'dwadwa', '', '', '', '', ''),
(5, 1, 'Mr.', '', '', '', '', '', '', ''),
(6, 1, 'Mr.', '', '', '', '', '', '', ''),
(7, 1, 'Mr.', '', '', '', '', '', '', ''),
(8, 1, 'Mr.', 'fesfesf', 'sefsfsfsef', '', '', '', 'thanhgiang_cm2005@yahoo.com', ''),
(9, 1, 'Mr.', 'phan thanh giang', 'developer', '0939161966', 'khong co', '0939161966', 'thanhgiang_cm2005@yahoo.com', '');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contact_person`
--
ALTER TABLE `contact_person`
  ADD CONSTRAINT `FK_company_3` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
