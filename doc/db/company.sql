-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 27, 2012 at 08:15 PM
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
-- Table structure for table `company`
--

CREATE TABLE IF NOT EXISTS `company` (
  `company_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) DEFAULT NULL,
  `busines_type` varchar(255) DEFAULT NULL,
  `tel` varchar(30) DEFAULT NULL,
  `fax` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  `website` varchar(100) DEFAULT NULL,
  `status` enum('Active','Deleted') NOT NULL DEFAULT 'Active',
  `information` text,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`company_id`, `company_name`, `busines_type`, `tel`, `fax`, `email`, `address`, `website`, `status`, `information`, `created_date`, `updated_date`) VALUES
(5, 'saf', NULL, '', '', '', '', '', 'Active', NULL, '2012-11-20 00:15:51', '2012-11-20 00:22:53'),
(6, 'abcd', NULL, '123456789', '123456789', '123456789@yahoo.com', '113 hcm', 'www.hoathien.com.vn', 'Active', 'an nhau', '2012-11-22 00:00:00', '2012-11-23 00:00:00'),
(9, 'test', NULL, 'tstestest', 'testset', 'thanhgiang_cm2005@yahoo.com', 'test', 'test', 'Active', 'setset', '2012-11-27 00:00:00', '2012-11-27 00:00:00'),
(11, 'thuan phat', 'abcd', '', '', '', '', '', 'Active', '', '2012-11-27 00:00:00', '2012-11-27 00:00:00');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
