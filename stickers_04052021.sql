﻿--
-- Script was generated by Devart dbForge Studio 2020 for MySQL, Version 9.0.567.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 04.05.2021 0:30:02
-- Server version: 8.0.24
-- Client version: 4.1
--

-- 
-- Disable foreign keys
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Set SQL mode
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Set character set the client will use to send SQL statements to the server
--
SET NAMES 'utf8';

--
-- Set default database
--
USE stickers;

--
-- Drop procedure `create_number`
--
DROP PROCEDURE IF EXISTS create_number;

--
-- Drop procedure `create_number_for_stickers`
--
DROP PROCEDURE IF EXISTS create_number_for_stickers;

--
-- Drop table `numbers`
--
DROP TABLE IF EXISTS numbers;

--
-- Drop procedure `get_all_locations`
--
DROP PROCEDURE IF EXISTS get_all_locations;

--
-- Drop procedure `get_location`
--
DROP PROCEDURE IF EXISTS get_location;

--
-- Drop procedure `get_location_copy_count`
--
DROP PROCEDURE IF EXISTS get_location_copy_count;

--
-- Drop procedure `insert_new_location`
--
DROP PROCEDURE IF EXISTS insert_new_location;

--
-- Drop table `locations`
--
DROP TABLE IF EXISTS locations;

--
-- Drop procedure `get_lpu`
--
DROP PROCEDURE IF EXISTS get_lpu;

--
-- Drop table `lpu`
--
DROP TABLE IF EXISTS lpu;

--
-- Set default database
--
USE stickers;

