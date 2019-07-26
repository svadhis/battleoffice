-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Jul 26, 2019 at 02:52 PM
-- Server version: 10.3.13-MariaDB-1:10.3.13+maria~bionic
-- PHP Version: 7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `elonico_battleoffice`
--

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `id` int(11) NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address1` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address2` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postal_code` int(11) NOT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`id`, `first_name`, `last_name`, `address1`, `address2`, `city`, `postal_code`, `country`, `phone`, `email`) VALUES
(125, 'd', 'd', 'd', 'd', 'd', 54321, 'France', '654321', 'd@rg.fr'),
(126, 'Uma', 'Gibson', '93 Green Fabien Parkway', 'Qui vel assumenda sed sed voluptas', 'Dolorem tempore do ducimus sit est consectetur qui vitae laboriosam reprehenderit tenetur ut', 40, 'France', '+1 (891) 395-9788', 'faqolu@mailinator.com'),
(127, 'Cherokee', 'Copeland', '77 Hague Street', 'Ut saepe architecto esse minima a sunt aut accusantium voluptatibus illo sequi aliquam occaecat ratione quo sequi elit qui', 'Ut autem porro mollitia cumque est fugiat laborum Ea aut atque omnis iure et asperiores ex et exercitation ea porro', 56, 'France', '+1 (151) 839-6261', 'dotiq@mailinator.com'),
(128, 'Herrod', 'Ashley', '911 North Green Oak Lane', 'Omnis atque quo labore nulla eum suscipit minima accusamus perferendis asperiores', 'Dolores pariatur Quod ipsam asperiores', 68, 'France', '+1 (473) 229-5148', 'bolyvybav@mailinator.com'),
(129, 'Quinlan', 'Hester', '372 South White Old Lane', 'Earum consequuntur reiciendis consequat Nulla quo non excepturi quis saepe exercitationem tenetur exercitation est provident similique consequatur', 'Dolorem sint quis deserunt autem error magni dolor nisi reiciendis sit', 26, 'France', '+1 (275) 259-5566', 'tevet@mailinator.net'),
(130, 'Jerry', 'William', '55 Green Second Drive', 'Quisquam tempora sit beatae esse anim porro qui non est nisi quia non distinctio', 'Voluptatem Perferendis corporis doloribus vel', 43, 'France', '+1 (431) 985-9704', 'xozy@mailinator.net'),
(131, 'Maggie', 'Hughes', '98 Second Parkway', 'Consequatur corporis culpa sapiente minima voluptatem tempore et consectetur sint quibusdam non sint velit dolor possimus consequuntur', 'Voluptas aut consectetur est dicta est unde alias sint est voluptas sit voluptates quasi repellendus Ullam earum', 93, 'France', '+1 (412) 988-7989', 'karyf@mailinator.net'),
(132, 'Jena', 'Barnett', '32 White Hague Parkway', 'Quia recusandae Ipsam quis et vel voluptatem dolores nulla molestiae', 'Cum fugiat deserunt asperiores incidunt', 85, 'France', '+1 (639) 584-1227', 'cokonebap@mailinator.net'),
(133, 'Jillian', 'Humphrey', '53 Fabien Drive', 'Aliquip aperiam minima dolor ea qui unde et velit neque nemo fuga Aperiam veritatis', 'Excepturi qui repellendus Voluptas aliquam soluta', 41, 'France', '+1 (387) 129-4028', 'rykobupy@mailinator.net'),
(134, 'Talon', 'Cruz', '207 Second Boulevard', 'Qui libero inventore voluptatem voluptatibus', 'Sed eligendi obcaecati sed provident autem ipsum', 52, 'France', '+1 (723) 584-2905', 'sutis@mailinator.com');

-- --------------------------------------------------------

--
-- Table structure for table `migration_versions`
--

CREATE TABLE `migration_versions` (
  `version` varchar(14) COLLATE utf8mb4_unicode_ci NOT NULL,
  `executed_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migration_versions`
--

INSERT INTO `migration_versions` (`version`, `executed_at`) VALUES
('20190722081406', '2019-07-22 08:14:40');

-- --------------------------------------------------------

--
-- Table structure for table `ordering`
--

CREATE TABLE `ordering` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `address1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` int(11) DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ordering`
--

INSERT INTO `ordering` (`id`, `client_id`, `product_id`, `address1`, `address2`, `city`, `postal_code`, `country`, `phone`, `payment_type`, `status_message`, `api_id`) VALUES
(109, 125, 3, NULL, NULL, NULL, NULL, 'France', NULL, 'paypal', 'Order successfully saved and PAID', 65),
(110, 126, 3, NULL, NULL, NULL, NULL, 'France', NULL, 'stripe', 'Order successfully saved and PAID', 74),
(111, 127, 2, NULL, NULL, NULL, NULL, 'France', NULL, 'stripe', 'Order successfully saved', 155),
(112, 128, 1, NULL, NULL, NULL, NULL, 'France', NULL, 'stripe', 'Order successfully saved', 174),
(113, 129, 3, NULL, NULL, NULL, NULL, 'France', NULL, 'stripe', 'Order successfully saved', 175),
(114, 130, 1, NULL, NULL, NULL, NULL, 'France', NULL, 'stripe', 'Order successfully saved', 178),
(115, 131, 3, NULL, NULL, NULL, NULL, 'France', NULL, 'stripe', 'Order successfully saved', 191),
(116, 132, 1, NULL, NULL, NULL, NULL, 'France', NULL, 'stripe', 'Order successfully saved', 197),
(117, 133, 2, NULL, NULL, NULL, NULL, 'France', NULL, 'stripe', 'Order successfully saved', 218),
(118, 134, 1, NULL, NULL, NULL, NULL, 'France', NULL, 'stripe', 'Order successfully saved and PAID', 233);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `regular_price` int(11) NOT NULL,
  `reduced_price` int(11) NOT NULL,
  `base_quantity` int(11) NOT NULL,
  `offered_quantity` int(11) NOT NULL,
  `popular` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `regular_price`, `reduced_price`, `base_quantity`, `offered_quantity`, `popular`) VALUES
(1, 'Nerf© Elite Jolt', 9490, 6490, 10, 4, 0),
(2, 'Nerf© Elite Disruptor', 7990, 5190, 4, 2, 1),
(3, 'Nerf© Elite Rapid Strike', 5990, 3990, 1, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migration_versions`
--
ALTER TABLE `migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `ordering`
--
ALTER TABLE `ordering`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_F529939819EB6921` (`client_id`),
  ADD KEY `UNIQ_F52993984584665A` (`product_id`) USING BTREE;

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=135;

--
-- AUTO_INCREMENT for table `ordering`
--
ALTER TABLE `ordering`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ordering`
--
ALTER TABLE `ordering`
  ADD CONSTRAINT `FK_F529939819EB6921` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
  ADD CONSTRAINT `FK_F52993984584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
