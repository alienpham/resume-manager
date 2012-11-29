-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 26, 2012 at 12:46 PM
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
-- Table structure for table `vacancy`
--

CREATE TABLE IF NOT EXISTS `vacancy` (
  `vacancy_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) NOT NULL,
  `job_title` varchar(100) DEFAULT NULL,
  `min_salary` double(7,2) unsigned DEFAULT NULL,
  `max_salary` double(7,2) unsigned DEFAULT NULL,
  `priority` enum('Urgent','High','Medium','Low') NOT NULL,
  `work_level` varchar(255) DEFAULT NULL,
  `function` varchar(255) DEFAULT NULL,
  `location` text,
  `desc_reqs` text,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  PRIMARY KEY (`vacancy_id`),
  KEY `FK_work_level_lookup_1` (`work_level`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `vacancy`
--

ALTER TABLE  `vacancy` CHANGE  `priority`  `priority` CHAR( 20 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL

ALTER TABLE `vacancy` ADD `consultant_id` INT NOT NULL AFTER `vacancy_id` 