--
-- Create table `lpu`
--
CREATE TABLE lpu (
  id int NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 11,
AVG_ROW_LENGTH = 2048,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci;

DELIMITER $$

--
-- Create procedure `get_lpu`
--
CREATE
DEFINER = 'root'@'localhost'
PROCEDURE get_lpu ()
BEGIN

  SELECT
    id AS 'value',
    name AS 'label'
  FROM lpu;

END
$$

DELIMITER ;

--
-- Create table `locations`
--
CREATE TABLE locations (
  id int NOT NULL AUTO_INCREMENT,
  lpu int NOT NULL COMMENT 'ID from table ''lpu''',
  location varchar(255) NOT NULL,
  copy int NOT NULL DEFAULT 2,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 14,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci;

DELIMITER $$

--
-- Create procedure `insert_new_location`
--
CREATE
DEFINER = 'root'@'localhost'
PROCEDURE insert_new_location (lpu_insert int, location_insert varchar(255))
BEGIN

  INSERT INTO locations (lpu, location)
    VALUES (lpu_insert, location_insert);

END
$$

--
-- Create procedure `get_location_copy_count`
--
CREATE
DEFINER = 'root'@'localhost'
PROCEDURE get_location_copy_count (copyCountVar int, locationVar varchar(255))
BEGIN

  UPDATE locations
  SET copy = copyCountVar
  WHERE id = locationVar;
  SELECT
    copy
  FROM locations
  WHERE id = locationVar;

END
$$

--
-- Create procedure `get_location`
--
CREATE
DEFINER = 'root'@'localhost'
PROCEDURE get_location (id_number int)
BEGIN

  SELECT
    l.name,
    loc.location
  FROM locations loc
    LEFT JOIN lpu l
      ON loc.lpu = l.id
  WHERE loc.id = id_number;

END
$$

--
-- Create procedure `get_all_locations`
--
CREATE
DEFINER = 'root'@'localhost'
PROCEDURE get_all_locations ()
BEGIN

  SELECT
    loc.id 'key',
    loc.id,
    l.name 'organization',
    loc.location
  FROM locations loc
    LEFT JOIN lpu l
      ON loc.lpu = l.id;

END
$$

DELIMITER ;

--
-- Create table `numbers`
--
CREATE TABLE numbers (
  id int NOT NULL AUTO_INCREMENT,
  number int NOT NULL,
  date datetime NOT NULL,
  location int NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 190,
AVG_ROW_LENGTH = 142,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci;

DELIMITER $$

--
-- Create procedure `create_number_for_stickers`
--
CREATE
DEFINER = 'root'@'localhost'
PROCEDURE create_number_for_stickers (id_number int)
BEGIN

  SELECT
    number
  FROM numbers
  WHERE id = (SELECT
      MAX(id)
    FROM numbers) LIMIT 1 INTO @a;

  INSERT INTO numbers (number, date, location)
    VALUES (@a + 1, NOW(), id_number);

  SELECT
    number
  FROM numbers
  WHERE id = (SELECT
      MAX(id)
    FROM numbers) LIMIT 1;

END
$$

--
-- Create procedure `create_number`
--
CREATE
DEFINER = 'root'@'localhost'
PROCEDURE create_number ()
DETERMINISTIC
COMMENT 'A procedure'
BEGIN

  SELECT
    number
  FROM numbers
  WHERE id = (SELECT
      MAX(id)
    FROM numbers) INTO @a;

  INSERT INTO numbers (number, date)
    VALUES (@a + 1, NOW());

  SELECT
    number
  FROM numbers
  WHERE id = (SELECT
      MAX(id)
    FROM numbers);

END
$$

DELIMITER ;

-- 
-- Dumping data for table numbers
--
INSERT INTO numbers VALUES
(1, 1, '2021-05-01 21:28:24', 1),
(118, 2, '2021-05-01 21:28:52', 46),
(119, 3, '2021-05-01 21:33:28', 0),
(120, 4, '2021-05-01 21:33:30', 0),
(121, 2, '2021-05-01 21:54:00', 46),
(122, 2, '2021-05-01 21:54:04', 46),
(123, 2, '2021-05-01 21:54:10', 46),
(124, 3, '2021-05-01 21:57:22', 0),
(125, 4, '2021-05-01 21:57:24', 0),
(126, 5, '2021-05-01 21:58:52', 46),
(127, 6, '2021-05-01 21:58:55', 46),
(128, 7, '2021-05-01 21:59:26', 46),
(129, 8, '2021-05-01 23:58:49', 1),
(130, 9, '2021-05-03 14:37:30', 4),
(131, 10, '2021-05-03 14:40:12', 4),
(132, 11, '2021-05-03 14:40:25', 4),
(133, 12, '2021-05-03 14:40:50', 4),
(134, 13, '2021-05-03 14:41:14', 4),
(135, 14, '2021-05-03 14:41:20', 4),
(136, 15, '2021-05-03 14:41:40', 4),
(137, 16, '2021-05-03 14:41:50', 4),
(138, 17, '2021-05-03 14:45:19', 4),
(139, 18, '2021-05-03 14:45:43', 4),
(140, 19, '2021-05-03 14:46:01', 4),
(141, 20, '2021-05-03 14:49:26', 4),
(142, 21, '2021-05-03 14:50:08', 4),
(143, 22, '2021-05-03 14:50:21', 4),
(144, 23, '2021-05-03 14:51:05', 4),
(145, 24, '2021-05-03 14:51:42', 4),
(146, 25, '2021-05-03 14:56:33', 4),
(147, 26, '2021-05-03 14:58:51', 4),
(148, 27, '2021-05-03 15:00:08', 4),
(149, 28, '2021-05-03 15:00:55', 4),
(150, 29, '2021-05-03 15:01:10', 4),
(151, 30, '2021-05-03 15:01:16', 4),
(152, 31, '2021-05-03 15:03:39', 4),
(153, 32, '2021-05-03 15:05:41', 4),
(154, 33, '2021-05-03 15:05:50', 4),
(155, 34, '2021-05-03 15:07:16', 4),
(156, 35, '2021-05-03 15:07:31', 4),
(157, 36, '2021-05-03 15:07:58', 4),
(158, 37, '2021-05-03 15:18:09', 4),
(159, 38, '2021-05-03 15:19:46', 4),
(160, 39, '2021-05-03 15:22:06', 4),
(161, 40, '2021-05-03 15:22:19', 4),
(162, 41, '2021-05-03 15:23:19', 4),
(163, 42, '2021-05-03 15:23:29', 4),
(164, 43, '2021-05-03 15:24:22', 4),
(165, 44, '2021-05-03 15:24:27', 4),
(166, 45, '2021-05-03 15:24:32', 4),
(167, 46, '2021-05-03 15:24:42', 4),
(168, 47, '2021-05-03 17:57:02', 4),
(169, 48, '2021-05-03 17:58:10', 4),
(170, 49, '2021-05-03 17:58:25', 3),
(171, 50, '2021-05-03 17:58:49', 3),
(172, 51, '2021-05-03 18:09:10', 3),
(173, 52, '2021-05-03 18:09:18', 1),
(174, 53, '2021-05-03 18:10:29', 1),
(175, 54, '2021-05-03 18:10:39', 4),
(176, 55, '2021-05-03 18:11:05', 4),
(177, 56, '2021-05-03 18:11:17', 4),
(178, 57, '2021-05-03 18:11:33', 4),
(179, 58, '2021-05-03 18:12:26', 4),
(180, 59, '2021-05-03 21:12:48', 3),
(181, 60, '2021-05-03 21:13:28', 3),
(182, 61, '2021-05-03 21:13:39', 3),
(183, 62, '2021-05-03 21:13:49', 4),
(184, 63, '2021-05-03 21:18:25', 4),
(185, 64, '2021-05-03 21:20:37', 4),
(186, 65, '2021-05-03 21:31:55', 4),
(187, 66, '2021-05-03 21:32:19', 4),
(188, 67, '2021-05-03 21:32:32', 4),
(189, 68, '2021-05-03 21:35:02', 3);

-- 
-- Dumping data for table lpu
--
INSERT INTO lpu VALUES
(1, 'Северская ЦРБ'),
(2, 'Ильская поликлиника'),
(3, 'Ильская детская поликлиника'),
(4, 'Черноморская поликлиника'),
(5, 'Афипская поликлиника'),
(6, 'Азовская амбулатория'),
(7, 'Львовская амбулатория'),
(8, 'Михайловская амбулатория'),
(9, 'Новодмитриевская амбулатория'),
(10, 'Смоленская амбулатория');

-- 
-- Dumping data for table locations
--
INSERT INTO locations VALUES
(1, 1, 'Отдел ИТ', 2),
(2, 1, 'Лаборатория корпус №4', 2),
(3, 1, 'Панель управления', 1),
(4, 1, 'ОтделИТ (Дмитрий Николаевич)', 2);

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;