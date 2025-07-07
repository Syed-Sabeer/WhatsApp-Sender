-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 07, 2025 at 06:25 PM
-- Server version: 11.7.2-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `whatsapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `company_settings`
--

CREATE TABLE `company_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `country_id` bigint(20) UNSIGNED DEFAULT NULL,
  `dark_logo` varchar(255) DEFAULT NULL,
  `light_logo` varchar(255) DEFAULT NULL,
  `favicon` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `about` text DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `facebook_url` varchar(255) DEFAULT NULL,
  `linkedin_url` varchar(255) DEFAULT NULL,
  `instagram_url` varchar(255) DEFAULT NULL,
  `twitter_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `phone_code` varchar(255) NOT NULL,
  `phone_number_limit` varchar(255) NOT NULL,
  `is_active` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `name`, `code`, `phone_code`, `phone_number_limit`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Afghanistan', 'AF', '+93', '9', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(2, 'Åland Islands', 'AX', '+358', '10', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(3, 'Albania', 'AL', '+355', '9', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(4, 'Algeria', 'DZ', '+213', '9', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(5, 'American Samoa', 'AS', '+1684', '7', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(6, 'Andorra', 'AD', '+376', '9', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(7, 'Angola', 'AO', '+244', '9', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(8, 'Anguilla', 'AI', '+1264', '7', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(9, 'Antarctica', 'AQ', '+672', '6', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(10, 'Antigua and Barbuda', 'AG', '+1268', '7', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(11, 'Argentina', 'AR', '+54', '10', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(12, 'Armenia', 'AM', '+374', '8', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(13, 'Aruba', 'AW', '+297', '7', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(14, 'Australia', 'AU', '+61', '9', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(15, 'Austria', 'AT', '+43', '10', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(16, 'Azerbaijan', 'AZ', '+994', '9', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(17, 'Bahamas', 'BS', '+1242', '7', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(18, 'Bahrain', 'BH', '+973', '8', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(19, 'Bangladesh', 'BD', '+880', '10', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(20, 'Barbados', 'BB', '+1246', '7', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(21, 'Belarus', 'BY', '+375', '9', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(22, 'Belgium', 'BE', '+32', '9', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(23, 'Belize', 'BZ', '+501', '7', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(24, 'Benin', 'BJ', '+229', '8', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(25, 'Bermuda', 'BM', '+1441', '7', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(26, 'Bhutan', 'BT', '+975', '8', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(27, 'Bolivia, Plurinational State of', 'BO', '+591', '8', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(28, 'Bonaire, Sint Eustatius and Saba', 'BQ', '+599', '7', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(29, 'Bosnia and Herzegovina', 'BA', '+387', '8', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(30, 'Botswana', 'BW', '+267', '8', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(31, 'Bouvet Island', 'BV', '+55', '10', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(32, 'Brazil', 'BR', '+55', '10', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(33, 'British Indian Ocean Territory', 'IO', '+246', '7', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(34, 'Brunei Darussalam', 'BN', '+673', '7', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(35, 'Bulgaria', 'BG', '+359', '9', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(36, 'Burkina Faso', 'BF', '+226', '8', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(37, 'Burundi', 'BI', '+257', '8', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(38, 'Cambodia', 'KH', '+855', '8', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(39, 'Cameroon', 'CM', '+237', '9', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(40, 'Canada', 'CA', '+1', '10', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(41, 'Cape Verde', 'CV', '+238', '7', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(42, 'Cayman Islands', 'KY', '+1345', '7', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(43, 'Central African Republic', 'CF', '+236', '9', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(44, 'Chad', 'TD', '+235', '9', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(45, 'Chile', 'CL', '+56', '9', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(46, 'China', 'CN', '+86', '11', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(47, 'Christmas Island', 'CX', '+61', '9', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(48, 'Cocos (Keeling) Islands', 'CC', '+61', '9', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(49, 'Colombia', 'CO', '+57', '10', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(50, 'Comoros', 'KM', '+269', '7', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(51, 'Congo', 'CG', '+242', '9', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(52, 'Congo, the Democratic Republic of the', 'CD', '+243', '9', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(53, 'Cook Islands', 'CK', '+682', '5', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(54, 'Costa Rica', 'CR', '+506', '8', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(55, 'Côte d\'Ivoire', 'CI', '+225', '8', 'active', '2025-07-04 09:31:05', '2025-07-04 09:31:05'),
(56, 'Croatia', 'HR', '+385', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(57, 'Cuba', 'CU', '+53', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(58, 'Curaçao', 'CW', '+599', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(59, 'Cyprus', 'CY', '+357', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(60, 'Czech Republic', 'CZ', '+420', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(61, 'Denmark', 'DK', '+45', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(62, 'Djibouti', 'DJ', '+253', '6', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(63, 'Dominica', 'DM', '+1767', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(64, 'Dominican Republic', 'DO', '+1809', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(65, 'Ecuador', 'EC', '+593', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(66, 'Egypt', 'EG', '+20', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(67, 'El Salvador', 'SV', '+503', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(68, 'Equatorial Guinea', 'GQ', '+240', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(69, 'Eritrea', 'ER', '+291', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(70, 'Estonia', 'EE', '+372', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(71, 'Eswatini', 'SZ', '+268', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(72, 'Ethiopia', 'ET', '+251', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(73, 'Falkland Islands (Malvinas)', 'FK', '+500', '5', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(74, 'Faroe Islands', 'FO', '+298', '6', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(75, 'Fiji', 'FJ', '+679', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(76, 'Finland', 'FI', '+358', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(77, 'France', 'FR', '+33', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(78, 'French Guiana', 'GF', '+594', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(79, 'French Polynesia', 'PF', '+689', '6', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(80, 'French Southern Territories', 'TF', '+262', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(81, 'Gabon', 'GA', '+241', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(82, 'Gambia', 'GM', '+220', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(83, 'Georgia', 'GE', '+995', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(84, 'Germany', 'DE', '+49', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(85, 'Ghana', 'GH', '+233', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(86, 'Gibraltar', 'GI', '+350', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(87, 'Greece', 'GR', '+30', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(88, 'Greenland', 'GL', '+299', '6', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(89, 'Grenada', 'GD', '+1473', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(90, 'Guadeloupe', 'GP', '+590', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(91, 'Guam', 'GU', '+1671', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(92, 'Guatemala', 'GT', '+502', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(93, 'Guernsey', 'GG', '+44', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(94, 'Guinea', 'GN', '+224', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(95, 'Guinea-Bissau', 'GW', '+245', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(96, 'Guyana', 'GY', '+592', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(97, 'Haiti', 'HT', '+509', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(98, 'Heard Island and McDonald Islands', 'HM', '+672', '6', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(99, 'Holy See (Vatican City State)', 'VA', '+39', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(100, 'Honduras', 'HN', '+504', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(101, 'Hong Kong', 'HK', '+852', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(102, 'Hungary', 'HU', '+36', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(103, 'Iceland', 'IS', '+354', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(104, 'India', 'IN', '+91', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(105, 'Indonesia', 'ID', '+62', '11', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(106, 'Iran', 'IR', '+98', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(107, 'Iraq', 'IQ', '+964', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(108, 'Ireland', 'IE', '+353', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(109, 'Isle of Man', 'IM', '+44', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(110, 'Israel', 'IL', '+972', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(111, 'Italy', 'IT', '+39', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(112, 'Jamaica', 'JM', '+1876', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(113, 'Japan', 'JP', '+81', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(114, 'Jersey', 'JE', '+44', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(115, 'Jordan', 'JO', '+962', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(116, 'Kazakhstan', 'KZ', '+7', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(117, 'Kenya', 'KE', '+254', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(118, 'Kiribati', 'KI', '+686', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(119, 'North Korea', 'KP', '+850', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(120, 'South Korea', 'KR', '+82', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(121, 'Kuwait', 'KW', '+965', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(122, 'Kyrgyzstan', 'KG', '+996', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(123, 'Lao People\'s Democratic Republic', 'LA', '+856', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(124, 'Latvia', 'LV', '+371', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(125, 'Lebanon', 'LB', '+961', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(126, 'Lesotho', 'LS', '+266', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(127, 'Liberia', 'LR', '+231', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(128, 'Libya', 'LY', '+218', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(129, 'Liechtenstein', 'LI', '+423', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(130, 'Lithuania', 'LT', '+370', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(131, 'Luxembourg', 'LU', '+352', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(132, 'Macao', 'MO', '+853', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(133, 'Macedonia, the Former Yugoslav Republic of', 'MK', '+389', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(134, 'Madagascar', 'MG', '+261', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(135, 'Malawi', 'MW', '+265', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(136, 'Malaysia', 'MY', '+60', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(137, 'Maldives', 'MV', '+960', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(138, 'Mali', 'ML', '+223', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(139, 'Malta', 'MT', '+356', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(140, 'Marshall Islands', 'MH', '+692', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(141, 'Martinique', 'MQ', '+596', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(142, 'Mauritania', 'MR', '+222', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(143, 'Mauritius', 'MU', '+230', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(144, 'Mayotte', 'YT', '+262', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(145, 'Mexico', 'MX', '+52', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(146, 'Micronesia', 'FM', '+691', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(147, 'Moldova, Republic of', 'MD', '+373', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(148, 'Monaco', 'MC', '+377', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(149, 'Mongolia', 'MN', '+976', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(150, 'Montenegro', 'ME', '+382', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(151, 'Montserrat', 'MS', '+1664', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(152, 'Morocco', 'MA', '+212', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(153, 'Mozambique', 'MZ', '+258', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(154, 'Myanmar', 'MM', '+95', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(155, 'Namibia', 'NA', '+264', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(156, 'Nauru', 'NR', '+674', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(157, 'Nepal', 'NP', '+977', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(158, 'Netherlands', 'NL', '+31', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(159, 'New Caledonia', 'NC', '+687', '6', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(160, 'New Zealand', 'NZ', '+64', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(161, 'Nicaragua', 'NI', '+505', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(162, 'Niger', 'NE', '+227', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(163, 'Nigeria', 'NG', '+234', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(164, 'Niue', 'NU', '+683', '4', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(165, 'Norfolk Island', 'NF', '+672', '6', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(166, 'Northern Mariana Islands', 'MP', '+1670', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(167, 'Norway', 'NO', '+47', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(168, 'Oman', 'OM', '+968', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(169, 'Pakistan', 'PK', '+92', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(170, 'Palau', 'PW', '+680', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(171, 'Palestine, State of', 'PS', '+970', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(172, 'Panama', 'PA', '+507', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(173, 'Papua New Guinea', 'PG', '+675', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(174, 'Paraguay', 'PY', '+595', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(175, 'Peru', 'PE', '+51', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(176, 'Philippines', 'PH', '+63', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(177, 'Pitcairn', 'PN', '+64', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(178, 'Poland', 'PL', '+48', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(179, 'Portugal', 'PT', '+351', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(180, 'Puerto Rico', 'PR', '+1939', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(181, 'Qatar', 'QA', '+974', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(182, 'Réunion', 'RE', '+262', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(183, 'Romania', 'RO', '+40', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(184, 'Russian Federation', 'RU', '+7', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(185, 'Rwanda', 'RW', '+250', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(186, 'Saint Barthélemy', 'BL', '+590', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(187, 'Saint Helena', 'SH', '+290', '4', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(188, 'Saint Kitts and Nevis', 'KN', '+1869', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(189, 'Saint Lucia', 'LC', '+1758', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(190, 'Saint Martin (French part)', 'MF', '+590', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(191, 'Saint Pierre and Miquelon', 'PM', '+508', '6', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(192, 'Saint Vincent and the Grenadines', 'VC', '+1784', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(193, 'Samoa', 'WS', '+685', '6', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(194, 'San Marino', 'SM', '+378', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(195, 'Sao Tome and Principe', 'ST', '+239', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(196, 'Saudi Arabia', 'SA', '+966', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(197, 'Senegal', 'SN', '+221', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(198, 'Serbia', 'RS', '+381', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(199, 'Seychelles', 'SC', '+248', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(200, 'Sierra Leone', 'SL', '+232', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(201, 'Singapore', 'SG', '+65', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(202, 'Sint Maarten (Dutch part)', 'SX', '+1721', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(203, 'Slovakia', 'SK', '+421', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(204, 'Slovenia', 'SI', '+386', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(205, 'Solomon Islands', 'SB', '+677', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(206, 'Somalia', 'SO', '+252', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(207, 'South Africa', 'ZA', '+27', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(208, 'South Georgia and the South Sandwich Islands', 'GS', '+500', '5', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(209, 'South Sudan', 'SS', '+211', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(210, 'Spain', 'ES', '+34', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(211, 'Sri Lanka', 'LK', '+94', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(212, 'Sudan', 'SD', '+249', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(213, 'Suriname', 'SR', '+597', '6', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(214, 'Svalbard and Jan Mayen', 'SJ', '+47', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(215, 'Sweden', 'SE', '+46', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(216, 'Switzerland', 'CH', '+41', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(217, 'Syrian Arab Republic', 'SY', '+963', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(218, 'Taiwan, Province of China', 'TW', '+886', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(219, 'Tajikistan', 'TJ', '+992', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(220, 'Tanzania, United Republic of', 'TZ', '+255', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(221, 'Thailand', 'TH', '+66', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(222, 'Timor-Leste', 'TL', '+670', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(223, 'Togo', 'TG', '+228', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(224, 'Tokelau', 'TK', '+690', '4', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(225, 'Tonga', 'TO', '+676', '5', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(226, 'Trinidad and Tobago', 'TT', '+1868', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(227, 'Tunisia', 'TN', '+216', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(228, 'Turkey', 'TR', '+90', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(229, 'Turkmenistan', 'TM', '+993', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(230, 'Tuvalu', 'TV', '+688', '5', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(231, 'Uganda', 'UG', '+256', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(232, 'Ukraine', 'UA', '+380', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(233, 'United Arab Emirates', 'AE', '+971', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(234, 'United Kingdom', 'GB', '+44', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(235, 'United States', 'US', '+1', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(236, 'Uruguay', 'UY', '+598', '8', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(237, 'Uzbekistan', 'UZ', '+998', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(238, 'Vanuatu', 'VU', '+678', '7', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(239, 'Venezuela', 'VE', '+58', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(240, 'Viet Nam', 'VN', '+84', '10', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(241, 'Wallis and Futuna', 'WF', '+681', '6', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(242, 'Western Sahara', 'EH', '+212', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(243, 'Yemen', 'YE', '+967', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(244, 'Zambia', 'ZM', '+260', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(245, 'Zimbabwe', 'ZW', '+263', '9', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06');

-- --------------------------------------------------------

--
-- Table structure for table `designations`
--

CREATE TABLE `designations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `designations`
--

