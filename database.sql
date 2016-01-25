-- phpMyAdmin SQL Dump
-- version 3.3.10.4
-- http://www.phpmyadmin.net
--

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `locationbot`
--

-- --------------------------------------------------------

--
-- Table structure for table `ActionTracking`
--

CREATE TABLE IF NOT EXISTS `ActionTracking` (
  `rec_id` int(11) NOT NULL AUTO_INCREMENT,
  `thing_id` varchar(16) NOT NULL,
  `action_type` varchar(64) NOT NULL,
  `action_description` varchar(256) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `username` varchar(32) NOT NULL,
  PRIMARY KEY (`rec_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=546 ;

-- --------------------------------------------------------

--
-- Table structure for table `Location`
--

CREATE TABLE IF NOT EXISTS `Location` (
  `rec_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rec_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=296 ;

-- --------------------------------------------------------

--
-- Table structure for table `LocationMatch`
--

CREATE TABLE IF NOT EXISTS `LocationMatch` (
  `rec_id` int(11) NOT NULL AUTO_INCREMENT,
  `Post_rec_id` int(11) NOT NULL,
  `name` text NOT NULL,
  PRIMARY KEY (`rec_id`),
  UNIQUE KEY `LocationMatch_Unique` (`name`(16),`Post_rec_id`),
  KEY `Matches_Post` (`Post_rec_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=26341 ;

-- --------------------------------------------------------

--
-- Table structure for table `MentionReply`
--

CREATE TABLE IF NOT EXISTS `MentionReply` (
  `rec_id` int(11) NOT NULL AUTO_INCREMENT,
  `thing_id` varchar(16) NOT NULL,
  PRIMARY KEY (`rec_id`),
  UNIQUE KEY `thing_id` (`thing_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=219 ;

-- --------------------------------------------------------

--
-- Table structure for table `Post`
--

CREATE TABLE IF NOT EXISTS `Post` (
  `rec_id` int(11) NOT NULL AUTO_INCREMENT,
  `Subreddit_rec_id` int(11) NOT NULL,
  `thing_id` varchar(16) NOT NULL,
  `author` varchar(32) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `body` text NOT NULL,
  `title` text NOT NULL,
  `url` varchar(512) NOT NULL,
  PRIMARY KEY (`rec_id`),
  UNIQUE KEY `Post_thing_id_ak` (`thing_id`),
  KEY `Post_Subreddit` (`Subreddit_rec_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=382294 ;

-- --------------------------------------------------------

--
-- Table structure for table `Reply`
--

CREATE TABLE IF NOT EXISTS `Reply` (
  `rec_id` int(11) NOT NULL AUTO_INCREMENT,
  `Post_rec_id` int(11) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rec_id`),
  UNIQUE KEY `Reply_post_rec_id_ak` (`Post_rec_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=863 ;

-- --------------------------------------------------------

--
-- Table structure for table `Subreddit`
--

CREATE TABLE IF NOT EXISTS `Subreddit` (
  `rec_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`rec_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `LocationMatch`
--
ALTER TABLE `LocationMatch`
  ADD CONSTRAINT `Matches_Post` FOREIGN KEY (`Post_rec_id`) REFERENCES `Post` (`rec_id`);

--
-- Constraints for table `Post`
--
ALTER TABLE `Post`
  ADD CONSTRAINT `Post_Subreddit` FOREIGN KEY (`Subreddit_rec_id`) REFERENCES `Subreddit` (`rec_id`);

--
-- Constraints for table `Reply`
--
ALTER TABLE `Reply`
  ADD CONSTRAINT `Reply_Post` FOREIGN KEY (`Post_rec_id`) REFERENCES `Post` (`rec_id`);
