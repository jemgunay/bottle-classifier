-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 19, 2017 at 02:19 am
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
(1, 'classifier_vodka/classifier_second/cascade.xml', '', 80, 150, 30, 10, 1),
(2, 'classifier_jd/classifier_second/cascade.xml', '', 0, 0, 0, 0, 0),
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
  `action` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
(81, 'Sugar');

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
(286, 62, 81, 'dash of');

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
(62, 'Huntsman Cocktail', 1, '3.60999989509583', 'Shake with ice and strain into a cocktail glass.');

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
  MODIFY `histogram_id` smallint(6) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Ingredient`
--
ALTER TABLE `Ingredient`
  MODIFY `ingredient_id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;
--
-- AUTO_INCREMENT for table `Measure`
--
ALTER TABLE `Measure`
  MODIFY `measure_id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=287;
--
-- AUTO_INCREMENT for table `Recipe`
--
ALTER TABLE `Recipe`
  MODIFY `recipe_id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;
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
