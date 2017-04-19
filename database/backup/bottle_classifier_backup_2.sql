-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 19, 2017 at 06:16 am
-- Server version: 10.1.21-MariaDB
-- PHP Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bottle_classifier`
--

-- --------------------------------------------------------

--
-- Table structure for table `Bottle`
--

CREATE TABLE `Bottle` (
  `bottle_id` smallint(6) NOT NULL,
  `ingredient_id` smallint(6) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Bottle`
--

INSERT INTO `Bottle` (`bottle_id`, `ingredient_id`, `name`) VALUES
(1, 8, 'Smirnoff Vodka');

-- --------------------------------------------------------

--
-- Table structure for table `Classifier`
--

CREATE TABLE `Classifier` (
  `classifier_id` smallint(6) NOT NULL,
  `lbp_path` varchar(255) NOT NULL,
  `haar_path` varchar(255) NOT NULL,
  `min_width` smallint(6) NOT NULL DEFAULT '0',
  `min_height` smallint(6) NOT NULL DEFAULT '0',
  `crop_width` smallint(6) NOT NULL,
  `crop_height` smallint(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `Classifier`
--

INSERT INTO `Classifier` (`classifier_id`, `lbp_path`, `haar_path`, `min_width`, `min_height`, `crop_width`, `crop_height`, `enabled`) VALUES
(1, 'classifier_vodka/classifier_first/cascade.xml', '', 80, 150, 30, 10, 1),
(2, 'classifier_jd/classifier_second/cascade.xml', '', 0, 0, 0, 0, 1),
(3, 'classifier_monster/classifier/cascade.xml', '', 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `Histogram`
--

CREATE TABLE `Histogram` (
  `histogram_id` smallint(6) NOT NULL,
  `classifier_id` smallint(6) NOT NULL,
  `bottle_id` smallint(6) NOT NULL,
  `rgb_path` varchar(255) NOT NULL,
  `hsv_path` varchar(255) NOT NULL,
  `action` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Histogram`
--

INSERT INTO `Histogram` (`histogram_id`, `classifier_id`, `bottle_id`, `rgb_path`, `hsv_path`, `action`) VALUES
(1, 1, 1, 'histogram_data/smirnoff_vodka_2_rgb.histo', 'histogram_data/smirnoff_vodka_2_hsv.histo', 1),
(2, 1, 1, 'histogram_data/neg_1_rgb.histo', 'histogram_data/neg_1_hsv.histo', 0),
(3, 1, 1, 'histogram_data/neg_2_rgb.histo', 'histogram_data/neg_2_hsv.histo', 0),
(4, 1, 1, 'histogram_data/monster_rgb.histo', 'histogram_data/monster_hsv.histo', 0);

-- --------------------------------------------------------

--
-- Table structure for table `Ingredient`
--

CREATE TABLE `Ingredient` (
  `ingredient_id` smallint(6) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Ingredient`
--

INSERT INTO `Ingredient` (`ingredient_id`, `name`) VALUES
(6, 'Lime juice'),
(7, 'Lime rind'),
(8, 'Vodka'),
(9, 'Cointreau'),
(10, 'Cranberry juice'),
(11, 'Peach schnapps'),
(12, 'Orange juice'),
(13, 'Lemon juice'),
(14, 'Ice cubes'),
(15, 'Orange wedge'),
(16, 'Triple sec'),
(17, 'Gin'),
(18, 'Sugar syrup'),
(19, 'White rum'),
(20, 'Cola'),
(21, 'Tequila'),
(22, 'Lemon wedge'),
(23, 'Kahlua'),
(24, 'Pineapple juice'),
(25, 'Blue curaçao'),
(26, 'Grapefruit juice'),
(27, 'Lime wedge'),
(28, 'Ice (crushed)'),
(29, 'Milk'),
(30, 'Lemon'),
(31, 'Orange slice'),
(32, 'Lemonade'),
(33, 'Taboo'),
(34, 'Cream'),
(35, 'Galliano'),
(36, ''),
(37, 'Lime'),
(38, 'Dark rum'),
(39, 'Whisky'),
(40, 'Red Bull'),
(41, 'Jack Daniels'),
(42, 'Tabasco sauce'),
(43, 'Martini bianco (dry)'),
(44, 'Green olive'),
(45, 'Lemon rind'),
(46, 'Maraschino liqueur'),
(47, 'Parfait amour'),
(48, 'Lemon slice'),
(49, 'Orange'),
(50, 'Grenadine'),
(51, 'Green chartreuse'),
(52, 'Maraschino cherry'),
(53, 'Crème de menthe (green)'),
(54, 'Banana liqueur'),
(55, 'Sour mix'),
(56, 'Aftershock (blue)'),
(57, 'Aftershock (red)'),
(58, 'Soda water'),
(59, 'Lime slice'),
(60, 'Ginger beer'),
(61, 'Malibu'),
(62, 'Apple juice'),
(63, 'Champagne'),
(64, 'Pernod'),
(65, 'Ginger ale'),
(66, 'Egg white'),
(67, 'Blueberry syrup'),
(68, 'Port'),
(69, 'Amaretto Di Saronno'),
(70, 'Strawberries'),
(71, 'Baileys  irish cream'),
(72, '7-up'),
(73, 'Banana'),
(74, 'Angostura bitters'),
(75, 'Southern Comfort'),
(76, 'Crème de cacao (dark)'),
(77, 'Sugar cube'),
(78, 'Frangelico'),
(79, 'Cherry brandy'),
(80, 'Midori melon liqueur'),
(81, 'Sugar'),
(82, 'Golden rum'),
(83, 'Absolut Mandarin'),
(84, 'Strawberry liqueur'),
(85, 'Absolut Raspberry'),
(86, 'Passion fruit liqueur'),
(87, 'Butterscotch schnapps'),
(88, 'Advocaat'),
(89, 'Martini extra dry'),
(90, 'Honey'),
(91, 'Absinthe'),
(92, 'Gold tequila'),
(93, 'Cider'),
(94, 'Lager'),
(95, 'Ribena blackcurrant syrup'),
(96, 'Jagermeister'),
(97, 'Sparkling wine'),
(98, 'Absolut Vodka'),
(99, 'Lime cordial'),
(100, 'Cherry vodka'),
(101, 'Mango'),
(102, 'Apricot liqueur'),
(103, 'Campari'),
(104, 'Goldschlager'),
(105, 'Blavod'),
(106, 'Frozen raspberries'),
(107, 'Raspberry schnapps'),
(108, 'Brandy'),
(109, 'Ouzo'),
(110, 'Blackberry juice'),
(111, 'Stout'),
(112, 'Blackcurrant cordial'),
(113, 'Plum'),
(114, 'Olive juice'),
(115, 'Spiced rum'),
(116, 'White wine'),
(117, 'Crème de cacao (white)'),
(118, 'Strawberry syrup'),
(119, 'Water'),
(120, 'Watermelon schnapps'),
(121, 'Raspberry juice'),
(122, 'Orange curacao');

-- --------------------------------------------------------

--
-- Table structure for table `Measure`
--

CREATE TABLE `Measure` (
  `measure_id` smallint(6) NOT NULL,
  `recipe_id` smallint(6) NOT NULL,
  `ingredient_id` smallint(6) NOT NULL,
  `amount` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Measure`
--

INSERT INTO `Measure` (`measure_id`, `recipe_id`, `ingredient_id`, `amount`) VALUES
(11, 3, 6, 'dash of'),
(12, 3, 7, '1'),
(13, 3, 8, '1 1/2 parts'),
(14, 3, 9, '1 part'),
(15, 3, 10, '1 part'),
(16, 4, 11, '1 part'),
(17, 4, 12, 'top up'),
(18, 4, 8, '1 part'),
(19, 4, 13, 'dash of'),
(20, 4, 14, '5'),
(21, 4, 15, '1'),
(22, 4, 10, 'top up'),
(23, 5, 16, '1/2 part'),
(24, 5, 17, '1/2 part'),
(25, 5, 18, 'dash of'),
(26, 5, 8, '1 part'),
(27, 5, 19, '1/2 part'),
(28, 5, 14, '5'),
(29, 5, 20, 'top up'),
(30, 5, 6, 'dash of'),
(31, 5, 21, '1/2 part'),
(32, 5, 22, '1'),
(33, 5, 13, 'dash of'),
(34, 6, 23, '1 part'),
(35, 6, 8, '2 parts'),
(36, 6, 14, '5'),
(37, 6, 20, 'top up'),
(38, 7, 24, 'top up'),
(39, 7, 25, '1 part'),
(40, 7, 8, '3 parts'),
(41, 8, 26, '3 parts'),
(42, 8, 8, '2 parts'),
(43, 8, 27, '1'),
(44, 8, 14, '1 part'),
(45, 8, 28, '5'),
(46, 8, 10, '3 parts'),
(47, 9, 29, '1/2 part'),
(48, 9, 8, '2 parts'),
(49, 9, 19, '1 part'),
(50, 9, 30, 'juice of 1/2'),
(51, 10, 12, '2 parts'),
(52, 10, 8, '2 parts'),
(53, 10, 14, '5'),
(54, 10, 31, '1'),
(55, 11, 32, '3 parts'),
(56, 11, 25, '1 part'),
(57, 11, 8, '1 part'),
(58, 11, 33, '2 parts'),
(59, 11, 12, '3 parts'),
(60, 12, 23, '1 part'),
(61, 12, 34, 'top up'),
(62, 12, 8, '2 parts'),
(63, 12, 14, '5'),
(64, 13, 16, '3 parts'),
(65, 13, 8, '3 parts'),
(66, 13, 13, '2 parts'),
(67, 13, 14, '5'),
(68, 13, 6, '2 parts'),
(69, 13, 27, '1'),
(70, 14, 12, '4 parts'),
(71, 14, 8, '1 part'),
(72, 14, 14, '6'),
(73, 14, 35, '2 teaspoons'),
(74, 14, 31, '1'),
(75, 15, 36, 'Cranberry juice'),
(76, 15, 11, '1 1/2 oz.'),
(77, 15, 8, '1 oz.'),
(78, 16, 21, '1 part'),
(79, 16, 37, 'juice of'),
(80, 16, 8, '1 part'),
(81, 16, 14, '5'),
(82, 17, 11, '1 part'),
(83, 17, 8, '1 part'),
(84, 18, 11, '2 parts'),
(85, 18, 12, '5 Parts'),
(86, 18, 8, '1 part'),
(87, 18, 23, '2 parts'),
(88, 19, 38, '2 parts'),
(89, 19, 12, 'top up'),
(90, 19, 8, '2 parts'),
(91, 19, 14, '3'),
(92, 20, 39, '1 part'),
(93, 20, 8, '1 part'),
(94, 20, 14, '4'),
(95, 21, 17, '1 part'),
(96, 21, 25, '1 part'),
(97, 21, 8, '1 part'),
(98, 21, 19, '1 part'),
(99, 21, 40, '1 part'),
(100, 21, 21, '1 part'),
(101, 22, 21, '1 part'),
(102, 22, 8, '1 part'),
(103, 22, 19, '1 part'),
(104, 23, 41, '1 part'),
(105, 23, 21, '1 part'),
(106, 23, 42, 'dash of'),
(107, 23, 8, '1 part'),
(108, 24, 20, '16.0 oz.'),
(109, 24, 8, '1 oz.'),
(110, 25, 11, '1 1/2 parts'),
(111, 25, 8, '1 1/2 parts'),
(112, 25, 14, '3'),
(113, 25, 10, '4 parts'),
(114, 26, 43, '1/2 part'),
(115, 26, 8, '3 parts'),
(116, 26, 14, '4'),
(117, 26, 44, '1'),
(118, 27, 45, '1'),
(119, 27, 8, '2 parts'),
(120, 27, 46, '1 part'),
(121, 27, 14, '5'),
(122, 27, 47, '1 part'),
(123, 28, 11, '1/2 part'),
(124, 28, 8, '1 part'),
(125, 28, 10, '1/2 part'),
(126, 28, 26, '1/2 part'),
(127, 29, 24, '1 part'),
(128, 29, 48, '1'),
(129, 29, 8, '3 parts'),
(130, 29, 49, 'juice of'),
(131, 29, 14, '5'),
(132, 29, 50, '1 teaspoon'),
(133, 29, 30, 'juice of'),
(134, 30, 8, '2 parts'),
(135, 30, 51, '1 part'),
(136, 30, 52, '1'),
(137, 31, 36, 'Cranberry juice'),
(138, 31, 11, '1 1/2 oz.'),
(139, 31, 8, '1 oz.'),
(140, 32, 53, '1/2 part'),
(141, 32, 32, '1/2'),
(142, 32, 25, '1/2 part'),
(143, 32, 8, '1/2 part'),
(144, 32, 36, 'Lime slice'),
(145, 32, 54, '1/2 part'),
(146, 32, 55, '2 tablespoons'),
(147, 32, 56, '1/2 part'),
(148, 32, 57, '1/2 part'),
(149, 32, 58, 'top up'),
(150, 33, 8, '2 parts'),
(151, 33, 31, '1'),
(152, 33, 6, '2 parts'),
(153, 33, 59, '1'),
(154, 33, 60, 'top up'),
(155, 33, 28, '4'),
(156, 34, 61, '1/2 part'),
(157, 34, 11, '1/2 part'),
(158, 34, 25, '1/2 part'),
(159, 34, 8, '1/2 part'),
(160, 34, 24, '3 parts'),
(161, 34, 14, '2 scoops'),
(162, 34, 50, '1 part'),
(163, 35, 24, '2 parts'),
(164, 35, 23, '1 part'),
(165, 35, 8, '1 part'),
(166, 35, 14, '5'),
(167, 36, 62, '1 part'),
(168, 36, 8, '1 part'),
(169, 36, 63, '2 parts'),
(170, 36, 32, 'top up'),
(171, 37, 64, '3 drops'),
(172, 37, 65, 'top up'),
(173, 37, 8, '3 parts'),
(174, 37, 14, '5'),
(175, 37, 18, '1/2 teaspoon'),
(176, 37, 30, 'juice of'),
(177, 37, 59, '1'),
(178, 37, 66, '1'),
(179, 38, 67, '1 part'),
(180, 38, 68, '2 parts'),
(181, 39, 23, '1 part'),
(182, 39, 8, '1 part'),
(183, 39, 69, '1 part'),
(184, 40, 16, 'dash of'),
(185, 40, 8, '1 part'),
(186, 40, 26, '1 part'),
(187, 40, 70, '1'),
(188, 40, 7, '1'),
(189, 40, 10, '1 part'),
(190, 41, 8, '0.5 shot'),
(191, 41, 23, '0.5 shot'),
(192, 41, 71, '0.5 shot'),
(193, 42, 17, '1 part'),
(194, 42, 25, '1 part'),
(195, 42, 8, '1 part'),
(196, 42, 19, '1 part'),
(197, 42, 40, '1'),
(198, 42, 21, '1 part'),
(199, 43, 72, 'top up'),
(200, 43, 37, 'juice of 1/2'),
(201, 43, 8, '2 parts'),
(202, 43, 27, '1'),
(203, 44, 11, '1 part'),
(204, 44, 29, '2 parts'),
(205, 44, 8, '1 part'),
(206, 44, 70, '1'),
(207, 44, 73, '1/2 part'),
(208, 44, 28, '2 tablespoons'),
(209, 45, 11, '1/2 part'),
(210, 45, 29, '3 parts'),
(211, 45, 8, '1/2 part'),
(212, 45, 10, '1/2 part'),
(213, 46, 17, '1 part'),
(214, 46, 25, '1 part'),
(215, 46, 8, '1 part'),
(216, 46, 74, '3 drops'),
(217, 46, 30, 'juice of'),
(218, 46, 28, 'top up'),
(219, 46, 12, '3 parts'),
(220, 47, 24, 'top up'),
(221, 47, 8, '1 1/2 parts'),
(222, 48, 21, '1/2 part'),
(223, 48, 8, '1/2 part'),
(224, 48, 75, '1/2 part'),
(225, 49, 53, '1 part'),
(226, 49, 8, '1 part'),
(227, 49, 52, '1'),
(228, 49, 76, '1 part'),
(229, 50, 8, '3 parts'),
(230, 50, 49, 'juice of 1/2'),
(231, 50, 14, '5'),
(232, 50, 30, 'juice of'),
(233, 50, 50, '1/2 teaspoon'),
(234, 50, 58, 'top up'),
(235, 51, 32, 'top up'),
(236, 51, 11, '1/2 part'),
(237, 51, 8, '1 1/2 parts'),
(238, 51, 14, '3'),
(239, 51, 50, 'dash of'),
(240, 52, 42, '1 dash'),
(241, 52, 8, '1 oz.'),
(242, 53, 11, '1 part'),
(243, 53, 12, 'top up'),
(244, 53, 8, '1 part'),
(245, 53, 14, '3'),
(246, 54, 25, '1 oz.'),
(247, 54, 8, '1 oz.'),
(248, 54, 51, '1/2 oz.'),
(249, 54, 29, '1/2 oz.'),
(250, 54, 69, '1 oz.'),
(251, 54, 23, '1 oz.'),
(252, 55, 64, '3 drops'),
(253, 55, 32, 'top up'),
(254, 55, 8, '2 parts'),
(255, 55, 14, '3'),
(256, 55, 74, '2 drops'),
(257, 55, 77, '1'),
(258, 56, 11, '1 part'),
(259, 56, 12, '1 part'),
(260, 56, 8, '1 part'),
(261, 56, 54, '1 part'),
(262, 57, 38, '1 oz.'),
(263, 57, 78, '0.5 oz.'),
(264, 57, 8, '0.5 oz.'),
(265, 57, 79, '0.5 oz.'),
(266, 57, 50, '2 tsp.'),
(267, 58, 25, '1/2 part'),
(268, 58, 8, '1 part'),
(269, 58, 51, 'dash of'),
(270, 58, 52, '1'),
(271, 58, 80, '1 part'),
(272, 59, 21, '1/2 part'),
(273, 59, 8, '1/2 part'),
(274, 60, 16, '1 part'),
(275, 60, 25, '5 drops'),
(276, 60, 8, '1 part'),
(277, 61, 32, 'top up'),
(278, 61, 25, '1 part'),
(279, 61, 8, '1 part'),
(280, 61, 52, '1'),
(281, 61, 31, '1'),
(282, 61, 26, 'dash of'),
(283, 62, 37, 'juice of 1/2'),
(284, 62, 8, '3 parts'),
(285, 62, 19, '1 part'),
(286, 62, 81, 'dash of'),
(287, 63, 8, '1 part'),
(288, 63, 21, '1 part'),
(289, 63, 40, 'top up'),
(290, 64, 25, '1 part'),
(291, 64, 40, '2 parts'),
(292, 64, 14, '2 parts'),
(293, 64, 19, '1 part'),
(294, 65, 82, '2 parts'),
(295, 65, 8, '3 parts'),
(296, 65, 14, '8'),
(297, 65, 25, 'dash of'),
(298, 65, 40, '1/2'),
(299, 66, 12, '2 parts'),
(300, 66, 40, '2 parts'),
(301, 66, 83, '1 part'),
(302, 67, 8, '2 parts'),
(303, 67, 14, '3'),
(304, 67, 53, '1 part'),
(305, 67, 63, '1/2 part'),
(306, 67, 40, 'top up'),
(307, 67, 37, 'juice of'),
(308, 68, 40, '2 parts'),
(309, 68, 84, '1 teaspoon'),
(310, 68, 85, '1 part'),
(311, 68, 86, '1 teaspoon'),
(312, 68, 87, '1 teaspoon'),
(313, 68, 80, '1/2 teaspoon'),
(314, 68, 54, '1/2 teaspoon'),
(315, 68, 88, '1 part'),
(316, 68, 50, '1 part'),
(317, 68, 35, '1 teaspoon'),
(318, 68, 10, '2 parts'),
(319, 69, 40, '1 part'),
(320, 69, 27, '1'),
(321, 69, 17, '1 part'),
(322, 69, 13, '3 parts'),
(323, 70, 41, '3 parts'),
(324, 70, 40, '1/2'),
(325, 70, 14, '5'),
(326, 71, 8, '1 part'),
(327, 71, 14, '3'),
(328, 71, 25, '1 part'),
(329, 71, 40, 'top up'),
(330, 72, 40, '2 parts'),
(331, 72, 28, '3 parts'),
(332, 72, 89, '1 part'),
(333, 72, 90, '1 teaspoon'),
(334, 72, 19, '3 parts'),
(335, 73, 91, '1 part'),
(336, 73, 8, '1 part'),
(337, 73, 57, '1 part'),
(338, 73, 40, '3 parts'),
(339, 74, 8, '2 parts'),
(340, 74, 25, '3 parts'),
(341, 74, 40, 'top up'),
(342, 74, 19, '1 part'),
(343, 75, 21, '2 parts'),
(344, 75, 92, '2 parts'),
(345, 75, 37, '1'),
(346, 75, 23, '1 part'),
(347, 75, 40, '3 parts'),
(348, 76, 93, '1/2'),
(349, 76, 40, '1'),
(350, 76, 94, '1/2'),
(351, 76, 95, 'top up'),
(352, 76, 14, '4'),
(353, 77, 40, 'dash of'),
(354, 77, 96, '1 part'),
(355, 78, 8, '5 Parts'),
(356, 78, 14, '8'),
(357, 78, 72, 'top up'),
(358, 78, 97, '2 parts'),
(359, 78, 40, '1'),
(360, 78, 10, '2 parts'),
(361, 79, 40, '1 part'),
(362, 79, 96, '1 part'),
(363, 80, 41, '1 part'),
(364, 80, 40, '3 parts'),
(365, 81, 40, '1 part'),
(366, 81, 59, '1 part'),
(367, 81, 98, '1 part'),
(368, 81, 13, '2 parts'),
(369, 81, 99, '1/2 part'),
(370, 81, 21, '1 part'),
(371, 81, 100, '2 parts'),
(372, 82, 8, '2 parts'),
(373, 82, 59, '1'),
(374, 82, 40, 'top up'),
(375, 82, 95, '2 parts'),
(376, 83, 25, '1 part'),
(377, 83, 98, '1 part'),
(378, 83, 40, '3 parts'),
(379, 84, 40, 'top up'),
(380, 84, 101, '2 parts'),
(381, 84, 9, '1 part'),
(382, 84, 102, '1 part'),
(383, 84, 96, '2 parts'),
(384, 84, 37, '3 parts'),
(385, 85, 52, '1'),
(386, 85, 8, '1 part'),
(387, 85, 31, '1'),
(388, 85, 40, 'top up'),
(389, 85, 11, '1 part'),
(390, 86, 20, '1 part'),
(391, 86, 8, '2 parts'),
(392, 86, 15, '1 drop'),
(393, 86, 30, 'dash of'),
(394, 86, 19, '1 part'),
(395, 86, 24, '1 part'),
(396, 86, 10, 'top up'),
(397, 86, 40, '1 1/2 parts'),
(398, 86, 11, '1 part'),
(399, 87, 12, 'top up'),
(400, 87, 8, '1 part'),
(401, 87, 50, 'dash of'),
(402, 87, 99, 'dash of'),
(403, 87, 40, '1'),
(404, 87, 103, '1 part'),
(405, 87, 10, '3 parts'),
(406, 88, 40, 'juice of 1/2'),
(407, 88, 96, '2 parts'),
(408, 88, 104, '2 parts'),
(409, 89, 6, '2 parts'),
(410, 89, 40, '3 parts'),
(411, 89, 37, '1/2'),
(412, 89, 17, '2 parts'),
(413, 89, 28, '3 parts'),
(414, 90, 36, 'Cherry'),
(415, 90, 79, '1 part'),
(416, 90, 8, '2 parts'),
(417, 90, 40, 'top up'),
(418, 90, 80, '1 part'),
(419, 90, 24, '3 parts'),
(420, 90, 35, '1 part'),
(421, 90, 10, '3 parts'),
(422, 91, 12, '1 part'),
(423, 91, 40, '1 part'),
(424, 91, 10, '1 part'),
(425, 92, 40, 'top up'),
(426, 92, 14, '1 part'),
(427, 92, 105, '1 part'),
(428, 93, 8, '1 part'),
(429, 93, 28, '1 scoop'),
(430, 93, 25, '1/2 part'),
(431, 93, 40, 'top up'),
(432, 93, 11, '1 part'),
(433, 94, 12, '3 parts'),
(434, 94, 106, '4'),
(435, 94, 8, '2 parts'),
(436, 94, 40, '2 parts'),
(437, 94, 107, '2 parts'),
(438, 95, 38, '1/2 part'),
(439, 95, 41, '1/2 part'),
(440, 95, 8, '1/2 part'),
(441, 95, 108, '1/2 part'),
(442, 95, 39, '1/2 part'),
(443, 95, 21, '1/2 part'),
(444, 95, 40, '1 part'),
(445, 95, 20, 'top up'),
(446, 96, 8, '1 part'),
(447, 96, 40, '1 part'),
(448, 97, 8, '2 parts'),
(449, 97, 40, '1'),
(450, 97, 50, '1 part'),
(451, 98, 25, '1 part'),
(452, 98, 11, '1 part'),
(453, 98, 40, '2 parts'),
(454, 98, 109, '1 part'),
(455, 99, 36, 'Red Bull®'),
(456, 99, 8, '1/3'),
(457, 99, 92, '1/4'),
(458, 99, 30, '1 part'),
(459, 99, 17, '1/2'),
(460, 99, 19, '1/5'),
(461, 99, 25, '1'),
(462, 99, 13, 'top up'),
(463, 99, 110, 'top up'),
(464, 99, 43, '1 part'),
(465, 99, 109, '1/2'),
(466, 100, 111, '1/2'),
(467, 100, 8, '2'),
(468, 100, 40, '1 part'),
(469, 100, 112, '1 part'),
(470, 101, 56, '1/2 part'),
(471, 101, 98, '1 part'),
(472, 101, 40, '1/2 part'),
(473, 101, 21, '1 part'),
(474, 102, 71, '2 parts'),
(475, 102, 113, 'wedge of'),
(476, 102, 40, 'dash of'),
(477, 102, 114, 'top up'),
(478, 102, 109, '2 parts'),
(479, 103, 40, '1 part'),
(480, 103, 57, '1 part'),
(481, 104, 56, '2 parts'),
(482, 104, 40, '1'),
(483, 104, 11, '2 parts'),
(484, 105, 40, '1 part'),
(485, 105, 59, '1'),
(486, 105, 24, '1 part'),
(487, 105, 6, 'dash of'),
(488, 105, 115, '1 1/2 parts'),
(489, 105, 25, '1/2 part'),
(490, 105, 74, 'dash of'),
(491, 105, 31, '1'),
(492, 105, 58, 'top up'),
(493, 106, 116, '1'),
(494, 106, 8, '2'),
(495, 106, 117, '1/2 part'),
(496, 106, 40, 'top up'),
(497, 107, 71, '2 parts'),
(498, 107, 8, '3 parts'),
(499, 107, 29, '1/2 part'),
(500, 107, 43, '2 parts'),
(501, 107, 40, 'top up'),
(502, 108, 104, '2 parts'),
(503, 108, 40, 'top up'),
(504, 108, 57, '2 parts'),
(505, 109, 91, '2 parts'),
(506, 109, 8, '1/2 part'),
(507, 109, 40, '3 parts'),
(508, 110, 31, '1 part'),
(509, 110, 40, '1 part'),
(510, 110, 83, '1 part'),
(511, 110, 14, '1 part'),
(512, 110, 10, '1 part'),
(513, 111, 8, '1 part'),
(514, 111, 14, '1 part'),
(515, 111, 25, '1 part'),
(516, 111, 40, '1 part'),
(517, 112, 56, '1 part'),
(518, 112, 14, '5'),
(519, 112, 8, '2 parts'),
(520, 112, 40, 'dash of'),
(521, 113, 40, '1 part'),
(522, 113, 118, 'dash of'),
(523, 113, 109, '2 parts'),
(524, 114, 8, '3 parts'),
(525, 114, 110, '1 part'),
(526, 114, 57, '2 parts'),
(527, 114, 14, '10'),
(528, 114, 40, '3 parts'),
(529, 114, 119, '3 parts'),
(530, 114, 120, '2 parts'),
(531, 114, 121, '2 parts'),
(532, 114, 32, '2 parts'),
(533, 115, 6, '5 drops'),
(534, 115, 16, 'dash of'),
(535, 115, 75, '1 part'),
(536, 115, 40, '2 parts'),
(537, 116, 40, 'top up'),
(538, 116, 104, '1 part'),
(539, 116, 19, '2 parts'),
(540, 117, 6, '1/2 part'),
(541, 117, 69, '1/2 part'),
(542, 117, 59, '1'),
(543, 117, 40, '1/2'),
(544, 117, 82, '3/4'),
(545, 117, 75, '1/4'),
(546, 117, 8, '1/2 part'),
(547, 117, 28, '1 scoop'),
(548, 118, 36, 'Orange juice'),
(549, 118, 99, 'dash of'),
(550, 118, 40, 'top up'),
(551, 119, 8, '1 part'),
(552, 119, 52, '1'),
(553, 119, 21, '1 part'),
(554, 119, 28, '1/2'),
(555, 119, 31, '1'),
(556, 119, 40, '3 parts'),
(557, 119, 122, '1 part');

-- --------------------------------------------------------

--
-- Table structure for table `Recipe`
--

CREATE TABLE `Recipe` (
  `recipe_id` smallint(6) NOT NULL,
  `name` varchar(50) NOT NULL,
  `serves` tinyint(4) NOT NULL,
  `rating` decimal(15,14) NOT NULL DEFAULT '0.00000000000000',
  `instructions` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `Recipe`
--

INSERT INTO `Recipe` (`recipe_id`, `name`, `serves`, `rating`, `instructions`) VALUES
(3, 'Cosmopolitan', 1, '4.59999990463257', 'Shake all the ingredients with cracked ice. Pour into a cocktail glass.'),
(4, 'Sex on the beach', 1, '4.30000019073486', 'None'),
(5, 'Long Island Iced Tea', 1, '4.80000019073486', 'None'),
(6, 'Black Russian', 1, '3.82999992370605', 'Shake the vodka and kahlua. Pour over the ice. Top up with cola. Serve in a tumbler.'),
(7, 'Blue Lagoon', 1, '3.82999992370605', 'Stir all the ingredients together in a bar glass. Then pour into a highball glass. Then pour a dash of blue curacao over the top.'),
(8, 'Sea Breeze', 1, '3.98000001907349', 'Pour the vodka, cranberry juice and grapefruit juice into a tall glass with the ice. Stir well. Decorate with a lime wedge.'),
(9, 'Bikini', 1, '3.06999993324280', 'Shake with ice and strain into a cocktail glass. Garnish with a twist of lemon.'),
(10, 'Screwdriver', 1, '3.90000009536743', 'Pour over ice and serve in a tumbler.'),
(11, 'Skittles', 1, '4.75000000000000', 'None'),
(12, 'White Russian', 1, '4.00000000000000', 'Shake the vodka and kahlua. Then pour over the ice in a tumbler. Top up with cream.'),
(13, 'Kamikaze', 1, '3.82999992370605', 'Shake all the ingredients with cracked ice. Strain and pour into a highball glass.'),
(14, 'Harvey Wallbanger', 1, '3.78999996185303', 'Put half the ice cubes, the vodka and orange juice into a cocktail shaker. Shake well for 30 seconds, then strain into a tall glass over the remaining ice. Float the galliano over the top. Decorate with orange slices.'),
(15, 'Woo-woo', 1, '4.38000011444092', 'Mix the liquor together and pour into a glass with ice. Add cranberry juice and mix well.'),
(16, 'Hawaiian Seduction', 1, '2.41000008583069', 'Pour in tall glass and fill with lime juice. Add ice and mix very well.'),
(17, 'Bad Habit', 1, '3.31999993324280', 'Build in a lowball glass.'),
(18, 'Sewer rat', 1, '3.41000008583069', 'Add them in order ** DO NOT STIR ** No Ice'),
(19, 'Brass Monkey', 1, '3.64000010490417', 'Pour the rum and vodka into an 8 oz. glass and fill with orange juice and ice. Stir and serve.'),
(20, 'God en Partners', 1, '5.00000000000000', 'None'),
(21, 'Official Bullfrog', 1, '4.19000005722046', 'The Bullfrog begins with a pint glass filled with ice. You then fill with Gin, Tequila, Vodka and Bacardi (All white spirits) and Blue Curaco. Then fill up to top with a tin of Red Bull - Give it a stir and presto!'),
(22, 'Horny Bull', 1, '3.59999990463257', 'Layer in a shot glass.'),
(23, 'Fire Bomb', 1, '2.98000001907349', 'Mix and serve in a shot glass.'),
(24, 'Adult pepsi', 1, '3.26999998092651', 'Pour 1 shot of vodka in glass. Add 1-16oz.pepsi.  You\'ll love it.'),
(25, 'Woo Woo Shooter', 1, '4.15000009536743', 'Pour all ingredients into a highball glass over ice cubes, stir, and serve.'),
(26, 'Vodka Martini', 1, '3.57999992370605', 'None'),
(27, 'Perfect Love', 1, '3.08999991416931', 'First pour (into a tumbler) the vodka, then the parfait amour, then the maraschino liqueur over the ice.'),
(28, 'Pink Floyd', 1, '3.73000001907349', 'Pour into a shot glass with equals parts of juice.'),
(29, 'Hawaiian Vodka', 1, '3.56999993324280', 'None'),
(30, 'Green Dragon', 1, '4.00000000000000', 'Shake all the ingredients with cracked ice. Strain and pour into a cocktail glass.'),
(31, 'Woo-woo', 1, '4.38000011444092', 'Mix the liquor together and pour into a glass with ice. Add cranberry juice and mix well.'),
(32, 'Rainbow', 1, '3.75999999046326', 'None'),
(33, 'Moscow Mule', 1, '3.56999993324280', 'Put the ice cubes into a cocktail shaker. Add the vodka and lime juice and shake well. Pour into a hurricane glass, top up with ginger beer and stir gently. Decorate with the slices.'),
(34, 'JELLYBABY', 1, '4.59000015258789', 'PUT GRENADINE IN COLLINS GLASS FIRST. ADD THE ICE AND PINEAPPLE JUICE. IN A MIXING TIN PUT ALL THE ALCOHOL AND MIX LIGHTLY. ONCE MIXED CAREFULLY FLOAT THE MIX ON TOP OF THE PINEAPPLE JUICE. ADD 2 STRAWS AS FINAL GARNISH.'),
(35, 'Indian Summer', 1, '3.53999996185303', 'Shake all the ingredients with cracked ice. Strain and pour into a tumbler.'),
(36, 'Last of the Architects', 1, '4.59999990463257', 'Shake a shot of Apple Juice with a shot of Bison Grass Vodka straight from the freezer & pour into a tall champagne flute. Add roughly two shots of chilled champagne & gently mix with a cocktail stick. Top up with Lemonade & dust with edible Pearl dust be'),
(37, 'Vodka Twister Fizz', 1, '2.42000007629395', 'Put the ice cubes into a cocktail shaker. Pour the lemon juice, sugar syrup, egg white, pernod and vodka over the ice and shake. Pour into a highball glass and top up with ginger ale.'),
(38, 'Cheeky Vimto', 1, '4.32999992370605', 'None'),
(39, 'Grandpa is Alive', 1, '4.28000020980835', 'None'),
(40, 'Madam I\'m Adam', 1, '4.30999994277954', 'None'),
(41, 'Slippery nipple (3)', 1, '4.23000001907349', 'Use a large shot glass.'),
(42, 'Bull Frog', 1, '4.53999996185303', 'Take a pint glass, add plenty of ice and begin to pour in each shot in any particular order, but usually blue curacao last. Then pour in the full can of red bull. If the cocktail has been made and stirred properly it should be a nice jade green colour and'),
(43, 'Vodka \'7\'', 1, '4.03000020980835', 'Pour vodka and juice of the lime into a collins glass over several ice cubes. Drop the lime wedge in glass and fill with lemon-lime soda. Stir well and serve.'),
(44, 'Top Banana', 1, '4.09000015258789', 'Mix the ingredients in a blender. Strain and pour into a highball glass over ice.'),
(45, 'Mofo', 1, '2.42000007629395', 'Layer in a rocks glass.'),
(46, 'Look At The Ceiling', 1, '2.52999997138977', 'None'),
(47, 'Jackhammer', 1, '3.28999996185303', 'Stir in a highball glass and fill with pineapple juice.'),
(48, 'Twister Shooter', 1, '3.98000001907349', 'Layer in a shot glass.'),
(49, 'Flying Grasshopper', 1, '2.40000009536743', 'Shake all the ingredients with the cracked ice. Strain and pour into a highball glass.'),
(50, 'Down Under Fizz', 1, '3.90000009536743', 'Put the ice cubes into a cocktail shaker. Pour the lemon and orange juices, grenadine and vodka over the ice and shake. Pour into a collins glass and top up with soda water.'),
(51, 'Georgia Peach', 1, '3.57999992370605', 'Pour first 3 ingredients into a Collins glass filled with ice. Fill with lemonade.'),
(52, 'Abortion shot', 1, '3.21000003814697', 'Combine. Serve.'),
(53, 'Hairy Navel', 1, '4.23000001907349', 'Stir in a highball glass and fill with orange juice.'),
(54, 'Flaming lamborgini', 1, '4.23999977111816', 'In a coctail glass, mix Kalhua, Amaretto, and Vodka. Float the  Chartreusse. In a liqueur glass, put the Blue Curaco and float the Milk. Light the cocktail glass and drink quickly through a straw. When it\'s almost gone, pour the Blue Curaco and milk into '),
(55, 'Vodka Sazerac', 1, '3.45000004768372', 'Put the sugar cube into an old fashioned glass and shake the bitters on to it. Add the pernod to the glass and swirl it. Drop in the ice cubes and pour in the vodka. Top up with lemonade and stir gently.'),
(56, 'Bubblegum', 1, '4.19000005722046', 'Put equal quantity of each part into a shaker and shake. Also be made as a cocktail.'),
(57, 'Broadside', 1, '5.00000000000000', 'Fill a shaker half full with ice cubes.  Pour all ingredients into shaker and shake well.  Strain drink into a Cocktail glass and serve.'),
(58, 'Save the Planet', 1, '4.19999980926514', 'Shake all the ingredients with cracked ice. Strain and pour into a cocktail glass.'),
(59, 'Pipeline', 1, '2.90000009536743', 'Layer in a shot glass.'),
(60, 'Thin blue line', 1, '4.30999994277954', 'Pour in the triple sec then the vodka on top. Then with a straw, add the blue curacao to create a thin blue line between the two layers!'),
(61, 'Venetian Lagoon', 1, '3.20000004768372', 'None'),
(62, 'Huntsman Cocktail', 1, '3.60999989509583', 'Shake with ice and strain into a cocktail glass.'),
(63, 'TVR', 1, '4.00000000000000', 'None'),
(64, 'Bat Out of Hell', 1, '2.71000003814697', 'None'),
(65, 'Fairy Liquid', 1, '1.89999997615814', 'Place it all in a glass and mix! Add ice to taste'),
(66, 'Tic-Tac', 1, '4.55999994277954', 'None'),
(67, 'Cryptonite', 1, '3.29999995231628', 'Pour vodka over ice and add creme de menthe. Add half measure champagne and top up with red bull. Finish with juice of lime and slice of lime. Serve in a tall slim glass.'),
(68, 'Drumstick', 1, '2.66000008583069', 'I stumbled across this recipes by accident trying to replicate the taste of kiddies drumstick lollypops (which make an awesome garnish!)just by adding the flavours as i went. however just whack em all in a shaker (minus the r/bull obviously!)give em a qui'),
(69, 'snoop dog', 1, '3.22000002861023', 'None'),
(70, 'Jodie\'s JD Punisher', 1, '4.19999980926514', 'Put jack daniels and 1/2 can of red bull into a shaker, shake for 30 seconds. Pour into a lowball glass over ice. Add rest of red bull if desired.'),
(71, 'Niagra', 1, '4.50000000000000', 'Place the ice cubes into a long glass. Pour in Vodka then the Curacao. At this point the drink should be blue. Top up with Red bull and the drink will go green, with bubblegum taste.'),
(72, 'Metadream', 2, '4.19999980926514', 'None'),
(73, 'Killer', 1, '3.68000006675720', 'None'),
(74, 'Green Mist', 1, '4.69999980926514', 'Pour three measures Curacao into a tall glass, add Vodka and Rum (Bacardi if poss.), top up with Red Bull. Add, or change spirits to suit you!'),
(75, 'Crazy Mexican', 1, '3.25000000000000', 'get drunk'),
(76, 'Red Diesel', 4, '4.00000000000000', 'None'),
(77, 'Jager-bomb', 1, '4.69999980926514', 'Place Jagermeister in a shotglass and the place the shotglass in a tumbler. Fill the tumbler with redbull, without mixing it with the shot. Pour Jagermeister only half way to the shotglass.'),
(78, 'Cranberry Boost', 5, '4.00000000000000', 'Im not sure of the parts. But in a blender, put lots of ice cubes.Then a lot of Cranberry Vodka(like FINLANDIA CRANBERRY),or use vodka with cranberry Juice.Pour 1/4 of peach fruit wine (like boones), 1 red bull and top with 7-up.Blend carefully (because o'),
(79, 'Jagabomb', 1, '5.00000000000000', 'Drop 1 shot glass of Jagermeister into a large glass and then fill the glass with Red Bull so as the shot glass is floating and drink altoghether trying not to spill any of it'),
(80, 'Jumping Jack Flash', 1, '4.59999990463257', 'Just mix them'),
(81, 'Boyakasha', 1, '4.30000019073486', 'Add all ingredients together, mix welll..and enjoy the pleasure of BOYAKASHA..'),
(82, 'Ribenaberry', 1, '4.00000000000000', 'None'),
(83, 'Mens viagra', 1, '2.00000000000000', 'Put ice in glass pour in vodka then blue curacao, fill glass with red bull..'),
(84, 'Chernobyl', 1, '5.00000000000000', 'All ingredients put in shaker, accept Red bull and fruit. put a lot of ice cube in highball glas then empty the shaker in. at the end fill glas with Red bull and put the fruit on the edge of glas...'),
(85, 'Soft Kiss', 1, '4.59999990463257', 'Pour the vodka and schnapps into a tall glass. Top up with Red Bull (a full can if possible). To garnish use the orange slice and cherry on a cocktail stick.'),
(86, 'T n T (Tropical Tequila)', 1, '3.40000009536743', 'Put orange slice/wedge in highball glass. Mix together the dash of lemon,vodka, rum, red bull and peach schnapps with 2 ice cubes and shake.Pour into glass ontop of orange. Pierce orange & leave for 5 mins. Top up with mainly cranberry juice.Add 1/2shot p'),
(87, 'Calpol On Steroids', 2, '4.19999980926514', 'None'),
(88, 'Flintstone Vitamin', 1, '5.00000000000000', 'Mix equal parts Jager. and Goldschlager in Goldschlager bottle. Pour off a double shot into a pounder glass and share a Red Bull with a friend and drink it up!'),
(89, 'Poor Man\'s Margarita', 1, '5.00000000000000', 'Mix the Gin, Lime Juice, and red bull into a blender with the ice. Blend until liquified. Use lime for garnish.'),
(90, 'Big Red Hooter #2', 2, '5.00000000000000', 'don\'t be too precise, serve with ice in a tall glass. Add more of one thing and less of another depending on tastes. Makes enough for at least 2, depending on how thirsty you are'),
(91, 'Virgin sunrise', 1, '2.00000000000000', 'Pour into a shaker with ice, shake and serve into a coktail glass with ice, lemon and orange slice'),
(92, 'Black Bull', 1, '0.00000000000000', 'None'),
(93, 'Bacoas green eyed monster', 1, '3.29999995231628', 'Add all the ingredients, shake and top up with red bull'),
(94, 'Last Order', 1, '0.00000000000000', 'Make sure red bull, schnapps and juice are all cool. Place all ingredients in shaker in order listed. Shake well, serve in cocktail glass and enjoy!'),
(95, 'the Disableiser', 1, '3.50000000000000', 'None'),
(96, 'nectar', 1, '4.19999980926514', 'Pour over ice and serve in a tumbler.'),
(97, 'Bull Fight', 1, '4.00000000000000', 'None'),
(98, 'peachy oozy floozy', 1, '0.00000000000000', 'pour in your 1 part ouzo then add your peach schnapps and blue curacao stir in a long glass and add your red bull to get a lovely shade of green  a very sweet and surprising taste to put you in the mood for anything'),
(99, 'Ala Trajce', 1, '5.00000000000000', 'Put the gin, ouzo, gold tequila, vodka and the white rum mix it and that put the rest of the ingredients put the lemon on the top'),
(100, 'Flamin Amy', 1, '2.00000000000000', 'None'),
(101, 'D-D-D', 1, '0.00000000000000', 'Mix emm all...perfect drink'),
(102, 'Pleasurable Jape', 1, '5.00000000000000', 'None'),
(103, 'Down in one Bubblegum', 1, '4.00000000000000', 'pour in the aftershock, pour in the redbull, cover the top of the glass and bang it off the bar/table and say \"Down in one Bubblegum\" before you drink it!'),
(104, 'A bita craic', 1, '4.40000009536743', 'None'),
(105, 'Green Parrot', 1, '5.00000000000000', 'None'),
(106, 'Like a j.lo.', 1, '5.00000000000000', 'In a shaker half-filled with ice cubes,combine vodka,wine and creme de cacao.Shake well.Strein in the high ball glass and top up with red bull. CHIN,CHIN'),
(107, 'Mad Cow\'s Moo', 1, '0.00000000000000', 'None'),
(108, 'Bubblegum #2', 1, '0.00000000000000', 'None'),
(109, 'Bull Rush', 1, '0.00000000000000', 'None'),
(110, 'long beach sunrise', 1, '5.00000000000000', 'Fill glass with ice.  Pour measure of Absolut Mandrin and Rebull.  Slowly pour in measure of cranberry juice as to create sunrise affect.  It is beautiful and delicious.  Long Beach Gloucester, MA, USA'),
(111, 'The Green Eyed Monster', 1, '4.00000000000000', 'Pour the Vodka and Blue Curacao (VK Blue) over ice. Top it off with red bull and stir before serving'),
(112, 'Green Dragon #2', 1, '0.00000000000000', 'Put 2 parts voka in 1/2 pint glass, add 1 part after skock (blue),add 5 ice cubes,then top up with red bull'),
(113, 'Greek bull', 1, '5.00000000000000', 'In usual class put crushed ice and strawberry syrup, the add Ouzo and at the end fill it with red bull..... do not drink with a srew'),
(114, 'Katatonic', 3, '4.69999980926514', 'I made this using a half bottle of vodka, a good bit of Watermelon Bacardi (couldnt find it on the site!), and all the other ingredients here, splashed it around in a jug and hey presto, a very strong drink that tastes good and will get you 100% wasted ve'),
(115, 'Gee\'s Aspirin', 1, '4.00000000000000', 'Fill glass with ice,pour the SC,add the Triple sec,fill with red bull and don\'t forget the lime juice! was testing it and apparently it reminds people of Kid\'s medicine and they love it! aaaah nostalgia!'),
(116, 'Cuban Fire', 1, '3.00000000000000', 'Just mix and enjoy!'),
(117, 'BULL BY THE HORNS', 1, '5.00000000000000', 'MIX THE VODKA, RUM, AMARETTO & SOUTHERN COMFORT IN A MIXING TIN. PLACE THE MIX INTO A COLLINGS GLASS AND ADD HALF THE CAN OF REDBULL. TAKE THE SCOOP OF CRUSHED ICE AND CAP THE COCKTAIL. DRIZZEL THE LIME JUICE OVER THE ICE & TOP WITH THE LIME SLICE.'),
(118, 'Tangy tutti frutti with a twist', 10, '4.50000000000000', 'This can be for any amount of people just add more juices but add a little more cranberry juice than orange juice as this will make a nicer flavour then just add the others required to taste as the more lime/ redbull the tangier it\'ll be. Just put all the'),
(119, 'Ccad', 1, '3.50000000000000', 'Half fill a tall glass with ice, add the Tequila, vodka and curacao, as much or as little as you wish. Top up with Red Bull and garnish with a cocktail stick that has a slice of orange folded over a cocktail cherry.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Bottle`
--
ALTER TABLE `Bottle`
  ADD PRIMARY KEY (`bottle_id`);

--
-- Indexes for table `Classifier`
--
ALTER TABLE `Classifier`
  ADD PRIMARY KEY (`classifier_id`);

--
-- Indexes for table `Histogram`
--
ALTER TABLE `Histogram`
  ADD PRIMARY KEY (`histogram_id`);

--
-- Indexes for table `Ingredient`
--
ALTER TABLE `Ingredient`
  ADD PRIMARY KEY (`ingredient_id`);

--
-- Indexes for table `Measure`
--
ALTER TABLE `Measure`
  ADD PRIMARY KEY (`measure_id`),
  ADD KEY `IngredientMeasure` (`ingredient_id`),
  ADD KEY `RecipeMeasure` (`recipe_id`);

--
-- Indexes for table `Recipe`
--
ALTER TABLE `Recipe`
  ADD PRIMARY KEY (`recipe_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Bottle`
--
ALTER TABLE `Bottle`
  MODIFY `bottle_id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `Classifier`
--
ALTER TABLE `Classifier`
  MODIFY `classifier_id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `Histogram`
--
ALTER TABLE `Histogram`
  MODIFY `histogram_id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `Ingredient`
--
ALTER TABLE `Ingredient`
  MODIFY `ingredient_id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;
--
-- AUTO_INCREMENT for table `Measure`
--
ALTER TABLE `Measure`
  MODIFY `measure_id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=558;
--
-- AUTO_INCREMENT for table `Recipe`
--
ALTER TABLE `Recipe`
  MODIFY `recipe_id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `Measure`
--
ALTER TABLE `Measure`
  ADD CONSTRAINT `IngredientMeasure` FOREIGN KEY (`ingredient_id`) REFERENCES `Ingredient` (`ingredient_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `RecipeMeasure` FOREIGN KEY (`recipe_id`) REFERENCES `Recipe` (`recipe_id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