INSERT INTO `designations` (`id`, `name`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Chief Executive Officer (CEO)', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(2, 'Chief Operating Officer (COO)', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(3, 'Chief Financial Officer (CFO)', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(4, 'Chief Technology Officer (CTO)', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(5, 'Chief Marketing Officer (CMO)', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(6, 'Managing Director', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(7, 'General Manager', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(8, 'Operations Manager', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(9, 'Project Manager', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(10, 'Product Manager', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(11, 'Human Resources Manager', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(12, 'Finance Manager', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(13, 'Software Engineer', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(14, 'Senior Software Engineer', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(15, 'Frontend Developer', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(16, 'Backend Developer', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(17, 'Full Stack Developer', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(18, 'UI/UX Designer', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(19, 'Quality Assurance Engineer', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(20, 'Data Analyst', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(21, 'Data Scientist', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(22, 'Network Administrator', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(23, 'Marketing Manager', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(24, 'Sales Manager', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(25, 'Customer Support Representative', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(26, 'Accountant', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(27, 'Business Analyst', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(28, 'Legal Advisor', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(29, 'Consultant', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(30, 'Research Analyst', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(31, 'Content Writer', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(32, 'Digital Marketing Specialist', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(33, 'Social Media Manager', 'active', '2025-07-04 09:31:07', '2025-07-04 09:31:07'),
(34, 'Administrative Assistant', 'active', '2025-07-04 09:31:07', '2025-07-04 09:31:07'),
(35, 'Receptionist', 'active', '2025-07-04 09:31:07', '2025-07-04 09:31:07'),
(36, 'Security Officer', 'active', '2025-07-04 09:31:07', '2025-07-04 09:31:07'),
(37, 'Office Assistant', 'active', '2025-07-04 09:31:07', '2025-07-04 09:31:07');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `file_messages`
--

CREATE TABLE `file_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mobile_number` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `original_filename` varchar(191) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `status` enum('pending','sent','failed') NOT NULL DEFAULT 'pending',
  `sent_at` timestamp NULL DEFAULT NULL,
  `failed_at` timestamp NULL DEFAULT NULL,
  `error_message` text DEFAULT NULL,
  `retry_count` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `file_messages`
--

INSERT INTO `file_messages` (`id`, `mobile_number`, `file_path`, `original_filename`, `file_name`, `file_size`, `status`, `sent_at`, `failed_at`, `error_message`, `retry_count`, `created_at`, `updated_at`) VALUES
(37, '923176198449', 'uploads/YGKsohftxtGkYE12GqWgfnT9jCGW7SFPAl5qhcWL.pdf', NULL, NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-05 09:36:04', '2025-07-05 09:36:04'),
(38, '923176198517', 'uploads/Ckadea1fmyMCmgH38dyNGnIfb15CqFfqbUb7EUD1.pdf', NULL, NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-05 09:36:04', '2025-07-05 09:36:05'),
(39, '923176198449', 'uploads/psxnmEzj2qBbsGU2RAEBMhinDyAX1kkxQZrBWuks.pdf', NULL, NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-05 10:37:49', '2025-07-05 10:39:52'),
(40, '923176198449', 'uploads/EPgdLvJhut1jvc2iCr8vPYqunrMuZKqPjkFjKTSn.pdf', NULL, NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-05 10:37:49', '2025-07-05 10:39:53'),
(41, '923176198517', 'uploads/sIZNfECeslLnFXdt8EVMC3KIaeiDtN56X4QJve7Q.pdf', NULL, NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-05 10:37:50', '2025-07-05 10:39:54'),
(42, '923198233793', 'uploads/nYRxGhEHgeOD8mB3idniNY6I0EB4QU5GsXlIBiKb.pdf', NULL, NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-05 10:37:50', '2025-07-05 10:39:55'),
(43, '923176198449', 'uploads/ZSriRZ0IA5Jw73ZaFiasjFXhjB7KakVcVkA1vcS3.pdf', NULL, NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-07 10:27:38', '2025-07-07 10:27:43'),
(44, '923176198449', 'uploads/2ZlBRjdzq2LtPRa2btT7XbyGPFThAVR05VnRdSAB.pdf', NULL, NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-07 10:27:38', '2025-07-07 10:27:44'),
(45, '923176198517', 'uploads/A0Vq15pvvIbt5WUvPwBMXDOg4m0AFxUrJQjIY1hm.pdf', NULL, NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-07 10:27:38', '2025-07-07 10:27:45'),
(46, '923198233793', 'uploads/f1skNO48fXnsNrDR8HcnDc4s8hjQFcheP42GA6Iv.pdf', NULL, NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-07 10:27:38', '2025-07-07 10:27:46'),
(47, '923176198449', 'uploads/UCtaqV5dn628GbQPO6zaXPdw6UGOY5Y9xHp8BYcq.pdf', '923176198449 - Copy.pdf', NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-07 11:12:22', '2025-07-07 11:12:25'),
(48, '923176198449', 'uploads/HfTFxt4Q8FJGj3yS1lOz3NJwTftda6oOKTgIrwtU.pdf', '923176198449.pdf', NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-07 11:12:22', '2025-07-07 11:12:26'),
(49, '923176198517', 'uploads/14ZVkUtHM3E7oJkr76EaiGnpo3sVjxlvwoq6mkd3.pdf', '923176198517.pdf', NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-07 11:12:22', '2025-07-07 11:12:27'),
(50, '923198233793', 'uploads/5TMTMNZXxoYiiFQLd51hKtqHFjtlV2u29QZXKlkD.pdf', '923198233793.pdf', NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-07 11:12:22', '2025-07-07 11:12:28'),
(51, '923176198449', 'uploads/FsPJNhDjAAMFVrpQS0mKqBwWVDpQ6pUxeHuNjMtQ.pdf', '923176198449.pdf', NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-07 11:21:14', '2025-07-07 11:21:14'),
(52, '923176198449', 'uploads/nSrpOfVknkFXW5vah2XgnY8QpTwuZAbamJhWIFGN.pdf', '923176198449 - Copy.pdf', NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-07 11:24:50', '2025-07-07 11:24:51'),
(53, '923176198449', 'uploads/OX1XqaxyLcMyyNrB3uEqRgpXm3tkbUZ1LustzrY0.pdf', '923176198449.pdf', NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-07 11:24:50', '2025-07-07 11:24:52'),
(54, '923176198517', 'uploads/opFhAyTIXjT33BzB18RDW67lFYs5QkQoxZ3GHazA.pdf', '923176198517.pdf', NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-07 11:24:50', '2025-07-07 11:24:53'),
(55, '923198233793', 'uploads/mqEx8nqzv3HR7ZwZyFMrC9Cv1adtO061eaqyvAuw.pdf', '923198233793.pdf', NULL, NULL, 'sent', NULL, NULL, NULL, 0, '2025-07-07 11:24:50', '2025-07-07 11:24:54');

-- --------------------------------------------------------

--
-- Table structure for table `genders`
--

CREATE TABLE `genders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `genders`
--

INSERT INTO `genders` (`id`, `name`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Male', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(2, 'Female', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(3, 'Non-Binary', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(4, 'Transgender Male', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(5, 'Transgender Female', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(6, 'Genderfluid', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(7, 'Agender', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(8, 'Bigender', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(9, 'Two-Spirit', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(10, 'Androgynous', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(11, 'Demiboy', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(12, 'Demigirl', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(13, 'Genderqueer', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(14, 'Intersex', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(15, 'Pangender', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(16, 'Neutrois', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(17, 'Questioning', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(18, 'Other', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(19, 'Prefer Not to Say', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `iso_code` varchar(255) NOT NULL,
  `native_name` varchar(255) NOT NULL,
  `is_active` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `iso_code`, `native_name`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'English', 'en', 'English', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(2, 'Spanish', 'es', 'Español', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(3, 'French', 'fr', 'Français', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(4, 'Chinese', 'zh', '中文', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(5, 'Arabic', 'ar', 'العربية', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(6, 'Hindi', 'hi', 'हिन्दी', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(7, 'Russian', 'ru', 'Русский', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(8, 'Portuguese', 'pt', 'Português', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(9, 'Bengali', 'bn', 'বাংলা', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(10, 'Urdu', 'ur', 'اردو', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(11, 'Japanese', 'ja', '日本語', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(12, 'German', 'de', 'Deutsch', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(13, 'Korean', 'ko', '한국어', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(14, 'Turkish', 'tr', 'Türkçe', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(15, 'Italian', 'it', 'Italiano', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(16, 'Persian', 'fa', 'فارسی', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(17, 'Dutch', 'nl', 'Nederlands', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(18, 'Swedish', 'sv', 'Svenska', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(19, 'Greek', 'el', 'Ελληνικά', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(20, 'Hebrew', 'he', 'עברית', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(21, 'Thai', 'th', 'ไทย', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(22, 'Vietnamese', 'vi', 'Tiếng Việt', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(23, 'Polish', 'pl', 'Polski', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(24, 'Romanian', 'ro', 'Română', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(25, 'Hungarian', 'hu', 'Magyar', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(26, 'Czech', 'cs', 'Čeština', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(27, 'Finnish', 'fi', 'Suomi', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(28, 'Malay', 'ms', 'Bahasa Melayu', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(29, 'Indonesian', 'id', 'Bahasa Indonesia', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(30, 'Norwegian', 'no', 'Norsk', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(31, 'Danish', 'da', 'Dansk', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(32, 'Slovak', 'sk', 'Slovenčina', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(33, 'Serbian', 'sr', 'Српски', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(34, 'Bulgarian', 'bg', 'Български', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(35, 'Lithuanian', 'lt', 'Lietuvių', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(36, 'Latvian', 'lv', 'Latviešu', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(37, 'Estonian', 'et', 'Eesti', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(38, 'Croatian', 'hr', 'Hrvatski', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(39, 'Slovenian', 'sl', 'Slovenščina', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(40, 'Swahili', 'sw', 'Kiswahili', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(41, 'Afrikaans', 'af', 'Afrikaans', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(42, 'Albanian', 'sq', 'Shqip', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(43, 'Armenian', 'hy', 'Հայերեն', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(44, 'Georgian', 'ka', 'ქართული', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(45, 'Pashto', 'ps', 'پښتو', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(46, 'Kurdish', 'ku', 'Kurdî', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(47, 'Sindhi', 'sd', 'سنڌي', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(48, 'Tamil', 'ta', 'தமிழ்', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(49, 'Telugu', 'te', 'తెలుగు', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(50, 'Marathi', 'mr', 'मराठी', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(51, 'Gujarati', 'gu', 'ગુજરાતી', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06');

-- --------------------------------------------------------

--
-- Table structure for table `marital_statuses`
--

CREATE TABLE `marital_statuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `marital_statuses`
--

INSERT INTO `marital_statuses` (`id`, `name`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Single', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(2, 'Married', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(3, 'Divorced', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(4, 'Widowed', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(5, 'Separated', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(6, 'Engaged', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(7, 'In a Relationship', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(8, 'It\'s Complicated', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(9, 'Domestic Partnership', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(10, 'Civil Union', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06'),
(11, 'Prefer Not to Say', 'active', '2025-07-04 09:31:06', '2025-07-04 09:31:06');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2025_05_21_203520_create_permission_tables', 1),
(6, '2025_05_22_202511_create_countries_table', 1),
(7, '2025_05_22_202520_create_languages_table', 1),
(8, '2025_05_22_202529_create_genders_table', 1),
(9, '2025_05_22_202546_create_marital_statuses_table', 1),
(10, '2025_05_22_202636_create_designations_table', 1),
(11, '2025_05_22_202637_create_timezones_table', 1),
(12, '2025_05_22_202638_create_company_settings_table', 1),
(13, '2025_05_22_202645_create_profiles_table', 1),
(14, '2025_05_22_203629_create_system_settings_table', 1),
(15, '2025_05_22_210323_create_notifications_table', 1),
(16, '2025_07_02_202413_create_file_messages_table', 1),
(17, '2025_07_02_212444_create_jobs_table', 1),
(18, '2025_07_03_055608_add_enhanced_fields_to_file_messages_table', 1),
(19, '2025_07_07_153439_add_original_filename_to_file_messages_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `message` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE `profiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `dob` timestamp NULL DEFAULT NULL,
  `gender_id` bigint(20) UNSIGNED DEFAULT NULL,
  `marital_status_id` bigint(20) UNSIGNED DEFAULT NULL,
  `language_id` bigint(20) UNSIGNED DEFAULT NULL,
  `designation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `country_id` bigint(20) UNSIGNED DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `bio` varchar(255) DEFAULT NULL,
  `facebook_url` varchar(255) DEFAULT NULL,
  `linkedin_url` varchar(255) DEFAULT NULL,
  `skype_url` varchar(255) DEFAULT NULL,
  `instagram_url` varchar(255) DEFAULT NULL,
  `github_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2025-07-04 09:31:05', '2025-07-04 09:31:05');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `max_upload_size` varchar(255) DEFAULT NULL,
  `currency_symbol` varchar(255) DEFAULT NULL,
  `currency_symbol_position` enum('prefix','postfix') NOT NULL DEFAULT 'prefix',
  `language_id` bigint(20) UNSIGNED DEFAULT NULL,
  `timezone_id` bigint(20) UNSIGNED DEFAULT NULL,
  `footer_text` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `timezones`
--

CREATE TABLE `timezones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `offset` varchar(255) NOT NULL,
  `is_active` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `is_active` enum('active','inactive') NOT NULL DEFAULT 'active',
  `provider` varchar(255) DEFAULT NULL,
  `provider_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `username`, `email_verified_at`, `password`, `remember_token`, `is_active`, `provider`, `provider_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Admin', 'admin@gmail.com', 'admin', NULL, '$2y$10$cIrKA9rsTzseQYxfupjY9.E2f/qnJu/RqUGaCGQGrHLVTfaTPZLRS', NULL, 'active', NULL, NULL, '2025-07-04 09:31:05', '2025-07-04 09:31:05', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `company_settings`
--
ALTER TABLE `company_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_settings_country_id_foreign` (`country_id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `designations`
--
ALTER TABLE `designations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `file_messages`
--
ALTER TABLE `file_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `file_messages_status_created_at_index` (`status`,`created_at`),
  ADD KEY `file_messages_mobile_number_index` (`mobile_number`);

--
-- Indexes for table `genders`
--
ALTER TABLE `genders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `marital_statuses`
--
ALTER TABLE `marital_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_user_id_foreign` (`user_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profiles_user_id_foreign` (`user_id`),
  ADD KEY `profiles_gender_id_foreign` (`gender_id`),
  ADD KEY `profiles_marital_status_id_foreign` (`marital_status_id`),
  ADD KEY `profiles_language_id_foreign` (`language_id`),
  ADD KEY `profiles_designation_id_foreign` (`designation_id`),
  ADD KEY `profiles_country_id_foreign` (`country_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `system_settings_language_id_foreign` (`language_id`),
  ADD KEY `system_settings_timezone_id_foreign` (`timezone_id`);

--
-- Indexes for table `timezones`
--
ALTER TABLE `timezones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `timezones_name_unique` (`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `company_settings`
--
ALTER TABLE `company_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=246;

--
-- AUTO_INCREMENT for table `designations`
--
ALTER TABLE `designations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `file_messages`
--
ALTER TABLE `file_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `genders`
--
ALTER TABLE `genders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `marital_statuses`
--
ALTER TABLE `marital_statuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `timezones`
--
ALTER TABLE `timezones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `company_settings`
--
ALTER TABLE `company_settings`
  ADD CONSTRAINT `company_settings_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `profiles`
--
ALTER TABLE `profiles`
  ADD CONSTRAINT `profiles_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `profiles_designation_id_foreign` FOREIGN KEY (`designation_id`) REFERENCES `designations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `profiles_gender_id_foreign` FOREIGN KEY (`gender_id`) REFERENCES `genders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `profiles_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `profiles_marital_status_id_foreign` FOREIGN KEY (`marital_status_id`) REFERENCES `marital_statuses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD CONSTRAINT `system_settings_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `system_settings_timezone_id_foreign` FOREIGN KEY (`timezone_id`) REFERENCES `timezones` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
