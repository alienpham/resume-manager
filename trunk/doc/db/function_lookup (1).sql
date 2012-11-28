-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 28, 2012 at 06:02 PM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=220 ;

--
-- Dumping data for table `function_lookup`
--

INSERT INTO `function_lookup` (`function_id`, `name`, `parent_function_id`, `sort_order`) VALUES
(203, 'Accounting/Finance/Banking', 0, 0),
(218, 'Banking', 203, 1),
(219, 'Accounting', 203, 2);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
