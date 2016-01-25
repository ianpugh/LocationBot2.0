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

--
-- Dumping data for table `Location`
--

INSERT INTO `Location` (`rec_id`, `name`, `date_added`) VALUES
(1, 'al', '2016-01-06 09:29:54'),
(2, 'alabama', '2016-01-06 09:29:54'),
(3, 'ak', '2016-01-06 09:29:54'),
(4, 'alaska', '2016-01-06 09:29:54'),
(5, 'az', '2016-01-06 09:29:54'),
(6, 'arizona', '2016-01-06 09:29:54'),
(7, 'ar', '2016-01-06 09:29:54'),
(8, 'arkansas', '2016-01-06 09:29:54'),
(9, 'ca', '2016-01-06 09:29:54'),
(10, 'california', '2016-01-06 09:29:54'),
(11, 'co', '2016-01-06 09:29:54'),
(12, 'colorado', '2016-01-06 09:29:54'),
(13, 'ct', '2016-01-06 09:29:54'),
(14, 'connecticut', '2016-01-06 09:29:54'),
(15, 'de', '2016-01-06 09:29:54'),
(16, 'delaware', '2016-01-06 09:29:54'),
(17, 'dc', '2016-01-06 09:29:54'),
(18, 'district of columbia', '2016-01-06 09:29:54'),
(19, 'fl', '2016-01-06 09:29:54'),
(20, 'florida', '2016-01-06 09:29:54'),
(21, 'ga', '2016-01-06 09:29:54'),
(22, 'georgia', '2016-01-06 09:29:54'),
(24, 'hawaii', '2016-01-06 09:29:54'),
(25, 'idaho', '2016-01-06 09:29:54'),
(26, 'il', '2016-01-06 09:29:54'),
(27, 'illinois', '2016-01-06 09:29:54'),
(28, 'indiana', '2016-01-06 09:29:54'),
(29, 'ia', '2016-01-06 09:29:54'),
(30, 'iowa', '2016-01-06 09:29:54'),
(31, 'ks', '2016-01-06 09:29:54'),
(32, 'kansas', '2016-01-06 09:29:54'),
(33, 'ky', '2016-01-06 09:29:54'),
(34, 'kentucky', '2016-01-06 09:29:54'),
(35, 'la', '2016-01-06 09:29:54'),
(36, 'louisiana', '2016-01-06 09:29:54'),
(37, 'maine', '2016-01-06 09:29:54'),
(38, 'md', '2016-01-06 09:29:54'),
(39, 'maryland', '2016-01-06 09:29:54'),
(40, 'ma', '2016-01-06 09:29:54'),
(41, 'massachusetts', '2016-01-06 09:29:54'),
(42, 'mi', '2016-01-06 09:29:54'),
(43, 'michigan', '2016-01-06 09:29:54'),
(44, 'mn', '2016-01-06 09:29:54'),
(45, 'minnesota', '2016-01-06 09:29:54'),
(46, 'ms', '2016-01-06 09:29:54'),
(47, 'mississippi', '2016-01-06 09:29:54'),
(48, 'mo', '2016-01-06 09:29:54'),
(49, 'missouri', '2016-01-06 09:29:54'),
(50, 'mt', '2016-01-06 09:29:54'),
(51, 'montana', '2016-01-06 09:29:54'),
(52, 'ne', '2016-01-06 09:29:54'),
(53, 'nebraska', '2016-01-06 09:29:54'),
(54, 'nv', '2016-01-06 09:29:54'),
(55, 'nevada', '2016-01-06 09:29:54'),
(56, 'nh', '2016-01-06 09:29:54'),
(57, 'new hampshire', '2016-01-06 09:29:54'),
(58, 'nj', '2016-01-06 09:29:54'),
(59, 'new jersey', '2016-01-06 09:29:54'),
(60, 'nm', '2016-01-06 09:29:54'),
(61, 'new mexico', '2016-01-06 09:29:54'),
(62, 'ny', '2016-01-06 09:29:54'),
(63, 'new york', '2016-01-06 09:29:54'),
(64, 'nc', '2016-01-06 09:29:54'),
(65, 'north carolina', '2016-01-06 09:29:54'),
(66, 'nd', '2016-01-06 09:29:54'),
(67, 'north dakota', '2016-01-06 09:29:54'),
(68, 'oh', '2016-01-06 09:29:54'),
(69, 'ohio', '2016-01-06 09:29:54'),
(71, 'oregon', '2016-01-06 09:29:54'),
(72, 'pa', '2016-01-06 09:29:54'),
(73, 'pennsylvania', '2016-01-06 09:29:54'),
(74, 'ri', '2016-01-06 09:29:54'),
(75, 'rhode island', '2016-01-06 09:29:54'),
(76, 'sc', '2016-01-06 09:29:54'),
(77, 'south carolina', '2016-01-06 09:29:54'),
(78, 'sd', '2016-01-06 09:29:54'),
(79, 'south dakota', '2016-01-06 09:29:54'),
(80, 'tn', '2016-01-06 09:29:54'),
(81, 'tennessee', '2016-01-06 09:29:54'),
(82, 'tx', '2016-01-06 09:29:54'),
(83, 'texas', '2016-01-06 09:29:54'),
(84, 'ut', '2016-01-06 09:29:54'),
(85, 'utah', '2016-01-06 09:29:54'),
(86, 'vt', '2016-01-06 09:29:54'),
(87, 'vermont', '2016-01-06 09:29:54'),
(88, 'va', '2016-01-06 09:29:54'),
(89, 'virginia', '2016-01-06 09:29:54'),
(90, 'wa', '2016-01-06 09:29:54'),
(91, 'washington', '2016-01-06 09:29:54'),
(92, 'wv', '2016-01-06 09:29:54'),
(93, 'west virginia', '2016-01-06 09:29:54'),
(94, 'wi', '2016-01-06 09:29:54'),
(95, 'wisconsin', '2016-01-06 09:29:54'),
(96, 'wy', '2016-01-06 09:29:54'),
(97, 'wyoming', '2016-01-06 09:29:54'),
(98, 'usa', '2016-01-06 09:29:54'),
(99, 'united states', '2016-01-06 09:29:54'),
(100, 'uk', '2016-01-06 09:29:54'),
(101, 'united kingdom', '2016-01-06 09:29:54'),
(102, 'ok, usa', '2016-01-06 09:29:54'),
(103, 'america', '2016-01-06 09:29:54'),
(105, 'los angeles', '2016-01-06 09:29:54'),
(106, 'chicago', '2016-01-06 09:29:54'),
(107, 'philadelphia', '2016-01-06 09:29:54'),
(108, 'dallas', '2016-01-06 09:29:54'),
(109, 'ft. worth', '2016-01-06 09:29:54'),
(110, 'san francisco', '2016-01-06 09:29:54'),
(111, 'oakland', '2016-01-06 09:29:54'),
(112, 'san jose', '2016-01-06 09:29:54'),
(113, 'boston', '2016-01-06 09:29:54'),
(114, 'atlanta', '2016-01-06 09:29:54'),
(115, 'washington, dc', '2016-01-06 09:29:54'),
(116, 'houston', '2016-01-06 09:29:54'),
(117, 'detroit', '2016-01-06 09:29:54'),
(118, 'phoenix', '2016-01-06 09:29:54'),
(119, 'tampa-st. petersburg', '2016-01-06 09:29:54'),
(120, 'seattle-tacoma', '2016-01-06 09:29:54'),
(121, 'minneapolis', '2016-01-06 09:29:54'),
(122, 'st. paul', '2016-01-06 09:29:54'),
(123, 'miami', '2016-01-06 09:29:54'),
(124, 'ft.lauderdale', '2016-01-06 09:29:54'),
(125, 'cleveland', '2016-01-06 09:29:54'),
(126, 'denver', '2016-01-06 09:29:54'),
(127, 'orlando', '2016-01-06 09:29:54'),
(128, 'sacramento', '2016-01-06 09:29:54'),
(129, 'stockton', '2016-01-06 09:29:54'),
(130, 'modesto', '2016-01-06 09:29:54'),
(131, 'st. louis', '2016-01-06 09:29:54'),
(132, 'portland', '2016-01-06 09:29:54'),
(133, 'pittsburgh', '2016-01-06 09:29:54'),
(134, 'charlotte', '2016-01-06 09:29:54'),
(135, 'indianapolis', '2016-01-06 09:29:54'),
(136, 'baltimore', '2016-01-06 09:29:54'),
(137, 'raleigh-durham', '2016-01-06 09:29:54'),
(138, 'san diego', '2016-01-06 09:29:54'),
(139, 'nashville', '2016-01-06 09:29:54'),
(140, 'hartford-new haven', '2016-01-06 09:29:54'),
(141, 'kansas city', '2016-01-06 09:29:54'),
(142, 'columbus', '2016-01-06 09:29:54'),
(143, 'salt lake city', '2016-01-06 09:29:54'),
(144, 'cincinnati', '2016-01-06 09:29:54'),
(145, 'milwaukee', '2016-01-06 09:29:54'),
(146, 'greenville', '2016-01-06 09:29:54'),
(147, 'spartanburg', '2016-01-06 09:29:54'),
(148, 'asheville', '2016-01-06 09:29:54'),
(149, 'anderson', '2016-01-06 09:29:54'),
(150, 'san antonio', '2016-01-06 09:29:54'),
(151, 'west palm beach', '2016-01-06 09:29:54'),
(152, 'grand rapids', '2016-01-06 09:29:54'),
(153, 'kalamazoo', '2016-01-06 09:29:54'),
(154, 'battle creek', '2016-01-06 09:29:54'),
(155, 'birmingham', '2016-01-06 09:29:54'),
(156, 'las vegas', '2016-01-06 09:29:54'),
(157, 'norfolk', '2016-01-06 09:29:54'),
(158, 'albuquerque', '2016-01-06 09:29:54'),
(159, 'santa fe', '2016-01-06 09:29:54'),
(160, 'oklahoma city', '2016-01-06 09:29:54'),
(161, 'winston-salem', '2016-01-06 09:29:54'),
(162, 'jacksonville', '2016-01-06 09:29:54'),
(163, 'memphis', '2016-01-06 09:29:54'),
(164, 'austin', '2016-01-06 09:29:54'),
(165, 'louisville', '2016-01-06 09:29:54'),
(166, 'buffalo', '2016-01-06 09:29:54'),
(167, 'new orleans', '2016-01-06 09:29:54'),
(168, 'scranton', '2016-01-06 09:29:54'),
(169, 'fresno', '2016-01-06 09:29:54'),
(170, 'little rock', '2016-01-06 09:29:54'),
(171, 'albany', '2016-01-06 09:29:54'),
(172, 'schenectady', '2016-01-06 09:29:54'),
(173, 'richmond', '2016-01-06 09:29:54'),
(174, 'knoxville', '2016-01-06 09:29:54'),
(175, 'pensacola', '2016-01-06 09:29:54'),
(176, 'tulsa', '2016-01-06 09:29:54'),
(177, 'ft. myers-naples', '2016-01-06 09:29:54'),
(178, 'lexington', '2016-01-06 09:29:54'),
(179, 'dayton', '2016-01-06 09:29:54'),
(180, 'charleston-huntington', '2016-01-06 09:29:54'),
(181, 'flint-saginaw-bay city', '2016-01-06 09:29:54'),
(182, 'roanoke-lynchburg', '2016-01-06 09:29:54'),
(183, 'tucson', '2016-01-06 09:29:54'),
(184, 'wichita-hutchinson', '2016-01-06 09:29:54'),
(185, 'green bay-appleton', '2016-01-06 09:29:54'),
(186, 'des moines-ames', '2016-01-06 09:29:54'),
(187, 'honolulu', '2016-01-06 09:29:54'),
(188, 'toledo', '2016-01-06 09:29:54'),
(189, 'springfield, mo', '2016-01-06 09:29:54'),
(190, 'spokane', '2016-01-06 09:29:54'),
(191, 'omaha', '2016-01-06 09:29:54'),
(192, 'portland-auburn', '2016-01-06 09:29:54'),
(193, 'columbia, sc', '2016-01-06 09:29:54'),
(194, 'rochester, ny', '2016-01-06 09:29:54'),
(195, 'syracuse', '2016-01-06 09:29:54'),
(196, 'decatur', '2016-01-06 09:29:54'),
(197, 'shreveport', '2016-01-06 09:29:54'),
(198, 'madison', '2016-01-06 09:29:54'),
(199, 'chattanooga', '2016-01-06 09:29:54'),
(200, 'harlingen', '2016-01-06 09:29:54'),
(201, 'cedar rapids-waterloo-iowa city-dubuque', '2016-01-06 09:29:54'),
(202, 'south bend-elkhart', '2016-01-06 09:29:54'),
(203, 'jackson,ms', '2016-01-06 09:29:54'),
(204, 'colorado springs-pueblo', '2016-01-06 09:29:54'),
(205, 'tri-cities', '2016-01-06 09:29:54'),
(206, 'burlington', '2016-01-06 09:29:54'),
(207, 'waco', '2016-01-06 09:29:54'),
(208, 'baton rouge', '2016-01-06 09:29:54'),
(209, 'savannah', '2016-01-06 09:29:54'),
(210, 'el paso', '2016-01-06 09:29:54'),
(211, 'charleston', '2016-01-06 09:29:54'),
(212, 'venezuela', '2016-01-06 09:29:54'),
(213, 'ft. smith', '2016-01-06 09:29:54'),
(214, 'queensland', '2016-01-06 09:29:54'),
(215, 'sydney', '2016-01-06 09:29:54'),
(216, 'perth', '2016-01-06 09:29:54'),
(217, 'aus', '2016-01-06 09:29:54'),
(218, 'australia', '2016-01-06 09:29:54'),
(219, 'norway', '2016-01-06 09:29:54'),
(220, 'denmark', '2016-01-06 09:29:54'),
(221, 'finland', '2016-01-06 09:29:54'),
(222, 'murica', '2016-01-06 09:29:54'),
(223, 'canada', '2016-01-06 09:29:54'),
(224, 'puerto rico', '2016-01-06 09:29:54'),
(226, 'hong kong', '2016-01-06 09:29:54'),
(227, 'taiwan', '2016-01-06 09:29:54'),
(229, 'canadian', '2016-01-06 09:29:54'),
(230, 'swedish', '2016-01-06 09:29:54'),
(231, 'toronto', '2016-01-06 09:29:54'),
(232, 'ontario', '2016-01-06 09:29:54'),
(233, 'nyc', '2016-01-06 09:29:54'),
(234, 'singapore', '2016-01-06 09:29:54'),
(235, 'new zealand', '2016-01-06 09:29:54'),
(236, 'brooklyn', '2016-01-06 09:29:54'),
(237, 'bronx', '2016-01-06 09:29:54'),
(238, 'staten island', '2016-01-06 09:29:54'),
(239, 'queens', '2016-01-06 09:29:54'),
(240, 'malaysia', '2016-01-06 09:29:54'),
(241, 'british columbia', '2016-01-06 09:29:54'),
(242, 'vancouver', '2016-01-06 09:29:54'),
(243, 'london', '2016-01-06 09:29:54'),
(245, 'quebec', '2016-01-06 09:29:54'),
(246, 'brazil', '2016-01-06 09:29:54'),
(247, 'ireland', '2016-01-06 09:29:54'),
(248, 'hungary', '2016-01-06 09:29:54'),
(249, 'netherlands', '2016-01-06 09:29:54'),
(250, 'philippines', '2016-01-06 09:29:54'),
(251, 'nova scotia', '2016-01-06 09:29:54'),
(252, 'sweden', '2016-01-06 09:29:54'),
(253, 'switzerland', '2016-01-06 09:29:54'),
(254, 'england', '2016-01-06 09:29:54'),
(255, 'federal law', '2016-01-06 09:29:54'),
(256, 'constitutional', '2016-01-06 09:29:54'),
(257, 'constitution', '2016-01-06 09:29:54'),
(258, 'south africa', '2016-01-06 09:29:54'),
(259, 'slovakia', '2016-01-06 09:29:54'),
(260, 'on, can', '2016-01-06 09:29:54'),
(261, 'portugal', '2016-01-06 09:29:54'),
(262, 'spain', '2016-01-06 09:29:54'),
(264, 'italy', '2016-01-06 09:29:54'),
(267, 'alberta', '2016-01-06 09:29:54'),
(268, 'mexico', '2016-01-06 09:29:54'),
(269, 'socal', '2016-01-06 09:29:54'),
(270, 'so-cal', '2016-01-06 09:29:54'),
(271, 'norcal', '2016-01-06 09:29:54'),
(272, 'calif', '2016-01-06 09:29:54'),
(275, 'saskatchewan', '2016-01-06 09:29:54'),
(276, 'manitoba', '2016-01-06 09:29:54'),
(279, 'new brunswick', '2016-01-06 09:29:54'),
(281, 'newfound and labrador', '2016-01-06 09:29:54'),
(282, 'nunavut', '2016-01-06 09:29:54'),
(283, '\\[OK\\]', '2016-01-06 12:59:47'),
(284, 'Scotland', '2016-01-11 06:00:04'),
(285, 'Eire', '2016-01-11 06:00:04'),
(288, ' (OK)', '2016-01-14 04:38:10'),
(291, 'oklahoma', '2016-01-14 04:49:23'),
(293, 'greece', '2016-01-14 04:56:49'),
(294, 'france', '2016-01-14 04:56:49');


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
