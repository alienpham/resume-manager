-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost


--
-- Table structure for table `company_comment`
--

CREATE TABLE IF NOT EXISTS `vacancy_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vacancy_id` int(10) NOT NULL,
  `consultant_id` int(11) NOT NULL,
  `content` text,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `vacancy_id` (`vacancy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

