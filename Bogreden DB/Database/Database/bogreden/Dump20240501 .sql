CREATE DATABASE  IF NOT EXISTS `bogreden` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `bogreden`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bogreden
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `br_address`
--

DROP TABLE IF EXISTS `br_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `br_address` (
  `adr_id` int(11) NOT NULL AUTO_INCREMENT,
  `adr_postal_code` varchar(15) NOT NULL,
  `adr_user_id` int(11) NOT NULL,
  `adr_street_address` varchar(100) NOT NULL,
  `adr_country` varchar(60) NOT NULL,
  `adr_is_billing_address` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`adr_id`),
  KEY `adr_postal_code` (`adr_postal_code`),
  KEY `adr_user_id` (`adr_user_id`),
  KEY `idx_address` (`adr_id`,`adr_postal_code`,`adr_user_id`,`adr_street_address`,`adr_country`,`adr_is_billing_address`),
  CONSTRAINT `br_address_ibfk_1` FOREIGN KEY (`adr_postal_code`) REFERENCES `br_city` (`city_postal_code`),
  CONSTRAINT `br_address_ibfk_2` FOREIGN KEY (`adr_user_id`) REFERENCES `br_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `br_address`
--

LOCK TABLES `br_address` WRITE;
/*!40000 ALTER TABLE `br_address` DISABLE KEYS */;
INSERT INTO `br_address` VALUES (1,'4180',1,'Strandboulevarden 1','Denmark',1),(2,'4180',2,'Vesterbrogade 2','Denmark',0),(3,'4180',3,'Nørrebrogade 3','Denmark',1),(4,'4180',4,'Sønderboulevard 4','Denmark',0),(5,'4180',5,'Hovedvejen 5','Denmark',1),(6,'4180',6,'Strandvejen 6','Denmark',0),(7,'4180',7,'Parkvej 7','Denmark',1),(8,'4180',8,'Bakkevej 8','Denmark',0),(9,'4180',9,'Skovvej 9','Denmark',1),(10,'4180',10,'Engvej 10','Denmark',0);
/*!40000 ALTER TABLE `br_address` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_address_before_insert BEFORE INSERT
    ON br_address FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'address_before',
        CURRENT_TIMESTAMP(),
        'Insert New Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_address_insert_after AFTER INSERT
    ON br_address FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'address_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'adr_id: ', COALESCE(NEW.adr_id,"NULL"), ', ',
            'adr_postal_code: ', COALESCE(NEW.adr_postal_code,"NULL"), ', ',
            'adr_user_id: ', COALESCE(NEW.adr_user_id,"NULL"), ', ',
            'adr_street_address: ', COALESCE(NEW.adr_street_address,"NULL"), ', ',
            'adr_country: ', COALESCE(NEW.adr_country,"NULL"), ', ',
            'adr_is_billing_address: ', COALESCE(NEW.adr_is_billing_address,"NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_address_update_before BEFORE UPDATE
ON br_address FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'address_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'adr_id: ', COALESCE(OLD.adr_id, "NULL"), ', ',
            'adr_postal_code: ', COALESCE(OLD.adr_postal_code, "NULL"), ', ',
            'adr_user_id: ', COALESCE(OLD.adr_user_id, "NULL"), ', ',
            'adr_street_address: ', COALESCE(OLD.adr_street_address, "NULL"), ', ',
            'adr_country: ', COALESCE(OLD.adr_country, "NULL"), ', ',
            'adr_is_billing_address: ', COALESCE(OLD.adr_is_billing_address, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_addressupdate__after AFTER UPDATE
ON br_address FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'address_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'adr_id: ', COALESCE(NEW.adr_id, "NULL"), ', ',
            'adr_postal_code: ', COALESCE(NEW.adr_postal_code, "NULL"), ', ',
            'adr_user_id: ', COALESCE(NEW.adr_user_id, "NULL"), ', ',
            'adr_street_address: ', COALESCE(NEW.adr_street_address, "NULL"), ', ',
            'adr_country: ', COALESCE(NEW.adr_country, "NULL"), ', ',
            'adr_is_billing_address: ', COALESCE(NEW.adr_is_billing_address, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_address_before_delete BEFORE DELETE
ON br_address FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'address_after',
        CURRENT_TIMESTAMP(),
        'Deleting Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_address_delete_after AFTER DELETE
ON br_address FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'address_after',
        CURRENT_TIMESTAMP(),
        'Row Deleted'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `br_author`
--

DROP TABLE IF EXISTS `br_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `br_author` (
  `auth_name` varchar(100) NOT NULL,
  PRIMARY KEY (`auth_name`),
  KEY `idx_author` (`auth_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `br_author`
--

LOCK TABLES `br_author` WRITE;
/*!40000 ALTER TABLE `br_author` DISABLE KEYS */;
INSERT INTO `br_author` VALUES ('Agatha Christie'),('Charles Dickens'),('Dan Brown'),('George Orwell'),('Harper Lee'),('J.K. Rowling'),('J.R.R. Tolkien'),('Jane Austen'),('Leo Tolstoy'),('Stephen King');
/*!40000 ALTER TABLE `br_author` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_author_before_insert BEFORE INSERT
    ON br_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'author_before',
        CURRENT_TIMESTAMP(),
        CONCAT('auth_name: ', NEW.auth_name)
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_author_insert_after AFTER INSERT
    ON br_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'author_after',
        CURRENT_TIMESTAMP(),
        CONCAT('auth_name: ', COALESCE(NEW.auth_name, "NULL"))
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_author_update_before BEFORE UPDATE
ON br_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'author_after',
        CURRENT_TIMESTAMP(),
        CONCAT('auth_name: ', COALESCE(NEW.auth_name,"NULL"))
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_authorupdate__after AFTER UPDATE
ON br_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'author_after',
        CURRENT_TIMESTAMP(),
        CONCAT('auth_name: ', COALESCE(NEW.auth_name,"NULL"))
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_author_before_delete BEFORE DELETE
ON br_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'author_after',
        CURRENT_TIMESTAMP(),
        'Delete Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_author_delete_after AFTER DELETE
ON br_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'author_after',
        CURRENT_TIMESTAMP(),
        'Row Deleted'
    );
    UPDATE br_book_author
    SET ba_author_name = (SELECT auth_name FROM br_author WHERE auth_name = 'unknown')
    WHERE ba_author_name = `ba_author_name`;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `br_bogreden_log`
--

DROP TABLE IF EXISTS `br_bogreden_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `br_bogreden_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `log_table_key` varchar(25) DEFAULT NULL,
  `log_time_stamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `log_message` text DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2909 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `br_bogreden_log`
--

LOCK TABLES `br_bogreden_log` WRITE;
/*!40000 ALTER TABLE `br_bogreden_log` DISABLE KEYS */;
INSERT INTO `br_bogreden_log` VALUES (1,'city_before','2024-05-01 11:18:40','Insert New Row'),(2,'city_after','2024-05-01 11:18:40','city_postal_code: 0555, city_name: Scanning\r'),(3,'city_before','2024-05-01 11:18:40','Insert New Row'),(4,'city_after','2024-05-01 11:18:40','city_postal_code: 0783, city_name: Facility\r'),(5,'city_before','2024-05-01 11:18:40','Insert New Row'),(6,'city_after','2024-05-01 11:18:40','city_postal_code: 0784, city_name: H&M\r'),(7,'city_before','2024-05-01 11:18:40','Insert New Row'),(8,'city_after','2024-05-01 11:18:40','city_postal_code: 0785, city_name: Bestseller \r'),(9,'city_before','2024-05-01 11:18:40','Insert New Row'),(10,'city_after','2024-05-01 11:18:40','city_postal_code: 0800, city_name: Høje Taastrup\r'),(11,'city_before','2024-05-01 11:18:40','Insert New Row'),(12,'city_after','2024-05-01 11:18:40','city_postal_code: 0877, city_name: København C\r'),(13,'city_before','2024-05-01 11:18:40','Insert New Row'),(14,'city_after','2024-05-01 11:18:40','city_postal_code: 0892, city_name: Sjælland USF P\r'),(15,'city_before','2024-05-01 11:18:40','Insert New Row'),(16,'city_after','2024-05-01 11:18:40','city_postal_code: 0893, city_name: Sjælland USF B\r'),(17,'city_before','2024-05-01 11:18:40','Insert New Row'),(18,'city_after','2024-05-01 11:18:40','city_postal_code: 0894, city_name: Udbetaling\r'),(19,'city_before','2024-05-01 11:18:40','Insert New Row'),(20,'city_after','2024-05-01 11:18:40','city_postal_code: 0899, city_name: Kommuneservice\r'),(21,'city_before','2024-05-01 11:18:40','Insert New Row'),(22,'city_after','2024-05-01 11:18:40','city_postal_code: 0900, city_name: København C\r'),(23,'city_before','2024-05-01 11:18:40','Insert New Row'),(24,'city_after','2024-05-01 11:18:40','city_postal_code: 0910, city_name: København C\r'),(25,'city_before','2024-05-01 11:18:40','Insert New Row'),(26,'city_after','2024-05-01 11:18:40','city_postal_code: 0913, city_name: Københavns Pakkecenter\r'),(27,'city_before','2024-05-01 11:18:40','Insert New Row'),(28,'city_after','2024-05-01 11:18:40','city_postal_code: 0914, city_name: Københavns Pakkecenter\r'),(29,'city_before','2024-05-01 11:18:40','Insert New Row'),(30,'city_after','2024-05-01 11:18:40','city_postal_code: 0917, city_name: Københavns Pakkecenter\r'),(31,'city_before','2024-05-01 11:18:40','Insert New Row'),(32,'city_after','2024-05-01 11:18:40','city_postal_code: 0918, city_name: Københavns Pakke BRC\r'),(33,'city_before','2024-05-01 11:18:40','Insert New Row'),(34,'city_after','2024-05-01 11:18:40','city_postal_code: 0919, city_name: Returprint BRC\r'),(35,'city_before','2024-05-01 11:18:40','Insert New Row'),(36,'city_after','2024-05-01 11:18:40','city_postal_code: 0929, city_name: København C\r'),(37,'city_before','2024-05-01 11:18:40','Insert New Row'),(38,'city_after','2024-05-01 11:18:40','city_postal_code: 0960, city_name: Internationalt Postcenter\r'),(39,'city_before','2024-05-01 11:18:40','Insert New Row'),(40,'city_after','2024-05-01 11:18:40','city_postal_code: 0999, city_name: København C\r'),(41,'city_before','2024-05-01 11:18:40','Insert New Row'),(42,'city_after','2024-05-01 11:18:40','city_postal_code: 1001, city_name: København K\r'),(43,'city_before','2024-05-01 11:18:40','Insert New Row'),(44,'city_after','2024-05-01 11:18:40','city_postal_code: 1002, city_name: København K\r'),(45,'city_before','2024-05-01 11:18:40','Insert New Row'),(46,'city_after','2024-05-01 11:18:40','city_postal_code: 1003, city_name: København K\r'),(47,'city_before','2024-05-01 11:18:40','Insert New Row'),(48,'city_after','2024-05-01 11:18:40','city_postal_code: 1004, city_name: København K\r'),(49,'city_before','2024-05-01 11:18:40','Insert New Row'),(50,'city_after','2024-05-01 11:18:40','city_postal_code: 1005, city_name: København K\r'),(51,'city_before','2024-05-01 11:18:40','Insert New Row'),(52,'city_after','2024-05-01 11:18:40','city_postal_code: 1006, city_name: København K\r'),(53,'city_before','2024-05-01 11:18:40','Insert New Row'),(54,'city_after','2024-05-01 11:18:40','city_postal_code: 1007, city_name: København K\r'),(55,'city_before','2024-05-01 11:18:40','Insert New Row'),(56,'city_after','2024-05-01 11:18:40','city_postal_code: 1008, city_name: København K\r'),(57,'city_before','2024-05-01 11:18:40','Insert New Row'),(58,'city_after','2024-05-01 11:18:40','city_postal_code: 1009, city_name: København K\r'),(59,'city_before','2024-05-01 11:18:40','Insert New Row'),(60,'city_after','2024-05-01 11:18:40','city_postal_code: 1010, city_name: København K\r'),(61,'city_before','2024-05-01 11:18:40','Insert New Row'),(62,'city_after','2024-05-01 11:18:40','city_postal_code: 1011, city_name: København K\r'),(63,'city_before','2024-05-01 11:18:40','Insert New Row'),(64,'city_after','2024-05-01 11:18:40','city_postal_code: 1012, city_name: København K\r'),(65,'city_before','2024-05-01 11:18:40','Insert New Row'),(66,'city_after','2024-05-01 11:18:40','city_postal_code: 1013, city_name: København K\r'),(67,'city_before','2024-05-01 11:18:40','Insert New Row'),(68,'city_after','2024-05-01 11:18:40','city_postal_code: 1014, city_name: København K\r'),(69,'city_before','2024-05-01 11:18:40','Insert New Row'),(70,'city_after','2024-05-01 11:18:40','city_postal_code: 1015, city_name: København K\r'),(71,'city_before','2024-05-01 11:18:40','Insert New Row'),(72,'city_after','2024-05-01 11:18:40','city_postal_code: 1016, city_name: København K\r'),(73,'city_before','2024-05-01 11:18:40','Insert New Row'),(74,'city_after','2024-05-01 11:18:40','city_postal_code: 1017, city_name: København K\r'),(75,'city_before','2024-05-01 11:18:40','Insert New Row'),(76,'city_after','2024-05-01 11:18:40','city_postal_code: 1018, city_name: København K\r'),(77,'city_before','2024-05-01 11:18:40','Insert New Row'),(78,'city_after','2024-05-01 11:18:40','city_postal_code: 1019, city_name: København K\r'),(79,'city_before','2024-05-01 11:18:40','Insert New Row'),(80,'city_after','2024-05-01 11:18:40','city_postal_code: 1020, city_name: København K\r'),(81,'city_before','2024-05-01 11:18:40','Insert New Row'),(82,'city_after','2024-05-01 11:18:40','city_postal_code: 1021, city_name: København K\r'),(83,'city_before','2024-05-01 11:18:40','Insert New Row'),(84,'city_after','2024-05-01 11:18:40','city_postal_code: 1022, city_name: København K\r'),(85,'city_before','2024-05-01 11:18:40','Insert New Row'),(86,'city_after','2024-05-01 11:18:40','city_postal_code: 1023, city_name: København K\r'),(87,'city_before','2024-05-01 11:18:40','Insert New Row'),(88,'city_after','2024-05-01 11:18:40','city_postal_code: 1024, city_name: København K\r'),(89,'city_before','2024-05-01 11:18:40','Insert New Row'),(90,'city_after','2024-05-01 11:18:40','city_postal_code: 1025, city_name: København K\r'),(91,'city_before','2024-05-01 11:18:40','Insert New Row'),(92,'city_after','2024-05-01 11:18:40','city_postal_code: 1026, city_name: København K\r'),(93,'city_before','2024-05-01 11:18:40','Insert New Row'),(94,'city_after','2024-05-01 11:18:40','city_postal_code: 1045, city_name: København K\r'),(95,'city_before','2024-05-01 11:18:40','Insert New Row'),(96,'city_after','2024-05-01 11:18:40','city_postal_code: 1050, city_name: København K\r'),(97,'city_before','2024-05-01 11:18:40','Insert New Row'),(98,'city_after','2024-05-01 11:18:40','city_postal_code: 1051, city_name: København K\r'),(99,'city_before','2024-05-01 11:18:40','Insert New Row'),(100,'city_after','2024-05-01 11:18:40','city_postal_code: 1052, city_name: København K\r'),(101,'city_before','2024-05-01 11:18:40','Insert New Row'),(102,'city_after','2024-05-01 11:18:40','city_postal_code: 1053, city_name: København K\r'),(103,'city_before','2024-05-01 11:18:40','Insert New Row'),(104,'city_after','2024-05-01 11:18:40','city_postal_code: 1054, city_name: København K\r'),(105,'city_before','2024-05-01 11:18:40','Insert New Row'),(106,'city_after','2024-05-01 11:18:40','city_postal_code: 1055, city_name: København K\r'),(107,'city_before','2024-05-01 11:18:40','Insert New Row'),(108,'city_after','2024-05-01 11:18:40','city_postal_code: 1056, city_name: København K\r'),(109,'city_before','2024-05-01 11:18:40','Insert New Row'),(110,'city_after','2024-05-01 11:18:40','city_postal_code: 1057, city_name: København K\r'),(111,'city_before','2024-05-01 11:18:40','Insert New Row'),(112,'city_after','2024-05-01 11:18:40','city_postal_code: 1058, city_name: København K\r'),(113,'city_before','2024-05-01 11:18:40','Insert New Row'),(114,'city_after','2024-05-01 11:18:40','city_postal_code: 1059, city_name: København K\r'),(115,'city_before','2024-05-01 11:18:40','Insert New Row'),(116,'city_after','2024-05-01 11:18:40','city_postal_code: 1060, city_name: København K\r'),(117,'city_before','2024-05-01 11:18:40','Insert New Row'),(118,'city_after','2024-05-01 11:18:40','city_postal_code: 1061, city_name: København K\r'),(119,'city_before','2024-05-01 11:18:40','Insert New Row'),(120,'city_after','2024-05-01 11:18:40','city_postal_code: 1062, city_name: København K\r'),(121,'city_before','2024-05-01 11:18:40','Insert New Row'),(122,'city_after','2024-05-01 11:18:40','city_postal_code: 1063, city_name: København K\r'),(123,'city_before','2024-05-01 11:18:40','Insert New Row'),(124,'city_after','2024-05-01 11:18:40','city_postal_code: 1064, city_name: København K\r'),(125,'city_before','2024-05-01 11:18:40','Insert New Row'),(126,'city_after','2024-05-01 11:18:40','city_postal_code: 1065, city_name: København K\r'),(127,'city_before','2024-05-01 11:18:40','Insert New Row'),(128,'city_after','2024-05-01 11:18:40','city_postal_code: 1066, city_name: København K\r'),(129,'city_before','2024-05-01 11:18:40','Insert New Row'),(130,'city_after','2024-05-01 11:18:40','city_postal_code: 1067, city_name: København K\r'),(131,'city_before','2024-05-01 11:18:40','Insert New Row'),(132,'city_after','2024-05-01 11:18:40','city_postal_code: 1068, city_name: København K\r'),(133,'city_before','2024-05-01 11:18:40','Insert New Row'),(134,'city_after','2024-05-01 11:18:40','city_postal_code: 1069, city_name: København K\r'),(135,'city_before','2024-05-01 11:18:40','Insert New Row'),(136,'city_after','2024-05-01 11:18:40','city_postal_code: 1070, city_name: København K\r'),(137,'city_before','2024-05-01 11:18:40','Insert New Row'),(138,'city_after','2024-05-01 11:18:40','city_postal_code: 1071, city_name: København K\r'),(139,'city_before','2024-05-01 11:18:40','Insert New Row'),(140,'city_after','2024-05-01 11:18:40','city_postal_code: 1072, city_name: København K\r'),(141,'city_before','2024-05-01 11:18:40','Insert New Row'),(142,'city_after','2024-05-01 11:18:40','city_postal_code: 1073, city_name: København K\r'),(143,'city_before','2024-05-01 11:18:40','Insert New Row'),(144,'city_after','2024-05-01 11:18:40','city_postal_code: 1074, city_name: København K\r'),(145,'city_before','2024-05-01 11:18:40','Insert New Row'),(146,'city_after','2024-05-01 11:18:40','city_postal_code: 1092, city_name: København K\r'),(147,'city_before','2024-05-01 11:18:40','Insert New Row'),(148,'city_after','2024-05-01 11:18:40','city_postal_code: 1093, city_name: København K\r'),(149,'city_before','2024-05-01 11:18:40','Insert New Row'),(150,'city_after','2024-05-01 11:18:40','city_postal_code: 1095, city_name: København K\r'),(151,'city_before','2024-05-01 11:18:40','Insert New Row'),(152,'city_after','2024-05-01 11:18:40','city_postal_code: 1098, city_name: København K\r'),(153,'city_before','2024-05-01 11:18:40','Insert New Row'),(154,'city_after','2024-05-01 11:18:40','city_postal_code: 1100, city_name: København K\r'),(155,'city_before','2024-05-01 11:18:40','Insert New Row'),(156,'city_after','2024-05-01 11:18:40','city_postal_code: 1101, city_name: København K\r'),(157,'city_before','2024-05-01 11:18:40','Insert New Row'),(158,'city_after','2024-05-01 11:18:40','city_postal_code: 1102, city_name: København K\r'),(159,'city_before','2024-05-01 11:18:40','Insert New Row'),(160,'city_after','2024-05-01 11:18:40','city_postal_code: 1103, city_name: København K\r'),(161,'city_before','2024-05-01 11:18:40','Insert New Row'),(162,'city_after','2024-05-01 11:18:40','city_postal_code: 1104, city_name: København K\r'),(163,'city_before','2024-05-01 11:18:40','Insert New Row'),(164,'city_after','2024-05-01 11:18:40','city_postal_code: 1105, city_name: København K\r'),(165,'city_before','2024-05-01 11:18:40','Insert New Row'),(166,'city_after','2024-05-01 11:18:40','city_postal_code: 1106, city_name: København K\r'),(167,'city_before','2024-05-01 11:18:40','Insert New Row'),(168,'city_after','2024-05-01 11:18:40','city_postal_code: 1107, city_name: København K\r'),(169,'city_before','2024-05-01 11:18:40','Insert New Row'),(170,'city_after','2024-05-01 11:18:40','city_postal_code: 1110, city_name: København K\r'),(171,'city_before','2024-05-01 11:18:40','Insert New Row'),(172,'city_after','2024-05-01 11:18:40','city_postal_code: 1111, city_name: København K\r'),(173,'city_before','2024-05-01 11:18:40','Insert New Row'),(174,'city_after','2024-05-01 11:18:40','city_postal_code: 1112, city_name: København K\r'),(175,'city_before','2024-05-01 11:18:40','Insert New Row'),(176,'city_after','2024-05-01 11:18:40','city_postal_code: 1113, city_name: København K\r'),(177,'city_before','2024-05-01 11:18:40','Insert New Row'),(178,'city_after','2024-05-01 11:18:40','city_postal_code: 1114, city_name: København K\r'),(179,'city_before','2024-05-01 11:18:40','Insert New Row'),(180,'city_after','2024-05-01 11:18:40','city_postal_code: 1115, city_name: København K\r'),(181,'city_before','2024-05-01 11:18:40','Insert New Row'),(182,'city_after','2024-05-01 11:18:40','city_postal_code: 1116, city_name: København K\r'),(183,'city_before','2024-05-01 11:18:40','Insert New Row'),(184,'city_after','2024-05-01 11:18:40','city_postal_code: 1117, city_name: København K\r'),(185,'city_before','2024-05-01 11:18:40','Insert New Row'),(186,'city_after','2024-05-01 11:18:40','city_postal_code: 1118, city_name: København K\r'),(187,'city_before','2024-05-01 11:18:40','Insert New Row'),(188,'city_after','2024-05-01 11:18:40','city_postal_code: 1119, city_name: København K\r'),(189,'city_before','2024-05-01 11:18:40','Insert New Row'),(190,'city_after','2024-05-01 11:18:40','city_postal_code: 1120, city_name: København K\r'),(191,'city_before','2024-05-01 11:18:40','Insert New Row'),(192,'city_after','2024-05-01 11:18:40','city_postal_code: 1121, city_name: København K\r'),(193,'city_before','2024-05-01 11:18:40','Insert New Row'),(194,'city_after','2024-05-01 11:18:40','city_postal_code: 1122, city_name: København K\r'),(195,'city_before','2024-05-01 11:18:40','Insert New Row'),(196,'city_after','2024-05-01 11:18:40','city_postal_code: 1123, city_name: København K\r'),(197,'city_before','2024-05-01 11:18:40','Insert New Row'),(198,'city_after','2024-05-01 11:18:40','city_postal_code: 1124, city_name: København K\r'),(199,'city_before','2024-05-01 11:18:40','Insert New Row'),(200,'city_after','2024-05-01 11:18:40','city_postal_code: 1125, city_name: København K\r'),(201,'city_before','2024-05-01 11:18:40','Insert New Row'),(202,'city_after','2024-05-01 11:18:40','city_postal_code: 1126, city_name: København K\r'),(203,'city_before','2024-05-01 11:18:40','Insert New Row'),(204,'city_after','2024-05-01 11:18:40','city_postal_code: 1127, city_name: København K\r'),(205,'city_before','2024-05-01 11:18:40','Insert New Row'),(206,'city_after','2024-05-01 11:18:40','city_postal_code: 1128, city_name: København K\r'),(207,'city_before','2024-05-01 11:18:40','Insert New Row'),(208,'city_after','2024-05-01 11:18:40','city_postal_code: 1129, city_name: København K\r'),(209,'city_before','2024-05-01 11:18:40','Insert New Row'),(210,'city_after','2024-05-01 11:18:40','city_postal_code: 1130, city_name: København K\r'),(211,'city_before','2024-05-01 11:18:40','Insert New Row'),(212,'city_after','2024-05-01 11:18:40','city_postal_code: 1131, city_name: København K\r'),(213,'city_before','2024-05-01 11:18:40','Insert New Row'),(214,'city_after','2024-05-01 11:18:40','city_postal_code: 1140, city_name: København K\r'),(215,'city_before','2024-05-01 11:18:40','Insert New Row'),(216,'city_after','2024-05-01 11:18:40','city_postal_code: 1147, city_name: København K\r'),(217,'city_before','2024-05-01 11:18:40','Insert New Row'),(218,'city_after','2024-05-01 11:18:40','city_postal_code: 1148, city_name: København K\r'),(219,'city_before','2024-05-01 11:18:40','Insert New Row'),(220,'city_after','2024-05-01 11:18:40','city_postal_code: 1150, city_name: København K\r'),(221,'city_before','2024-05-01 11:18:40','Insert New Row'),(222,'city_after','2024-05-01 11:18:40','city_postal_code: 1151, city_name: København K\r'),(223,'city_before','2024-05-01 11:18:40','Insert New Row'),(224,'city_after','2024-05-01 11:18:40','city_postal_code: 1152, city_name: København K\r'),(225,'city_before','2024-05-01 11:18:40','Insert New Row'),(226,'city_after','2024-05-01 11:18:40','city_postal_code: 1153, city_name: København K\r'),(227,'city_before','2024-05-01 11:18:40','Insert New Row'),(228,'city_after','2024-05-01 11:18:40','city_postal_code: 1154, city_name: København K\r'),(229,'city_before','2024-05-01 11:18:40','Insert New Row'),(230,'city_after','2024-05-01 11:18:40','city_postal_code: 1155, city_name: København K\r'),(231,'city_before','2024-05-01 11:18:40','Insert New Row'),(232,'city_after','2024-05-01 11:18:40','city_postal_code: 1156, city_name: København K\r'),(233,'city_before','2024-05-01 11:18:40','Insert New Row'),(234,'city_after','2024-05-01 11:18:40','city_postal_code: 1157, city_name: København K\r'),(235,'city_before','2024-05-01 11:18:40','Insert New Row'),(236,'city_after','2024-05-01 11:18:40','city_postal_code: 1158, city_name: København K\r'),(237,'city_before','2024-05-01 11:18:40','Insert New Row'),(238,'city_after','2024-05-01 11:18:40','city_postal_code: 1159, city_name: København K\r'),(239,'city_before','2024-05-01 11:18:40','Insert New Row'),(240,'city_after','2024-05-01 11:18:40','city_postal_code: 1160, city_name: København K\r'),(241,'city_before','2024-05-01 11:18:40','Insert New Row'),(242,'city_after','2024-05-01 11:18:40','city_postal_code: 1161, city_name: København K\r'),(243,'city_before','2024-05-01 11:18:40','Insert New Row'),(244,'city_after','2024-05-01 11:18:40','city_postal_code: 1162, city_name: København K\r'),(245,'city_before','2024-05-01 11:18:40','Insert New Row'),(246,'city_after','2024-05-01 11:18:40','city_postal_code: 1164, city_name: København K\r'),(247,'city_before','2024-05-01 11:18:40','Insert New Row'),(248,'city_after','2024-05-01 11:18:40','city_postal_code: 1165, city_name: København K\r'),(249,'city_before','2024-05-01 11:18:40','Insert New Row'),(250,'city_after','2024-05-01 11:18:40','city_postal_code: 1166, city_name: København K\r'),(251,'city_before','2024-05-01 11:18:40','Insert New Row'),(252,'city_after','2024-05-01 11:18:40','city_postal_code: 1167, city_name: København K\r'),(253,'city_before','2024-05-01 11:18:40','Insert New Row'),(254,'city_after','2024-05-01 11:18:40','city_postal_code: 1168, city_name: København K\r'),(255,'city_before','2024-05-01 11:18:40','Insert New Row'),(256,'city_after','2024-05-01 11:18:40','city_postal_code: 1169, city_name: København K\r'),(257,'city_before','2024-05-01 11:18:40','Insert New Row'),(258,'city_after','2024-05-01 11:18:40','city_postal_code: 1170, city_name: København K\r'),(259,'city_before','2024-05-01 11:18:40','Insert New Row'),(260,'city_after','2024-05-01 11:18:40','city_postal_code: 1171, city_name: København K\r'),(261,'city_before','2024-05-01 11:18:40','Insert New Row'),(262,'city_after','2024-05-01 11:18:40','city_postal_code: 1172, city_name: København K\r'),(263,'city_before','2024-05-01 11:18:40','Insert New Row'),(264,'city_after','2024-05-01 11:18:40','city_postal_code: 1173, city_name: København K\r'),(265,'city_before','2024-05-01 11:18:40','Insert New Row'),(266,'city_after','2024-05-01 11:18:40','city_postal_code: 1174, city_name: København K\r'),(267,'city_before','2024-05-01 11:18:40','Insert New Row'),(268,'city_after','2024-05-01 11:18:40','city_postal_code: 1175, city_name: København K\r'),(269,'city_before','2024-05-01 11:18:40','Insert New Row'),(270,'city_after','2024-05-01 11:18:40','city_postal_code: 1200, city_name: København K\r'),(271,'city_before','2024-05-01 11:18:40','Insert New Row'),(272,'city_after','2024-05-01 11:18:40','city_postal_code: 1201, city_name: København K\r'),(273,'city_before','2024-05-01 11:18:40','Insert New Row'),(274,'city_after','2024-05-01 11:18:40','city_postal_code: 1202, city_name: København K\r'),(275,'city_before','2024-05-01 11:18:40','Insert New Row'),(276,'city_after','2024-05-01 11:18:40','city_postal_code: 1203, city_name: København K\r'),(277,'city_before','2024-05-01 11:18:40','Insert New Row'),(278,'city_after','2024-05-01 11:18:40','city_postal_code: 1204, city_name: København K\r'),(279,'city_before','2024-05-01 11:18:40','Insert New Row'),(280,'city_after','2024-05-01 11:18:40','city_postal_code: 1205, city_name: København K\r'),(281,'city_before','2024-05-01 11:18:40','Insert New Row'),(282,'city_after','2024-05-01 11:18:40','city_postal_code: 1206, city_name: København K\r'),(283,'city_before','2024-05-01 11:18:40','Insert New Row'),(284,'city_after','2024-05-01 11:18:40','city_postal_code: 1207, city_name: København K\r'),(285,'city_before','2024-05-01 11:18:40','Insert New Row'),(286,'city_after','2024-05-01 11:18:40','city_postal_code: 1208, city_name: København K\r'),(287,'city_before','2024-05-01 11:18:40','Insert New Row'),(288,'city_after','2024-05-01 11:18:40','city_postal_code: 1209, city_name: København K\r'),(289,'city_before','2024-05-01 11:18:40','Insert New Row'),(290,'city_after','2024-05-01 11:18:40','city_postal_code: 1210, city_name: København K\r'),(291,'city_before','2024-05-01 11:18:40','Insert New Row'),(292,'city_after','2024-05-01 11:18:40','city_postal_code: 1211, city_name: København K\r'),(293,'city_before','2024-05-01 11:18:40','Insert New Row'),(294,'city_after','2024-05-01 11:18:40','city_postal_code: 1212, city_name: København K\r'),(295,'city_before','2024-05-01 11:18:40','Insert New Row'),(296,'city_after','2024-05-01 11:18:40','city_postal_code: 1213, city_name: København K\r'),(297,'city_before','2024-05-01 11:18:40','Insert New Row'),(298,'city_after','2024-05-01 11:18:40','city_postal_code: 1214, city_name: København K\r'),(299,'city_before','2024-05-01 11:18:40','Insert New Row'),(300,'city_after','2024-05-01 11:18:40','city_postal_code: 1215, city_name: København K\r'),(301,'city_before','2024-05-01 11:18:40','Insert New Row'),(302,'city_after','2024-05-01 11:18:40','city_postal_code: 1216, city_name: København K\r'),(303,'city_before','2024-05-01 11:18:40','Insert New Row'),(304,'city_after','2024-05-01 11:18:40','city_postal_code: 1217, city_name: København K\r'),(305,'city_before','2024-05-01 11:18:40','Insert New Row'),(306,'city_after','2024-05-01 11:18:40','city_postal_code: 1218, city_name: København K\r'),(307,'city_before','2024-05-01 11:18:40','Insert New Row'),(308,'city_after','2024-05-01 11:18:40','city_postal_code: 1219, city_name: København K\r'),(309,'city_before','2024-05-01 11:18:40','Insert New Row'),(310,'city_after','2024-05-01 11:18:40','city_postal_code: 1220, city_name: København K\r'),(311,'city_before','2024-05-01 11:18:40','Insert New Row'),(312,'city_after','2024-05-01 11:18:40','city_postal_code: 1221, city_name: København K\r'),(313,'city_before','2024-05-01 11:18:40','Insert New Row'),(314,'city_after','2024-05-01 11:18:40','city_postal_code: 1240, city_name: København K\r'),(315,'city_before','2024-05-01 11:18:40','Insert New Row'),(316,'city_after','2024-05-01 11:18:40','city_postal_code: 1250, city_name: København K\r'),(317,'city_before','2024-05-01 11:18:40','Insert New Row'),(318,'city_after','2024-05-01 11:18:40','city_postal_code: 1251, city_name: København K\r'),(319,'city_before','2024-05-01 11:18:40','Insert New Row'),(320,'city_after','2024-05-01 11:18:40','city_postal_code: 1252, city_name: København K\r'),(321,'city_before','2024-05-01 11:18:40','Insert New Row'),(322,'city_after','2024-05-01 11:18:40','city_postal_code: 1253, city_name: København K\r'),(323,'city_before','2024-05-01 11:18:40','Insert New Row'),(324,'city_after','2024-05-01 11:18:40','city_postal_code: 1254, city_name: København K\r'),(325,'city_before','2024-05-01 11:18:40','Insert New Row'),(326,'city_after','2024-05-01 11:18:40','city_postal_code: 1255, city_name: København K\r'),(327,'city_before','2024-05-01 11:18:40','Insert New Row'),(328,'city_after','2024-05-01 11:18:40','city_postal_code: 1256, city_name: København K\r'),(329,'city_before','2024-05-01 11:18:40','Insert New Row'),(330,'city_after','2024-05-01 11:18:40','city_postal_code: 1257, city_name: København K\r'),(331,'city_before','2024-05-01 11:18:40','Insert New Row'),(332,'city_after','2024-05-01 11:18:40','city_postal_code: 1259, city_name: København K\r'),(333,'city_before','2024-05-01 11:18:40','Insert New Row'),(334,'city_after','2024-05-01 11:18:40','city_postal_code: 1260, city_name: København K\r'),(335,'city_before','2024-05-01 11:18:40','Insert New Row'),(336,'city_after','2024-05-01 11:18:40','city_postal_code: 1261, city_name: København K\r'),(337,'city_before','2024-05-01 11:18:40','Insert New Row'),(338,'city_after','2024-05-01 11:18:40','city_postal_code: 1263, city_name: København K\r'),(339,'city_before','2024-05-01 11:18:40','Insert New Row'),(340,'city_after','2024-05-01 11:18:40','city_postal_code: 1264, city_name: København K\r'),(341,'city_before','2024-05-01 11:18:40','Insert New Row'),(342,'city_after','2024-05-01 11:18:40','city_postal_code: 1265, city_name: København K\r'),(343,'city_before','2024-05-01 11:18:40','Insert New Row'),(344,'city_after','2024-05-01 11:18:40','city_postal_code: 1266, city_name: København K\r'),(345,'city_before','2024-05-01 11:18:40','Insert New Row'),(346,'city_after','2024-05-01 11:18:40','city_postal_code: 1267, city_name: København K\r'),(347,'city_before','2024-05-01 11:18:40','Insert New Row'),(348,'city_after','2024-05-01 11:18:40','city_postal_code: 1268, city_name: København K\r'),(349,'city_before','2024-05-01 11:18:40','Insert New Row'),(350,'city_after','2024-05-01 11:18:40','city_postal_code: 1270, city_name: København K\r'),(351,'city_before','2024-05-01 11:18:40','Insert New Row'),(352,'city_after','2024-05-01 11:18:40','city_postal_code: 1271, city_name: København K\r'),(353,'city_before','2024-05-01 11:18:40','Insert New Row'),(354,'city_after','2024-05-01 11:18:40','city_postal_code: 1300, city_name: København K\r'),(355,'city_before','2024-05-01 11:18:40','Insert New Row'),(356,'city_after','2024-05-01 11:18:40','city_postal_code: 1301, city_name: København K\r'),(357,'city_before','2024-05-01 11:18:40','Insert New Row'),(358,'city_after','2024-05-01 11:18:40','city_postal_code: 1302, city_name: København K\r'),(359,'city_before','2024-05-01 11:18:40','Insert New Row'),(360,'city_after','2024-05-01 11:18:40','city_postal_code: 1303, city_name: København K\r'),(361,'city_before','2024-05-01 11:18:40','Insert New Row'),(362,'city_after','2024-05-01 11:18:40','city_postal_code: 1304, city_name: København K\r'),(363,'city_before','2024-05-01 11:18:40','Insert New Row'),(364,'city_after','2024-05-01 11:18:40','city_postal_code: 1306, city_name: København K\r'),(365,'city_before','2024-05-01 11:18:40','Insert New Row'),(366,'city_after','2024-05-01 11:18:40','city_postal_code: 1307, city_name: København K\r'),(367,'city_before','2024-05-01 11:18:40','Insert New Row'),(368,'city_after','2024-05-01 11:18:40','city_postal_code: 1308, city_name: København K\r'),(369,'city_before','2024-05-01 11:18:40','Insert New Row'),(370,'city_after','2024-05-01 11:18:40','city_postal_code: 1309, city_name: København K\r'),(371,'city_before','2024-05-01 11:18:40','Insert New Row'),(372,'city_after','2024-05-01 11:18:40','city_postal_code: 1310, city_name: København K\r'),(373,'city_before','2024-05-01 11:18:40','Insert New Row'),(374,'city_after','2024-05-01 11:18:40','city_postal_code: 1311, city_name: København K\r'),(375,'city_before','2024-05-01 11:18:40','Insert New Row'),(376,'city_after','2024-05-01 11:18:40','city_postal_code: 1312, city_name: København K\r'),(377,'city_before','2024-05-01 11:18:40','Insert New Row'),(378,'city_after','2024-05-01 11:18:40','city_postal_code: 1313, city_name: København K\r'),(379,'city_before','2024-05-01 11:18:40','Insert New Row'),(380,'city_after','2024-05-01 11:18:40','city_postal_code: 1314, city_name: København K\r'),(381,'city_before','2024-05-01 11:18:40','Insert New Row'),(382,'city_after','2024-05-01 11:18:40','city_postal_code: 1315, city_name: København K\r'),(383,'city_before','2024-05-01 11:18:40','Insert New Row'),(384,'city_after','2024-05-01 11:18:40','city_postal_code: 1316, city_name: København K\r'),(385,'city_before','2024-05-01 11:18:40','Insert New Row'),(386,'city_after','2024-05-01 11:18:40','city_postal_code: 1317, city_name: København K\r'),(387,'city_before','2024-05-01 11:18:40','Insert New Row'),(388,'city_after','2024-05-01 11:18:40','city_postal_code: 1318, city_name: København K\r'),(389,'city_before','2024-05-01 11:18:40','Insert New Row'),(390,'city_after','2024-05-01 11:18:40','city_postal_code: 1319, city_name: København K\r'),(391,'city_before','2024-05-01 11:18:40','Insert New Row'),(392,'city_after','2024-05-01 11:18:40','city_postal_code: 1320, city_name: København K\r'),(393,'city_before','2024-05-01 11:18:40','Insert New Row'),(394,'city_after','2024-05-01 11:18:40','city_postal_code: 1321, city_name: København K\r'),(395,'city_before','2024-05-01 11:18:40','Insert New Row'),(396,'city_after','2024-05-01 11:18:40','city_postal_code: 1322, city_name: København K\r'),(397,'city_before','2024-05-01 11:18:40','Insert New Row'),(398,'city_after','2024-05-01 11:18:40','city_postal_code: 1323, city_name: København K\r'),(399,'city_before','2024-05-01 11:18:40','Insert New Row'),(400,'city_after','2024-05-01 11:18:40','city_postal_code: 1324, city_name: København K\r'),(401,'city_before','2024-05-01 11:18:40','Insert New Row'),(402,'city_after','2024-05-01 11:18:40','city_postal_code: 1325, city_name: København K\r'),(403,'city_before','2024-05-01 11:18:40','Insert New Row'),(404,'city_after','2024-05-01 11:18:40','city_postal_code: 1326, city_name: København K\r'),(405,'city_before','2024-05-01 11:18:40','Insert New Row'),(406,'city_after','2024-05-01 11:18:40','city_postal_code: 1327, city_name: København K\r'),(407,'city_before','2024-05-01 11:18:40','Insert New Row'),(408,'city_after','2024-05-01 11:18:40','city_postal_code: 1328, city_name: København K\r'),(409,'city_before','2024-05-01 11:18:40','Insert New Row'),(410,'city_after','2024-05-01 11:18:40','city_postal_code: 1329, city_name: København K\r'),(411,'city_before','2024-05-01 11:18:40','Insert New Row'),(412,'city_after','2024-05-01 11:18:40','city_postal_code: 1350, city_name: København K\r'),(413,'city_before','2024-05-01 11:18:40','Insert New Row'),(414,'city_after','2024-05-01 11:18:40','city_postal_code: 1352, city_name: København K\r'),(415,'city_before','2024-05-01 11:18:40','Insert New Row'),(416,'city_after','2024-05-01 11:18:40','city_postal_code: 1353, city_name: København K\r'),(417,'city_before','2024-05-01 11:18:40','Insert New Row'),(418,'city_after','2024-05-01 11:18:40','city_postal_code: 1354, city_name: København K\r'),(419,'city_before','2024-05-01 11:18:40','Insert New Row'),(420,'city_after','2024-05-01 11:18:40','city_postal_code: 1355, city_name: København K\r'),(421,'city_before','2024-05-01 11:18:40','Insert New Row'),(422,'city_after','2024-05-01 11:18:40','city_postal_code: 1356, city_name: København K\r'),(423,'city_before','2024-05-01 11:18:40','Insert New Row'),(424,'city_after','2024-05-01 11:18:40','city_postal_code: 1357, city_name: København K\r'),(425,'city_before','2024-05-01 11:18:40','Insert New Row'),(426,'city_after','2024-05-01 11:18:40','city_postal_code: 1358, city_name: København K\r'),(427,'city_before','2024-05-01 11:18:40','Insert New Row'),(428,'city_after','2024-05-01 11:18:40','city_postal_code: 1359, city_name: København K\r'),(429,'city_before','2024-05-01 11:18:40','Insert New Row'),(430,'city_after','2024-05-01 11:18:40','city_postal_code: 1360, city_name: København K\r'),(431,'city_before','2024-05-01 11:18:40','Insert New Row'),(432,'city_after','2024-05-01 11:18:40','city_postal_code: 1361, city_name: København K\r'),(433,'city_before','2024-05-01 11:18:40','Insert New Row'),(434,'city_after','2024-05-01 11:18:40','city_postal_code: 1362, city_name: København K\r'),(435,'city_before','2024-05-01 11:18:40','Insert New Row'),(436,'city_after','2024-05-01 11:18:40','city_postal_code: 1363, city_name: København K\r'),(437,'city_before','2024-05-01 11:18:40','Insert New Row'),(438,'city_after','2024-05-01 11:18:40','city_postal_code: 1364, city_name: København K\r'),(439,'city_before','2024-05-01 11:18:40','Insert New Row'),(440,'city_after','2024-05-01 11:18:40','city_postal_code: 1365, city_name: København K\r'),(441,'city_before','2024-05-01 11:18:40','Insert New Row'),(442,'city_after','2024-05-01 11:18:40','city_postal_code: 1366, city_name: København K\r'),(443,'city_before','2024-05-01 11:18:40','Insert New Row'),(444,'city_after','2024-05-01 11:18:40','city_postal_code: 1367, city_name: København K\r'),(445,'city_before','2024-05-01 11:18:40','Insert New Row'),(446,'city_after','2024-05-01 11:18:40','city_postal_code: 1368, city_name: København K\r'),(447,'city_before','2024-05-01 11:18:40','Insert New Row'),(448,'city_after','2024-05-01 11:18:40','city_postal_code: 1369, city_name: København K\r'),(449,'city_before','2024-05-01 11:18:40','Insert New Row'),(450,'city_after','2024-05-01 11:18:40','city_postal_code: 1370, city_name: København K\r'),(451,'city_before','2024-05-01 11:18:40','Insert New Row'),(452,'city_after','2024-05-01 11:18:40','city_postal_code: 1371, city_name: København K\r'),(453,'city_before','2024-05-01 11:18:40','Insert New Row'),(454,'city_after','2024-05-01 11:18:40','city_postal_code: 1400, city_name: København K\r'),(455,'city_before','2024-05-01 11:18:40','Insert New Row'),(456,'city_after','2024-05-01 11:18:40','city_postal_code: 1401, city_name: København K\r'),(457,'city_before','2024-05-01 11:18:40','Insert New Row'),(458,'city_after','2024-05-01 11:18:40','city_postal_code: 1402, city_name: København K\r'),(459,'city_before','2024-05-01 11:18:40','Insert New Row'),(460,'city_after','2024-05-01 11:18:40','city_postal_code: 1403, city_name: København K\r'),(461,'city_before','2024-05-01 11:18:40','Insert New Row'),(462,'city_after','2024-05-01 11:18:40','city_postal_code: 1406, city_name: København K\r'),(463,'city_before','2024-05-01 11:18:40','Insert New Row'),(464,'city_after','2024-05-01 11:18:40','city_postal_code: 1407, city_name: København K\r'),(465,'city_before','2024-05-01 11:18:40','Insert New Row'),(466,'city_after','2024-05-01 11:18:40','city_postal_code: 1408, city_name: København K\r'),(467,'city_before','2024-05-01 11:18:40','Insert New Row'),(468,'city_after','2024-05-01 11:18:40','city_postal_code: 1409, city_name: København K\r'),(469,'city_before','2024-05-01 11:18:40','Insert New Row'),(470,'city_after','2024-05-01 11:18:40','city_postal_code: 1410, city_name: København K\r'),(471,'city_before','2024-05-01 11:18:40','Insert New Row'),(472,'city_after','2024-05-01 11:18:40','city_postal_code: 1411, city_name: København K\r'),(473,'city_before','2024-05-01 11:18:40','Insert New Row'),(474,'city_after','2024-05-01 11:18:40','city_postal_code: 1412, city_name: København K\r'),(475,'city_before','2024-05-01 11:18:40','Insert New Row'),(476,'city_after','2024-05-01 11:18:40','city_postal_code: 1413, city_name: København K\r'),(477,'city_before','2024-05-01 11:18:40','Insert New Row'),(478,'city_after','2024-05-01 11:18:40','city_postal_code: 1414, city_name: København K\r'),(479,'city_before','2024-05-01 11:18:40','Insert New Row'),(480,'city_after','2024-05-01 11:18:40','city_postal_code: 1415, city_name: København K\r'),(481,'city_before','2024-05-01 11:18:40','Insert New Row'),(482,'city_after','2024-05-01 11:18:40','city_postal_code: 1416, city_name: København K\r'),(483,'city_before','2024-05-01 11:18:40','Insert New Row'),(484,'city_after','2024-05-01 11:18:40','city_postal_code: 1417, city_name: København K\r'),(485,'city_before','2024-05-01 11:18:40','Insert New Row'),(486,'city_after','2024-05-01 11:18:40','city_postal_code: 1418, city_name: København K\r'),(487,'city_before','2024-05-01 11:18:40','Insert New Row'),(488,'city_after','2024-05-01 11:18:40','city_postal_code: 1419, city_name: København K\r'),(489,'city_before','2024-05-01 11:18:40','Insert New Row'),(490,'city_after','2024-05-01 11:18:40','city_postal_code: 1420, city_name: København K\r'),(491,'city_before','2024-05-01 11:18:40','Insert New Row'),(492,'city_after','2024-05-01 11:18:40','city_postal_code: 1421, city_name: København K\r'),(493,'city_before','2024-05-01 11:18:40','Insert New Row'),(494,'city_after','2024-05-01 11:18:40','city_postal_code: 1422, city_name: København K\r'),(495,'city_before','2024-05-01 11:18:40','Insert New Row'),(496,'city_after','2024-05-01 11:18:40','city_postal_code: 1423, city_name: København K\r'),(497,'city_before','2024-05-01 11:18:40','Insert New Row'),(498,'city_after','2024-05-01 11:18:40','city_postal_code: 1424, city_name: København K\r'),(499,'city_before','2024-05-01 11:18:40','Insert New Row'),(500,'city_after','2024-05-01 11:18:40','city_postal_code: 1425, city_name: København K\r'),(501,'city_before','2024-05-01 11:18:40','Insert New Row'),(502,'city_after','2024-05-01 11:18:40','city_postal_code: 1426, city_name: København K\r'),(503,'city_before','2024-05-01 11:18:40','Insert New Row'),(504,'city_after','2024-05-01 11:18:40','city_postal_code: 1427, city_name: København K\r'),(505,'city_before','2024-05-01 11:18:40','Insert New Row'),(506,'city_after','2024-05-01 11:18:40','city_postal_code: 1428, city_name: København K\r'),(507,'city_before','2024-05-01 11:18:40','Insert New Row'),(508,'city_after','2024-05-01 11:18:40','city_postal_code: 1429, city_name: København K\r'),(509,'city_before','2024-05-01 11:18:40','Insert New Row'),(510,'city_after','2024-05-01 11:18:40','city_postal_code: 1430, city_name: København K\r'),(511,'city_before','2024-05-01 11:18:40','Insert New Row'),(512,'city_after','2024-05-01 11:18:40','city_postal_code: 1432, city_name: København K\r'),(513,'city_before','2024-05-01 11:18:40','Insert New Row'),(514,'city_after','2024-05-01 11:18:40','city_postal_code: 1433, city_name: København K\r'),(515,'city_before','2024-05-01 11:18:40','Insert New Row'),(516,'city_after','2024-05-01 11:18:40','city_postal_code: 1434, city_name: København K\r'),(517,'city_before','2024-05-01 11:18:40','Insert New Row'),(518,'city_after','2024-05-01 11:18:40','city_postal_code: 1435, city_name: København K\r'),(519,'city_before','2024-05-01 11:18:40','Insert New Row'),(520,'city_after','2024-05-01 11:18:40','city_postal_code: 1436, city_name: København K\r'),(521,'city_before','2024-05-01 11:18:40','Insert New Row'),(522,'city_after','2024-05-01 11:18:40','city_postal_code: 1437, city_name: København K\r'),(523,'city_before','2024-05-01 11:18:40','Insert New Row'),(524,'city_after','2024-05-01 11:18:40','city_postal_code: 1438, city_name: København K\r'),(525,'city_before','2024-05-01 11:18:40','Insert New Row'),(526,'city_after','2024-05-01 11:18:40','city_postal_code: 1439, city_name: København K\r'),(527,'city_before','2024-05-01 11:18:40','Insert New Row'),(528,'city_after','2024-05-01 11:18:40','city_postal_code: 1440, city_name: København K\r'),(529,'city_before','2024-05-01 11:18:40','Insert New Row'),(530,'city_after','2024-05-01 11:18:40','city_postal_code: 1441, city_name: København K\r'),(531,'city_before','2024-05-01 11:18:40','Insert New Row'),(532,'city_after','2024-05-01 11:18:40','city_postal_code: 1448, city_name: København K\r'),(533,'city_before','2024-05-01 11:18:40','Insert New Row'),(534,'city_after','2024-05-01 11:18:40','city_postal_code: 1450, city_name: København K\r'),(535,'city_before','2024-05-01 11:18:40','Insert New Row'),(536,'city_after','2024-05-01 11:18:40','city_postal_code: 1451, city_name: København K\r'),(537,'city_before','2024-05-01 11:18:40','Insert New Row'),(538,'city_after','2024-05-01 11:18:40','city_postal_code: 1452, city_name: København K\r'),(539,'city_before','2024-05-01 11:18:40','Insert New Row'),(540,'city_after','2024-05-01 11:18:40','city_postal_code: 1453, city_name: København K\r'),(541,'city_before','2024-05-01 11:18:40','Insert New Row'),(542,'city_after','2024-05-01 11:18:40','city_postal_code: 1454, city_name: København K\r'),(543,'city_before','2024-05-01 11:18:40','Insert New Row'),(544,'city_after','2024-05-01 11:18:40','city_postal_code: 1455, city_name: København K\r'),(545,'city_before','2024-05-01 11:18:40','Insert New Row'),(546,'city_after','2024-05-01 11:18:40','city_postal_code: 1456, city_name: København K\r'),(547,'city_before','2024-05-01 11:18:40','Insert New Row'),(548,'city_after','2024-05-01 11:18:40','city_postal_code: 1457, city_name: København K\r'),(549,'city_before','2024-05-01 11:18:40','Insert New Row'),(550,'city_after','2024-05-01 11:18:40','city_postal_code: 1458, city_name: København K\r'),(551,'city_before','2024-05-01 11:18:40','Insert New Row'),(552,'city_after','2024-05-01 11:18:40','city_postal_code: 1459, city_name: København K\r'),(553,'city_before','2024-05-01 11:18:40','Insert New Row'),(554,'city_after','2024-05-01 11:18:40','city_postal_code: 1460, city_name: København K\r'),(555,'city_before','2024-05-01 11:18:40','Insert New Row'),(556,'city_after','2024-05-01 11:18:40','city_postal_code: 1461, city_name: København K\r'),(557,'city_before','2024-05-01 11:18:40','Insert New Row'),(558,'city_after','2024-05-01 11:18:40','city_postal_code: 1462, city_name: København K\r'),(559,'city_before','2024-05-01 11:18:40','Insert New Row'),(560,'city_after','2024-05-01 11:18:40','city_postal_code: 1463, city_name: København K\r'),(561,'city_before','2024-05-01 11:18:40','Insert New Row'),(562,'city_after','2024-05-01 11:18:40','city_postal_code: 1464, city_name: København K\r'),(563,'city_before','2024-05-01 11:18:40','Insert New Row'),(564,'city_after','2024-05-01 11:18:40','city_postal_code: 1465, city_name: København K\r'),(565,'city_before','2024-05-01 11:18:40','Insert New Row'),(566,'city_after','2024-05-01 11:18:40','city_postal_code: 1466, city_name: København K\r'),(567,'city_before','2024-05-01 11:18:40','Insert New Row'),(568,'city_after','2024-05-01 11:18:40','city_postal_code: 1467, city_name: København K\r'),(569,'city_before','2024-05-01 11:18:40','Insert New Row'),(570,'city_after','2024-05-01 11:18:40','city_postal_code: 1468, city_name: København K\r'),(571,'city_before','2024-05-01 11:18:40','Insert New Row'),(572,'city_after','2024-05-01 11:18:40','city_postal_code: 1470, city_name: København K\r'),(573,'city_before','2024-05-01 11:18:40','Insert New Row'),(574,'city_after','2024-05-01 11:18:40','city_postal_code: 1471, city_name: København K\r'),(575,'city_before','2024-05-01 11:18:40','Insert New Row'),(576,'city_after','2024-05-01 11:18:40','city_postal_code: 1472, city_name: København K\r'),(577,'city_before','2024-05-01 11:18:40','Insert New Row'),(578,'city_after','2024-05-01 11:18:40','city_postal_code: 1473, city_name: København K\r'),(579,'city_before','2024-05-01 11:18:40','Insert New Row'),(580,'city_after','2024-05-01 11:18:40','city_postal_code: 1500, city_name: København V\r'),(581,'city_before','2024-05-01 11:18:40','Insert New Row'),(582,'city_after','2024-05-01 11:18:40','city_postal_code: 1501, city_name: København V\r'),(583,'city_before','2024-05-01 11:18:40','Insert New Row'),(584,'city_after','2024-05-01 11:18:40','city_postal_code: 1502, city_name: København V\r'),(585,'city_before','2024-05-01 11:18:40','Insert New Row'),(586,'city_after','2024-05-01 11:18:40','city_postal_code: 1503, city_name: København V\r'),(587,'city_before','2024-05-01 11:18:40','Insert New Row'),(588,'city_after','2024-05-01 11:18:40','city_postal_code: 1504, city_name: København V\r'),(589,'city_before','2024-05-01 11:18:40','Insert New Row'),(590,'city_after','2024-05-01 11:18:40','city_postal_code: 1505, city_name: København V\r'),(591,'city_before','2024-05-01 11:18:40','Insert New Row'),(592,'city_after','2024-05-01 11:18:40','city_postal_code: 1506, city_name: København V\r'),(593,'city_before','2024-05-01 11:18:40','Insert New Row'),(594,'city_after','2024-05-01 11:18:40','city_postal_code: 1507, city_name: København V\r'),(595,'city_before','2024-05-01 11:18:40','Insert New Row'),(596,'city_after','2024-05-01 11:18:40','city_postal_code: 1508, city_name: København V\r'),(597,'city_before','2024-05-01 11:18:40','Insert New Row'),(598,'city_after','2024-05-01 11:18:40','city_postal_code: 1509, city_name: København V\r'),(599,'city_before','2024-05-01 11:18:40','Insert New Row'),(600,'city_after','2024-05-01 11:18:40','city_postal_code: 1510, city_name: København V\r'),(601,'city_before','2024-05-01 11:18:40','Insert New Row'),(602,'city_after','2024-05-01 11:18:40','city_postal_code: 1512, city_name: Returpost\r'),(603,'city_before','2024-05-01 11:18:40','Insert New Row'),(604,'city_after','2024-05-01 11:18:40','city_postal_code: 1513, city_name: Flytninger og Nejtak\r'),(605,'city_before','2024-05-01 11:18:40','Insert New Row'),(606,'city_after','2024-05-01 11:18:40','city_postal_code: 1532, city_name: København V\r'),(607,'city_before','2024-05-01 11:18:40','Insert New Row'),(608,'city_after','2024-05-01 11:18:40','city_postal_code: 1533, city_name: København V\r'),(609,'city_before','2024-05-01 11:18:40','Insert New Row'),(610,'city_after','2024-05-01 11:18:40','city_postal_code: 1550, city_name: København V\r'),(611,'city_before','2024-05-01 11:18:40','Insert New Row'),(612,'city_after','2024-05-01 11:18:40','city_postal_code: 1551, city_name: København V\r'),(613,'city_before','2024-05-01 11:18:40','Insert New Row'),(614,'city_after','2024-05-01 11:18:40','city_postal_code: 1552, city_name: København V\r'),(615,'city_before','2024-05-01 11:18:40','Insert New Row'),(616,'city_after','2024-05-01 11:18:40','city_postal_code: 1553, city_name: København V\r'),(617,'city_before','2024-05-01 11:18:40','Insert New Row'),(618,'city_after','2024-05-01 11:18:40','city_postal_code: 1554, city_name: København V\r'),(619,'city_before','2024-05-01 11:18:40','Insert New Row'),(620,'city_after','2024-05-01 11:18:40','city_postal_code: 1555, city_name: København V\r'),(621,'city_before','2024-05-01 11:18:40','Insert New Row'),(622,'city_after','2024-05-01 11:18:40','city_postal_code: 1556, city_name: København V\r'),(623,'city_before','2024-05-01 11:18:40','Insert New Row'),(624,'city_after','2024-05-01 11:18:40','city_postal_code: 1557, city_name: København V\r'),(625,'city_before','2024-05-01 11:18:40','Insert New Row'),(626,'city_after','2024-05-01 11:18:40','city_postal_code: 1558, city_name: København V\r'),(627,'city_before','2024-05-01 11:18:40','Insert New Row'),(628,'city_after','2024-05-01 11:18:40','city_postal_code: 1559, city_name: København V\r'),(629,'city_before','2024-05-01 11:18:40','Insert New Row'),(630,'city_after','2024-05-01 11:18:40','city_postal_code: 1560, city_name: København V\r'),(631,'city_before','2024-05-01 11:18:40','Insert New Row'),(632,'city_after','2024-05-01 11:18:40','city_postal_code: 1561, city_name: København V\r'),(633,'city_before','2024-05-01 11:18:40','Insert New Row'),(634,'city_after','2024-05-01 11:18:40','city_postal_code: 1562, city_name: København V\r'),(635,'city_before','2024-05-01 11:18:40','Insert New Row'),(636,'city_after','2024-05-01 11:18:40','city_postal_code: 1563, city_name: København V\r'),(637,'city_before','2024-05-01 11:18:40','Insert New Row'),(638,'city_after','2024-05-01 11:18:40','city_postal_code: 1564, city_name: København V\r'),(639,'city_before','2024-05-01 11:18:40','Insert New Row'),(640,'city_after','2024-05-01 11:18:40','city_postal_code: 1567, city_name: København V\r'),(641,'city_before','2024-05-01 11:18:40','Insert New Row'),(642,'city_after','2024-05-01 11:18:40','city_postal_code: 1568, city_name: København V\r'),(643,'city_before','2024-05-01 11:18:40','Insert New Row'),(644,'city_after','2024-05-01 11:18:40','city_postal_code: 1569, city_name: København V\r'),(645,'city_before','2024-05-01 11:18:40','Insert New Row'),(646,'city_after','2024-05-01 11:18:40','city_postal_code: 1570, city_name: København V\r'),(647,'city_before','2024-05-01 11:18:40','Insert New Row'),(648,'city_after','2024-05-01 11:18:40','city_postal_code: 1571, city_name: København V\r'),(649,'city_before','2024-05-01 11:18:40','Insert New Row'),(650,'city_after','2024-05-01 11:18:40','city_postal_code: 1572, city_name: København V\r'),(651,'city_before','2024-05-01 11:18:40','Insert New Row'),(652,'city_after','2024-05-01 11:18:40','city_postal_code: 1573, city_name: København V\r'),(653,'city_before','2024-05-01 11:18:40','Insert New Row'),(654,'city_after','2024-05-01 11:18:40','city_postal_code: 1574, city_name: København V\r'),(655,'city_before','2024-05-01 11:18:40','Insert New Row'),(656,'city_after','2024-05-01 11:18:40','city_postal_code: 1575, city_name: København V\r'),(657,'city_before','2024-05-01 11:18:40','Insert New Row'),(658,'city_after','2024-05-01 11:18:40','city_postal_code: 1576, city_name: København V\r'),(659,'city_before','2024-05-01 11:18:40','Insert New Row'),(660,'city_after','2024-05-01 11:18:40','city_postal_code: 1577, city_name: København V\r'),(661,'city_before','2024-05-01 11:18:40','Insert New Row'),(662,'city_after','2024-05-01 11:18:40','city_postal_code: 1592, city_name: København V\r'),(663,'city_before','2024-05-01 11:18:40','Insert New Row'),(664,'city_after','2024-05-01 11:18:40','city_postal_code: 1599, city_name: København V\r'),(665,'city_before','2024-05-01 11:18:40','Insert New Row'),(666,'city_after','2024-05-01 11:18:40','city_postal_code: 1600, city_name: København V\r'),(667,'city_before','2024-05-01 11:18:40','Insert New Row'),(668,'city_after','2024-05-01 11:18:40','city_postal_code: 1601, city_name: København V\r'),(669,'city_before','2024-05-01 11:18:40','Insert New Row'),(670,'city_after','2024-05-01 11:18:40','city_postal_code: 1602, city_name: København V\r'),(671,'city_before','2024-05-01 11:18:40','Insert New Row'),(672,'city_after','2024-05-01 11:18:40','city_postal_code: 1603, city_name: København V\r'),(673,'city_before','2024-05-01 11:18:40','Insert New Row'),(674,'city_after','2024-05-01 11:18:40','city_postal_code: 1604, city_name: København V\r'),(675,'city_before','2024-05-01 11:18:40','Insert New Row'),(676,'city_after','2024-05-01 11:18:40','city_postal_code: 1605, city_name: København V\r'),(677,'city_before','2024-05-01 11:18:40','Insert New Row'),(678,'city_after','2024-05-01 11:18:40','city_postal_code: 1606, city_name: København V\r'),(679,'city_before','2024-05-01 11:18:40','Insert New Row'),(680,'city_after','2024-05-01 11:18:40','city_postal_code: 1607, city_name: København V\r'),(681,'city_before','2024-05-01 11:18:40','Insert New Row'),(682,'city_after','2024-05-01 11:18:40','city_postal_code: 1608, city_name: København V\r'),(683,'city_before','2024-05-01 11:18:40','Insert New Row'),(684,'city_after','2024-05-01 11:18:40','city_postal_code: 1609, city_name: København V\r'),(685,'city_before','2024-05-01 11:18:40','Insert New Row'),(686,'city_after','2024-05-01 11:18:40','city_postal_code: 1610, city_name: København V\r'),(687,'city_before','2024-05-01 11:18:40','Insert New Row'),(688,'city_after','2024-05-01 11:18:40','city_postal_code: 1611, city_name: København V\r'),(689,'city_before','2024-05-01 11:18:40','Insert New Row'),(690,'city_after','2024-05-01 11:18:40','city_postal_code: 1612, city_name: København V\r'),(691,'city_before','2024-05-01 11:18:40','Insert New Row'),(692,'city_after','2024-05-01 11:18:40','city_postal_code: 1613, city_name: København V\r'),(693,'city_before','2024-05-01 11:18:40','Insert New Row'),(694,'city_after','2024-05-01 11:18:40','city_postal_code: 1614, city_name: København V\r'),(695,'city_before','2024-05-01 11:18:40','Insert New Row'),(696,'city_after','2024-05-01 11:18:40','city_postal_code: 1615, city_name: København V\r'),(697,'city_before','2024-05-01 11:18:40','Insert New Row'),(698,'city_after','2024-05-01 11:18:40','city_postal_code: 1616, city_name: København V\r'),(699,'city_before','2024-05-01 11:18:40','Insert New Row'),(700,'city_after','2024-05-01 11:18:40','city_postal_code: 1617, city_name: København V\r'),(701,'city_before','2024-05-01 11:18:40','Insert New Row'),(702,'city_after','2024-05-01 11:18:40','city_postal_code: 1618, city_name: København V\r'),(703,'city_before','2024-05-01 11:18:40','Insert New Row'),(704,'city_after','2024-05-01 11:18:40','city_postal_code: 1619, city_name: København V\r'),(705,'city_before','2024-05-01 11:18:40','Insert New Row'),(706,'city_after','2024-05-01 11:18:40','city_postal_code: 1620, city_name: København V\r'),(707,'city_before','2024-05-01 11:18:40','Insert New Row'),(708,'city_after','2024-05-01 11:18:40','city_postal_code: 1621, city_name: København V\r'),(709,'city_before','2024-05-01 11:18:40','Insert New Row'),(710,'city_after','2024-05-01 11:18:40','city_postal_code: 1622, city_name: København V\r'),(711,'city_before','2024-05-01 11:18:40','Insert New Row'),(712,'city_after','2024-05-01 11:18:40','city_postal_code: 1623, city_name: København V\r'),(713,'city_before','2024-05-01 11:18:40','Insert New Row'),(714,'city_after','2024-05-01 11:18:40','city_postal_code: 1624, city_name: København V\r'),(715,'city_before','2024-05-01 11:18:40','Insert New Row'),(716,'city_after','2024-05-01 11:18:40','city_postal_code: 1630, city_name: København V\r'),(717,'city_before','2024-05-01 11:18:40','Insert New Row'),(718,'city_after','2024-05-01 11:18:40','city_postal_code: 1631, city_name: København V\r'),(719,'city_before','2024-05-01 11:18:40','Insert New Row'),(720,'city_after','2024-05-01 11:18:40','city_postal_code: 1632, city_name: København V\r'),(721,'city_before','2024-05-01 11:18:40','Insert New Row'),(722,'city_after','2024-05-01 11:18:40','city_postal_code: 1633, city_name: København V\r'),(723,'city_before','2024-05-01 11:18:40','Insert New Row'),(724,'city_after','2024-05-01 11:18:40','city_postal_code: 1634, city_name: København V\r'),(725,'city_before','2024-05-01 11:18:40','Insert New Row'),(726,'city_after','2024-05-01 11:18:40','city_postal_code: 1635, city_name: København V\r'),(727,'city_before','2024-05-01 11:18:40','Insert New Row'),(728,'city_after','2024-05-01 11:18:40','city_postal_code: 1650, city_name: København V\r'),(729,'city_before','2024-05-01 11:18:40','Insert New Row'),(730,'city_after','2024-05-01 11:18:40','city_postal_code: 1651, city_name: København V\r'),(731,'city_before','2024-05-01 11:18:40','Insert New Row'),(732,'city_after','2024-05-01 11:18:40','city_postal_code: 1652, city_name: København V\r'),(733,'city_before','2024-05-01 11:18:40','Insert New Row'),(734,'city_after','2024-05-01 11:18:40','city_postal_code: 1653, city_name: København V\r'),(735,'city_before','2024-05-01 11:18:40','Insert New Row'),(736,'city_after','2024-05-01 11:18:40','city_postal_code: 1654, city_name: København V\r'),(737,'city_before','2024-05-01 11:18:40','Insert New Row'),(738,'city_after','2024-05-01 11:18:40','city_postal_code: 1655, city_name: København V\r'),(739,'city_before','2024-05-01 11:18:40','Insert New Row'),(740,'city_after','2024-05-01 11:18:40','city_postal_code: 1656, city_name: København V\r'),(741,'city_before','2024-05-01 11:18:40','Insert New Row'),(742,'city_after','2024-05-01 11:18:40','city_postal_code: 1657, city_name: København V\r'),(743,'city_before','2024-05-01 11:18:40','Insert New Row'),(744,'city_after','2024-05-01 11:18:40','city_postal_code: 1658, city_name: København V\r'),(745,'city_before','2024-05-01 11:18:40','Insert New Row'),(746,'city_after','2024-05-01 11:18:40','city_postal_code: 1659, city_name: København V\r'),(747,'city_before','2024-05-01 11:18:40','Insert New Row'),(748,'city_after','2024-05-01 11:18:40','city_postal_code: 1660, city_name: København V\r'),(749,'city_before','2024-05-01 11:18:40','Insert New Row'),(750,'city_after','2024-05-01 11:18:40','city_postal_code: 1661, city_name: København V\r'),(751,'city_before','2024-05-01 11:18:40','Insert New Row'),(752,'city_after','2024-05-01 11:18:40','city_postal_code: 1662, city_name: København V\r'),(753,'city_before','2024-05-01 11:18:40','Insert New Row'),(754,'city_after','2024-05-01 11:18:40','city_postal_code: 1663, city_name: København V\r'),(755,'city_before','2024-05-01 11:18:40','Insert New Row'),(756,'city_after','2024-05-01 11:18:40','city_postal_code: 1664, city_name: København V\r'),(757,'city_before','2024-05-01 11:18:40','Insert New Row'),(758,'city_after','2024-05-01 11:18:40','city_postal_code: 1665, city_name: København V\r'),(759,'city_before','2024-05-01 11:18:40','Insert New Row'),(760,'city_after','2024-05-01 11:18:40','city_postal_code: 1666, city_name: København V\r'),(761,'city_before','2024-05-01 11:18:40','Insert New Row'),(762,'city_after','2024-05-01 11:18:40','city_postal_code: 1667, city_name: København V\r'),(763,'city_before','2024-05-01 11:18:40','Insert New Row'),(764,'city_after','2024-05-01 11:18:40','city_postal_code: 1668, city_name: København V\r'),(765,'city_before','2024-05-01 11:18:40','Insert New Row'),(766,'city_after','2024-05-01 11:18:40','city_postal_code: 1669, city_name: København V\r'),(767,'city_before','2024-05-01 11:18:40','Insert New Row'),(768,'city_after','2024-05-01 11:18:40','city_postal_code: 1670, city_name: København V\r'),(769,'city_before','2024-05-01 11:18:40','Insert New Row'),(770,'city_after','2024-05-01 11:18:40','city_postal_code: 1671, city_name: København V\r'),(771,'city_before','2024-05-01 11:18:40','Insert New Row'),(772,'city_after','2024-05-01 11:18:40','city_postal_code: 1672, city_name: København V\r'),(773,'city_before','2024-05-01 11:18:40','Insert New Row'),(774,'city_after','2024-05-01 11:18:40','city_postal_code: 1673, city_name: København V\r'),(775,'city_before','2024-05-01 11:18:40','Insert New Row'),(776,'city_after','2024-05-01 11:18:40','city_postal_code: 1674, city_name: København V\r'),(777,'city_before','2024-05-01 11:18:40','Insert New Row'),(778,'city_after','2024-05-01 11:18:40','city_postal_code: 1675, city_name: København V\r'),(779,'city_before','2024-05-01 11:18:40','Insert New Row'),(780,'city_after','2024-05-01 11:18:40','city_postal_code: 1676, city_name: København V\r'),(781,'city_before','2024-05-01 11:18:40','Insert New Row'),(782,'city_after','2024-05-01 11:18:40','city_postal_code: 1677, city_name: København V\r'),(783,'city_before','2024-05-01 11:18:40','Insert New Row'),(784,'city_after','2024-05-01 11:18:40','city_postal_code: 1699, city_name: København V\r'),(785,'city_before','2024-05-01 11:18:40','Insert New Row'),(786,'city_after','2024-05-01 11:18:40','city_postal_code: 1700, city_name: København V\r'),(787,'city_before','2024-05-01 11:18:40','Insert New Row'),(788,'city_after','2024-05-01 11:18:40','city_postal_code: 1701, city_name: København V\r'),(789,'city_before','2024-05-01 11:18:40','Insert New Row'),(790,'city_after','2024-05-01 11:18:40','city_postal_code: 1702, city_name: København V\r'),(791,'city_before','2024-05-01 11:18:40','Insert New Row'),(792,'city_after','2024-05-01 11:18:40','city_postal_code: 1703, city_name: København V\r'),(793,'city_before','2024-05-01 11:18:40','Insert New Row'),(794,'city_after','2024-05-01 11:18:40','city_postal_code: 1704, city_name: København V\r'),(795,'city_before','2024-05-01 11:18:40','Insert New Row'),(796,'city_after','2024-05-01 11:18:40','city_postal_code: 1705, city_name: København V\r'),(797,'city_before','2024-05-01 11:18:40','Insert New Row'),(798,'city_after','2024-05-01 11:18:40','city_postal_code: 1706, city_name: København V\r'),(799,'city_before','2024-05-01 11:18:40','Insert New Row'),(800,'city_after','2024-05-01 11:18:40','city_postal_code: 1707, city_name: København V\r'),(801,'city_before','2024-05-01 11:18:40','Insert New Row'),(802,'city_after','2024-05-01 11:18:40','city_postal_code: 1708, city_name: København V\r'),(803,'city_before','2024-05-01 11:18:40','Insert New Row'),(804,'city_after','2024-05-01 11:18:40','city_postal_code: 1709, city_name: København V\r'),(805,'city_before','2024-05-01 11:18:40','Insert New Row'),(806,'city_after','2024-05-01 11:18:40','city_postal_code: 1710, city_name: København V\r'),(807,'city_before','2024-05-01 11:18:40','Insert New Row'),(808,'city_after','2024-05-01 11:18:40','city_postal_code: 1711, city_name: København V\r'),(809,'city_before','2024-05-01 11:18:40','Insert New Row'),(810,'city_after','2024-05-01 11:18:40','city_postal_code: 1712, city_name: København V\r'),(811,'city_before','2024-05-01 11:18:40','Insert New Row'),(812,'city_after','2024-05-01 11:18:40','city_postal_code: 1714, city_name: København V\r'),(813,'city_before','2024-05-01 11:18:40','Insert New Row'),(814,'city_after','2024-05-01 11:18:40','city_postal_code: 1715, city_name: København V\r'),(815,'city_before','2024-05-01 11:18:40','Insert New Row'),(816,'city_after','2024-05-01 11:18:40','city_postal_code: 1716, city_name: København V\r'),(817,'city_before','2024-05-01 11:18:40','Insert New Row'),(818,'city_after','2024-05-01 11:18:40','city_postal_code: 1717, city_name: København V\r'),(819,'city_before','2024-05-01 11:18:40','Insert New Row'),(820,'city_after','2024-05-01 11:18:40','city_postal_code: 1718, city_name: København V\r'),(821,'city_before','2024-05-01 11:18:40','Insert New Row'),(822,'city_after','2024-05-01 11:18:40','city_postal_code: 1719, city_name: København V\r'),(823,'city_before','2024-05-01 11:18:40','Insert New Row'),(824,'city_after','2024-05-01 11:18:40','city_postal_code: 1720, city_name: København V\r'),(825,'city_before','2024-05-01 11:18:40','Insert New Row'),(826,'city_after','2024-05-01 11:18:40','city_postal_code: 1721, city_name: København V\r'),(827,'city_before','2024-05-01 11:18:40','Insert New Row'),(828,'city_after','2024-05-01 11:18:40','city_postal_code: 1722, city_name: København V\r'),(829,'city_before','2024-05-01 11:18:40','Insert New Row'),(830,'city_after','2024-05-01 11:18:40','city_postal_code: 1723, city_name: København V\r'),(831,'city_before','2024-05-01 11:18:40','Insert New Row'),(832,'city_after','2024-05-01 11:18:40','city_postal_code: 1724, city_name: København V\r'),(833,'city_before','2024-05-01 11:18:40','Insert New Row'),(834,'city_after','2024-05-01 11:18:40','city_postal_code: 1725, city_name: København V\r'),(835,'city_before','2024-05-01 11:18:40','Insert New Row'),(836,'city_after','2024-05-01 11:18:40','city_postal_code: 1726, city_name: København V\r'),(837,'city_before','2024-05-01 11:18:40','Insert New Row'),(838,'city_after','2024-05-01 11:18:40','city_postal_code: 1727, city_name: København V\r'),(839,'city_before','2024-05-01 11:18:40','Insert New Row'),(840,'city_after','2024-05-01 11:18:40','city_postal_code: 1728, city_name: København V\r'),(841,'city_before','2024-05-01 11:18:40','Insert New Row'),(842,'city_after','2024-05-01 11:18:40','city_postal_code: 1729, city_name: København V\r'),(843,'city_before','2024-05-01 11:18:40','Insert New Row'),(844,'city_after','2024-05-01 11:18:40','city_postal_code: 1730, city_name: København V\r'),(845,'city_before','2024-05-01 11:18:40','Insert New Row'),(846,'city_after','2024-05-01 11:18:40','city_postal_code: 1731, city_name: København V\r'),(847,'city_before','2024-05-01 11:18:40','Insert New Row'),(848,'city_after','2024-05-01 11:18:40','city_postal_code: 1732, city_name: København V\r'),(849,'city_before','2024-05-01 11:18:40','Insert New Row'),(850,'city_after','2024-05-01 11:18:40','city_postal_code: 1733, city_name: København V\r'),(851,'city_before','2024-05-01 11:18:40','Insert New Row'),(852,'city_after','2024-05-01 11:18:40','city_postal_code: 1734, city_name: København V\r'),(853,'city_before','2024-05-01 11:18:40','Insert New Row'),(854,'city_after','2024-05-01 11:18:40','city_postal_code: 1735, city_name: København V\r'),(855,'city_before','2024-05-01 11:18:40','Insert New Row'),(856,'city_after','2024-05-01 11:18:40','city_postal_code: 1736, city_name: København V\r'),(857,'city_before','2024-05-01 11:18:40','Insert New Row'),(858,'city_after','2024-05-01 11:18:40','city_postal_code: 1737, city_name: København V\r'),(859,'city_before','2024-05-01 11:18:40','Insert New Row'),(860,'city_after','2024-05-01 11:18:40','city_postal_code: 1738, city_name: København V\r'),(861,'city_before','2024-05-01 11:18:40','Insert New Row'),(862,'city_after','2024-05-01 11:18:40','city_postal_code: 1739, city_name: København V\r'),(863,'city_before','2024-05-01 11:18:40','Insert New Row'),(864,'city_after','2024-05-01 11:18:40','city_postal_code: 1749, city_name: København V\r'),(865,'city_before','2024-05-01 11:18:40','Insert New Row'),(866,'city_after','2024-05-01 11:18:40','city_postal_code: 1750, city_name: København V\r'),(867,'city_before','2024-05-01 11:18:40','Insert New Row'),(868,'city_after','2024-05-01 11:18:40','city_postal_code: 1751, city_name: København V\r'),(869,'city_before','2024-05-01 11:18:40','Insert New Row'),(870,'city_after','2024-05-01 11:18:40','city_postal_code: 1752, city_name: København V\r'),(871,'city_before','2024-05-01 11:18:40','Insert New Row'),(872,'city_after','2024-05-01 11:18:40','city_postal_code: 1753, city_name: København V\r'),(873,'city_before','2024-05-01 11:18:40','Insert New Row'),(874,'city_after','2024-05-01 11:18:40','city_postal_code: 1754, city_name: København V\r'),(875,'city_before','2024-05-01 11:18:40','Insert New Row'),(876,'city_after','2024-05-01 11:18:40','city_postal_code: 1755, city_name: København V\r'),(877,'city_before','2024-05-01 11:18:40','Insert New Row'),(878,'city_after','2024-05-01 11:18:40','city_postal_code: 1756, city_name: København V\r'),(879,'city_before','2024-05-01 11:18:40','Insert New Row'),(880,'city_after','2024-05-01 11:18:40','city_postal_code: 1757, city_name: København V\r'),(881,'city_before','2024-05-01 11:18:40','Insert New Row'),(882,'city_after','2024-05-01 11:18:40','city_postal_code: 1758, city_name: København V\r'),(883,'city_before','2024-05-01 11:18:40','Insert New Row'),(884,'city_after','2024-05-01 11:18:40','city_postal_code: 1759, city_name: København V\r'),(885,'city_before','2024-05-01 11:18:40','Insert New Row'),(886,'city_after','2024-05-01 11:18:40','city_postal_code: 1760, city_name: København V\r'),(887,'city_before','2024-05-01 11:18:40','Insert New Row'),(888,'city_after','2024-05-01 11:18:40','city_postal_code: 1761, city_name: København V\r'),(889,'city_before','2024-05-01 11:18:40','Insert New Row'),(890,'city_after','2024-05-01 11:18:40','city_postal_code: 1762, city_name: København V\r'),(891,'city_before','2024-05-01 11:18:40','Insert New Row'),(892,'city_after','2024-05-01 11:18:40','city_postal_code: 1763, city_name: København V\r'),(893,'city_before','2024-05-01 11:18:40','Insert New Row'),(894,'city_after','2024-05-01 11:18:40','city_postal_code: 1764, city_name: København V\r'),(895,'city_before','2024-05-01 11:18:40','Insert New Row'),(896,'city_after','2024-05-01 11:18:40','city_postal_code: 1765, city_name: København V\r'),(897,'city_before','2024-05-01 11:18:40','Insert New Row'),(898,'city_after','2024-05-01 11:18:40','city_postal_code: 1766, city_name: København V\r'),(899,'city_before','2024-05-01 11:18:40','Insert New Row'),(900,'city_after','2024-05-01 11:18:40','city_postal_code: 1770, city_name: København V\r'),(901,'city_before','2024-05-01 11:18:40','Insert New Row'),(902,'city_after','2024-05-01 11:18:40','city_postal_code: 1771, city_name: København V\r'),(903,'city_before','2024-05-01 11:18:40','Insert New Row'),(904,'city_after','2024-05-01 11:18:40','city_postal_code: 1772, city_name: København V\r'),(905,'city_before','2024-05-01 11:18:40','Insert New Row'),(906,'city_after','2024-05-01 11:18:40','city_postal_code: 1773, city_name: København V\r'),(907,'city_before','2024-05-01 11:18:40','Insert New Row'),(908,'city_after','2024-05-01 11:18:40','city_postal_code: 1774, city_name: København V\r'),(909,'city_before','2024-05-01 11:18:40','Insert New Row'),(910,'city_after','2024-05-01 11:18:40','city_postal_code: 1775, city_name: København V\r'),(911,'city_before','2024-05-01 11:18:40','Insert New Row'),(912,'city_after','2024-05-01 11:18:40','city_postal_code: 1777, city_name: København V\r'),(913,'city_before','2024-05-01 11:18:40','Insert New Row'),(914,'city_after','2024-05-01 11:18:40','city_postal_code: 1780, city_name: København V\r'),(915,'city_before','2024-05-01 11:18:40','Insert New Row'),(916,'city_after','2024-05-01 11:18:40','city_postal_code: 1782, city_name: København V\r'),(917,'city_before','2024-05-01 11:18:40','Insert New Row'),(918,'city_after','2024-05-01 11:18:40','city_postal_code: 1785, city_name: København V\r'),(919,'city_before','2024-05-01 11:18:40','Insert New Row'),(920,'city_after','2024-05-01 11:18:40','city_postal_code: 1786, city_name: København V\r'),(921,'city_before','2024-05-01 11:18:40','Insert New Row'),(922,'city_after','2024-05-01 11:18:40','city_postal_code: 1787, city_name: København V\r'),(923,'city_before','2024-05-01 11:18:40','Insert New Row'),(924,'city_after','2024-05-01 11:18:40','city_postal_code: 1790, city_name: København V\r'),(925,'city_before','2024-05-01 11:18:40','Insert New Row'),(926,'city_after','2024-05-01 11:18:40','city_postal_code: 1799, city_name: København V\r'),(927,'city_before','2024-05-01 11:18:40','Insert New Row'),(928,'city_after','2024-05-01 11:18:40','city_postal_code: 1800, city_name: Frederiksberg C\r'),(929,'city_before','2024-05-01 11:18:40','Insert New Row'),(930,'city_after','2024-05-01 11:18:40','city_postal_code: 1801, city_name: Frederiksberg C\r'),(931,'city_before','2024-05-01 11:18:40','Insert New Row'),(932,'city_after','2024-05-01 11:18:40','city_postal_code: 1802, city_name: Frederiksberg C\r'),(933,'city_before','2024-05-01 11:18:40','Insert New Row'),(934,'city_after','2024-05-01 11:18:40','city_postal_code: 1803, city_name: Frederiksberg C\r'),(935,'city_before','2024-05-01 11:18:40','Insert New Row'),(936,'city_after','2024-05-01 11:18:40','city_postal_code: 1804, city_name: Frederiksberg C\r'),(937,'city_before','2024-05-01 11:18:40','Insert New Row'),(938,'city_after','2024-05-01 11:18:40','city_postal_code: 1805, city_name: Frederiksberg C\r'),(939,'city_before','2024-05-01 11:18:40','Insert New Row'),(940,'city_after','2024-05-01 11:18:40','city_postal_code: 1806, city_name: Frederiksberg C\r'),(941,'city_before','2024-05-01 11:18:40','Insert New Row'),(942,'city_after','2024-05-01 11:18:40','city_postal_code: 1807, city_name: Frederiksberg C\r'),(943,'city_before','2024-05-01 11:18:40','Insert New Row'),(944,'city_after','2024-05-01 11:18:40','city_postal_code: 1808, city_name: Frederiksberg C\r'),(945,'city_before','2024-05-01 11:18:40','Insert New Row'),(946,'city_after','2024-05-01 11:18:40','city_postal_code: 1809, city_name: Frederiksberg C\r'),(947,'city_before','2024-05-01 11:18:40','Insert New Row'),(948,'city_after','2024-05-01 11:18:40','city_postal_code: 1810, city_name: Frederiksberg C\r'),(949,'city_before','2024-05-01 11:18:40','Insert New Row'),(950,'city_after','2024-05-01 11:18:40','city_postal_code: 1811, city_name: Frederiksberg C\r'),(951,'city_before','2024-05-01 11:18:40','Insert New Row'),(952,'city_after','2024-05-01 11:18:40','city_postal_code: 1812, city_name: Frederiksberg C\r'),(953,'city_before','2024-05-01 11:18:40','Insert New Row'),(954,'city_after','2024-05-01 11:18:40','city_postal_code: 1813, city_name: Frederiksberg C\r'),(955,'city_before','2024-05-01 11:18:40','Insert New Row'),(956,'city_after','2024-05-01 11:18:40','city_postal_code: 1814, city_name: Frederiksberg C\r'),(957,'city_before','2024-05-01 11:18:40','Insert New Row'),(958,'city_after','2024-05-01 11:18:40','city_postal_code: 1815, city_name: Frederiksberg C\r'),(959,'city_before','2024-05-01 11:18:40','Insert New Row'),(960,'city_after','2024-05-01 11:18:40','city_postal_code: 1816, city_name: Frederiksberg C\r'),(961,'city_before','2024-05-01 11:18:40','Insert New Row'),(962,'city_after','2024-05-01 11:18:40','city_postal_code: 1817, city_name: Frederiksberg C\r'),(963,'city_before','2024-05-01 11:18:40','Insert New Row'),(964,'city_after','2024-05-01 11:18:40','city_postal_code: 1818, city_name: Frederiksberg C\r'),(965,'city_before','2024-05-01 11:18:40','Insert New Row'),(966,'city_after','2024-05-01 11:18:40','city_postal_code: 1819, city_name: Frederiksberg C\r'),(967,'city_before','2024-05-01 11:18:40','Insert New Row'),(968,'city_after','2024-05-01 11:18:40','city_postal_code: 1820, city_name: Frederiksberg C\r'),(969,'city_before','2024-05-01 11:18:40','Insert New Row'),(970,'city_after','2024-05-01 11:18:40','city_postal_code: 1822, city_name: Frederiksberg C\r'),(971,'city_before','2024-05-01 11:18:40','Insert New Row'),(972,'city_after','2024-05-01 11:18:40','city_postal_code: 1823, city_name: Frederiksberg C\r'),(973,'city_before','2024-05-01 11:18:40','Insert New Row'),(974,'city_after','2024-05-01 11:18:40','city_postal_code: 1824, city_name: Frederiksberg C\r'),(975,'city_before','2024-05-01 11:18:40','Insert New Row'),(976,'city_after','2024-05-01 11:18:40','city_postal_code: 1825, city_name: Frederiksberg C\r'),(977,'city_before','2024-05-01 11:18:40','Insert New Row'),(978,'city_after','2024-05-01 11:18:40','city_postal_code: 1826, city_name: Frederiksberg C\r'),(979,'city_before','2024-05-01 11:18:40','Insert New Row'),(980,'city_after','2024-05-01 11:18:40','city_postal_code: 1827, city_name: Frederiksberg C\r'),(981,'city_before','2024-05-01 11:18:40','Insert New Row'),(982,'city_after','2024-05-01 11:18:40','city_postal_code: 1828, city_name: Frederiksberg C\r'),(983,'city_before','2024-05-01 11:18:40','Insert New Row'),(984,'city_after','2024-05-01 11:18:40','city_postal_code: 1829, city_name: Frederiksberg C\r'),(985,'city_before','2024-05-01 11:18:40','Insert New Row'),(986,'city_after','2024-05-01 11:18:40','city_postal_code: 1835, city_name: Frederiksberg C\r'),(987,'city_before','2024-05-01 11:18:40','Insert New Row'),(988,'city_after','2024-05-01 11:18:40','city_postal_code: 1850, city_name: Frederiksberg C\r'),(989,'city_before','2024-05-01 11:18:40','Insert New Row'),(990,'city_after','2024-05-01 11:18:40','city_postal_code: 1851, city_name: Frederiksberg C\r'),(991,'city_before','2024-05-01 11:18:40','Insert New Row'),(992,'city_after','2024-05-01 11:18:40','city_postal_code: 1852, city_name: Frederiksberg C\r'),(993,'city_before','2024-05-01 11:18:40','Insert New Row'),(994,'city_after','2024-05-01 11:18:40','city_postal_code: 1853, city_name: Frederiksberg C\r'),(995,'city_before','2024-05-01 11:18:40','Insert New Row'),(996,'city_after','2024-05-01 11:18:40','city_postal_code: 1854, city_name: Frederiksberg C\r'),(997,'city_before','2024-05-01 11:18:40','Insert New Row'),(998,'city_after','2024-05-01 11:18:40','city_postal_code: 1855, city_name: Frederiksberg C\r'),(999,'city_before','2024-05-01 11:18:40','Insert New Row'),(1000,'city_after','2024-05-01 11:18:40','city_postal_code: 1856, city_name: Frederiksberg C\r'),(1001,'city_before','2024-05-01 11:18:40','Insert New Row'),(1002,'city_after','2024-05-01 11:18:40','city_postal_code: 1857, city_name: Frederiksberg C\r'),(1003,'city_before','2024-05-01 11:18:40','Insert New Row'),(1004,'city_after','2024-05-01 11:18:40','city_postal_code: 1860, city_name: Frederiksberg C\r'),(1005,'city_before','2024-05-01 11:18:40','Insert New Row'),(1006,'city_after','2024-05-01 11:18:40','city_postal_code: 1861, city_name: Frederiksberg C\r'),(1007,'city_before','2024-05-01 11:18:40','Insert New Row'),(1008,'city_after','2024-05-01 11:18:40','city_postal_code: 1862, city_name: Frederiksberg C\r'),(1009,'city_before','2024-05-01 11:18:40','Insert New Row'),(1010,'city_after','2024-05-01 11:18:40','city_postal_code: 1863, city_name: Frederiksberg C\r'),(1011,'city_before','2024-05-01 11:18:40','Insert New Row'),(1012,'city_after','2024-05-01 11:18:40','city_postal_code: 1864, city_name: Frederiksberg C\r'),(1013,'city_before','2024-05-01 11:18:40','Insert New Row'),(1014,'city_after','2024-05-01 11:18:40','city_postal_code: 1865, city_name: Frederiksberg C\r'),(1015,'city_before','2024-05-01 11:18:40','Insert New Row'),(1016,'city_after','2024-05-01 11:18:40','city_postal_code: 1866, city_name: Frederiksberg C\r'),(1017,'city_before','2024-05-01 11:18:40','Insert New Row'),(1018,'city_after','2024-05-01 11:18:40','city_postal_code: 1867, city_name: Frederiksberg C\r'),(1019,'city_before','2024-05-01 11:18:40','Insert New Row'),(1020,'city_after','2024-05-01 11:18:40','city_postal_code: 1868, city_name: Frederiksberg C\r'),(1021,'city_before','2024-05-01 11:18:40','Insert New Row'),(1022,'city_after','2024-05-01 11:18:40','city_postal_code: 1870, city_name: Frederiksberg C\r'),(1023,'city_before','2024-05-01 11:18:40','Insert New Row'),(1024,'city_after','2024-05-01 11:18:40','city_postal_code: 1871, city_name: Frederiksberg C\r'),(1025,'city_before','2024-05-01 11:18:40','Insert New Row'),(1026,'city_after','2024-05-01 11:18:40','city_postal_code: 1872, city_name: Frederiksberg C\r'),(1027,'city_before','2024-05-01 11:18:40','Insert New Row'),(1028,'city_after','2024-05-01 11:18:40','city_postal_code: 1873, city_name: Frederiksberg C\r'),(1029,'city_before','2024-05-01 11:18:40','Insert New Row'),(1030,'city_after','2024-05-01 11:18:40','city_postal_code: 1874, city_name: Frederiksberg C\r'),(1031,'city_before','2024-05-01 11:18:40','Insert New Row'),(1032,'city_after','2024-05-01 11:18:40','city_postal_code: 1875, city_name: Frederiksberg C\r'),(1033,'city_before','2024-05-01 11:18:40','Insert New Row'),(1034,'city_after','2024-05-01 11:18:40','city_postal_code: 1876, city_name: Frederiksberg C\r'),(1035,'city_before','2024-05-01 11:18:40','Insert New Row'),(1036,'city_after','2024-05-01 11:18:40','city_postal_code: 1877, city_name: Frederiksberg C\r'),(1037,'city_before','2024-05-01 11:18:40','Insert New Row'),(1038,'city_after','2024-05-01 11:18:40','city_postal_code: 1878, city_name: Frederiksberg C\r'),(1039,'city_before','2024-05-01 11:18:40','Insert New Row'),(1040,'city_after','2024-05-01 11:18:40','city_postal_code: 1879, city_name: Frederiksberg C\r'),(1041,'city_before','2024-05-01 11:18:40','Insert New Row'),(1042,'city_after','2024-05-01 11:18:40','city_postal_code: 1900, city_name: Frederiksberg C\r'),(1043,'city_before','2024-05-01 11:18:40','Insert New Row'),(1044,'city_after','2024-05-01 11:18:40','city_postal_code: 1901, city_name: Frederiksberg C\r'),(1045,'city_before','2024-05-01 11:18:40','Insert New Row'),(1046,'city_after','2024-05-01 11:18:40','city_postal_code: 1902, city_name: Frederiksberg C\r'),(1047,'city_before','2024-05-01 11:18:40','Insert New Row'),(1048,'city_after','2024-05-01 11:18:40','city_postal_code: 1903, city_name: Frederiksberg C\r'),(1049,'city_before','2024-05-01 11:18:40','Insert New Row'),(1050,'city_after','2024-05-01 11:18:40','city_postal_code: 1904, city_name: Frederiksberg C\r'),(1051,'city_before','2024-05-01 11:18:40','Insert New Row'),(1052,'city_after','2024-05-01 11:18:40','city_postal_code: 1905, city_name: Frederiksberg C\r'),(1053,'city_before','2024-05-01 11:18:40','Insert New Row'),(1054,'city_after','2024-05-01 11:18:40','city_postal_code: 1906, city_name: Frederiksberg C\r'),(1055,'city_before','2024-05-01 11:18:40','Insert New Row'),(1056,'city_after','2024-05-01 11:18:40','city_postal_code: 1908, city_name: Frederiksberg C\r'),(1057,'city_before','2024-05-01 11:18:40','Insert New Row'),(1058,'city_after','2024-05-01 11:18:40','city_postal_code: 1909, city_name: Frederiksberg C\r'),(1059,'city_before','2024-05-01 11:18:40','Insert New Row'),(1060,'city_after','2024-05-01 11:18:40','city_postal_code: 1910, city_name: Frederiksberg C\r'),(1061,'city_before','2024-05-01 11:18:40','Insert New Row'),(1062,'city_after','2024-05-01 11:18:40','city_postal_code: 1911, city_name: Frederiksberg C\r'),(1063,'city_before','2024-05-01 11:18:40','Insert New Row'),(1064,'city_after','2024-05-01 11:18:40','city_postal_code: 1912, city_name: Frederiksberg C\r'),(1065,'city_before','2024-05-01 11:18:40','Insert New Row'),(1066,'city_after','2024-05-01 11:18:40','city_postal_code: 1913, city_name: Frederiksberg C\r'),(1067,'city_before','2024-05-01 11:18:40','Insert New Row'),(1068,'city_after','2024-05-01 11:18:40','city_postal_code: 1914, city_name: Frederiksberg C\r'),(1069,'city_before','2024-05-01 11:18:40','Insert New Row'),(1070,'city_after','2024-05-01 11:18:40','city_postal_code: 1915, city_name: Frederiksberg C\r'),(1071,'city_before','2024-05-01 11:18:40','Insert New Row'),(1072,'city_after','2024-05-01 11:18:40','city_postal_code: 1916, city_name: Frederiksberg C\r'),(1073,'city_before','2024-05-01 11:18:40','Insert New Row'),(1074,'city_after','2024-05-01 11:18:40','city_postal_code: 1917, city_name: Frederiksberg C\r'),(1075,'city_before','2024-05-01 11:18:40','Insert New Row'),(1076,'city_after','2024-05-01 11:18:40','city_postal_code: 1920, city_name: Frederiksberg C\r'),(1077,'city_before','2024-05-01 11:18:40','Insert New Row'),(1078,'city_after','2024-05-01 11:18:40','city_postal_code: 1921, city_name: Frederiksberg C\r'),(1079,'city_before','2024-05-01 11:18:40','Insert New Row'),(1080,'city_after','2024-05-01 11:18:40','city_postal_code: 1922, city_name: Frederiksberg C\r'),(1081,'city_before','2024-05-01 11:18:40','Insert New Row'),(1082,'city_after','2024-05-01 11:18:40','city_postal_code: 1923, city_name: Frederiksberg C\r'),(1083,'city_before','2024-05-01 11:18:40','Insert New Row'),(1084,'city_after','2024-05-01 11:18:40','city_postal_code: 1924, city_name: Frederiksberg C\r'),(1085,'city_before','2024-05-01 11:18:40','Insert New Row'),(1086,'city_after','2024-05-01 11:18:40','city_postal_code: 1925, city_name: Frederiksberg C\r'),(1087,'city_before','2024-05-01 11:18:40','Insert New Row'),(1088,'city_after','2024-05-01 11:18:40','city_postal_code: 1926, city_name: Frederiksberg C\r'),(1089,'city_before','2024-05-01 11:18:40','Insert New Row'),(1090,'city_after','2024-05-01 11:18:40','city_postal_code: 1927, city_name: Frederiksberg C\r'),(1091,'city_before','2024-05-01 11:18:40','Insert New Row'),(1092,'city_after','2024-05-01 11:18:40','city_postal_code: 1928, city_name: Frederiksberg C\r'),(1093,'city_before','2024-05-01 11:18:40','Insert New Row'),(1094,'city_after','2024-05-01 11:18:40','city_postal_code: 1931, city_name: Frederiksberg C\r'),(1095,'city_before','2024-05-01 11:18:40','Insert New Row'),(1096,'city_after','2024-05-01 11:18:40','city_postal_code: 1950, city_name: Frederiksberg C\r'),(1097,'city_before','2024-05-01 11:18:40','Insert New Row'),(1098,'city_after','2024-05-01 11:18:40','city_postal_code: 1951, city_name: Frederiksberg C\r'),(1099,'city_before','2024-05-01 11:18:40','Insert New Row'),(1100,'city_after','2024-05-01 11:18:40','city_postal_code: 1952, city_name: Frederiksberg C\r'),(1101,'city_before','2024-05-01 11:18:40','Insert New Row'),(1102,'city_after','2024-05-01 11:18:40','city_postal_code: 1953, city_name: Frederiksberg C\r'),(1103,'city_before','2024-05-01 11:18:40','Insert New Row'),(1104,'city_after','2024-05-01 11:18:40','city_postal_code: 1954, city_name: Frederiksberg C\r'),(1105,'city_before','2024-05-01 11:18:40','Insert New Row'),(1106,'city_after','2024-05-01 11:18:40','city_postal_code: 1955, city_name: Frederiksberg C\r'),(1107,'city_before','2024-05-01 11:18:40','Insert New Row'),(1108,'city_after','2024-05-01 11:18:40','city_postal_code: 1956, city_name: Frederiksberg C\r'),(1109,'city_before','2024-05-01 11:18:40','Insert New Row'),(1110,'city_after','2024-05-01 11:18:40','city_postal_code: 1957, city_name: Frederiksberg C\r'),(1111,'city_before','2024-05-01 11:18:40','Insert New Row'),(1112,'city_after','2024-05-01 11:18:40','city_postal_code: 1958, city_name: Frederiksberg C\r'),(1113,'city_before','2024-05-01 11:18:40','Insert New Row'),(1114,'city_after','2024-05-01 11:18:40','city_postal_code: 1959, city_name: Frederiksberg C\r'),(1115,'city_before','2024-05-01 11:18:40','Insert New Row'),(1116,'city_after','2024-05-01 11:18:40','city_postal_code: 1960, city_name: Frederiksberg C\r'),(1117,'city_before','2024-05-01 11:18:40','Insert New Row'),(1118,'city_after','2024-05-01 11:18:40','city_postal_code: 1961, city_name: Frederiksberg C\r'),(1119,'city_before','2024-05-01 11:18:40','Insert New Row'),(1120,'city_after','2024-05-01 11:18:40','city_postal_code: 1962, city_name: Frederiksberg C\r'),(1121,'city_before','2024-05-01 11:18:40','Insert New Row'),(1122,'city_after','2024-05-01 11:18:40','city_postal_code: 1963, city_name: Frederiksberg C\r'),(1123,'city_before','2024-05-01 11:18:40','Insert New Row'),(1124,'city_after','2024-05-01 11:18:40','city_postal_code: 1964, city_name: Frederiksberg C\r'),(1125,'city_before','2024-05-01 11:18:40','Insert New Row'),(1126,'city_after','2024-05-01 11:18:40','city_postal_code: 1965, city_name: Frederiksberg C\r'),(1127,'city_before','2024-05-01 11:18:40','Insert New Row'),(1128,'city_after','2024-05-01 11:18:40','city_postal_code: 1966, city_name: Frederiksberg C\r'),(1129,'city_before','2024-05-01 11:18:40','Insert New Row'),(1130,'city_after','2024-05-01 11:18:40','city_postal_code: 1967, city_name: Frederiksberg C\r'),(1131,'city_before','2024-05-01 11:18:40','Insert New Row'),(1132,'city_after','2024-05-01 11:18:40','city_postal_code: 1970, city_name: Frederiksberg C\r'),(1133,'city_before','2024-05-01 11:18:40','Insert New Row'),(1134,'city_after','2024-05-01 11:18:40','city_postal_code: 1971, city_name: Frederiksberg C\r'),(1135,'city_before','2024-05-01 11:18:40','Insert New Row'),(1136,'city_after','2024-05-01 11:18:40','city_postal_code: 1972, city_name: Frederiksberg C\r'),(1137,'city_before','2024-05-01 11:18:40','Insert New Row'),(1138,'city_after','2024-05-01 11:18:40','city_postal_code: 1973, city_name: Frederiksberg C\r'),(1139,'city_before','2024-05-01 11:18:40','Insert New Row'),(1140,'city_after','2024-05-01 11:18:40','city_postal_code: 1974, city_name: Frederiksberg C\r'),(1141,'city_before','2024-05-01 11:18:40','Insert New Row'),(1142,'city_after','2024-05-01 11:18:40','city_postal_code: 2000, city_name: Frederiksberg\r'),(1143,'city_before','2024-05-01 11:18:40','Insert New Row'),(1144,'city_after','2024-05-01 11:18:40','city_postal_code: 2100, city_name: København Ø\r'),(1145,'city_before','2024-05-01 11:18:40','Insert New Row'),(1146,'city_after','2024-05-01 11:18:40','city_postal_code: 2150, city_name: Nordhavn\r'),(1147,'city_before','2024-05-01 11:18:40','Insert New Row'),(1148,'city_after','2024-05-01 11:18:40','city_postal_code: 2200, city_name: København N\r'),(1149,'city_before','2024-05-01 11:18:40','Insert New Row'),(1150,'city_after','2024-05-01 11:18:40','city_postal_code: 2300, city_name: København S\r'),(1151,'city_before','2024-05-01 11:18:40','Insert New Row'),(1152,'city_after','2024-05-01 11:18:40','city_postal_code: 2400, city_name: København NV\r'),(1153,'city_before','2024-05-01 11:18:40','Insert New Row'),(1154,'city_after','2024-05-01 11:18:40','city_postal_code: 2412, city_name: Grønland\r'),(1155,'city_before','2024-05-01 11:18:40','Insert New Row'),(1156,'city_after','2024-05-01 11:18:40','city_postal_code: 2450, city_name: København SV\r'),(1157,'city_before','2024-05-01 11:18:40','Insert New Row'),(1158,'city_after','2024-05-01 11:18:40','city_postal_code: 2500, city_name: Valby\r'),(1159,'city_before','2024-05-01 11:18:40','Insert New Row'),(1160,'city_after','2024-05-01 11:18:40','city_postal_code: 2600, city_name: Glostrup\r'),(1161,'city_before','2024-05-01 11:18:40','Insert New Row'),(1162,'city_after','2024-05-01 11:18:40','city_postal_code: 2605, city_name: Brøndby\r'),(1163,'city_before','2024-05-01 11:18:40','Insert New Row'),(1164,'city_after','2024-05-01 11:18:40','city_postal_code: 2610, city_name: Rødovre\r'),(1165,'city_before','2024-05-01 11:18:40','Insert New Row'),(1166,'city_after','2024-05-01 11:18:40','city_postal_code: 2620, city_name: Albertslund\r'),(1167,'city_before','2024-05-01 11:18:40','Insert New Row'),(1168,'city_after','2024-05-01 11:18:40','city_postal_code: 2625, city_name: Vallensbæk\r'),(1169,'city_before','2024-05-01 11:18:40','Insert New Row'),(1170,'city_after','2024-05-01 11:18:40','city_postal_code: 2630, city_name: Taastrup\r'),(1171,'city_before','2024-05-01 11:18:40','Insert New Row'),(1172,'city_after','2024-05-01 11:18:40','city_postal_code: 2635, city_name: Ishøj\r'),(1173,'city_before','2024-05-01 11:18:40','Insert New Row'),(1174,'city_after','2024-05-01 11:18:40','city_postal_code: 2640, city_name: Hedehusene\r'),(1175,'city_before','2024-05-01 11:18:40','Insert New Row'),(1176,'city_after','2024-05-01 11:18:40','city_postal_code: 2644, city_name: Spejdernes Lejr 2022\r'),(1177,'city_before','2024-05-01 11:18:40','Insert New Row'),(1178,'city_after','2024-05-01 11:18:40','city_postal_code: 2650, city_name: Hvidovre\r'),(1179,'city_before','2024-05-01 11:18:40','Insert New Row'),(1180,'city_after','2024-05-01 11:18:40','city_postal_code: 2660, city_name: Brøndby Strand\r'),(1181,'city_before','2024-05-01 11:18:40','Insert New Row'),(1182,'city_after','2024-05-01 11:18:40','city_postal_code: 2665, city_name: Vallensbæk Strand\r'),(1183,'city_before','2024-05-01 11:18:40','Insert New Row'),(1184,'city_after','2024-05-01 11:18:40','city_postal_code: 2670, city_name: Greve\r'),(1185,'city_before','2024-05-01 11:18:40','Insert New Row'),(1186,'city_after','2024-05-01 11:18:40','city_postal_code: 2680, city_name: Solrød Strand\r'),(1187,'city_before','2024-05-01 11:18:40','Insert New Row'),(1188,'city_after','2024-05-01 11:18:40','city_postal_code: 2690, city_name: Karlslunde\r'),(1189,'city_before','2024-05-01 11:18:40','Insert New Row'),(1190,'city_after','2024-05-01 11:18:40','city_postal_code: 2700, city_name: Brønshøj\r'),(1191,'city_before','2024-05-01 11:18:40','Insert New Row'),(1192,'city_after','2024-05-01 11:18:40','city_postal_code: 2720, city_name: Vanløse\r'),(1193,'city_before','2024-05-01 11:18:40','Insert New Row'),(1194,'city_after','2024-05-01 11:18:40','city_postal_code: 2730, city_name: Herlev\r'),(1195,'city_before','2024-05-01 11:18:40','Insert New Row'),(1196,'city_after','2024-05-01 11:18:40','city_postal_code: 2740, city_name: Skovlunde\r'),(1197,'city_before','2024-05-01 11:18:40','Insert New Row'),(1198,'city_after','2024-05-01 11:18:40','city_postal_code: 2750, city_name: Ballerup\r'),(1199,'city_before','2024-05-01 11:18:40','Insert New Row'),(1200,'city_after','2024-05-01 11:18:40','city_postal_code: 2760, city_name: Måløv\r'),(1201,'city_before','2024-05-01 11:18:40','Insert New Row'),(1202,'city_after','2024-05-01 11:18:40','city_postal_code: 2765, city_name: Smørum\r'),(1203,'city_before','2024-05-01 11:18:40','Insert New Row'),(1204,'city_after','2024-05-01 11:18:40','city_postal_code: 2770, city_name: Kastrup\r'),(1205,'city_before','2024-05-01 11:18:40','Insert New Row'),(1206,'city_after','2024-05-01 11:18:40','city_postal_code: 2791, city_name: Dragør\r'),(1207,'city_before','2024-05-01 11:18:40','Insert New Row'),(1208,'city_after','2024-05-01 11:18:40','city_postal_code: 2800, city_name: Kongens Lyngby\r'),(1209,'city_before','2024-05-01 11:18:40','Insert New Row'),(1210,'city_after','2024-05-01 11:18:40','city_postal_code: 2820, city_name: Gentofte\r'),(1211,'city_before','2024-05-01 11:18:40','Insert New Row'),(1212,'city_after','2024-05-01 11:18:40','city_postal_code: 2830, city_name: Virum\r'),(1213,'city_before','2024-05-01 11:18:40','Insert New Row'),(1214,'city_after','2024-05-01 11:18:40','city_postal_code: 2840, city_name: Holte\r'),(1215,'city_before','2024-05-01 11:18:40','Insert New Row'),(1216,'city_after','2024-05-01 11:18:40','city_postal_code: 2850, city_name: Nærum\r'),(1217,'city_before','2024-05-01 11:18:40','Insert New Row'),(1218,'city_after','2024-05-01 11:18:40','city_postal_code: 2860, city_name: Søborg\r'),(1219,'city_before','2024-05-01 11:18:40','Insert New Row'),(1220,'city_after','2024-05-01 11:18:40','city_postal_code: 2870, city_name: Dyssegård\r'),(1221,'city_before','2024-05-01 11:18:40','Insert New Row'),(1222,'city_after','2024-05-01 11:18:40','city_postal_code: 2880, city_name: Bagsværd\r'),(1223,'city_before','2024-05-01 11:18:40','Insert New Row'),(1224,'city_after','2024-05-01 11:18:40','city_postal_code: 2900, city_name: Hellerup\r'),(1225,'city_before','2024-05-01 11:18:40','Insert New Row'),(1226,'city_after','2024-05-01 11:18:40','city_postal_code: 2920, city_name: Charlottenlund\r'),(1227,'city_before','2024-05-01 11:18:40','Insert New Row'),(1228,'city_after','2024-05-01 11:18:40','city_postal_code: 2930, city_name: Klampenborg\r'),(1229,'city_before','2024-05-01 11:18:40','Insert New Row'),(1230,'city_after','2024-05-01 11:18:40','city_postal_code: 2942, city_name: Skodsborg\r'),(1231,'city_before','2024-05-01 11:18:40','Insert New Row'),(1232,'city_after','2024-05-01 11:18:40','city_postal_code: 2950, city_name: Vedbæk\r'),(1233,'city_before','2024-05-01 11:18:40','Insert New Row'),(1234,'city_after','2024-05-01 11:18:40','city_postal_code: 2960, city_name: Rungsted Kyst\r'),(1235,'city_before','2024-05-01 11:18:40','Insert New Row'),(1236,'city_after','2024-05-01 11:18:40','city_postal_code: 2970, city_name: Hørsholm\r'),(1237,'city_before','2024-05-01 11:18:40','Insert New Row'),(1238,'city_after','2024-05-01 11:18:40','city_postal_code: 2980, city_name: Kokkedal\r'),(1239,'city_before','2024-05-01 11:18:40','Insert New Row'),(1240,'city_after','2024-05-01 11:18:40','city_postal_code: 2990, city_name: Nivå\r'),(1241,'city_before','2024-05-01 11:18:40','Insert New Row'),(1242,'city_after','2024-05-01 11:18:40','city_postal_code: 3000, city_name: Helsingør\r'),(1243,'city_before','2024-05-01 11:18:40','Insert New Row'),(1244,'city_after','2024-05-01 11:18:40','city_postal_code: 3050, city_name: Humlebæk\r'),(1245,'city_before','2024-05-01 11:18:40','Insert New Row'),(1246,'city_after','2024-05-01 11:18:40','city_postal_code: 3060, city_name: Espergærde\r'),(1247,'city_before','2024-05-01 11:18:40','Insert New Row'),(1248,'city_after','2024-05-01 11:18:40','city_postal_code: 3070, city_name: Snekkersten\r'),(1249,'city_before','2024-05-01 11:18:40','Insert New Row'),(1250,'city_after','2024-05-01 11:18:40','city_postal_code: 3080, city_name: Tikøb\r'),(1251,'city_before','2024-05-01 11:18:40','Insert New Row'),(1252,'city_after','2024-05-01 11:18:40','city_postal_code: 3100, city_name: Hornbæk\r'),(1253,'city_before','2024-05-01 11:18:40','Insert New Row'),(1254,'city_after','2024-05-01 11:18:40','city_postal_code: 3120, city_name: Dronningmølle\r'),(1255,'city_before','2024-05-01 11:18:40','Insert New Row'),(1256,'city_after','2024-05-01 11:18:40','city_postal_code: 3140, city_name: Ålsgårde\r'),(1257,'city_before','2024-05-01 11:18:40','Insert New Row'),(1258,'city_after','2024-05-01 11:18:40','city_postal_code: 3150, city_name: Hellebæk\r'),(1259,'city_before','2024-05-01 11:18:40','Insert New Row'),(1260,'city_after','2024-05-01 11:18:40','city_postal_code: 3200, city_name: Helsinge\r'),(1261,'city_before','2024-05-01 11:18:40','Insert New Row'),(1262,'city_after','2024-05-01 11:18:40','city_postal_code: 3210, city_name: Vejby\r'),(1263,'city_before','2024-05-01 11:18:40','Insert New Row'),(1264,'city_after','2024-05-01 11:18:40','city_postal_code: 3220, city_name: Tisvildeleje\r'),(1265,'city_before','2024-05-01 11:18:40','Insert New Row'),(1266,'city_after','2024-05-01 11:18:40','city_postal_code: 3230, city_name: Græsted\r'),(1267,'city_before','2024-05-01 11:18:40','Insert New Row'),(1268,'city_after','2024-05-01 11:18:40','city_postal_code: 3250, city_name: Gilleleje\r'),(1269,'city_before','2024-05-01 11:18:40','Insert New Row'),(1270,'city_after','2024-05-01 11:18:40','city_postal_code: 3300, city_name: Frederiksværk\r'),(1271,'city_before','2024-05-01 11:18:40','Insert New Row'),(1272,'city_after','2024-05-01 11:18:40','city_postal_code: 3310, city_name: Ølsted\r'),(1273,'city_before','2024-05-01 11:18:40','Insert New Row'),(1274,'city_after','2024-05-01 11:18:40','city_postal_code: 3320, city_name: Skævinge\r'),(1275,'city_before','2024-05-01 11:18:40','Insert New Row'),(1276,'city_after','2024-05-01 11:18:40','city_postal_code: 3330, city_name: Gørløse\r'),(1277,'city_before','2024-05-01 11:18:40','Insert New Row'),(1278,'city_after','2024-05-01 11:18:40','city_postal_code: 3360, city_name: Liseleje\r'),(1279,'city_before','2024-05-01 11:18:40','Insert New Row'),(1280,'city_after','2024-05-01 11:18:40','city_postal_code: 3370, city_name: Melby\r'),(1281,'city_before','2024-05-01 11:18:40','Insert New Row'),(1282,'city_after','2024-05-01 11:18:40','city_postal_code: 3390, city_name: Hundested\r'),(1283,'city_before','2024-05-01 11:18:40','Insert New Row'),(1284,'city_after','2024-05-01 11:18:40','city_postal_code: 3400, city_name: Hillerød\r'),(1285,'city_before','2024-05-01 11:18:40','Insert New Row'),(1286,'city_after','2024-05-01 11:18:40','city_postal_code: 3450, city_name: Allerød\r'),(1287,'city_before','2024-05-01 11:18:40','Insert New Row'),(1288,'city_after','2024-05-01 11:18:40','city_postal_code: 3460, city_name: Birkerød\r'),(1289,'city_before','2024-05-01 11:18:40','Insert New Row'),(1290,'city_after','2024-05-01 11:18:40','city_postal_code: 3480, city_name: Fredensborg\r'),(1291,'city_before','2024-05-01 11:18:40','Insert New Row'),(1292,'city_after','2024-05-01 11:18:40','city_postal_code: 3490, city_name: Kvistgård\r'),(1293,'city_before','2024-05-01 11:18:40','Insert New Row'),(1294,'city_after','2024-05-01 11:18:40','city_postal_code: 3500, city_name: Værløse\r'),(1295,'city_before','2024-05-01 11:18:40','Insert New Row'),(1296,'city_after','2024-05-01 11:18:40','city_postal_code: 3520, city_name: Farum\r'),(1297,'city_before','2024-05-01 11:18:40','Insert New Row'),(1298,'city_after','2024-05-01 11:18:40','city_postal_code: 3540, city_name: Lynge\r'),(1299,'city_before','2024-05-01 11:18:40','Insert New Row'),(1300,'city_after','2024-05-01 11:18:40','city_postal_code: 3550, city_name: Slangerup\r'),(1301,'city_before','2024-05-01 11:18:40','Insert New Row'),(1302,'city_after','2024-05-01 11:18:40','city_postal_code: 3600, city_name: Frederikssund\r'),(1303,'city_before','2024-05-01 11:18:40','Insert New Row'),(1304,'city_after','2024-05-01 11:18:40','city_postal_code: 3630, city_name: Jægerspris\r'),(1305,'city_before','2024-05-01 11:18:40','Insert New Row'),(1306,'city_after','2024-05-01 11:18:40','city_postal_code: 3650, city_name: Ølstykke\r'),(1307,'city_before','2024-05-01 11:18:40','Insert New Row'),(1308,'city_after','2024-05-01 11:18:40','city_postal_code: 3660, city_name: Stenløse\r'),(1309,'city_before','2024-05-01 11:18:40','Insert New Row'),(1310,'city_after','2024-05-01 11:18:40','city_postal_code: 3670, city_name: Veksø Sjælland\r'),(1311,'city_before','2024-05-01 11:18:40','Insert New Row'),(1312,'city_after','2024-05-01 11:18:40','city_postal_code: 3700, city_name: Rønne\r'),(1313,'city_before','2024-05-01 11:18:40','Insert New Row'),(1314,'city_after','2024-05-01 11:18:40','city_postal_code: 3720, city_name: Aakirkeby\r'),(1315,'city_before','2024-05-01 11:18:40','Insert New Row'),(1316,'city_after','2024-05-01 11:18:40','city_postal_code: 3730, city_name: Nexø\r'),(1317,'city_before','2024-05-01 11:18:40','Insert New Row'),(1318,'city_after','2024-05-01 11:18:40','city_postal_code: 3740, city_name: Svaneke\r'),(1319,'city_before','2024-05-01 11:18:40','Insert New Row'),(1320,'city_after','2024-05-01 11:18:40','city_postal_code: 3751, city_name: Østermarie\r'),(1321,'city_before','2024-05-01 11:18:40','Insert New Row'),(1322,'city_after','2024-05-01 11:18:40','city_postal_code: 3760, city_name: Gudhjem\r'),(1323,'city_before','2024-05-01 11:18:40','Insert New Row'),(1324,'city_after','2024-05-01 11:18:40','city_postal_code: 3770, city_name: Allinge\r'),(1325,'city_before','2024-05-01 11:18:40','Insert New Row'),(1326,'city_after','2024-05-01 11:18:40','city_postal_code: 3782, city_name: Klemensker\r'),(1327,'city_before','2024-05-01 11:18:40','Insert New Row'),(1328,'city_after','2024-05-01 11:18:40','city_postal_code: 3790, city_name: Hasle\r'),(1329,'city_before','2024-05-01 11:18:40','Insert New Row'),(1330,'city_after','2024-05-01 11:18:40','city_postal_code: 4000, city_name: Roskilde\r'),(1331,'city_before','2024-05-01 11:18:40','Insert New Row'),(1332,'city_after','2024-05-01 11:18:40','city_postal_code: 4030, city_name: Tune\r'),(1333,'city_before','2024-05-01 11:18:40','Insert New Row'),(1334,'city_after','2024-05-01 11:18:40','city_postal_code: 4040, city_name: Jyllinge\r'),(1335,'city_before','2024-05-01 11:18:40','Insert New Row'),(1336,'city_after','2024-05-01 11:18:40','city_postal_code: 4050, city_name: Skibby\r'),(1337,'city_before','2024-05-01 11:18:40','Insert New Row'),(1338,'city_after','2024-05-01 11:18:40','city_postal_code: 4060, city_name: Kirke Såby\r'),(1339,'city_before','2024-05-01 11:18:40','Insert New Row'),(1340,'city_after','2024-05-01 11:18:40','city_postal_code: 4070, city_name: Kirke Hyllinge\r'),(1341,'city_before','2024-05-01 11:18:40','Insert New Row'),(1342,'city_after','2024-05-01 11:18:40','city_postal_code: 4100, city_name: Ringsted\r'),(1343,'city_before','2024-05-01 11:18:40','Insert New Row'),(1344,'city_after','2024-05-01 11:18:40','city_postal_code: 4129, city_name: Ringsted\r'),(1345,'city_before','2024-05-01 11:18:40','Insert New Row'),(1346,'city_after','2024-05-01 11:18:40','city_postal_code: 4130, city_name: Viby Sjælland\r'),(1347,'city_before','2024-05-01 11:18:40','Insert New Row'),(1348,'city_after','2024-05-01 11:18:40','city_postal_code: 4140, city_name: Borup\r'),(1349,'city_before','2024-05-01 11:18:40','Insert New Row'),(1350,'city_after','2024-05-01 11:18:40','city_postal_code: 4160, city_name: Herlufmagle\r'),(1351,'city_before','2024-05-01 11:18:40','Insert New Row'),(1352,'city_after','2024-05-01 11:18:40','city_postal_code: 4171, city_name: Glumsø\r'),(1353,'city_before','2024-05-01 11:18:40','Insert New Row'),(1354,'city_after','2024-05-01 11:18:40','city_postal_code: 4173, city_name: Fjenneslev\r'),(1355,'city_before','2024-05-01 11:18:40','Insert New Row'),(1356,'city_after','2024-05-01 11:18:40','city_postal_code: 4174, city_name: Jystrup Midtsj\r'),(1357,'city_before','2024-05-01 11:18:40','Insert New Row'),(1358,'city_after','2024-05-01 11:18:40','city_postal_code: 4180, city_name: Sorø\r'),(1359,'city_before','2024-05-01 11:18:40','Insert New Row'),(1360,'city_after','2024-05-01 11:18:40','city_postal_code: 4190, city_name: Munke Bjergby\r'),(1361,'city_before','2024-05-01 11:18:40','Insert New Row'),(1362,'city_after','2024-05-01 11:18:40','city_postal_code: 4200, city_name: Slagelse\r'),(1363,'city_before','2024-05-01 11:18:40','Insert New Row'),(1364,'city_after','2024-05-01 11:18:40','city_postal_code: 4220, city_name: Korsør\r'),(1365,'city_before','2024-05-01 11:18:40','Insert New Row'),(1366,'city_after','2024-05-01 11:18:40','city_postal_code: 4230, city_name: Skælskør\r'),(1367,'city_before','2024-05-01 11:18:40','Insert New Row'),(1368,'city_after','2024-05-01 11:18:40','city_postal_code: 4241, city_name: Vemmelev\r'),(1369,'city_before','2024-05-01 11:18:40','Insert New Row'),(1370,'city_after','2024-05-01 11:18:40','city_postal_code: 4242, city_name: Boeslunde\r'),(1371,'city_before','2024-05-01 11:18:40','Insert New Row'),(1372,'city_after','2024-05-01 11:18:40','city_postal_code: 4243, city_name: Rude\r'),(1373,'city_before','2024-05-01 11:18:40','Insert New Row'),(1374,'city_after','2024-05-01 11:18:40','city_postal_code: 4244, city_name: Agersø\r'),(1375,'city_before','2024-05-01 11:18:40','Insert New Row'),(1376,'city_after','2024-05-01 11:18:40','city_postal_code: 4245, city_name: Omø\r'),(1377,'city_before','2024-05-01 11:18:40','Insert New Row'),(1378,'city_after','2024-05-01 11:18:40','city_postal_code: 4250, city_name: Fuglebjerg\r'),(1379,'city_before','2024-05-01 11:18:40','Insert New Row'),(1380,'city_after','2024-05-01 11:18:40','city_postal_code: 4261, city_name: Dalmose\r'),(1381,'city_before','2024-05-01 11:18:40','Insert New Row'),(1382,'city_after','2024-05-01 11:18:40','city_postal_code: 4262, city_name: Sandved\r'),(1383,'city_before','2024-05-01 11:18:40','Insert New Row'),(1384,'city_after','2024-05-01 11:18:40','city_postal_code: 4270, city_name: Høng\r'),(1385,'city_before','2024-05-01 11:18:40','Insert New Row'),(1386,'city_after','2024-05-01 11:18:40','city_postal_code: 4281, city_name: Gørlev\r'),(1387,'city_before','2024-05-01 11:18:40','Insert New Row'),(1388,'city_after','2024-05-01 11:18:40','city_postal_code: 4291, city_name: Ruds Vedby\r'),(1389,'city_before','2024-05-01 11:18:40','Insert New Row'),(1390,'city_after','2024-05-01 11:18:40','city_postal_code: 4293, city_name: Dianalund\r'),(1391,'city_before','2024-05-01 11:18:40','Insert New Row'),(1392,'city_after','2024-05-01 11:18:40','city_postal_code: 4295, city_name: Stenlille\r'),(1393,'city_before','2024-05-01 11:18:40','Insert New Row'),(1394,'city_after','2024-05-01 11:18:40','city_postal_code: 4296, city_name: Nyrup\r'),(1395,'city_before','2024-05-01 11:18:40','Insert New Row'),(1396,'city_after','2024-05-01 11:18:40','city_postal_code: 4300, city_name: Holbæk\r'),(1397,'city_before','2024-05-01 11:18:40','Insert New Row'),(1398,'city_after','2024-05-01 11:18:40','city_postal_code: 4305, city_name: Orø\r'),(1399,'city_before','2024-05-01 11:18:40','Insert New Row'),(1400,'city_after','2024-05-01 11:18:40','city_postal_code: 4320, city_name: Lejre\r'),(1401,'city_before','2024-05-01 11:18:40','Insert New Row'),(1402,'city_after','2024-05-01 11:18:40','city_postal_code: 4330, city_name: Hvalsø\r'),(1403,'city_before','2024-05-01 11:18:40','Insert New Row'),(1404,'city_after','2024-05-01 11:18:40','city_postal_code: 4340, city_name: Tølløse\r'),(1405,'city_before','2024-05-01 11:18:40','Insert New Row'),(1406,'city_after','2024-05-01 11:18:40','city_postal_code: 4350, city_name: Ugerløse\r'),(1407,'city_before','2024-05-01 11:18:40','Insert New Row'),(1408,'city_after','2024-05-01 11:18:40','city_postal_code: 4360, city_name: Kirke Eskilstrup\r'),(1409,'city_before','2024-05-01 11:18:40','Insert New Row'),(1410,'city_after','2024-05-01 11:18:40','city_postal_code: 4370, city_name: Store Merløse\r'),(1411,'city_before','2024-05-01 11:18:40','Insert New Row'),(1412,'city_after','2024-05-01 11:18:40','city_postal_code: 4390, city_name: Vipperød\r'),(1413,'city_before','2024-05-01 11:18:40','Insert New Row'),(1414,'city_after','2024-05-01 11:18:40','city_postal_code: 4400, city_name: Kalundborg\r'),(1415,'city_before','2024-05-01 11:18:40','Insert New Row'),(1416,'city_after','2024-05-01 11:18:40','city_postal_code: 4420, city_name: Regstrup\r'),(1417,'city_before','2024-05-01 11:18:40','Insert New Row'),(1418,'city_after','2024-05-01 11:18:40','city_postal_code: 4440, city_name: Mørkøv\r'),(1419,'city_before','2024-05-01 11:18:40','Insert New Row'),(1420,'city_after','2024-05-01 11:18:40','city_postal_code: 4450, city_name: Jyderup\r'),(1421,'city_before','2024-05-01 11:18:40','Insert New Row'),(1422,'city_after','2024-05-01 11:18:40','city_postal_code: 4460, city_name: Snertinge\r'),(1423,'city_before','2024-05-01 11:18:40','Insert New Row'),(1424,'city_after','2024-05-01 11:18:40','city_postal_code: 4470, city_name: Svebølle\r'),(1425,'city_before','2024-05-01 11:18:40','Insert New Row'),(1426,'city_after','2024-05-01 11:18:40','city_postal_code: 4480, city_name: Store Fuglede\r'),(1427,'city_before','2024-05-01 11:18:40','Insert New Row'),(1428,'city_after','2024-05-01 11:18:40','city_postal_code: 4490, city_name: Jerslev Sjælland\r'),(1429,'city_before','2024-05-01 11:18:40','Insert New Row'),(1430,'city_after','2024-05-01 11:18:40','city_postal_code: 4500, city_name: Nykøbing Sj\r'),(1431,'city_before','2024-05-01 11:18:40','Insert New Row'),(1432,'city_after','2024-05-01 11:18:40','city_postal_code: 4520, city_name: Svinninge\r'),(1433,'city_before','2024-05-01 11:18:40','Insert New Row'),(1434,'city_after','2024-05-01 11:18:40','city_postal_code: 4532, city_name: Gislinge\r'),(1435,'city_before','2024-05-01 11:18:40','Insert New Row'),(1436,'city_after','2024-05-01 11:18:40','city_postal_code: 4534, city_name: Hørve\r'),(1437,'city_before','2024-05-01 11:18:40','Insert New Row'),(1438,'city_after','2024-05-01 11:18:40','city_postal_code: 4540, city_name: Fårevejle\r'),(1439,'city_before','2024-05-01 11:18:40','Insert New Row'),(1440,'city_after','2024-05-01 11:18:40','city_postal_code: 4550, city_name: Asnæs\r'),(1441,'city_before','2024-05-01 11:18:40','Insert New Row'),(1442,'city_after','2024-05-01 11:18:40','city_postal_code: 4560, city_name: Vig\r'),(1443,'city_before','2024-05-01 11:18:40','Insert New Row'),(1444,'city_after','2024-05-01 11:18:40','city_postal_code: 4571, city_name: Grevinge\r'),(1445,'city_before','2024-05-01 11:18:40','Insert New Row'),(1446,'city_after','2024-05-01 11:18:40','city_postal_code: 4572, city_name: Nørre Asmindrup\r'),(1447,'city_before','2024-05-01 11:18:40','Insert New Row'),(1448,'city_after','2024-05-01 11:18:40','city_postal_code: 4573, city_name: Højby\r'),(1449,'city_before','2024-05-01 11:18:40','Insert New Row'),(1450,'city_after','2024-05-01 11:18:40','city_postal_code: 4581, city_name: Rørvig\r'),(1451,'city_before','2024-05-01 11:18:40','Insert New Row'),(1452,'city_after','2024-05-01 11:18:40','city_postal_code: 4583, city_name: Sjællands Odde\r'),(1453,'city_before','2024-05-01 11:18:40','Insert New Row'),(1454,'city_after','2024-05-01 11:18:40','city_postal_code: 4591, city_name: Føllenslev\r'),(1455,'city_before','2024-05-01 11:18:40','Insert New Row'),(1456,'city_after','2024-05-01 11:18:40','city_postal_code: 4592, city_name: Sejerø\r'),(1457,'city_before','2024-05-01 11:18:40','Insert New Row'),(1458,'city_after','2024-05-01 11:18:40','city_postal_code: 4593, city_name: Eskebjerg\r'),(1459,'city_before','2024-05-01 11:18:40','Insert New Row'),(1460,'city_after','2024-05-01 11:18:40','city_postal_code: 4600, city_name: Køge\r'),(1461,'city_before','2024-05-01 11:18:40','Insert New Row'),(1462,'city_after','2024-05-01 11:18:40','city_postal_code: 4621, city_name: Gadstrup\r'),(1463,'city_before','2024-05-01 11:18:40','Insert New Row'),(1464,'city_after','2024-05-01 11:18:40','city_postal_code: 4622, city_name: Havdrup\r'),(1465,'city_before','2024-05-01 11:18:40','Insert New Row'),(1466,'city_after','2024-05-01 11:18:40','city_postal_code: 4623, city_name: Lille Skensved\r'),(1467,'city_before','2024-05-01 11:18:40','Insert New Row'),(1468,'city_after','2024-05-01 11:18:40','city_postal_code: 4632, city_name: Bjæverskov\r'),(1469,'city_before','2024-05-01 11:18:40','Insert New Row'),(1470,'city_after','2024-05-01 11:18:40','city_postal_code: 4640, city_name: Faxe\r'),(1471,'city_before','2024-05-01 11:18:40','Insert New Row'),(1472,'city_after','2024-05-01 11:18:40','city_postal_code: 4652, city_name: Hårlev\r'),(1473,'city_before','2024-05-01 11:18:40','Insert New Row'),(1474,'city_after','2024-05-01 11:18:40','city_postal_code: 4653, city_name: Karise\r'),(1475,'city_before','2024-05-01 11:18:40','Insert New Row'),(1476,'city_after','2024-05-01 11:18:40','city_postal_code: 4654, city_name: Faxe Ladeplads\r'),(1477,'city_before','2024-05-01 11:18:40','Insert New Row'),(1478,'city_after','2024-05-01 11:18:40','city_postal_code: 4660, city_name: Store Heddinge\r'),(1479,'city_before','2024-05-01 11:18:40','Insert New Row'),(1480,'city_after','2024-05-01 11:18:40','city_postal_code: 4671, city_name: Strøby\r'),(1481,'city_before','2024-05-01 11:18:40','Insert New Row'),(1482,'city_after','2024-05-01 11:18:40','city_postal_code: 4672, city_name: Klippinge\r'),(1483,'city_before','2024-05-01 11:18:40','Insert New Row'),(1484,'city_after','2024-05-01 11:18:40','city_postal_code: 4673, city_name: Rødvig Stevns\r'),(1485,'city_before','2024-05-01 11:18:40','Insert New Row'),(1486,'city_after','2024-05-01 11:18:40','city_postal_code: 4681, city_name: Herfølge\r'),(1487,'city_before','2024-05-01 11:18:40','Insert New Row'),(1488,'city_after','2024-05-01 11:18:40','city_postal_code: 4682, city_name: Tureby\r'),(1489,'city_before','2024-05-01 11:18:40','Insert New Row'),(1490,'city_after','2024-05-01 11:18:40','city_postal_code: 4683, city_name: Rønnede\r'),(1491,'city_before','2024-05-01 11:18:40','Insert New Row'),(1492,'city_after','2024-05-01 11:18:40','city_postal_code: 4684, city_name: Holmegaard\r'),(1493,'city_before','2024-05-01 11:18:40','Insert New Row'),(1494,'city_after','2024-05-01 11:18:40','city_postal_code: 4690, city_name: Haslev\r'),(1495,'city_before','2024-05-01 11:18:40','Insert New Row'),(1496,'city_after','2024-05-01 11:18:40','city_postal_code: 4700, city_name: Næstved\r'),(1497,'city_before','2024-05-01 11:18:40','Insert New Row'),(1498,'city_after','2024-05-01 11:18:40','city_postal_code: 4720, city_name: Præstø\r'),(1499,'city_before','2024-05-01 11:18:40','Insert New Row'),(1500,'city_after','2024-05-01 11:18:40','city_postal_code: 4733, city_name: Tappernøje\r'),(1501,'city_before','2024-05-01 11:18:40','Insert New Row'),(1502,'city_after','2024-05-01 11:18:40','city_postal_code: 4735, city_name: Mern\r'),(1503,'city_before','2024-05-01 11:18:40','Insert New Row'),(1504,'city_after','2024-05-01 11:18:40','city_postal_code: 4736, city_name: Karrebæksminde\r'),(1505,'city_before','2024-05-01 11:18:40','Insert New Row'),(1506,'city_after','2024-05-01 11:18:40','city_postal_code: 4750, city_name: Lundby\r'),(1507,'city_before','2024-05-01 11:18:40','Insert New Row'),(1508,'city_after','2024-05-01 11:18:40','city_postal_code: 4760, city_name: Vordingborg\r'),(1509,'city_before','2024-05-01 11:18:40','Insert New Row'),(1510,'city_after','2024-05-01 11:18:40','city_postal_code: 4771, city_name: Kalvehave\r'),(1511,'city_before','2024-05-01 11:18:40','Insert New Row'),(1512,'city_after','2024-05-01 11:18:40','city_postal_code: 4772, city_name: Langebæk\r'),(1513,'city_before','2024-05-01 11:18:40','Insert New Row'),(1514,'city_after','2024-05-01 11:18:40','city_postal_code: 4773, city_name: Stensved\r'),(1515,'city_before','2024-05-01 11:18:40','Insert New Row'),(1516,'city_after','2024-05-01 11:18:40','city_postal_code: 4780, city_name: Stege\r'),(1517,'city_before','2024-05-01 11:18:40','Insert New Row'),(1518,'city_after','2024-05-01 11:18:40','city_postal_code: 4791, city_name: Borre\r'),(1519,'city_before','2024-05-01 11:18:40','Insert New Row'),(1520,'city_after','2024-05-01 11:18:40','city_postal_code: 4792, city_name: Askeby\r'),(1521,'city_before','2024-05-01 11:18:40','Insert New Row'),(1522,'city_after','2024-05-01 11:18:40','city_postal_code: 4793, city_name: Bogø By\r'),(1523,'city_before','2024-05-01 11:18:40','Insert New Row'),(1524,'city_after','2024-05-01 11:18:40','city_postal_code: 4800, city_name: Nykøbing F\r'),(1525,'city_before','2024-05-01 11:18:40','Insert New Row'),(1526,'city_after','2024-05-01 11:18:40','city_postal_code: 4840, city_name: Nørre Alslev\r'),(1527,'city_before','2024-05-01 11:18:40','Insert New Row'),(1528,'city_after','2024-05-01 11:18:40','city_postal_code: 4850, city_name: Stubbekøbing\r'),(1529,'city_before','2024-05-01 11:18:40','Insert New Row'),(1530,'city_after','2024-05-01 11:18:40','city_postal_code: 4862, city_name: Guldborg\r'),(1531,'city_before','2024-05-01 11:18:40','Insert New Row'),(1532,'city_after','2024-05-01 11:18:40','city_postal_code: 4863, city_name: Eskilstrup\r'),(1533,'city_before','2024-05-01 11:18:40','Insert New Row'),(1534,'city_after','2024-05-01 11:18:40','city_postal_code: 4871, city_name: Horbelev\r'),(1535,'city_before','2024-05-01 11:18:40','Insert New Row'),(1536,'city_after','2024-05-01 11:18:40','city_postal_code: 4872, city_name: Idestrup\r'),(1537,'city_before','2024-05-01 11:18:40','Insert New Row'),(1538,'city_after','2024-05-01 11:18:40','city_postal_code: 4873, city_name: Væggerløse\r'),(1539,'city_before','2024-05-01 11:18:40','Insert New Row'),(1540,'city_after','2024-05-01 11:18:40','city_postal_code: 4874, city_name: Gedser\r'),(1541,'city_before','2024-05-01 11:18:40','Insert New Row'),(1542,'city_after','2024-05-01 11:18:40','city_postal_code: 4880, city_name: Nysted\r'),(1543,'city_before','2024-05-01 11:18:40','Insert New Row'),(1544,'city_after','2024-05-01 11:18:40','city_postal_code: 4891, city_name: Toreby L\r'),(1545,'city_before','2024-05-01 11:18:40','Insert New Row'),(1546,'city_after','2024-05-01 11:18:40','city_postal_code: 4892, city_name: Kettinge\r'),(1547,'city_before','2024-05-01 11:18:40','Insert New Row'),(1548,'city_after','2024-05-01 11:18:40','city_postal_code: 4894, city_name: Øster Ulslev\r'),(1549,'city_before','2024-05-01 11:18:40','Insert New Row'),(1550,'city_after','2024-05-01 11:18:40','city_postal_code: 4895, city_name: Errindlev\r'),(1551,'city_before','2024-05-01 11:18:40','Insert New Row'),(1552,'city_after','2024-05-01 11:18:40','city_postal_code: 4900, city_name: Nakskov\r'),(1553,'city_before','2024-05-01 11:18:40','Insert New Row'),(1554,'city_after','2024-05-01 11:18:40','city_postal_code: 4912, city_name: Harpelunde\r'),(1555,'city_before','2024-05-01 11:18:40','Insert New Row'),(1556,'city_after','2024-05-01 11:18:40','city_postal_code: 4913, city_name: Horslunde\r'),(1557,'city_before','2024-05-01 11:18:40','Insert New Row'),(1558,'city_after','2024-05-01 11:18:40','city_postal_code: 4920, city_name: Søllested\r'),(1559,'city_before','2024-05-01 11:18:40','Insert New Row'),(1560,'city_after','2024-05-01 11:18:40','city_postal_code: 4930, city_name: Maribo\r'),(1561,'city_before','2024-05-01 11:18:40','Insert New Row'),(1562,'city_after','2024-05-01 11:18:40','city_postal_code: 4941, city_name: Bandholm\r'),(1563,'city_before','2024-05-01 11:18:40','Insert New Row'),(1564,'city_after','2024-05-01 11:18:40','city_postal_code: 4942, city_name: Askø og Lilleø\r'),(1565,'city_before','2024-05-01 11:18:40','Insert New Row'),(1566,'city_after','2024-05-01 11:18:40','city_postal_code: 4943, city_name: Torrig L\r'),(1567,'city_before','2024-05-01 11:18:40','Insert New Row'),(1568,'city_after','2024-05-01 11:18:40','city_postal_code: 4944, city_name: Fejø\r'),(1569,'city_before','2024-05-01 11:18:40','Insert New Row'),(1570,'city_after','2024-05-01 11:18:40','city_postal_code: 4945, city_name: Femø\r'),(1571,'city_before','2024-05-01 11:18:40','Insert New Row'),(1572,'city_after','2024-05-01 11:18:40','city_postal_code: 4951, city_name: Nørreballe\r'),(1573,'city_before','2024-05-01 11:18:40','Insert New Row'),(1574,'city_after','2024-05-01 11:18:40','city_postal_code: 4952, city_name: Stokkemarke\r'),(1575,'city_before','2024-05-01 11:18:40','Insert New Row'),(1576,'city_after','2024-05-01 11:18:40','city_postal_code: 4953, city_name: Vesterborg\r'),(1577,'city_before','2024-05-01 11:18:40','Insert New Row'),(1578,'city_after','2024-05-01 11:18:40','city_postal_code: 4960, city_name: Holeby\r'),(1579,'city_before','2024-05-01 11:18:40','Insert New Row'),(1580,'city_after','2024-05-01 11:18:40','city_postal_code: 4970, city_name: Rødby\r'),(1581,'city_before','2024-05-01 11:18:40','Insert New Row'),(1582,'city_after','2024-05-01 11:18:40','city_postal_code: 4983, city_name: Dannemare\r'),(1583,'city_before','2024-05-01 11:18:40','Insert New Row'),(1584,'city_after','2024-05-01 11:18:40','city_postal_code: 4990, city_name: Sakskøbing\r'),(1585,'city_before','2024-05-01 11:18:40','Insert New Row'),(1586,'city_after','2024-05-01 11:18:40','city_postal_code: 4992, city_name: Midtsjælland USF P\r'),(1587,'city_before','2024-05-01 11:18:40','Insert New Row'),(1588,'city_after','2024-05-01 11:18:40','city_postal_code: 5000, city_name: Odense C\r'),(1589,'city_before','2024-05-01 11:18:40','Insert New Row'),(1590,'city_after','2024-05-01 11:18:40','city_postal_code: 5029, city_name: Odense C\r'),(1591,'city_before','2024-05-01 11:18:40','Insert New Row'),(1592,'city_after','2024-05-01 11:18:40','city_postal_code: 5100, city_name: Odense C\r'),(1593,'city_before','2024-05-01 11:18:40','Insert New Row'),(1594,'city_after','2024-05-01 11:18:40','city_postal_code: 5200, city_name: Odense V\r'),(1595,'city_before','2024-05-01 11:18:40','Insert New Row'),(1596,'city_after','2024-05-01 11:18:40','city_postal_code: 5210, city_name: Odense NV\r'),(1597,'city_before','2024-05-01 11:18:40','Insert New Row'),(1598,'city_after','2024-05-01 11:18:40','city_postal_code: 5220, city_name: Odense SØ\r'),(1599,'city_before','2024-05-01 11:18:40','Insert New Row'),(1600,'city_after','2024-05-01 11:18:40','city_postal_code: 5230, city_name: Odense M\r'),(1601,'city_before','2024-05-01 11:18:40','Insert New Row'),(1602,'city_after','2024-05-01 11:18:40','city_postal_code: 5240, city_name: Odense NØ\r'),(1603,'city_before','2024-05-01 11:18:40','Insert New Row'),(1604,'city_after','2024-05-01 11:18:40','city_postal_code: 5250, city_name: Odense SV\r'),(1605,'city_before','2024-05-01 11:18:40','Insert New Row'),(1606,'city_after','2024-05-01 11:18:40','city_postal_code: 5260, city_name: Odense S\r'),(1607,'city_before','2024-05-01 11:18:40','Insert New Row'),(1608,'city_after','2024-05-01 11:18:40','city_postal_code: 5270, city_name: Odense N\r'),(1609,'city_before','2024-05-01 11:18:40','Insert New Row'),(1610,'city_after','2024-05-01 11:18:40','city_postal_code: 5290, city_name: Marslev\r'),(1611,'city_before','2024-05-01 11:18:40','Insert New Row'),(1612,'city_after','2024-05-01 11:18:40','city_postal_code: 5300, city_name: Kerteminde\r'),(1613,'city_before','2024-05-01 11:18:40','Insert New Row'),(1614,'city_after','2024-05-01 11:18:40','city_postal_code: 5320, city_name: Agedrup\r'),(1615,'city_before','2024-05-01 11:18:40','Insert New Row'),(1616,'city_after','2024-05-01 11:18:40','city_postal_code: 5330, city_name: Munkebo\r'),(1617,'city_before','2024-05-01 11:18:40','Insert New Row'),(1618,'city_after','2024-05-01 11:18:40','city_postal_code: 5350, city_name: Rynkeby\r'),(1619,'city_before','2024-05-01 11:18:40','Insert New Row'),(1620,'city_after','2024-05-01 11:18:40','city_postal_code: 5370, city_name: Mesinge\r'),(1621,'city_before','2024-05-01 11:18:40','Insert New Row'),(1622,'city_after','2024-05-01 11:18:40','city_postal_code: 5380, city_name: Dalby\r'),(1623,'city_before','2024-05-01 11:18:40','Insert New Row'),(1624,'city_after','2024-05-01 11:18:40','city_postal_code: 5390, city_name: Martofte\r'),(1625,'city_before','2024-05-01 11:18:40','Insert New Row'),(1626,'city_after','2024-05-01 11:18:40','city_postal_code: 5400, city_name: Bogense\r'),(1627,'city_before','2024-05-01 11:18:40','Insert New Row'),(1628,'city_after','2024-05-01 11:18:40','city_postal_code: 5450, city_name: Otterup\r'),(1629,'city_before','2024-05-01 11:18:40','Insert New Row'),(1630,'city_after','2024-05-01 11:18:40','city_postal_code: 5462, city_name: Morud\r'),(1631,'city_before','2024-05-01 11:18:40','Insert New Row'),(1632,'city_after','2024-05-01 11:18:40','city_postal_code: 5463, city_name: Harndrup\r'),(1633,'city_before','2024-05-01 11:18:40','Insert New Row'),(1634,'city_after','2024-05-01 11:18:40','city_postal_code: 5464, city_name: Brenderup Fyn\r'),(1635,'city_before','2024-05-01 11:18:40','Insert New Row'),(1636,'city_after','2024-05-01 11:18:40','city_postal_code: 5466, city_name: Asperup\r'),(1637,'city_before','2024-05-01 11:18:40','Insert New Row'),(1638,'city_after','2024-05-01 11:18:40','city_postal_code: 5471, city_name: Søndersø\r'),(1639,'city_before','2024-05-01 11:18:40','Insert New Row'),(1640,'city_after','2024-05-01 11:18:40','city_postal_code: 5474, city_name: Veflinge\r'),(1641,'city_before','2024-05-01 11:18:40','Insert New Row'),(1642,'city_after','2024-05-01 11:18:40','city_postal_code: 5485, city_name: Skamby\r'),(1643,'city_before','2024-05-01 11:18:40','Insert New Row'),(1644,'city_after','2024-05-01 11:18:40','city_postal_code: 5491, city_name: Blommenslyst\r'),(1645,'city_before','2024-05-01 11:18:40','Insert New Row'),(1646,'city_after','2024-05-01 11:18:40','city_postal_code: 5492, city_name: Vissenbjerg\r'),(1647,'city_before','2024-05-01 11:18:40','Insert New Row'),(1648,'city_after','2024-05-01 11:18:40','city_postal_code: 5500, city_name: Middelfart\r'),(1649,'city_before','2024-05-01 11:18:40','Insert New Row'),(1650,'city_after','2024-05-01 11:18:40','city_postal_code: 5540, city_name: Ullerslev\r'),(1651,'city_before','2024-05-01 11:18:40','Insert New Row'),(1652,'city_after','2024-05-01 11:18:40','city_postal_code: 5550, city_name: Langeskov\r'),(1653,'city_before','2024-05-01 11:18:40','Insert New Row'),(1654,'city_after','2024-05-01 11:18:40','city_postal_code: 5560, city_name: Aarup\r'),(1655,'city_before','2024-05-01 11:18:40','Insert New Row'),(1656,'city_after','2024-05-01 11:18:40','city_postal_code: 5580, city_name: Nørre Aaby\r'),(1657,'city_before','2024-05-01 11:18:40','Insert New Row'),(1658,'city_after','2024-05-01 11:18:40','city_postal_code: 5591, city_name: Gelsted\r'),(1659,'city_before','2024-05-01 11:18:40','Insert New Row'),(1660,'city_after','2024-05-01 11:18:40','city_postal_code: 5592, city_name: Ejby\r'),(1661,'city_before','2024-05-01 11:18:40','Insert New Row'),(1662,'city_after','2024-05-01 11:18:40','city_postal_code: 5600, city_name: Faaborg\r'),(1663,'city_before','2024-05-01 11:18:40','Insert New Row'),(1664,'city_after','2024-05-01 11:18:40','city_postal_code: 5601, city_name: Lyø\r'),(1665,'city_before','2024-05-01 11:18:40','Insert New Row'),(1666,'city_after','2024-05-01 11:18:40','city_postal_code: 5602, city_name: Avernakø\r'),(1667,'city_before','2024-05-01 11:18:40','Insert New Row'),(1668,'city_after','2024-05-01 11:18:40','city_postal_code: 5603, city_name: Bjørnø\r'),(1669,'city_before','2024-05-01 11:18:40','Insert New Row'),(1670,'city_after','2024-05-01 11:18:40','city_postal_code: 5610, city_name: Assens\r'),(1671,'city_before','2024-05-01 11:18:40','Insert New Row'),(1672,'city_after','2024-05-01 11:18:40','city_postal_code: 5620, city_name: Glamsbjerg\r'),(1673,'city_before','2024-05-01 11:18:40','Insert New Row'),(1674,'city_after','2024-05-01 11:18:40','city_postal_code: 5631, city_name: Ebberup\r'),(1675,'city_before','2024-05-01 11:18:40','Insert New Row'),(1676,'city_after','2024-05-01 11:18:40','city_postal_code: 5642, city_name: Millinge\r'),(1677,'city_before','2024-05-01 11:18:40','Insert New Row'),(1678,'city_after','2024-05-01 11:18:40','city_postal_code: 5672, city_name: Broby\r'),(1679,'city_before','2024-05-01 11:18:40','Insert New Row'),(1680,'city_after','2024-05-01 11:18:40','city_postal_code: 5683, city_name: Haarby\r'),(1681,'city_before','2024-05-01 11:18:40','Insert New Row'),(1682,'city_after','2024-05-01 11:18:40','city_postal_code: 5690, city_name: Tommerup\r'),(1683,'city_before','2024-05-01 11:18:40','Insert New Row'),(1684,'city_after','2024-05-01 11:18:40','city_postal_code: 5700, city_name: Svendborg\r'),(1685,'city_before','2024-05-01 11:18:40','Insert New Row'),(1686,'city_after','2024-05-01 11:18:40','city_postal_code: 5750, city_name: Ringe\r'),(1687,'city_before','2024-05-01 11:18:40','Insert New Row'),(1688,'city_after','2024-05-01 11:18:40','city_postal_code: 5762, city_name: Vester Skerninge\r'),(1689,'city_before','2024-05-01 11:18:40','Insert New Row'),(1690,'city_after','2024-05-01 11:18:40','city_postal_code: 5771, city_name: Stenstrup\r'),(1691,'city_before','2024-05-01 11:18:40','Insert New Row'),(1692,'city_after','2024-05-01 11:18:40','city_postal_code: 5772, city_name: Kværndrup\r'),(1693,'city_before','2024-05-01 11:18:40','Insert New Row'),(1694,'city_after','2024-05-01 11:18:40','city_postal_code: 5792, city_name: Årslev\r'),(1695,'city_before','2024-05-01 11:18:40','Insert New Row'),(1696,'city_after','2024-05-01 11:18:40','city_postal_code: 5800, city_name: Nyborg\r'),(1697,'city_before','2024-05-01 11:18:40','Insert New Row'),(1698,'city_after','2024-05-01 11:18:40','city_postal_code: 5853, city_name: Ørbæk\r'),(1699,'city_before','2024-05-01 11:18:40','Insert New Row'),(1700,'city_after','2024-05-01 11:18:40','city_postal_code: 5854, city_name: Gislev\r'),(1701,'city_before','2024-05-01 11:18:40','Insert New Row'),(1702,'city_after','2024-05-01 11:18:40','city_postal_code: 5856, city_name: Ryslinge\r'),(1703,'city_before','2024-05-01 11:18:40','Insert New Row'),(1704,'city_after','2024-05-01 11:18:40','city_postal_code: 5863, city_name: Ferritslev Fyn\r'),(1705,'city_before','2024-05-01 11:18:40','Insert New Row'),(1706,'city_after','2024-05-01 11:18:40','city_postal_code: 5871, city_name: Frørup\r'),(1707,'city_before','2024-05-01 11:18:40','Insert New Row'),(1708,'city_after','2024-05-01 11:18:40','city_postal_code: 5874, city_name: Hesselager\r'),(1709,'city_before','2024-05-01 11:18:40','Insert New Row'),(1710,'city_after','2024-05-01 11:18:40','city_postal_code: 5881, city_name: Skårup Fyn\r'),(1711,'city_before','2024-05-01 11:18:40','Insert New Row'),(1712,'city_after','2024-05-01 11:18:40','city_postal_code: 5882, city_name: Vejstrup\r'),(1713,'city_before','2024-05-01 11:18:40','Insert New Row'),(1714,'city_after','2024-05-01 11:18:40','city_postal_code: 5883, city_name: Oure\r'),(1715,'city_before','2024-05-01 11:18:40','Insert New Row'),(1716,'city_after','2024-05-01 11:18:40','city_postal_code: 5884, city_name: Gudme\r'),(1717,'city_before','2024-05-01 11:18:40','Insert New Row'),(1718,'city_after','2024-05-01 11:18:40','city_postal_code: 5892, city_name: Gudbjerg Sydfyn\r'),(1719,'city_before','2024-05-01 11:18:40','Insert New Row'),(1720,'city_after','2024-05-01 11:18:40','city_postal_code: 5900, city_name: Rudkøbing\r'),(1721,'city_before','2024-05-01 11:18:40','Insert New Row'),(1722,'city_after','2024-05-01 11:18:40','city_postal_code: 5932, city_name: Humble\r'),(1723,'city_before','2024-05-01 11:18:40','Insert New Row'),(1724,'city_after','2024-05-01 11:18:40','city_postal_code: 5935, city_name: Bagenkop\r'),(1725,'city_before','2024-05-01 11:18:40','Insert New Row'),(1726,'city_after','2024-05-01 11:18:40','city_postal_code: 5943, city_name: Strynø\r'),(1727,'city_before','2024-05-01 11:18:40','Insert New Row'),(1728,'city_after','2024-05-01 11:18:40','city_postal_code: 5953, city_name: Tranekær\r'),(1729,'city_before','2024-05-01 11:18:40','Insert New Row'),(1730,'city_after','2024-05-01 11:18:40','city_postal_code: 5960, city_name: Marstal\r'),(1731,'city_before','2024-05-01 11:18:40','Insert New Row'),(1732,'city_after','2024-05-01 11:18:40','city_postal_code: 5965, city_name: Birkholm\r'),(1733,'city_before','2024-05-01 11:18:40','Insert New Row'),(1734,'city_after','2024-05-01 11:18:40','city_postal_code: 5970, city_name: Ærøskøbing\r'),(1735,'city_before','2024-05-01 11:18:40','Insert New Row'),(1736,'city_after','2024-05-01 11:18:40','city_postal_code: 5985, city_name: Søby Ærø\r'),(1737,'city_before','2024-05-01 11:18:40','Insert New Row'),(1738,'city_after','2024-05-01 11:18:40','city_postal_code: 6000, city_name: Kolding\r'),(1739,'city_before','2024-05-01 11:18:40','Insert New Row'),(1740,'city_after','2024-05-01 11:18:40','city_postal_code: 6040, city_name: Egtved\r'),(1741,'city_before','2024-05-01 11:18:40','Insert New Row'),(1742,'city_after','2024-05-01 11:18:40','city_postal_code: 6051, city_name: Almind\r'),(1743,'city_before','2024-05-01 11:18:40','Insert New Row'),(1744,'city_after','2024-05-01 11:18:40','city_postal_code: 6052, city_name: Viuf\r'),(1745,'city_before','2024-05-01 11:18:40','Insert New Row'),(1746,'city_after','2024-05-01 11:18:40','city_postal_code: 6064, city_name: Jordrup\r'),(1747,'city_before','2024-05-01 11:18:40','Insert New Row'),(1748,'city_after','2024-05-01 11:18:40','city_postal_code: 6070, city_name: Christiansfeld\r'),(1749,'city_before','2024-05-01 11:18:40','Insert New Row'),(1750,'city_after','2024-05-01 11:18:40','city_postal_code: 6091, city_name: Bjert\r'),(1751,'city_before','2024-05-01 11:18:40','Insert New Row'),(1752,'city_after','2024-05-01 11:18:40','city_postal_code: 6092, city_name: Sønder Stenderup\r'),(1753,'city_before','2024-05-01 11:18:40','Insert New Row'),(1754,'city_after','2024-05-01 11:18:40','city_postal_code: 6093, city_name: Sjølund\r'),(1755,'city_before','2024-05-01 11:18:40','Insert New Row'),(1756,'city_after','2024-05-01 11:18:40','city_postal_code: 6094, city_name: Hejls\r'),(1757,'city_before','2024-05-01 11:18:40','Insert New Row'),(1758,'city_after','2024-05-01 11:18:40','city_postal_code: 6100, city_name: Haderslev\r'),(1759,'city_before','2024-05-01 11:18:40','Insert New Row'),(1760,'city_after','2024-05-01 11:18:40','city_postal_code: 6200, city_name: Aabenraa\r'),(1761,'city_before','2024-05-01 11:18:40','Insert New Row'),(1762,'city_after','2024-05-01 11:18:40','city_postal_code: 6210, city_name: Barsø\r'),(1763,'city_before','2024-05-01 11:18:40','Insert New Row'),(1764,'city_after','2024-05-01 11:18:40','city_postal_code: 6230, city_name: Rødekro\r'),(1765,'city_before','2024-05-01 11:18:40','Insert New Row'),(1766,'city_after','2024-05-01 11:18:40','city_postal_code: 6240, city_name: Løgumkloster\r'),(1767,'city_before','2024-05-01 11:18:40','Insert New Row'),(1768,'city_after','2024-05-01 11:18:40','city_postal_code: 6261, city_name: Bredebro\r'),(1769,'city_before','2024-05-01 11:18:40','Insert New Row'),(1770,'city_after','2024-05-01 11:18:40','city_postal_code: 6270, city_name: Tønder\r'),(1771,'city_before','2024-05-01 11:18:40','Insert New Row'),(1772,'city_after','2024-05-01 11:18:40','city_postal_code: 6280, city_name: Højer\r'),(1773,'city_before','2024-05-01 11:18:40','Insert New Row'),(1774,'city_after','2024-05-01 11:18:40','city_postal_code: 6300, city_name: Gråsten\r'),(1775,'city_before','2024-05-01 11:18:40','Insert New Row'),(1776,'city_after','2024-05-01 11:18:40','city_postal_code: 6310, city_name: Broager\r'),(1777,'city_before','2024-05-01 11:18:40','Insert New Row'),(1778,'city_after','2024-05-01 11:18:40','city_postal_code: 6320, city_name: Egernsund\r'),(1779,'city_before','2024-05-01 11:18:40','Insert New Row'),(1780,'city_after','2024-05-01 11:18:40','city_postal_code: 6330, city_name: Padborg\r'),(1781,'city_before','2024-05-01 11:18:40','Insert New Row'),(1782,'city_after','2024-05-01 11:18:40','city_postal_code: 6340, city_name: Kruså\r'),(1783,'city_before','2024-05-01 11:18:40','Insert New Row'),(1784,'city_after','2024-05-01 11:18:40','city_postal_code: 6360, city_name: Tinglev\r'),(1785,'city_before','2024-05-01 11:18:40','Insert New Row'),(1786,'city_after','2024-05-01 11:18:40','city_postal_code: 6372, city_name: Bylderup-Bov\r'),(1787,'city_before','2024-05-01 11:18:40','Insert New Row'),(1788,'city_after','2024-05-01 11:18:40','city_postal_code: 6392, city_name: Bolderslev\r'),(1789,'city_before','2024-05-01 11:18:40','Insert New Row'),(1790,'city_after','2024-05-01 11:18:40','city_postal_code: 6400, city_name: Sønderborg\r'),(1791,'city_before','2024-05-01 11:18:40','Insert New Row'),(1792,'city_after','2024-05-01 11:18:40','city_postal_code: 6430, city_name: Nordborg\r'),(1793,'city_before','2024-05-01 11:18:40','Insert New Row'),(1794,'city_after','2024-05-01 11:18:40','city_postal_code: 6440, city_name: Augustenborg\r'),(1795,'city_before','2024-05-01 11:18:40','Insert New Row'),(1796,'city_after','2024-05-01 11:18:40','city_postal_code: 6470, city_name: Sydals\r'),(1797,'city_before','2024-05-01 11:18:40','Insert New Row'),(1798,'city_after','2024-05-01 11:18:40','city_postal_code: 6500, city_name: Vojens\r'),(1799,'city_before','2024-05-01 11:18:40','Insert New Row'),(1800,'city_after','2024-05-01 11:18:40','city_postal_code: 6510, city_name: Gram\r'),(1801,'city_before','2024-05-01 11:18:40','Insert New Row'),(1802,'city_after','2024-05-01 11:18:40','city_postal_code: 6520, city_name: Toftlund\r'),(1803,'city_before','2024-05-01 11:18:40','Insert New Row'),(1804,'city_after','2024-05-01 11:18:40','city_postal_code: 6534, city_name: Agerskov\r'),(1805,'city_before','2024-05-01 11:18:40','Insert New Row'),(1806,'city_after','2024-05-01 11:18:40','city_postal_code: 6535, city_name: Branderup J\r'),(1807,'city_before','2024-05-01 11:18:40','Insert New Row'),(1808,'city_after','2024-05-01 11:18:40','city_postal_code: 6541, city_name: Bevtoft\r'),(1809,'city_before','2024-05-01 11:18:40','Insert New Row'),(1810,'city_after','2024-05-01 11:18:40','city_postal_code: 6560, city_name: Sommersted\r'),(1811,'city_before','2024-05-01 11:18:40','Insert New Row'),(1812,'city_after','2024-05-01 11:18:40','city_postal_code: 6580, city_name: Vamdrup\r'),(1813,'city_before','2024-05-01 11:18:40','Insert New Row'),(1814,'city_after','2024-05-01 11:18:40','city_postal_code: 6600, city_name: Vejen\r'),(1815,'city_before','2024-05-01 11:18:40','Insert New Row'),(1816,'city_after','2024-05-01 11:18:40','city_postal_code: 6621, city_name: Gesten\r'),(1817,'city_before','2024-05-01 11:18:40','Insert New Row'),(1818,'city_after','2024-05-01 11:18:40','city_postal_code: 6622, city_name: Bække\r'),(1819,'city_before','2024-05-01 11:18:40','Insert New Row'),(1820,'city_after','2024-05-01 11:18:40','city_postal_code: 6623, city_name: Vorbasse\r'),(1821,'city_before','2024-05-01 11:18:40','Insert New Row'),(1822,'city_after','2024-05-01 11:18:40','city_postal_code: 6630, city_name: Rødding\r'),(1823,'city_before','2024-05-01 11:18:40','Insert New Row'),(1824,'city_after','2024-05-01 11:18:40','city_postal_code: 6640, city_name: Lunderskov\r'),(1825,'city_before','2024-05-01 11:18:40','Insert New Row'),(1826,'city_after','2024-05-01 11:18:40','city_postal_code: 6650, city_name: Brørup\r'),(1827,'city_before','2024-05-01 11:18:40','Insert New Row'),(1828,'city_after','2024-05-01 11:18:40','city_postal_code: 6660, city_name: Lintrup\r'),(1829,'city_before','2024-05-01 11:18:40','Insert New Row'),(1830,'city_after','2024-05-01 11:18:40','city_postal_code: 6670, city_name: Holsted\r'),(1831,'city_before','2024-05-01 11:18:40','Insert New Row'),(1832,'city_after','2024-05-01 11:18:40','city_postal_code: 6682, city_name: Hovborg\r'),(1833,'city_before','2024-05-01 11:18:40','Insert New Row'),(1834,'city_after','2024-05-01 11:18:40','city_postal_code: 6683, city_name: Føvling\r'),(1835,'city_before','2024-05-01 11:18:40','Insert New Row'),(1836,'city_after','2024-05-01 11:18:40','city_postal_code: 6690, city_name: Gørding\r'),(1837,'city_before','2024-05-01 11:18:40','Insert New Row'),(1838,'city_after','2024-05-01 11:18:40','city_postal_code: 6700, city_name: Esbjerg\r'),(1839,'city_before','2024-05-01 11:18:40','Insert New Row'),(1840,'city_after','2024-05-01 11:18:40','city_postal_code: 6701, city_name: Esbjerg\r'),(1841,'city_before','2024-05-01 11:18:40','Insert New Row'),(1842,'city_after','2024-05-01 11:18:40','city_postal_code: 6705, city_name: Esbjerg Ø\r'),(1843,'city_before','2024-05-01 11:18:40','Insert New Row'),(1844,'city_after','2024-05-01 11:18:40','city_postal_code: 6710, city_name: Esbjerg V\r'),(1845,'city_before','2024-05-01 11:18:40','Insert New Row'),(1846,'city_after','2024-05-01 11:18:40','city_postal_code: 6715, city_name: Esbjerg N\r'),(1847,'city_before','2024-05-01 11:18:40','Insert New Row'),(1848,'city_after','2024-05-01 11:18:40','city_postal_code: 6720, city_name: Fanø\r'),(1849,'city_before','2024-05-01 11:18:40','Insert New Row'),(1850,'city_after','2024-05-01 11:18:40','city_postal_code: 6731, city_name: Tjæreborg\r'),(1851,'city_before','2024-05-01 11:18:40','Insert New Row'),(1852,'city_after','2024-05-01 11:18:40','city_postal_code: 6740, city_name: Bramming\r'),(1853,'city_before','2024-05-01 11:18:40','Insert New Row'),(1854,'city_after','2024-05-01 11:18:40','city_postal_code: 6752, city_name: Glejbjerg\r'),(1855,'city_before','2024-05-01 11:18:40','Insert New Row'),(1856,'city_after','2024-05-01 11:18:40','city_postal_code: 6753, city_name: Agerbæk\r'),(1857,'city_before','2024-05-01 11:18:40','Insert New Row'),(1858,'city_after','2024-05-01 11:18:40','city_postal_code: 6760, city_name: Ribe\r'),(1859,'city_before','2024-05-01 11:18:40','Insert New Row'),(1860,'city_after','2024-05-01 11:18:40','city_postal_code: 6771, city_name: Gredstedbro\r'),(1861,'city_before','2024-05-01 11:18:40','Insert New Row'),(1862,'city_after','2024-05-01 11:18:40','city_postal_code: 6780, city_name: Skærbæk\r'),(1863,'city_before','2024-05-01 11:18:40','Insert New Row'),(1864,'city_after','2024-05-01 11:18:40','city_postal_code: 6792, city_name: Rømø\r'),(1865,'city_before','2024-05-01 11:18:40','Insert New Row'),(1866,'city_after','2024-05-01 11:18:40','city_postal_code: 6800, city_name: Varde\r'),(1867,'city_before','2024-05-01 11:18:40','Insert New Row'),(1868,'city_after','2024-05-01 11:18:40','city_postal_code: 6818, city_name: Årre\r'),(1869,'city_before','2024-05-01 11:18:40','Insert New Row'),(1870,'city_after','2024-05-01 11:18:40','city_postal_code: 6823, city_name: Ansager\r'),(1871,'city_before','2024-05-01 11:18:40','Insert New Row'),(1872,'city_after','2024-05-01 11:18:40','city_postal_code: 6830, city_name: Nørre Nebel\r'),(1873,'city_before','2024-05-01 11:18:40','Insert New Row'),(1874,'city_after','2024-05-01 11:18:40','city_postal_code: 6840, city_name: Oksbøl\r'),(1875,'city_before','2024-05-01 11:18:40','Insert New Row'),(1876,'city_after','2024-05-01 11:18:40','city_postal_code: 6851, city_name: Janderup Vestj\r'),(1877,'city_before','2024-05-01 11:18:40','Insert New Row'),(1878,'city_after','2024-05-01 11:18:40','city_postal_code: 6852, city_name: Billum\r'),(1879,'city_before','2024-05-01 11:18:40','Insert New Row'),(1880,'city_after','2024-05-01 11:18:40','city_postal_code: 6853, city_name: Vejers Strand\r'),(1881,'city_before','2024-05-01 11:18:40','Insert New Row'),(1882,'city_after','2024-05-01 11:18:40','city_postal_code: 6854, city_name: Henne\r'),(1883,'city_before','2024-05-01 11:18:40','Insert New Row'),(1884,'city_after','2024-05-01 11:18:40','city_postal_code: 6855, city_name: Outrup\r'),(1885,'city_before','2024-05-01 11:18:40','Insert New Row'),(1886,'city_after','2024-05-01 11:18:40','city_postal_code: 6857, city_name: Blåvand\r'),(1887,'city_before','2024-05-01 11:18:40','Insert New Row'),(1888,'city_after','2024-05-01 11:18:40','city_postal_code: 6862, city_name: Tistrup\r'),(1889,'city_before','2024-05-01 11:18:40','Insert New Row'),(1890,'city_after','2024-05-01 11:18:40','city_postal_code: 6870, city_name: Ølgod\r'),(1891,'city_before','2024-05-01 11:18:40','Insert New Row'),(1892,'city_after','2024-05-01 11:18:40','city_postal_code: 6880, city_name: Tarm\r'),(1893,'city_before','2024-05-01 11:18:40','Insert New Row'),(1894,'city_after','2024-05-01 11:18:40','city_postal_code: 6893, city_name: Hemmet\r'),(1895,'city_before','2024-05-01 11:18:40','Insert New Row'),(1896,'city_after','2024-05-01 11:18:40','city_postal_code: 6900, city_name: Skjern\r'),(1897,'city_before','2024-05-01 11:18:40','Insert New Row'),(1898,'city_after','2024-05-01 11:18:40','city_postal_code: 6920, city_name: Videbæk\r'),(1899,'city_before','2024-05-01 11:18:40','Insert New Row'),(1900,'city_after','2024-05-01 11:18:40','city_postal_code: 6933, city_name: Kibæk\r'),(1901,'city_before','2024-05-01 11:18:40','Insert New Row'),(1902,'city_after','2024-05-01 11:18:40','city_postal_code: 6940, city_name: Lem St\r'),(1903,'city_before','2024-05-01 11:18:40','Insert New Row'),(1904,'city_after','2024-05-01 11:18:40','city_postal_code: 6950, city_name: Ringkøbing\r'),(1905,'city_before','2024-05-01 11:18:40','Insert New Row'),(1906,'city_after','2024-05-01 11:18:40','city_postal_code: 6960, city_name: Hvide Sande\r'),(1907,'city_before','2024-05-01 11:18:40','Insert New Row'),(1908,'city_after','2024-05-01 11:18:40','city_postal_code: 6971, city_name: Spjald\r'),(1909,'city_before','2024-05-01 11:18:40','Insert New Row'),(1910,'city_after','2024-05-01 11:18:40','city_postal_code: 6973, city_name: Ørnhøj\r'),(1911,'city_before','2024-05-01 11:18:40','Insert New Row'),(1912,'city_after','2024-05-01 11:18:40','city_postal_code: 6980, city_name: Tim\r'),(1913,'city_before','2024-05-01 11:18:40','Insert New Row'),(1914,'city_after','2024-05-01 11:18:40','city_postal_code: 6990, city_name: Ulfborg\r'),(1915,'city_before','2024-05-01 11:18:40','Insert New Row'),(1916,'city_after','2024-05-01 11:18:40','city_postal_code: 7000, city_name: Fredericia\r'),(1917,'city_before','2024-05-01 11:18:40','Insert New Row'),(1918,'city_after','2024-05-01 11:18:40','city_postal_code: 7007, city_name: Fredericia\r'),(1919,'city_before','2024-05-01 11:18:40','Insert New Row'),(1920,'city_after','2024-05-01 11:18:40','city_postal_code: 7017, city_name: Taulov Pakkecenter\r'),(1921,'city_before','2024-05-01 11:18:40','Insert New Row'),(1922,'city_after','2024-05-01 11:18:40','city_postal_code: 7018, city_name: Pakker TLP\r'),(1923,'city_before','2024-05-01 11:18:40','Insert New Row'),(1924,'city_after','2024-05-01 11:18:40','city_postal_code: 7029, city_name: Fredericia\r'),(1925,'city_before','2024-05-01 11:18:40','Insert New Row'),(1926,'city_after','2024-05-01 11:18:40','city_postal_code: 7080, city_name: Børkop\r'),(1927,'city_before','2024-05-01 11:18:40','Insert New Row'),(1928,'city_after','2024-05-01 11:18:40','city_postal_code: 7100, city_name: Vejle\r'),(1929,'city_before','2024-05-01 11:18:40','Insert New Row'),(1930,'city_after','2024-05-01 11:18:40','city_postal_code: 7120, city_name: Vejle Øst\r'),(1931,'city_before','2024-05-01 11:18:40','Insert New Row'),(1932,'city_after','2024-05-01 11:18:40','city_postal_code: 7130, city_name: Juelsminde\r'),(1933,'city_before','2024-05-01 11:18:40','Insert New Row'),(1934,'city_after','2024-05-01 11:18:40','city_postal_code: 7140, city_name: Stouby\r'),(1935,'city_before','2024-05-01 11:18:40','Insert New Row'),(1936,'city_after','2024-05-01 11:18:40','city_postal_code: 7150, city_name: Barrit\r'),(1937,'city_before','2024-05-01 11:18:40','Insert New Row'),(1938,'city_after','2024-05-01 11:18:40','city_postal_code: 7160, city_name: Tørring\r'),(1939,'city_before','2024-05-01 11:18:40','Insert New Row'),(1940,'city_after','2024-05-01 11:18:40','city_postal_code: 7171, city_name: Uldum\r'),(1941,'city_before','2024-05-01 11:18:40','Insert New Row'),(1942,'city_after','2024-05-01 11:18:40','city_postal_code: 7173, city_name: Vonge\r'),(1943,'city_before','2024-05-01 11:18:40','Insert New Row'),(1944,'city_after','2024-05-01 11:18:40','city_postal_code: 7182, city_name: Bredsten\r'),(1945,'city_before','2024-05-01 11:18:40','Insert New Row'),(1946,'city_after','2024-05-01 11:18:40','city_postal_code: 7183, city_name: Randbøl\r'),(1947,'city_before','2024-05-01 11:18:40','Insert New Row'),(1948,'city_after','2024-05-01 11:18:40','city_postal_code: 7184, city_name: Vandel\r'),(1949,'city_before','2024-05-01 11:18:40','Insert New Row'),(1950,'city_after','2024-05-01 11:18:40','city_postal_code: 7190, city_name: Billund\r'),(1951,'city_before','2024-05-01 11:18:40','Insert New Row'),(1952,'city_after','2024-05-01 11:18:40','city_postal_code: 7200, city_name: Grindsted\r'),(1953,'city_before','2024-05-01 11:18:40','Insert New Row'),(1954,'city_after','2024-05-01 11:18:40','city_postal_code: 7250, city_name: Hejnsvig\r'),(1955,'city_before','2024-05-01 11:18:40','Insert New Row'),(1956,'city_after','2024-05-01 11:18:40','city_postal_code: 7260, city_name: Sønder Omme\r'),(1957,'city_before','2024-05-01 11:18:40','Insert New Row'),(1958,'city_after','2024-05-01 11:18:40','city_postal_code: 7270, city_name: Stakroge\r'),(1959,'city_before','2024-05-01 11:18:40','Insert New Row'),(1960,'city_after','2024-05-01 11:18:40','city_postal_code: 7280, city_name: Sønder Felding\r'),(1961,'city_before','2024-05-01 11:18:40','Insert New Row'),(1962,'city_after','2024-05-01 11:18:40','city_postal_code: 7300, city_name: Jelling\r'),(1963,'city_before','2024-05-01 11:18:40','Insert New Row'),(1964,'city_after','2024-05-01 11:18:40','city_postal_code: 7321, city_name: Gadbjerg\r'),(1965,'city_before','2024-05-01 11:18:40','Insert New Row'),(1966,'city_after','2024-05-01 11:18:40','city_postal_code: 7323, city_name: Give\r'),(1967,'city_before','2024-05-01 11:18:40','Insert New Row'),(1968,'city_after','2024-05-01 11:18:40','city_postal_code: 7330, city_name: Brande\r'),(1969,'city_before','2024-05-01 11:18:40','Insert New Row'),(1970,'city_after','2024-05-01 11:18:40','city_postal_code: 7361, city_name: Ejstrupholm\r'),(1971,'city_before','2024-05-01 11:18:40','Insert New Row'),(1972,'city_after','2024-05-01 11:18:40','city_postal_code: 7362, city_name: Hampen\r'),(1973,'city_before','2024-05-01 11:18:40','Insert New Row'),(1974,'city_after','2024-05-01 11:18:40','city_postal_code: 7400, city_name: Herning\r'),(1975,'city_before','2024-05-01 11:18:40','Insert New Row'),(1976,'city_after','2024-05-01 11:18:40','city_postal_code: 7429, city_name: Herning\r'),(1977,'city_before','2024-05-01 11:18:40','Insert New Row'),(1978,'city_after','2024-05-01 11:18:40','city_postal_code: 7430, city_name: Ikast\r'),(1979,'city_before','2024-05-01 11:18:40','Insert New Row'),(1980,'city_after','2024-05-01 11:18:40','city_postal_code: 7441, city_name: Bording\r'),(1981,'city_before','2024-05-01 11:18:40','Insert New Row'),(1982,'city_after','2024-05-01 11:18:40','city_postal_code: 7442, city_name: Engesvang\r'),(1983,'city_before','2024-05-01 11:18:40','Insert New Row'),(1984,'city_after','2024-05-01 11:18:40','city_postal_code: 7451, city_name: Sunds\r'),(1985,'city_before','2024-05-01 11:18:40','Insert New Row'),(1986,'city_after','2024-05-01 11:18:40','city_postal_code: 7470, city_name: Karup J\r'),(1987,'city_before','2024-05-01 11:18:40','Insert New Row'),(1988,'city_after','2024-05-01 11:18:40','city_postal_code: 7480, city_name: Vildbjerg\r'),(1989,'city_before','2024-05-01 11:18:40','Insert New Row'),(1990,'city_after','2024-05-01 11:18:40','city_postal_code: 7490, city_name: Aulum\r'),(1991,'city_before','2024-05-01 11:18:40','Insert New Row'),(1992,'city_after','2024-05-01 11:18:40','city_postal_code: 7500, city_name: Holstebro\r'),(1993,'city_before','2024-05-01 11:18:40','Insert New Row'),(1994,'city_after','2024-05-01 11:18:40','city_postal_code: 7540, city_name: Haderup\r'),(1995,'city_before','2024-05-01 11:18:40','Insert New Row'),(1996,'city_after','2024-05-01 11:18:40','city_postal_code: 7550, city_name: Sørvad\r'),(1997,'city_before','2024-05-01 11:18:40','Insert New Row'),(1998,'city_after','2024-05-01 11:18:40','city_postal_code: 7560, city_name: Hjerm\r'),(1999,'city_before','2024-05-01 11:18:40','Insert New Row'),(2000,'city_after','2024-05-01 11:18:40','city_postal_code: 7570, city_name: Vemb\r'),(2001,'city_before','2024-05-01 11:18:40','Insert New Row'),(2002,'city_after','2024-05-01 11:18:40','city_postal_code: 7600, city_name: Struer\r'),(2003,'city_before','2024-05-01 11:18:40','Insert New Row'),(2004,'city_after','2024-05-01 11:18:40','city_postal_code: 7620, city_name: Lemvig\r'),(2005,'city_before','2024-05-01 11:18:40','Insert New Row'),(2006,'city_after','2024-05-01 11:18:40','city_postal_code: 7650, city_name: Bøvlingbjerg\r'),(2007,'city_before','2024-05-01 11:18:40','Insert New Row'),(2008,'city_after','2024-05-01 11:18:40','city_postal_code: 7660, city_name: Bækmarksbro\r'),(2009,'city_before','2024-05-01 11:18:40','Insert New Row'),(2010,'city_after','2024-05-01 11:18:40','city_postal_code: 7673, city_name: Harboøre\r'),(2011,'city_before','2024-05-01 11:18:40','Insert New Row'),(2012,'city_after','2024-05-01 11:18:40','city_postal_code: 7680, city_name: Thyborøn\r'),(2013,'city_before','2024-05-01 11:18:40','Insert New Row'),(2014,'city_after','2024-05-01 11:18:40','city_postal_code: 7700, city_name: Thisted\r'),(2015,'city_before','2024-05-01 11:18:40','Insert New Row'),(2016,'city_after','2024-05-01 11:18:40','city_postal_code: 7730, city_name: Hanstholm\r'),(2017,'city_before','2024-05-01 11:18:40','Insert New Row'),(2018,'city_after','2024-05-01 11:18:40','city_postal_code: 7741, city_name: Frøstrup\r'),(2019,'city_before','2024-05-01 11:18:40','Insert New Row'),(2020,'city_after','2024-05-01 11:18:40','city_postal_code: 7742, city_name: Vesløs\r'),(2021,'city_before','2024-05-01 11:18:40','Insert New Row'),(2022,'city_after','2024-05-01 11:18:40','city_postal_code: 7752, city_name: Snedsted\r'),(2023,'city_before','2024-05-01 11:18:40','Insert New Row'),(2024,'city_after','2024-05-01 11:18:40','city_postal_code: 7755, city_name: Bedsted Thy\r'),(2025,'city_before','2024-05-01 11:18:40','Insert New Row'),(2026,'city_after','2024-05-01 11:18:40','city_postal_code: 7760, city_name: Hurup Thy\r'),(2027,'city_before','2024-05-01 11:18:40','Insert New Row'),(2028,'city_after','2024-05-01 11:18:40','city_postal_code: 7770, city_name: Vestervig\r'),(2029,'city_before','2024-05-01 11:18:40','Insert New Row'),(2030,'city_after','2024-05-01 11:18:40','city_postal_code: 7790, city_name: Thyholm\r'),(2031,'city_before','2024-05-01 11:18:40','Insert New Row'),(2032,'city_after','2024-05-01 11:18:40','city_postal_code: 7800, city_name: Skive\r'),(2033,'city_before','2024-05-01 11:18:40','Insert New Row'),(2034,'city_after','2024-05-01 11:18:40','city_postal_code: 7830, city_name: Vinderup\r'),(2035,'city_before','2024-05-01 11:18:40','Insert New Row'),(2036,'city_after','2024-05-01 11:18:40','city_postal_code: 7840, city_name: Højslev\r'),(2037,'city_before','2024-05-01 11:18:40','Insert New Row'),(2038,'city_after','2024-05-01 11:18:40','city_postal_code: 7850, city_name: Stoholm Jyll\r'),(2039,'city_before','2024-05-01 11:18:40','Insert New Row'),(2040,'city_after','2024-05-01 11:18:40','city_postal_code: 7860, city_name: Spøttrup\r'),(2041,'city_before','2024-05-01 11:18:40','Insert New Row'),(2042,'city_after','2024-05-01 11:18:40','city_postal_code: 7870, city_name: Roslev\r'),(2043,'city_before','2024-05-01 11:18:40','Insert New Row'),(2044,'city_after','2024-05-01 11:18:40','city_postal_code: 7884, city_name: Fur\r'),(2045,'city_before','2024-05-01 11:18:40','Insert New Row'),(2046,'city_after','2024-05-01 11:18:40','city_postal_code: 7900, city_name: Nykøbing M\r'),(2047,'city_before','2024-05-01 11:18:40','Insert New Row'),(2048,'city_after','2024-05-01 11:18:40','city_postal_code: 7950, city_name: Erslev\r'),(2049,'city_before','2024-05-01 11:18:40','Insert New Row'),(2050,'city_after','2024-05-01 11:18:40','city_postal_code: 7960, city_name: Karby\r'),(2051,'city_before','2024-05-01 11:18:40','Insert New Row'),(2052,'city_after','2024-05-01 11:18:40','city_postal_code: 7970, city_name: Redsted M\r'),(2053,'city_before','2024-05-01 11:18:40','Insert New Row'),(2054,'city_after','2024-05-01 11:18:40','city_postal_code: 7980, city_name: Vils\r'),(2055,'city_before','2024-05-01 11:18:40','Insert New Row'),(2056,'city_after','2024-05-01 11:18:40','city_postal_code: 7990, city_name: Øster Assels\r'),(2057,'city_before','2024-05-01 11:18:40','Insert New Row'),(2058,'city_after','2024-05-01 11:18:40','city_postal_code: 7992, city_name: Sydjylland/Fyn USF P\r'),(2059,'city_before','2024-05-01 11:18:40','Insert New Row'),(2060,'city_after','2024-05-01 11:18:40','city_postal_code: 7993, city_name: Sydjylland/Fyn USF B\r'),(2061,'city_before','2024-05-01 11:18:40','Insert New Row'),(2062,'city_after','2024-05-01 11:18:40','city_postal_code: 7996, city_name: Fakturaservice\r'),(2063,'city_before','2024-05-01 11:18:40','Insert New Row'),(2064,'city_after','2024-05-01 11:18:40','city_postal_code: 7997, city_name: Fakturascanning\r'),(2065,'city_before','2024-05-01 11:18:40','Insert New Row'),(2066,'city_after','2024-05-01 11:18:40','city_postal_code: 7998, city_name: Statsservice\r'),(2067,'city_before','2024-05-01 11:18:40','Insert New Row'),(2068,'city_after','2024-05-01 11:18:40','city_postal_code: 7999, city_name: Kommunepost\r'),(2069,'city_before','2024-05-01 11:18:40','Insert New Row'),(2070,'city_after','2024-05-01 11:18:40','city_postal_code: 8000, city_name: Aarhus C\r'),(2071,'city_before','2024-05-01 11:18:40','Insert New Row'),(2072,'city_after','2024-05-01 11:18:40','city_postal_code: 8100, city_name: Aarhus C\r'),(2073,'city_before','2024-05-01 11:18:40','Insert New Row'),(2074,'city_after','2024-05-01 11:18:40','city_postal_code: 8200, city_name: Aarhus N\r'),(2075,'city_before','2024-05-01 11:18:40','Insert New Row'),(2076,'city_after','2024-05-01 11:18:40','city_postal_code: 8210, city_name: Aarhus V\r'),(2077,'city_before','2024-05-01 11:18:40','Insert New Row'),(2078,'city_after','2024-05-01 11:18:40','city_postal_code: 8220, city_name: Brabrand\r'),(2079,'city_before','2024-05-01 11:18:40','Insert New Row'),(2080,'city_after','2024-05-01 11:18:40','city_postal_code: 8229, city_name: Risskov Ø\r'),(2081,'city_before','2024-05-01 11:18:40','Insert New Row'),(2082,'city_after','2024-05-01 11:18:40','city_postal_code: 8230, city_name: Åbyhøj\r'),(2083,'city_before','2024-05-01 11:18:40','Insert New Row'),(2084,'city_after','2024-05-01 11:18:40','city_postal_code: 8240, city_name: Risskov\r'),(2085,'city_before','2024-05-01 11:18:40','Insert New Row'),(2086,'city_after','2024-05-01 11:18:40','city_postal_code: 8245, city_name: Risskov Ø\r'),(2087,'city_before','2024-05-01 11:18:40','Insert New Row'),(2088,'city_after','2024-05-01 11:18:40','city_postal_code: 8250, city_name: Egå\r'),(2089,'city_before','2024-05-01 11:18:40','Insert New Row'),(2090,'city_after','2024-05-01 11:18:40','city_postal_code: 8260, city_name: Viby J\r'),(2091,'city_before','2024-05-01 11:18:40','Insert New Row'),(2092,'city_after','2024-05-01 11:18:40','city_postal_code: 8270, city_name: Højbjerg\r'),(2093,'city_before','2024-05-01 11:18:40','Insert New Row'),(2094,'city_after','2024-05-01 11:18:40','city_postal_code: 8300, city_name: Odder\r'),(2095,'city_before','2024-05-01 11:18:40','Insert New Row'),(2096,'city_after','2024-05-01 11:18:40','city_postal_code: 8305, city_name: Samsø\r'),(2097,'city_before','2024-05-01 11:18:40','Insert New Row'),(2098,'city_after','2024-05-01 11:18:40','city_postal_code: 8310, city_name: Tranbjerg J\r'),(2099,'city_before','2024-05-01 11:18:40','Insert New Row'),(2100,'city_after','2024-05-01 11:18:40','city_postal_code: 8320, city_name: Mårslet\r'),(2101,'city_before','2024-05-01 11:18:40','Insert New Row'),(2102,'city_after','2024-05-01 11:18:40','city_postal_code: 8330, city_name: Beder\r'),(2103,'city_before','2024-05-01 11:18:40','Insert New Row'),(2104,'city_after','2024-05-01 11:18:40','city_postal_code: 8340, city_name: Malling\r'),(2105,'city_before','2024-05-01 11:18:40','Insert New Row'),(2106,'city_after','2024-05-01 11:18:40','city_postal_code: 8350, city_name: Hundslund\r'),(2107,'city_before','2024-05-01 11:18:40','Insert New Row'),(2108,'city_after','2024-05-01 11:18:40','city_postal_code: 8355, city_name: Solbjerg\r'),(2109,'city_before','2024-05-01 11:18:40','Insert New Row'),(2110,'city_after','2024-05-01 11:18:40','city_postal_code: 8361, city_name: Hasselager\r'),(2111,'city_before','2024-05-01 11:18:40','Insert New Row'),(2112,'city_after','2024-05-01 11:18:40','city_postal_code: 8362, city_name: Hørning\r'),(2113,'city_before','2024-05-01 11:18:40','Insert New Row'),(2114,'city_after','2024-05-01 11:18:40','city_postal_code: 8370, city_name: Hadsten\r'),(2115,'city_before','2024-05-01 11:18:40','Insert New Row'),(2116,'city_after','2024-05-01 11:18:40','city_postal_code: 8380, city_name: Trige\r'),(2117,'city_before','2024-05-01 11:18:40','Insert New Row'),(2118,'city_after','2024-05-01 11:18:40','city_postal_code: 8381, city_name: Tilst\r'),(2119,'city_before','2024-05-01 11:18:40','Insert New Row'),(2120,'city_after','2024-05-01 11:18:40','city_postal_code: 8382, city_name: Hinnerup\r'),(2121,'city_before','2024-05-01 11:18:40','Insert New Row'),(2122,'city_after','2024-05-01 11:18:40','city_postal_code: 8400, city_name: Ebeltoft\r'),(2123,'city_before','2024-05-01 11:18:40','Insert New Row'),(2124,'city_after','2024-05-01 11:18:40','city_postal_code: 8410, city_name: Rønde\r'),(2125,'city_before','2024-05-01 11:18:40','Insert New Row'),(2126,'city_after','2024-05-01 11:18:40','city_postal_code: 8420, city_name: Knebel\r'),(2127,'city_before','2024-05-01 11:18:40','Insert New Row'),(2128,'city_after','2024-05-01 11:18:40','city_postal_code: 8444, city_name: Balle\r'),(2129,'city_before','2024-05-01 11:18:40','Insert New Row'),(2130,'city_after','2024-05-01 11:18:40','city_postal_code: 8450, city_name: Hammel\r'),(2131,'city_before','2024-05-01 11:18:40','Insert New Row'),(2132,'city_after','2024-05-01 11:18:40','city_postal_code: 8462, city_name: Harlev J\r'),(2133,'city_before','2024-05-01 11:18:40','Insert New Row'),(2134,'city_after','2024-05-01 11:18:40','city_postal_code: 8464, city_name: Galten\r'),(2135,'city_before','2024-05-01 11:18:40','Insert New Row'),(2136,'city_after','2024-05-01 11:18:40','city_postal_code: 8471, city_name: Sabro\r'),(2137,'city_before','2024-05-01 11:18:40','Insert New Row'),(2138,'city_after','2024-05-01 11:18:40','city_postal_code: 8472, city_name: Sporup\r'),(2139,'city_before','2024-05-01 11:18:40','Insert New Row'),(2140,'city_after','2024-05-01 11:18:40','city_postal_code: 8500, city_name: Grenaa\r'),(2141,'city_before','2024-05-01 11:18:40','Insert New Row'),(2142,'city_after','2024-05-01 11:18:40','city_postal_code: 8520, city_name: Lystrup\r'),(2143,'city_before','2024-05-01 11:18:40','Insert New Row'),(2144,'city_after','2024-05-01 11:18:40','city_postal_code: 8530, city_name: Hjortshøj\r'),(2145,'city_before','2024-05-01 11:18:40','Insert New Row'),(2146,'city_after','2024-05-01 11:18:40','city_postal_code: 8541, city_name: Skødstrup\r'),(2147,'city_before','2024-05-01 11:18:40','Insert New Row'),(2148,'city_after','2024-05-01 11:18:40','city_postal_code: 8543, city_name: Hornslet\r'),(2149,'city_before','2024-05-01 11:18:40','Insert New Row'),(2150,'city_after','2024-05-01 11:18:40','city_postal_code: 8544, city_name: Mørke\r'),(2151,'city_before','2024-05-01 11:18:40','Insert New Row'),(2152,'city_after','2024-05-01 11:18:40','city_postal_code: 8550, city_name: Ryomgård\r'),(2153,'city_before','2024-05-01 11:18:40','Insert New Row'),(2154,'city_after','2024-05-01 11:18:40','city_postal_code: 8560, city_name: Kolind\r'),(2155,'city_before','2024-05-01 11:18:40','Insert New Row'),(2156,'city_after','2024-05-01 11:18:40','city_postal_code: 8570, city_name: Trustrup\r'),(2157,'city_before','2024-05-01 11:18:40','Insert New Row'),(2158,'city_after','2024-05-01 11:18:40','city_postal_code: 8581, city_name: Nimtofte\r'),(2159,'city_before','2024-05-01 11:18:40','Insert New Row'),(2160,'city_after','2024-05-01 11:18:40','city_postal_code: 8585, city_name: Glesborg\r'),(2161,'city_before','2024-05-01 11:18:40','Insert New Row'),(2162,'city_after','2024-05-01 11:18:40','city_postal_code: 8586, city_name: Ørum Djurs\r'),(2163,'city_before','2024-05-01 11:18:40','Insert New Row'),(2164,'city_after','2024-05-01 11:18:40','city_postal_code: 8592, city_name: Anholt\r'),(2165,'city_before','2024-05-01 11:18:40','Insert New Row'),(2166,'city_after','2024-05-01 11:18:40','city_postal_code: 8600, city_name: Silkeborg\r'),(2167,'city_before','2024-05-01 11:18:40','Insert New Row'),(2168,'city_after','2024-05-01 11:18:40','city_postal_code: 8620, city_name: Kjellerup\r'),(2169,'city_before','2024-05-01 11:18:40','Insert New Row'),(2170,'city_after','2024-05-01 11:18:40','city_postal_code: 8632, city_name: Lemming\r'),(2171,'city_before','2024-05-01 11:18:40','Insert New Row'),(2172,'city_after','2024-05-01 11:18:40','city_postal_code: 8641, city_name: Sorring\r'),(2173,'city_before','2024-05-01 11:18:40','Insert New Row'),(2174,'city_after','2024-05-01 11:18:40','city_postal_code: 8643, city_name: Ans By\r'),(2175,'city_before','2024-05-01 11:18:40','Insert New Row'),(2176,'city_after','2024-05-01 11:18:40','city_postal_code: 8653, city_name: Them\r'),(2177,'city_before','2024-05-01 11:18:40','Insert New Row'),(2178,'city_after','2024-05-01 11:18:40','city_postal_code: 8654, city_name: Bryrup\r'),(2179,'city_before','2024-05-01 11:18:40','Insert New Row'),(2180,'city_after','2024-05-01 11:18:40','city_postal_code: 8660, city_name: Skanderborg\r'),(2181,'city_before','2024-05-01 11:18:40','Insert New Row'),(2182,'city_after','2024-05-01 11:18:40','city_postal_code: 8670, city_name: Låsby\r'),(2183,'city_before','2024-05-01 11:18:40','Insert New Row'),(2184,'city_after','2024-05-01 11:18:40','city_postal_code: 8680, city_name: Ry\r'),(2185,'city_before','2024-05-01 11:18:40','Insert New Row'),(2186,'city_after','2024-05-01 11:18:40','city_postal_code: 8700, city_name: Horsens\r'),(2187,'city_before','2024-05-01 11:18:40','Insert New Row'),(2188,'city_after','2024-05-01 11:18:40','city_postal_code: 8721, city_name: Daugård\r'),(2189,'city_before','2024-05-01 11:18:40','Insert New Row'),(2190,'city_after','2024-05-01 11:18:40','city_postal_code: 8722, city_name: Hedensted\r'),(2191,'city_before','2024-05-01 11:18:40','Insert New Row'),(2192,'city_after','2024-05-01 11:18:40','city_postal_code: 8723, city_name: Løsning\r'),(2193,'city_before','2024-05-01 11:18:40','Insert New Row'),(2194,'city_after','2024-05-01 11:18:40','city_postal_code: 8732, city_name: Hovedgård\r'),(2195,'city_before','2024-05-01 11:18:40','Insert New Row'),(2196,'city_after','2024-05-01 11:18:40','city_postal_code: 8740, city_name: Brædstrup\r'),(2197,'city_before','2024-05-01 11:18:40','Insert New Row'),(2198,'city_after','2024-05-01 11:18:40','city_postal_code: 8751, city_name: Gedved\r'),(2199,'city_before','2024-05-01 11:18:40','Insert New Row'),(2200,'city_after','2024-05-01 11:18:40','city_postal_code: 8752, city_name: Østbirk\r'),(2201,'city_before','2024-05-01 11:18:40','Insert New Row'),(2202,'city_after','2024-05-01 11:18:40','city_postal_code: 8762, city_name: Flemming\r'),(2203,'city_before','2024-05-01 11:18:40','Insert New Row'),(2204,'city_after','2024-05-01 11:18:40','city_postal_code: 8763, city_name: Rask Mølle\r'),(2205,'city_before','2024-05-01 11:18:40','Insert New Row'),(2206,'city_after','2024-05-01 11:18:40','city_postal_code: 8765, city_name: Klovborg\r'),(2207,'city_before','2024-05-01 11:18:40','Insert New Row'),(2208,'city_after','2024-05-01 11:18:40','city_postal_code: 8766, city_name: Nørre Snede\r'),(2209,'city_before','2024-05-01 11:18:40','Insert New Row'),(2210,'city_after','2024-05-01 11:18:40','city_postal_code: 8781, city_name: Stenderup\r'),(2211,'city_before','2024-05-01 11:18:40','Insert New Row'),(2212,'city_after','2024-05-01 11:18:40','city_postal_code: 8783, city_name: Hornsyld\r'),(2213,'city_before','2024-05-01 11:18:40','Insert New Row'),(2214,'city_after','2024-05-01 11:18:40','city_postal_code: 8789, city_name: Endelave\r'),(2215,'city_before','2024-05-01 11:18:40','Insert New Row'),(2216,'city_after','2024-05-01 11:18:40','city_postal_code: 8799, city_name: Tunø\r'),(2217,'city_before','2024-05-01 11:18:40','Insert New Row'),(2218,'city_after','2024-05-01 11:18:40','city_postal_code: 8800, city_name: Viborg\r'),(2219,'city_before','2024-05-01 11:18:40','Insert New Row'),(2220,'city_after','2024-05-01 11:18:40','city_postal_code: 8830, city_name: Tjele\r'),(2221,'city_before','2024-05-01 11:18:40','Insert New Row'),(2222,'city_after','2024-05-01 11:18:40','city_postal_code: 8831, city_name: Løgstrup\r'),(2223,'city_before','2024-05-01 11:18:40','Insert New Row'),(2224,'city_after','2024-05-01 11:18:40','city_postal_code: 8832, city_name: Skals\r'),(2225,'city_before','2024-05-01 11:18:40','Insert New Row'),(2226,'city_after','2024-05-01 11:18:40','city_postal_code: 8840, city_name: Rødkærsbro\r'),(2227,'city_before','2024-05-01 11:18:40','Insert New Row'),(2228,'city_after','2024-05-01 11:18:40','city_postal_code: 8850, city_name: Bjerringbro\r'),(2229,'city_before','2024-05-01 11:18:40','Insert New Row'),(2230,'city_after','2024-05-01 11:18:40','city_postal_code: 8860, city_name: Ulstrup\r'),(2231,'city_before','2024-05-01 11:18:40','Insert New Row'),(2232,'city_after','2024-05-01 11:18:40','city_postal_code: 8870, city_name: Langå\r'),(2233,'city_before','2024-05-01 11:18:40','Insert New Row'),(2234,'city_after','2024-05-01 11:18:40','city_postal_code: 8881, city_name: Thorsø\r'),(2235,'city_before','2024-05-01 11:18:40','Insert New Row'),(2236,'city_after','2024-05-01 11:18:40','city_postal_code: 8882, city_name: Fårvang\r'),(2237,'city_before','2024-05-01 11:18:40','Insert New Row'),(2238,'city_after','2024-05-01 11:18:40','city_postal_code: 8883, city_name: Gjern\r'),(2239,'city_before','2024-05-01 11:18:40','Insert New Row'),(2240,'city_after','2024-05-01 11:18:40','city_postal_code: 8900, city_name: Randers C\r'),(2241,'city_before','2024-05-01 11:18:40','Insert New Row'),(2242,'city_after','2024-05-01 11:18:40','city_postal_code: 8920, city_name: Randers NV\r'),(2243,'city_before','2024-05-01 11:18:40','Insert New Row'),(2244,'city_after','2024-05-01 11:18:40','city_postal_code: 8930, city_name: Randers NØ\r'),(2245,'city_before','2024-05-01 11:18:40','Insert New Row'),(2246,'city_after','2024-05-01 11:18:40','city_postal_code: 8940, city_name: Randers SV\r'),(2247,'city_before','2024-05-01 11:18:40','Insert New Row'),(2248,'city_after','2024-05-01 11:18:40','city_postal_code: 8950, city_name: Ørsted\r'),(2249,'city_before','2024-05-01 11:18:40','Insert New Row'),(2250,'city_after','2024-05-01 11:18:40','city_postal_code: 8960, city_name: Randers SØ\r'),(2251,'city_before','2024-05-01 11:18:40','Insert New Row'),(2252,'city_after','2024-05-01 11:18:40','city_postal_code: 8961, city_name: Allingåbro\r'),(2253,'city_before','2024-05-01 11:18:40','Insert New Row'),(2254,'city_after','2024-05-01 11:18:40','city_postal_code: 8963, city_name: Auning\r'),(2255,'city_before','2024-05-01 11:18:40','Insert New Row'),(2256,'city_after','2024-05-01 11:18:40','city_postal_code: 8970, city_name: Havndal\r'),(2257,'city_before','2024-05-01 11:18:40','Insert New Row'),(2258,'city_after','2024-05-01 11:18:40','city_postal_code: 8981, city_name: Spentrup\r'),(2259,'city_before','2024-05-01 11:18:40','Insert New Row'),(2260,'city_after','2024-05-01 11:18:40','city_postal_code: 8983, city_name: Gjerlev J\r'),(2261,'city_before','2024-05-01 11:18:40','Insert New Row'),(2262,'city_after','2024-05-01 11:18:40','city_postal_code: 8990, city_name: Fårup\r'),(2263,'city_before','2024-05-01 11:18:40','Insert New Row'),(2264,'city_after','2024-05-01 11:18:40','city_postal_code: 9000, city_name: Aalborg\r'),(2265,'city_before','2024-05-01 11:18:40','Insert New Row'),(2266,'city_after','2024-05-01 11:18:40','city_postal_code: 9029, city_name: Aalborg\r'),(2267,'city_before','2024-05-01 11:18:40','Insert New Row'),(2268,'city_after','2024-05-01 11:18:40','city_postal_code: 9100, city_name: Aalborg\r'),(2269,'city_before','2024-05-01 11:18:40','Insert New Row'),(2270,'city_after','2024-05-01 11:18:40','city_postal_code: 9200, city_name: Aalborg SV\r'),(2271,'city_before','2024-05-01 11:18:40','Insert New Row'),(2272,'city_after','2024-05-01 11:18:40','city_postal_code: 9210, city_name: Aalborg SØ\r'),(2273,'city_before','2024-05-01 11:18:40','Insert New Row'),(2274,'city_after','2024-05-01 11:18:40','city_postal_code: 9220, city_name: Aalborg Øst\r'),(2275,'city_before','2024-05-01 11:18:40','Insert New Row'),(2276,'city_after','2024-05-01 11:18:40','city_postal_code: 9230, city_name: Svenstrup J\r'),(2277,'city_before','2024-05-01 11:18:40','Insert New Row'),(2278,'city_after','2024-05-01 11:18:40','city_postal_code: 9240, city_name: Nibe\r'),(2279,'city_before','2024-05-01 11:18:40','Insert New Row'),(2280,'city_after','2024-05-01 11:18:40','city_postal_code: 9260, city_name: Gistrup\r'),(2281,'city_before','2024-05-01 11:18:40','Insert New Row'),(2282,'city_after','2024-05-01 11:18:40','city_postal_code: 9270, city_name: Klarup\r'),(2283,'city_before','2024-05-01 11:18:40','Insert New Row'),(2284,'city_after','2024-05-01 11:18:40','city_postal_code: 9280, city_name: Storvorde\r'),(2285,'city_before','2024-05-01 11:18:40','Insert New Row'),(2286,'city_after','2024-05-01 11:18:40','city_postal_code: 9293, city_name: Kongerslev\r'),(2287,'city_before','2024-05-01 11:18:40','Insert New Row'),(2288,'city_after','2024-05-01 11:18:40','city_postal_code: 9300, city_name: Sæby\r'),(2289,'city_before','2024-05-01 11:18:40','Insert New Row'),(2290,'city_after','2024-05-01 11:18:40','city_postal_code: 9310, city_name: Vodskov\r'),(2291,'city_before','2024-05-01 11:18:40','Insert New Row'),(2292,'city_after','2024-05-01 11:18:40','city_postal_code: 9320, city_name: Hjallerup\r'),(2293,'city_before','2024-05-01 11:18:40','Insert New Row'),(2294,'city_after','2024-05-01 11:18:40','city_postal_code: 9330, city_name: Dronninglund\r'),(2295,'city_before','2024-05-01 11:18:40','Insert New Row'),(2296,'city_after','2024-05-01 11:18:40','city_postal_code: 9340, city_name: Asaa\r'),(2297,'city_before','2024-05-01 11:18:40','Insert New Row'),(2298,'city_after','2024-05-01 11:18:40','city_postal_code: 9352, city_name: Dybvad\r'),(2299,'city_before','2024-05-01 11:18:40','Insert New Row'),(2300,'city_after','2024-05-01 11:18:40','city_postal_code: 9362, city_name: Gandrup\r'),(2301,'city_before','2024-05-01 11:18:40','Insert New Row'),(2302,'city_after','2024-05-01 11:18:40','city_postal_code: 9370, city_name: Hals\r'),(2303,'city_before','2024-05-01 11:18:40','Insert New Row'),(2304,'city_after','2024-05-01 11:18:40','city_postal_code: 9380, city_name: Vestbjerg\r'),(2305,'city_before','2024-05-01 11:18:40','Insert New Row'),(2306,'city_after','2024-05-01 11:18:40','city_postal_code: 9381, city_name: Sulsted\r'),(2307,'city_before','2024-05-01 11:18:40','Insert New Row'),(2308,'city_after','2024-05-01 11:18:40','city_postal_code: 9382, city_name: Tylstrup\r'),(2309,'city_before','2024-05-01 11:18:40','Insert New Row'),(2310,'city_after','2024-05-01 11:18:40','city_postal_code: 9400, city_name: Nørresundby\r'),(2311,'city_before','2024-05-01 11:18:40','Insert New Row'),(2312,'city_after','2024-05-01 11:18:40','city_postal_code: 9430, city_name: Vadum\r'),(2313,'city_before','2024-05-01 11:18:40','Insert New Row'),(2314,'city_after','2024-05-01 11:18:40','city_postal_code: 9440, city_name: Aabybro\r'),(2315,'city_before','2024-05-01 11:18:40','Insert New Row'),(2316,'city_after','2024-05-01 11:18:40','city_postal_code: 9460, city_name: Brovst\r'),(2317,'city_before','2024-05-01 11:18:40','Insert New Row'),(2318,'city_after','2024-05-01 11:18:40','city_postal_code: 9480, city_name: Løkken\r'),(2319,'city_before','2024-05-01 11:18:40','Insert New Row'),(2320,'city_after','2024-05-01 11:18:40','city_postal_code: 9490, city_name: Pandrup\r'),(2321,'city_before','2024-05-01 11:18:40','Insert New Row'),(2322,'city_after','2024-05-01 11:18:40','city_postal_code: 9492, city_name: Blokhus\r'),(2323,'city_before','2024-05-01 11:18:40','Insert New Row'),(2324,'city_after','2024-05-01 11:18:40','city_postal_code: 9493, city_name: Saltum\r'),(2325,'city_before','2024-05-01 11:18:40','Insert New Row'),(2326,'city_after','2024-05-01 11:18:40','city_postal_code: 9500, city_name: Hobro\r'),(2327,'city_before','2024-05-01 11:18:40','Insert New Row'),(2328,'city_after','2024-05-01 11:18:40','city_postal_code: 9510, city_name: Arden\r'),(2329,'city_before','2024-05-01 11:18:40','Insert New Row'),(2330,'city_after','2024-05-01 11:18:40','city_postal_code: 9520, city_name: Skørping\r'),(2331,'city_before','2024-05-01 11:18:40','Insert New Row'),(2332,'city_after','2024-05-01 11:18:40','city_postal_code: 9530, city_name: Støvring\r'),(2333,'city_before','2024-05-01 11:18:40','Insert New Row'),(2334,'city_after','2024-05-01 11:18:40','city_postal_code: 9541, city_name: Suldrup\r'),(2335,'city_before','2024-05-01 11:18:40','Insert New Row'),(2336,'city_after','2024-05-01 11:18:40','city_postal_code: 9550, city_name: Mariager\r'),(2337,'city_before','2024-05-01 11:18:40','Insert New Row'),(2338,'city_after','2024-05-01 11:18:40','city_postal_code: 9560, city_name: Hadsund\r'),(2339,'city_before','2024-05-01 11:18:40','Insert New Row'),(2340,'city_after','2024-05-01 11:18:40','city_postal_code: 9574, city_name: Bælum\r'),(2341,'city_before','2024-05-01 11:18:40','Insert New Row'),(2342,'city_after','2024-05-01 11:18:40','city_postal_code: 9575, city_name: Terndrup\r'),(2343,'city_before','2024-05-01 11:18:40','Insert New Row'),(2344,'city_after','2024-05-01 11:18:40','city_postal_code: 9600, city_name: Aars\r'),(2345,'city_before','2024-05-01 11:18:40','Insert New Row'),(2346,'city_after','2024-05-01 11:18:40','city_postal_code: 9610, city_name: Nørager\r'),(2347,'city_before','2024-05-01 11:18:40','Insert New Row'),(2348,'city_after','2024-05-01 11:18:40','city_postal_code: 9620, city_name: Aalestrup\r'),(2349,'city_before','2024-05-01 11:18:40','Insert New Row'),(2350,'city_after','2024-05-01 11:18:40','city_postal_code: 9631, city_name: Gedsted\r'),(2351,'city_before','2024-05-01 11:18:40','Insert New Row'),(2352,'city_after','2024-05-01 11:18:40','city_postal_code: 9632, city_name: Møldrup\r'),(2353,'city_before','2024-05-01 11:18:40','Insert New Row'),(2354,'city_after','2024-05-01 11:18:40','city_postal_code: 9640, city_name: Farsø\r'),(2355,'city_before','2024-05-01 11:18:40','Insert New Row'),(2356,'city_after','2024-05-01 11:18:40','city_postal_code: 9670, city_name: Løgstør\r'),(2357,'city_before','2024-05-01 11:18:40','Insert New Row'),(2358,'city_after','2024-05-01 11:18:40','city_postal_code: 9681, city_name: Ranum\r'),(2359,'city_before','2024-05-01 11:18:40','Insert New Row'),(2360,'city_after','2024-05-01 11:18:40','city_postal_code: 9690, city_name: Fjerritslev\r'),(2361,'city_before','2024-05-01 11:18:40','Insert New Row'),(2362,'city_after','2024-05-01 11:18:40','city_postal_code: 9700, city_name: Brønderslev\r'),(2363,'city_before','2024-05-01 11:18:40','Insert New Row'),(2364,'city_after','2024-05-01 11:18:40','city_postal_code: 9740, city_name: Jerslev J\r'),(2365,'city_before','2024-05-01 11:18:40','Insert New Row'),(2366,'city_after','2024-05-01 11:18:40','city_postal_code: 9750, city_name: Østervrå\r'),(2367,'city_before','2024-05-01 11:18:40','Insert New Row'),(2368,'city_after','2024-05-01 11:18:40','city_postal_code: 9760, city_name: Vrå\r'),(2369,'city_before','2024-05-01 11:18:40','Insert New Row'),(2370,'city_after','2024-05-01 11:18:40','city_postal_code: 9800, city_name: Hjørring\r'),(2371,'city_before','2024-05-01 11:18:40','Insert New Row'),(2372,'city_after','2024-05-01 11:18:40','city_postal_code: 9830, city_name: Tårs\r'),(2373,'city_before','2024-05-01 11:18:40','Insert New Row'),(2374,'city_after','2024-05-01 11:18:40','city_postal_code: 9850, city_name: Hirtshals\r'),(2375,'city_before','2024-05-01 11:18:40','Insert New Row'),(2376,'city_after','2024-05-01 11:18:40','city_postal_code: 9870, city_name: Sindal\r'),(2377,'city_before','2024-05-01 11:18:40','Insert New Row'),(2378,'city_after','2024-05-01 11:18:40','city_postal_code: 9881, city_name: Bindslev\r'),(2379,'city_before','2024-05-01 11:18:40','Insert New Row'),(2380,'city_after','2024-05-01 11:18:40','city_postal_code: 9900, city_name: Frederikshavn\r'),(2381,'city_before','2024-05-01 11:18:40','Insert New Row'),(2382,'city_after','2024-05-01 11:18:40','city_postal_code: 9940, city_name: Læsø\r'),(2383,'city_before','2024-05-01 11:18:40','Insert New Row'),(2384,'city_after','2024-05-01 11:18:40','city_postal_code: 9970, city_name: Strandby\r'),(2385,'city_before','2024-05-01 11:18:40','Insert New Row'),(2386,'city_after','2024-05-01 11:18:40','city_postal_code: 9981, city_name: Jerup\r'),(2387,'city_before','2024-05-01 11:18:40','Insert New Row'),(2388,'city_after','2024-05-01 11:18:40','city_postal_code: 9982, city_name: Ålbæk\r'),(2389,'city_before','2024-05-01 11:18:40','Insert New Row'),(2390,'city_after','2024-05-01 11:18:40','city_postal_code: 9990, city_name: Skagen\r'),(2391,'city_before','2024-05-01 11:18:40','Insert New Row'),(2392,'city_after','2024-05-01 11:18:40','city_postal_code: 9992, city_name: Jylland USF P\r'),(2393,'city_before','2024-05-01 11:18:40','Insert New Row'),(2394,'city_after','2024-05-01 11:18:40','city_postal_code: 9993, city_name: Jylland USF B\r'),(2395,'city_before','2024-05-01 11:18:40','Insert New Row'),(2396,'city_after','2024-05-01 11:18:40','city_postal_code: 9996, city_name: Fakturaservice\r'),(2397,'city_before','2024-05-01 11:18:40','Insert New Row'),(2398,'city_after','2024-05-01 11:18:40','city_postal_code: 9997, city_name: Fakturascanning\r'),(2399,'city_before','2024-05-01 11:18:40','Insert New Row'),(2400,'city_after','2024-05-01 11:18:40','city_postal_code: 9998, city_name: Borgerservice\r'),(2401,'city_before','2024-05-01 11:18:40','Insert New Row'),(2402,'city_after','2024-05-01 11:18:40','city_postal_code: 3900, city_name: Nuuk\r'),(2403,'city_before','2024-05-01 11:18:40','Insert New Row'),(2404,'city_after','2024-05-01 11:18:40','city_postal_code: 3905, city_name: Nuussuaq\r'),(2405,'city_before','2024-05-01 11:18:40','Insert New Row'),(2406,'city_after','2024-05-01 11:18:40','city_postal_code: 3910, city_name: Kangerlussuaq\r'),(2407,'city_before','2024-05-01 11:18:40','Insert New Row'),(2408,'city_after','2024-05-01 11:18:40','city_postal_code: 3911, city_name: Sisimiut\r'),(2409,'city_before','2024-05-01 11:18:40','Insert New Row'),(2410,'city_after','2024-05-01 11:18:40','city_postal_code: 3912, city_name: Maniitsoq\r'),(2411,'city_before','2024-05-01 11:18:40','Insert New Row'),(2412,'city_after','2024-05-01 11:18:40','city_postal_code: 3913, city_name: Tasiilaq\r'),(2413,'city_before','2024-05-01 11:18:40','Insert New Row'),(2414,'city_after','2024-05-01 11:18:40','city_postal_code: 3915, city_name: Kulusuk\r'),(2415,'city_before','2024-05-01 11:18:40','Insert New Row'),(2416,'city_after','2024-05-01 11:18:40','city_postal_code: 3919, city_name: Alluitsup Paa\r'),(2417,'city_before','2024-05-01 11:18:40','Insert New Row'),(2418,'city_after','2024-05-01 11:18:40','city_postal_code: 3920, city_name: Qaqortoq\r'),(2419,'city_before','2024-05-01 11:18:40','Insert New Row'),(2420,'city_after','2024-05-01 11:18:40','city_postal_code: 3921, city_name: Narsaq\r'),(2421,'city_before','2024-05-01 11:18:40','Insert New Row'),(2422,'city_after','2024-05-01 11:18:40','city_postal_code: 3922, city_name: Nanortalik\r'),(2423,'city_before','2024-05-01 11:18:40','Insert New Row'),(2424,'city_after','2024-05-01 11:18:40','city_postal_code: 3923, city_name: Narsarsuaq\r'),(2425,'city_before','2024-05-01 11:18:40','Insert New Row'),(2426,'city_after','2024-05-01 11:18:40','city_postal_code: 3924, city_name: Ikerasassuaq\r'),(2427,'city_before','2024-05-01 11:18:40','Insert New Row'),(2428,'city_after','2024-05-01 11:18:40','city_postal_code: 3930, city_name: Kangilinnguit\r'),(2429,'city_before','2024-05-01 11:18:40','Insert New Row'),(2430,'city_after','2024-05-01 11:18:40','city_postal_code: 3932, city_name: Arsuk\r'),(2431,'city_before','2024-05-01 11:18:40','Insert New Row'),(2432,'city_after','2024-05-01 11:18:40','city_postal_code: 3940, city_name: Paamiut\r'),(2433,'city_before','2024-05-01 11:18:40','Insert New Row'),(2434,'city_after','2024-05-01 11:18:40','city_postal_code: 3950, city_name: Aasiaat\r'),(2435,'city_before','2024-05-01 11:18:40','Insert New Row'),(2436,'city_after','2024-05-01 11:18:40','city_postal_code: 3951, city_name: Qasigiannguit\r'),(2437,'city_before','2024-05-01 11:18:40','Insert New Row'),(2438,'city_after','2024-05-01 11:18:40','city_postal_code: 3952, city_name: Ilulissat\r'),(2439,'city_before','2024-05-01 11:18:40','Insert New Row'),(2440,'city_after','2024-05-01 11:18:40','city_postal_code: 3953, city_name: Qeqertarsuaq\r'),(2441,'city_before','2024-05-01 11:18:40','Insert New Row'),(2442,'city_after','2024-05-01 11:18:40','city_postal_code: 3955, city_name: Kangaatsiaq\r'),(2443,'city_before','2024-05-01 11:18:40','Insert New Row'),(2444,'city_after','2024-05-01 11:18:40','city_postal_code: 3961, city_name: Uummannaq\r'),(2445,'city_before','2024-05-01 11:18:40','Insert New Row'),(2446,'city_after','2024-05-01 11:18:40','city_postal_code: 3962, city_name: Upernavik\r'),(2447,'city_before','2024-05-01 11:18:40','Insert New Row'),(2448,'city_after','2024-05-01 11:18:40','city_postal_code: 3964, city_name: Qaarsut\r'),(2449,'city_before','2024-05-01 11:18:40','Insert New Row'),(2450,'city_after','2024-05-01 11:18:40','city_postal_code: 3970, city_name: Pituffik\r'),(2451,'city_before','2024-05-01 11:18:40','Insert New Row'),(2452,'city_after','2024-05-01 11:18:40','city_postal_code: 3971, city_name: Qaanaaq\r'),(2453,'city_before','2024-05-01 11:18:40','Insert New Row'),(2454,'city_after','2024-05-01 11:18:40','city_postal_code: 3972, city_name: Station Nord\r'),(2455,'city_before','2024-05-01 11:18:40','Insert New Row'),(2456,'city_after','2024-05-01 11:18:40','city_postal_code: 3980, city_name: Ittoqqortoormiit\r'),(2457,'city_before','2024-05-01 11:18:40','Insert New Row'),(2458,'city_after','2024-05-01 11:18:40','city_postal_code: 3982, city_name: Mestersvig\r'),(2459,'city_before','2024-05-01 11:18:40','Insert New Row'),(2460,'city_after','2024-05-01 11:18:40','city_postal_code: 3984, city_name: Danmarkshavn\r'),(2461,'city_before','2024-05-01 11:18:40','Insert New Row'),(2462,'city_after','2024-05-01 11:18:40','city_postal_code: 3985, city_name: Constable Pynt\r'),(2463,'city_before','2024-05-01 11:18:40','Insert New Row'),(2464,'city_after','2024-05-01 11:18:40','city_postal_code: 3992, city_name: Slædepatrulje Sirius\r'),(2465,'city_before','2024-05-01 11:18:40','Insert New Row'),(2466,'city_after','2024-05-01 11:18:40','city_postal_code: 100, city_name: Tórshavn\r'),(2467,'city_before','2024-05-01 11:18:40','Insert New Row'),(2468,'city_after','2024-05-01 11:18:40','city_postal_code: 110, city_name: Tórshavn \r'),(2469,'city_before','2024-05-01 11:18:40','Insert New Row'),(2470,'city_after','2024-05-01 11:18:40','city_postal_code: 160, city_name: Argir\r'),(2471,'city_before','2024-05-01 11:18:40','Insert New Row'),(2472,'city_after','2024-05-01 11:18:40','city_postal_code: 165, city_name: Argir \r'),(2473,'city_before','2024-05-01 11:18:40','Insert New Row'),(2474,'city_after','2024-05-01 11:18:40','city_postal_code: 175, city_name: Kirkjubøur\r'),(2475,'city_before','2024-05-01 11:18:40','Insert New Row'),(2476,'city_after','2024-05-01 11:18:40','city_postal_code: 176, city_name: Velbastadur\r'),(2477,'city_before','2024-05-01 11:18:40','Insert New Row'),(2478,'city_after','2024-05-01 11:18:40','city_postal_code: 177, city_name: Sydradalur'),(2479,'city_before','2024-05-01 11:18:40','Insert New Row'),(2480,'city_after','2024-05-01 11:18:40','city_postal_code: 178, city_name: Nordradalur\r'),(2481,'city_before','2024-05-01 11:18:40','Insert New Row'),(2482,'city_after','2024-05-01 11:18:40','city_postal_code: 180, city_name: Kaldbak\r'),(2483,'city_before','2024-05-01 11:18:40','Insert New Row'),(2484,'city_after','2024-05-01 11:18:40','city_postal_code: 185, city_name: Kaldbaksbotnur\r'),(2485,'city_before','2024-05-01 11:18:40','Insert New Row'),(2486,'city_after','2024-05-01 11:18:40','city_postal_code: 186, city_name: Sund\r'),(2487,'city_before','2024-05-01 11:18:40','Insert New Row'),(2488,'city_after','2024-05-01 11:18:40','city_postal_code: 187, city_name: Hvitanes\r'),(2489,'city_before','2024-05-01 11:18:40','Insert New Row'),(2490,'city_after','2024-05-01 11:18:40','city_postal_code: 188, city_name: Hoyvík\r'),(2491,'city_before','2024-05-01 11:18:40','Insert New Row'),(2492,'city_after','2024-05-01 11:18:40','city_postal_code: 210, city_name: Sandur\r'),(2493,'city_before','2024-05-01 11:18:40','Insert New Row'),(2494,'city_after','2024-05-01 11:18:40','city_postal_code: 215, city_name: Sandur\r'),(2495,'city_before','2024-05-01 11:18:40','Insert New Row'),(2496,'city_after','2024-05-01 11:18:40','city_postal_code: 220, city_name: Skálavík\r'),(2497,'city_before','2024-05-01 11:18:40','Insert New Row'),(2498,'city_after','2024-05-01 11:18:40','city_postal_code: 230, city_name: Húsavík\r'),(2499,'city_before','2024-05-01 11:18:40','Insert New Row'),(2500,'city_after','2024-05-01 11:18:40','city_postal_code: 235, city_name: Dalur\r'),(2501,'city_before','2024-05-01 11:18:40','Insert New Row'),(2502,'city_after','2024-05-01 11:18:40','city_postal_code: 236, city_name: Skarvanes\r'),(2503,'city_before','2024-05-01 11:18:40','Insert New Row'),(2504,'city_after','2024-05-01 11:18:40','city_postal_code: 240, city_name: Skopun\r'),(2505,'city_before','2024-05-01 11:18:40','Insert New Row'),(2506,'city_after','2024-05-01 11:18:40','city_postal_code: 260, city_name: Skúvoy\r'),(2507,'city_before','2024-05-01 11:18:40','Insert New Row'),(2508,'city_after','2024-05-01 11:18:40','city_postal_code: 270, city_name: Nólsoy\r'),(2509,'city_before','2024-05-01 11:18:40','Insert New Row'),(2510,'city_after','2024-05-01 11:18:40','city_postal_code: 280, city_name: Hestur\r'),(2511,'city_before','2024-05-01 11:18:40','Insert New Row'),(2512,'city_after','2024-05-01 11:18:40','city_postal_code: 285, city_name: Koltur\r'),(2513,'city_before','2024-05-01 11:18:40','Insert New Row'),(2514,'city_after','2024-05-01 11:18:40','city_postal_code: 286, city_name: Stóra Dimun\r'),(2515,'city_before','2024-05-01 11:18:40','Insert New Row'),(2516,'city_after','2024-05-01 11:18:40','city_postal_code: 330, city_name: Stykkid\r'),(2517,'city_before','2024-05-01 11:18:40','Insert New Row'),(2518,'city_after','2024-05-01 11:18:40','city_postal_code: 335, city_name: Leynar\r'),(2519,'city_before','2024-05-01 11:18:40','Insert New Row'),(2520,'city_after','2024-05-01 11:18:40','city_postal_code: 336, city_name: Skællingur\r'),(2521,'city_before','2024-05-01 11:18:40','Insert New Row'),(2522,'city_after','2024-05-01 11:18:40','city_postal_code: 340, city_name: Kvívík\r'),(2523,'city_before','2024-05-01 11:18:40','Insert New Row'),(2524,'city_after','2024-05-01 11:18:40','city_postal_code: 350, city_name: Vestmanna\r'),(2525,'city_before','2024-05-01 11:18:40','Insert New Row'),(2526,'city_after','2024-05-01 11:18:40','city_postal_code: 355, city_name: Vestmanna\r'),(2527,'city_before','2024-05-01 11:18:40','Insert New Row'),(2528,'city_after','2024-05-01 11:18:40','city_postal_code: 358, city_name: Válur\r'),(2529,'city_before','2024-05-01 11:18:40','Insert New Row'),(2530,'city_after','2024-05-01 11:18:40','city_postal_code: 360, city_name: Sandavágur\r'),(2531,'city_before','2024-05-01 11:18:40','Insert New Row'),(2532,'city_after','2024-05-01 11:18:40','city_postal_code: 370, city_name: Midvágur\r'),(2533,'city_before','2024-05-01 11:18:40','Insert New Row'),(2534,'city_after','2024-05-01 11:18:40','city_postal_code: 375, city_name: Midvágur\r'),(2535,'city_before','2024-05-01 11:18:40','Insert New Row'),(2536,'city_after','2024-05-01 11:18:40','city_postal_code: 380, city_name: Sørvágur\r'),(2537,'city_before','2024-05-01 11:18:40','Insert New Row'),(2538,'city_after','2024-05-01 11:18:40','city_postal_code: 385, city_name: Vatnsoyrar\r'),(2539,'city_before','2024-05-01 11:18:40','Insert New Row'),(2540,'city_after','2024-05-01 11:18:40','city_postal_code: 386, city_name: Bøur\r'),(2541,'city_before','2024-05-01 11:18:40','Insert New Row'),(2542,'city_after','2024-05-01 11:18:40','city_postal_code: 387, city_name: Gásadalur\r'),(2543,'city_before','2024-05-01 11:18:40','Insert New Row'),(2544,'city_after','2024-05-01 11:18:40','city_postal_code: 388, city_name: Mykines\r'),(2545,'city_before','2024-05-01 11:18:40','Insert New Row'),(2546,'city_after','2024-05-01 11:18:40','city_postal_code: 400, city_name: Oyrarbakki\r'),(2547,'city_before','2024-05-01 11:18:40','Insert New Row'),(2548,'city_after','2024-05-01 11:18:40','city_postal_code: 405, city_name: Oyrarbakki\r'),(2549,'city_before','2024-05-01 11:18:40','Insert New Row'),(2550,'city_after','2024-05-01 11:18:40','city_postal_code: 410, city_name: Kollafjørdur\r'),(2551,'city_before','2024-05-01 11:18:40','Insert New Row'),(2552,'city_after','2024-05-01 11:18:40','city_postal_code: 415, city_name: Oyrareingir\r'),(2553,'city_before','2024-05-01 11:18:40','Insert New Row'),(2554,'city_after','2024-05-01 11:18:40','city_postal_code: 416, city_name: Signabøur\r'),(2555,'city_before','2024-05-01 11:18:40','Insert New Row'),(2556,'city_after','2024-05-01 11:18:40','city_postal_code: 420, city_name: Hósvík\r'),(2557,'city_before','2024-05-01 11:18:40','Insert New Row'),(2558,'city_after','2024-05-01 11:18:40','city_postal_code: 430, city_name: Hvalvík\r'),(2559,'city_before','2024-05-01 11:18:40','Insert New Row'),(2560,'city_after','2024-05-01 11:18:40','city_postal_code: 435, city_name: Streymnes\r'),(2561,'city_before','2024-05-01 11:18:40','Insert New Row'),(2562,'city_after','2024-05-01 11:18:40','city_postal_code: 436, city_name: Saksun\r'),(2563,'city_before','2024-05-01 11:18:40','Insert New Row'),(2564,'city_after','2024-05-01 11:18:40','city_postal_code: 437, city_name: Nesvík\r'),(2565,'city_before','2024-05-01 11:18:40','Insert New Row'),(2566,'city_after','2024-05-01 11:18:40','city_postal_code: 438, city_name: Langasandur\r'),(2567,'city_before','2024-05-01 11:18:40','Insert New Row'),(2568,'city_after','2024-05-01 11:18:40','city_postal_code: 440, city_name: Haldarsvík\r'),(2569,'city_before','2024-05-01 11:18:40','Insert New Row'),(2570,'city_after','2024-05-01 11:18:40','city_postal_code: 445, city_name: Tjørnuvík\r'),(2571,'city_before','2024-05-01 11:18:40','Insert New Row'),(2572,'city_after','2024-05-01 11:18:40','city_postal_code: 450, city_name: Oyri\r'),(2573,'city_before','2024-05-01 11:18:40','Insert New Row'),(2574,'city_after','2024-05-01 11:18:40','city_postal_code: 460, city_name: Nordskáli\r'),(2575,'city_before','2024-05-01 11:18:40','Insert New Row'),(2576,'city_after','2024-05-01 11:18:40','city_postal_code: 465, city_name: Svináir\r'),(2577,'city_before','2024-05-01 11:18:40','Insert New Row'),(2578,'city_after','2024-05-01 11:18:40','city_postal_code: 466, city_name: Ljósá\r'),(2579,'city_before','2024-05-01 11:18:40','Insert New Row'),(2580,'city_after','2024-05-01 11:18:40','city_postal_code: 470, city_name: Eidi\r'),(2581,'city_before','2024-05-01 11:18:40','Insert New Row'),(2582,'city_after','2024-05-01 11:18:40','city_postal_code: 475, city_name: Funningur\r'),(2583,'city_before','2024-05-01 11:18:40','Insert New Row'),(2584,'city_after','2024-05-01 11:18:40','city_postal_code: 476, city_name: Gjógv\r'),(2585,'city_before','2024-05-01 11:18:40','Insert New Row'),(2586,'city_after','2024-05-01 11:18:40','city_postal_code: 477, city_name: Funningsfjørdur\r'),(2587,'city_before','2024-05-01 11:18:40','Insert New Row'),(2588,'city_after','2024-05-01 11:18:40','city_postal_code: 478, city_name: Elduvík\r'),(2589,'city_before','2024-05-01 11:18:40','Insert New Row'),(2590,'city_after','2024-05-01 11:18:40','city_postal_code: 480, city_name: Skáli\r'),(2591,'city_before','2024-05-01 11:18:40','Insert New Row'),(2592,'city_after','2024-05-01 11:18:40','city_postal_code: 485, city_name: Skálafjørdur\r'),(2593,'city_before','2024-05-01 11:18:40','Insert New Row'),(2594,'city_after','2024-05-01 11:18:40','city_postal_code: 490, city_name: Strendur\r'),(2595,'city_before','2024-05-01 11:18:40','Insert New Row'),(2596,'city_after','2024-05-01 11:18:40','city_postal_code: 494, city_name: Innan Glyvur\r'),(2597,'city_before','2024-05-01 11:18:40','Insert New Row'),(2598,'city_after','2024-05-01 11:18:40','city_postal_code: 495, city_name: Kolbanargjógv\r'),(2599,'city_before','2024-05-01 11:18:40','Insert New Row'),(2600,'city_after','2024-05-01 11:18:40','city_postal_code: 496, city_name: Morskranes\r'),(2601,'city_before','2024-05-01 11:18:40','Insert New Row'),(2602,'city_after','2024-05-01 11:18:40','city_postal_code: 497, city_name: Selatrad\r'),(2603,'city_before','2024-05-01 11:18:40','Insert New Row'),(2604,'city_after','2024-05-01 11:18:40','city_postal_code: 510, city_name: Gøta\r'),(2605,'city_before','2024-05-01 11:18:40','Insert New Row'),(2606,'city_after','2024-05-01 11:18:40','city_postal_code: 511, city_name: Gøtugjógv\r'),(2607,'city_before','2024-05-01 11:18:40','Insert New Row'),(2608,'city_after','2024-05-01 11:18:40','city_postal_code: 512, city_name: Nordragøta\r'),(2609,'city_before','2024-05-01 11:18:40','Insert New Row'),(2610,'city_after','2024-05-01 11:18:40','city_postal_code: 513, city_name: Sydrugøta\r'),(2611,'city_before','2024-05-01 11:18:40','Insert New Row'),(2612,'city_after','2024-05-01 11:18:40','city_postal_code: 515, city_name: Gøta\r'),(2613,'city_before','2024-05-01 11:18:40','Insert New Row'),(2614,'city_after','2024-05-01 11:18:40','city_postal_code: 520, city_name: Leirvík\r'),(2615,'city_before','2024-05-01 11:18:40','Insert New Row'),(2616,'city_after','2024-05-01 11:18:40','city_postal_code: 530, city_name: Fuglafjørdur\r'),(2617,'city_before','2024-05-01 11:18:40','Insert New Row'),(2618,'city_after','2024-05-01 11:18:40','city_postal_code: 535, city_name: Fuglafjørdur\r'),(2619,'city_before','2024-05-01 11:18:40','Insert New Row'),(2620,'city_after','2024-05-01 11:18:40','city_postal_code: 600, city_name: Saltangará\r'),(2621,'city_before','2024-05-01 11:18:40','Insert New Row'),(2622,'city_after','2024-05-01 11:18:40','city_postal_code: 610, city_name: Saltangará\r'),(2623,'city_before','2024-05-01 11:18:40','Insert New Row'),(2624,'city_after','2024-05-01 11:18:40','city_postal_code: 620, city_name: Runavík\r'),(2625,'city_before','2024-05-01 11:18:40','Insert New Row'),(2626,'city_after','2024-05-01 11:18:40','city_postal_code: 625, city_name: Glyvrar\r'),(2627,'city_before','2024-05-01 11:18:40','Insert New Row'),(2628,'city_after','2024-05-01 11:18:40','city_postal_code: 626, city_name: Lambareidi\r'),(2629,'city_before','2024-05-01 11:18:40','Insert New Row'),(2630,'city_after','2024-05-01 11:18:40','city_postal_code: 627, city_name: Lambi\r'),(2631,'city_before','2024-05-01 11:18:40','Insert New Row'),(2632,'city_after','2024-05-01 11:18:40','city_postal_code: 640, city_name: Rituvík\r'),(2633,'city_before','2024-05-01 11:18:40','Insert New Row'),(2634,'city_after','2024-05-01 11:18:40','city_postal_code: 645, city_name: Æduvík\r'),(2635,'city_before','2024-05-01 11:18:40','Insert New Row'),(2636,'city_after','2024-05-01 11:18:40','city_postal_code: 650, city_name: Toftir\r'),(2637,'city_before','2024-05-01 11:18:40','Insert New Row'),(2638,'city_after','2024-05-01 11:18:40','city_postal_code: 655, city_name: Nes'),(2639,'city_before','2024-05-01 11:18:40','Insert New Row'),(2640,'city_after','2024-05-01 11:18:40','city_postal_code: 656, city_name: Saltnes\r'),(2641,'city_before','2024-05-01 11:18:40','Insert New Row'),(2642,'city_after','2024-05-01 11:18:40','city_postal_code: 660, city_name: Søldarfjørdur\r'),(2643,'city_before','2024-05-01 11:18:40','Insert New Row'),(2644,'city_after','2024-05-01 11:18:40','city_postal_code: 665, city_name: Skipanes\r'),(2645,'city_before','2024-05-01 11:18:40','Insert New Row'),(2646,'city_after','2024-05-01 11:18:40','city_postal_code: 666, city_name: Gøtueidi\r'),(2647,'city_before','2024-05-01 11:18:40','Insert New Row'),(2648,'city_after','2024-05-01 11:18:40','city_postal_code: 690, city_name: Oyndarfjørdur\r'),(2649,'city_before','2024-05-01 11:18:40','Insert New Row'),(2650,'city_after','2024-05-01 11:18:40','city_postal_code: 695, city_name: Hellur\r'),(2651,'city_before','2024-05-01 11:18:40','Insert New Row'),(2652,'city_after','2024-05-01 11:18:40','city_postal_code: 700, city_name: Klaksvík\r'),(2653,'city_before','2024-05-01 11:18:40','Insert New Row'),(2654,'city_after','2024-05-01 11:18:40','city_postal_code: 710, city_name: Klaksvík\r'),(2655,'city_before','2024-05-01 11:18:40','Insert New Row'),(2656,'city_after','2024-05-01 11:18:40','city_postal_code: 725, city_name: Nordoyri\r'),(2657,'city_before','2024-05-01 11:18:40','Insert New Row'),(2658,'city_after','2024-05-01 11:18:40','city_postal_code: 726, city_name: Ánir\r'),(2659,'city_before','2024-05-01 11:18:40','Insert New Row'),(2660,'city_after','2024-05-01 11:18:40','city_postal_code: 727, city_name: Árnafjørdur\r'),(2661,'city_before','2024-05-01 11:18:40','Insert New Row'),(2662,'city_after','2024-05-01 11:18:40','city_postal_code: 730, city_name: Norddepil\r'),(2663,'city_before','2024-05-01 11:18:40','Insert New Row'),(2664,'city_after','2024-05-01 11:18:40','city_postal_code: 735, city_name: Depil\r'),(2665,'city_before','2024-05-01 11:18:40','Insert New Row'),(2666,'city_after','2024-05-01 11:18:40','city_postal_code: 736, city_name: Nordtoftir\r'),(2667,'city_before','2024-05-01 11:18:40','Insert New Row'),(2668,'city_after','2024-05-01 11:18:40','city_postal_code: 737, city_name: Múli\r'),(2669,'city_before','2024-05-01 11:18:40','Insert New Row'),(2670,'city_after','2024-05-01 11:18:40','city_postal_code: 740, city_name: Hvannasund\r'),(2671,'city_before','2024-05-01 11:18:40','Insert New Row'),(2672,'city_after','2024-05-01 11:18:40','city_postal_code: 750, city_name: Vidareidi\r'),(2673,'city_before','2024-05-01 11:18:40','Insert New Row'),(2674,'city_after','2024-05-01 11:18:40','city_postal_code: 765, city_name: Svinoy\r'),(2675,'city_before','2024-05-01 11:18:40','Insert New Row'),(2676,'city_after','2024-05-01 11:18:40','city_postal_code: 766, city_name: Kirkja\r'),(2677,'city_before','2024-05-01 11:18:40','Insert New Row'),(2678,'city_after','2024-05-01 11:18:40','city_postal_code: 767, city_name: Hattarvík\r'),(2679,'city_before','2024-05-01 11:18:40','Insert New Row'),(2680,'city_after','2024-05-01 11:18:40','city_postal_code: 780, city_name: Kunoy\r'),(2681,'city_before','2024-05-01 11:18:40','Insert New Row'),(2682,'city_after','2024-05-01 11:18:40','city_postal_code: 785, city_name: Haraldssund\r'),(2683,'city_before','2024-05-01 11:18:40','Insert New Row'),(2684,'city_after','2024-05-01 11:18:40','city_postal_code: 795, city_name: Sydradalur'),(2685,'city_before','2024-05-01 11:18:40','Insert New Row'),(2686,'city_after','2024-05-01 11:18:40','city_postal_code: 796, city_name: Húsar\r'),(2687,'city_before','2024-05-01 11:18:40','Insert New Row'),(2688,'city_after','2024-05-01 11:18:40','city_postal_code: 797, city_name: Mikladalur\r'),(2689,'city_before','2024-05-01 11:18:40','Insert New Row'),(2690,'city_after','2024-05-01 11:18:40','city_postal_code: 798, city_name: Trøllanes\r'),(2691,'city_before','2024-05-01 11:18:40','Insert New Row'),(2692,'city_after','2024-05-01 11:18:40','city_postal_code: 800, city_name: Tvøroyri\r'),(2693,'city_before','2024-05-01 11:18:40','Insert New Row'),(2694,'city_after','2024-05-01 11:18:40','city_postal_code: 810, city_name: Tvøroyri\r'),(2695,'city_before','2024-05-01 11:18:40','Insert New Row'),(2696,'city_after','2024-05-01 11:18:40','city_postal_code: 825, city_name: Frodba\r'),(2697,'city_before','2024-05-01 11:18:40','Insert New Row'),(2698,'city_after','2024-05-01 11:18:40','city_postal_code: 826, city_name: Trongisvágur\r'),(2699,'city_before','2024-05-01 11:18:40','Insert New Row'),(2700,'city_after','2024-05-01 11:18:40','city_postal_code: 827, city_name: Øravík\r'),(2701,'city_before','2024-05-01 11:18:40','Insert New Row'),(2702,'city_after','2024-05-01 11:18:40','city_postal_code: 850, city_name: Hvalba\r'),(2703,'city_before','2024-05-01 11:18:40','Insert New Row'),(2704,'city_after','2024-05-01 11:18:40','city_postal_code: 860, city_name: Sandvík\r'),(2705,'city_before','2024-05-01 11:18:40','Insert New Row'),(2706,'city_after','2024-05-01 11:18:40','city_postal_code: 870, city_name: Fámjin\r'),(2707,'city_before','2024-05-01 11:18:40','Insert New Row'),(2708,'city_after','2024-05-01 11:18:40','city_postal_code: 900, city_name: Vágur\r'),(2709,'city_before','2024-05-01 11:18:40','Insert New Row'),(2710,'city_after','2024-05-01 11:18:40','city_postal_code: 910, city_name: Vágur\r'),(2711,'city_before','2024-05-01 11:18:40','Insert New Row'),(2712,'city_after','2024-05-01 11:18:40','city_postal_code: 925, city_name: Nes'),(2713,'city_before','2024-05-01 11:18:40','Insert New Row'),(2714,'city_after','2024-05-01 11:18:40','city_postal_code: 926, city_name: Lopra\r'),(2715,'city_before','2024-05-01 11:18:40','Insert New Row'),(2716,'city_after','2024-05-01 11:18:40','city_postal_code: 927, city_name: Akrar\r'),(2717,'city_before','2024-05-01 11:18:40','Insert New Row'),(2718,'city_after','2024-05-01 11:18:40','city_postal_code: 928, city_name: Vikarbyrgi\r'),(2719,'city_before','2024-05-01 11:18:40','Insert New Row'),(2720,'city_after','2024-05-01 11:18:40','city_postal_code: 950, city_name: Porkeri\r'),(2721,'city_before','2024-05-01 11:18:40','Insert New Row'),(2722,'city_after','2024-05-01 11:18:40','city_postal_code: 960, city_name: Hov\r'),(2723,'city_before','2024-05-01 11:18:40','Insert New Row'),(2724,'city_after','2024-05-01 11:18:40','city_postal_code: 970, city_name: Sumba\r'),(2725,'user_before','2024-05-01 11:18:41','Insert New Row'),(2726,'user_after','2024-05-01 11:18:41','user_id: 1, user_first_name: John, user_last_name: Doe, user_username: johndoe, user_password: password123, user_email: john@example.com, user_phone_number: 1234567890'),(2727,'user_before','2024-05-01 11:18:41','Insert New Row'),(2728,'user_after','2024-05-01 11:18:41','user_id: 2, user_first_name: Jane, user_last_name: Smith, user_username: janesmith, user_password: password456, user_email: jane@example.com, user_phone_number: 9876543210'),(2729,'user_before','2024-05-01 11:18:41','Insert New Row'),(2730,'user_after','2024-05-01 11:18:41','user_id: 3, user_first_name: Alice, user_last_name: Johnson, user_username: alicej, user_password: password789, user_email: alice@example.com, user_phone_number: 5555555555'),(2731,'user_before','2024-05-01 11:18:41','Insert New Row'),(2732,'user_after','2024-05-01 11:18:41','user_id: 4, user_first_name: Bob, user_last_name: Brown, user_username: bobb, user_password: passwordabc, user_email: bob@example.com, user_phone_number: 7777777777'),(2733,'user_before','2024-05-01 11:18:41','Insert New Row'),(2734,'user_after','2024-05-01 11:18:41','user_id: 5, user_first_name: Emma, user_last_name: White, user_username: emmaw, user_password: passwordxyz, user_email: emma@example.com, user_phone_number: 9999999999'),(2735,'user_before','2024-05-01 11:18:41','Insert New Row'),(2736,'user_after','2024-05-01 11:18:41','user_id: 6, user_first_name: Michael, user_last_name: Lee, user_username: michaell, user_password: pass123word, user_email: michael@example.com, user_phone_number: 1111111111'),(2737,'user_before','2024-05-01 11:18:41','Insert New Row'),(2738,'user_after','2024-05-01 11:18:41','user_id: 7, user_first_name: Sarah, user_last_name: Taylor, user_username: saraht, user_password: pass456word, user_email: sarah@example.com, user_phone_number: 2222222222'),(2739,'user_before','2024-05-01 11:18:41','Insert New Row'),(2740,'user_after','2024-05-01 11:18:41','user_id: 8, user_first_name: David, user_last_name: Martinez, user_username: davidm, user_password: pass789word, user_email: david@example.com, user_phone_number: 3333333333'),(2741,'user_before','2024-05-01 11:18:41','Insert New Row'),(2742,'user_after','2024-05-01 11:18:41','user_id: 9, user_first_name: Sophia, user_last_name: Garcia, user_username: sophiag, user_password: passabcword, user_email: sophia@example.com, user_phone_number: 4444444444'),(2743,'user_before','2024-05-01 11:18:41','Insert New Row'),(2744,'user_after','2024-05-01 11:18:41','user_id: 10, user_first_name: Daniel, user_last_name: Lopez, user_username: daniell, user_password: passxyzword, user_email: daniel@example.com, user_phone_number: 6666666666'),(2745,'tax_before','2024-05-01 11:18:41','Insert New Row'),(2746,'tax_after','2024-05-01 11:18:41','tax_id: 1, tax_rate: 25.00, tax_name: moms, tax_incoming: 1'),(2747,'taxes_before','2024-05-01 11:18:41','Insert New Row'),(2748,'taxes_after','2024-05-01 11:18:41','pri_id: 1, fk_tax_id: 1, Accumi_tax: 0.00, last_update: 2024-05-01 13:18:41, last_tax_paid: 2024-05-01 13:18:41'),(2749,'pricing_before','2024-05-01 11:18:41','Insert New Row'),(2750,'pricing_after','2024-05-01 11:18:41','pri_id: 1, pri_purchase_price: 50.00, pri_sales_price: 75.00, pri_sale_percentage: 20.00, pri_price_reduction: 10.00'),(2751,'pricing_before','2024-05-01 11:18:41','Insert New Row'),(2752,'pricing_after','2024-05-01 11:18:41','pri_id: 2, pri_purchase_price: 60.00, pri_sales_price: 90.00, pri_sale_percentage: 25.00, pri_price_reduction: 15.00'),(2753,'pricing_before','2024-05-01 11:18:41','Insert New Row'),(2754,'pricing_after','2024-05-01 11:18:41','pri_id: 3, pri_purchase_price: 70.00, pri_sales_price: 100.00, pri_sale_percentage: 30.00, pri_price_reduction: 20.00'),(2755,'pricing_before','2024-05-01 11:18:41','Insert New Row'),(2756,'pricing_after','2024-05-01 11:18:41','pri_id: 4, pri_purchase_price: 80.00, pri_sales_price: 110.00, pri_sale_percentage: 35.00, pri_price_reduction: 25.00'),(2757,'pricing_before','2024-05-01 11:18:41','Insert New Row'),(2758,'pricing_after','2024-05-01 11:18:41','pri_id: 5, pri_purchase_price: 90.00, pri_sales_price: 120.00, pri_sale_percentage: 40.00, pri_price_reduction: 30.00'),(2759,'pricing_before','2024-05-01 11:18:41','Insert New Row'),(2760,'pricing_after','2024-05-01 11:18:41','pri_id: 6, pri_purchase_price: 100.00, pri_sales_price: 130.00, pri_sale_percentage: 45.00, pri_price_reduction: 35.00'),(2761,'pricing_before','2024-05-01 11:18:41','Insert New Row'),(2762,'pricing_after','2024-05-01 11:18:41','pri_id: 7, pri_purchase_price: 110.00, pri_sales_price: 140.00, pri_sale_percentage: 50.00, pri_price_reduction: 40.00'),(2763,'pricing_before','2024-05-01 11:18:41','Insert New Row'),(2764,'pricing_after','2024-05-01 11:18:41','pri_id: 8, pri_purchase_price: 120.00, pri_sales_price: 150.00, pri_sale_percentage: 55.00, pri_price_reduction: 45.00'),(2765,'pricing_before','2024-05-01 11:18:41','Insert New Row'),(2766,'pricing_after','2024-05-01 11:18:41','pri_id: 9, pri_purchase_price: 130.00, pri_sales_price: 160.00, pri_sale_percentage: 60.00, pri_price_reduction: 50.00'),(2767,'pricing_before','2024-05-01 11:18:41','Insert New Row'),(2768,'pricing_after','2024-05-01 11:18:41','pri_id: 10, pri_purchase_price: 140.00, pri_sales_price: 170.00, pri_sale_percentage: 65.00, pri_price_reduction: 55.00'),(2769,'genre_before','2024-05-01 11:18:41','gen_value: Horror'),(2770,'genre_after','2024-05-01 11:18:41','gen_value: Horror'),(2771,'genre_before','2024-05-01 11:18:41','gen_value: Fantasy'),(2772,'genre_after','2024-05-01 11:18:41','gen_value: Fantasy'),(2773,'genre_before','2024-05-01 11:18:41','gen_value: Mystery'),(2774,'genre_after','2024-05-01 11:18:41','gen_value: Mystery'),(2775,'genre_before','2024-05-01 11:18:41','gen_value: Thriller'),(2776,'genre_after','2024-05-01 11:18:41','gen_value: Thriller'),(2777,'genre_before','2024-05-01 11:18:41','gen_value: Romance'),(2778,'genre_after','2024-05-01 11:18:41','gen_value: Romance'),(2779,'genre_before','2024-05-01 11:18:41','gen_value: Science Fiction'),(2780,'genre_after','2024-05-01 11:18:41','gen_value: Science Fiction'),(2781,'genre_before','2024-05-01 11:18:41','gen_value: Historical Fiction'),(2782,'genre_after','2024-05-01 11:18:41','gen_value: Historical Fiction'),(2783,'genre_before','2024-05-01 11:18:41','gen_value: Biography'),(2784,'genre_after','2024-05-01 11:18:41','gen_value: Biography'),(2785,'genre_before','2024-05-01 11:18:41','gen_value: Self-Help'),(2786,'genre_after','2024-05-01 11:18:41','gen_value: Self-Help'),(2787,'genre_before','2024-05-01 11:18:41','gen_value: Adventure'),(2788,'genre_after','2024-05-01 11:18:41','gen_value: Adventure'),(2789,'author_before','2024-05-01 11:18:41','auth_name: Stephen King'),(2790,'author_after','2024-05-01 11:18:41','auth_name: Stephen King'),(2791,'author_before','2024-05-01 11:18:41','auth_name: J.K. Rowling'),(2792,'author_after','2024-05-01 11:18:41','auth_name: J.K. Rowling'),(2793,'author_before','2024-05-01 11:18:41','auth_name: Agatha Christie'),(2794,'author_after','2024-05-01 11:18:41','auth_name: Agatha Christie'),(2795,'author_before','2024-05-01 11:18:41','auth_name: Dan Brown'),(2796,'author_after','2024-05-01 11:18:41','auth_name: Dan Brown'),(2797,'author_before','2024-05-01 11:18:41','auth_name: Jane Austen'),(2798,'author_after','2024-05-01 11:18:41','auth_name: Jane Austen'),(2799,'author_before','2024-05-01 11:18:41','auth_name: George Orwell'),(2800,'author_after','2024-05-01 11:18:41','auth_name: George Orwell'),(2801,'author_before','2024-05-01 11:18:41','auth_name: Harper Lee'),(2802,'author_after','2024-05-01 11:18:41','auth_name: Harper Lee'),(2803,'author_before','2024-05-01 11:18:41','auth_name: J.R.R. Tolkien'),(2804,'author_after','2024-05-01 11:18:41','auth_name: J.R.R. Tolkien'),(2805,'author_before','2024-05-01 11:18:41','auth_name: Charles Dickens'),(2806,'author_after','2024-05-01 11:18:41','auth_name: Charles Dickens'),(2807,'author_before','2024-05-01 11:18:41','auth_name: Leo Tolstoy'),(2808,'author_after','2024-05-01 11:18:41','auth_name: Leo Tolstoy'),(2809,'address_before','2024-05-01 11:18:41','Insert New Row'),(2810,'address_after','2024-05-01 11:18:41','adr_id: 1, adr_postal_code: 4180, adr_user_id: 1, adr_street_address: Strandboulevarden 1, adr_country: Denmark, adr_is_billing_address: 1'),(2811,'address_before','2024-05-01 11:18:41','Insert New Row'),(2812,'address_after','2024-05-01 11:18:41','adr_id: 2, adr_postal_code: 4180, adr_user_id: 2, adr_street_address: Vesterbrogade 2, adr_country: Denmark, adr_is_billing_address: 0'),(2813,'address_before','2024-05-01 11:18:41','Insert New Row'),(2814,'address_after','2024-05-01 11:18:41','adr_id: 3, adr_postal_code: 4180, adr_user_id: 3, adr_street_address: Nørrebrogade 3, adr_country: Denmark, adr_is_billing_address: 1'),(2815,'address_before','2024-05-01 11:18:41','Insert New Row'),(2816,'address_after','2024-05-01 11:18:41','adr_id: 4, adr_postal_code: 4180, adr_user_id: 4, adr_street_address: Sønderboulevard 4, adr_country: Denmark, adr_is_billing_address: 0'),(2817,'address_before','2024-05-01 11:18:41','Insert New Row'),(2818,'address_after','2024-05-01 11:18:41','adr_id: 5, adr_postal_code: 4180, adr_user_id: 5, adr_street_address: Hovedvejen 5, adr_country: Denmark, adr_is_billing_address: 1'),(2819,'address_before','2024-05-01 11:18:41','Insert New Row'),(2820,'address_after','2024-05-01 11:18:41','adr_id: 6, adr_postal_code: 4180, adr_user_id: 6, adr_street_address: Strandvejen 6, adr_country: Denmark, adr_is_billing_address: 0'),(2821,'address_before','2024-05-01 11:18:41','Insert New Row'),(2822,'address_after','2024-05-01 11:18:41','adr_id: 7, adr_postal_code: 4180, adr_user_id: 7, adr_street_address: Parkvej 7, adr_country: Denmark, adr_is_billing_address: 1'),(2823,'address_before','2024-05-01 11:18:41','Insert New Row'),(2824,'address_after','2024-05-01 11:18:41','adr_id: 8, adr_postal_code: 4180, adr_user_id: 8, adr_street_address: Bakkevej 8, adr_country: Denmark, adr_is_billing_address: 0'),(2825,'address_before','2024-05-01 11:18:41','Insert New Row'),(2826,'address_after','2024-05-01 11:18:41','adr_id: 9, adr_postal_code: 4180, adr_user_id: 9, adr_street_address: Skovvej 9, adr_country: Denmark, adr_is_billing_address: 1'),(2827,'address_before','2024-05-01 11:18:41','Insert New Row'),(2828,'address_after','2024-05-01 11:18:41','adr_id: 10, adr_postal_code: 4180, adr_user_id: 10, adr_street_address: Engvej 10, adr_country: Denmark, adr_is_billing_address: 0'),(2829,'order_before','2024-05-01 11:18:41','Insert New Row'),(2830,'order_after','2024-05-01 11:18:41','odr_id: 1, odr_user_id: 1, odr_shipping_date: 2024-04-25 12:00:00, odr_sold_price: 100.00, odr_status: Shipped, '),(2831,'order_before','2024-05-01 11:18:41','Insert New Row'),(2832,'order_after','2024-05-01 11:18:41','odr_id: 2, odr_user_id: 2, odr_shipping_date: 2024-04-26 12:00:00, odr_sold_price: 150.00, odr_status: Processed, '),(2833,'order_before','2024-05-01 11:18:41','Insert New Row'),(2834,'order_after','2024-05-01 11:18:41','odr_id: 3, odr_user_id: 3, odr_shipping_date: 2024-04-27 12:00:00, odr_sold_price: 200.00, odr_status: Shipped, '),(2835,'order_before','2024-05-01 11:18:41','Insert New Row'),(2836,'order_after','2024-05-01 11:18:41','odr_id: 4, odr_user_id: 4, odr_shipping_date: 2024-04-28 12:00:00, odr_sold_price: 250.00, odr_status: Delivered, '),(2837,'order_before','2024-05-01 11:18:41','Insert New Row'),(2838,'order_after','2024-05-01 11:18:41','odr_id: 5, odr_user_id: 5, odr_shipping_date: 2024-04-29 12:00:00, odr_sold_price: 300.00, odr_status: Cancelled, '),(2839,'order_before','2024-05-01 11:18:41','Insert New Row'),(2840,'order_after','2024-05-01 11:18:41','odr_id: 6, odr_user_id: 6, odr_shipping_date: 2024-04-30 12:00:00, odr_sold_price: 350.00, odr_status: Returned, '),(2841,'order_before','2024-05-01 11:18:41','Insert New Row'),(2842,'order_after','2024-05-01 11:18:41','odr_id: 7, odr_user_id: 7, odr_shipping_date: 2024-05-01 12:00:00, odr_sold_price: 400.00, odr_status: Failed, '),(2843,'order_before','2024-05-01 11:18:41','Insert New Row'),(2844,'order_after','2024-05-01 11:18:41','odr_id: 8, odr_user_id: 8, odr_shipping_date: 2024-05-02 12:00:00, odr_sold_price: 450.00, odr_status: On Hold, '),(2845,'order_before','2024-05-01 11:18:41','Insert New Row'),(2846,'order_after','2024-05-01 11:18:41','odr_id: 9, odr_user_id: 9, odr_shipping_date: 2024-05-03 12:00:00, odr_sold_price: 500.00, odr_status: Shipped, '),(2847,'order_before','2024-05-01 11:18:41','Insert New Row'),(2848,'order_after','2024-05-01 11:18:41','odr_id: 10, odr_user_id: 10, odr_shipping_date: 2024-05-04 12:00:00, odr_sold_price: 550.00, odr_status: Processed, '),(2849,'book_before','2024-05-01 11:18:41','Insert New Row'),(2850,'book_after','2024-05-01 11:18:41','bk_id: 1, bk_pricing_id: 1, bk_titel: Sample Book 1, bk_weight: 0.5000, bk_description: This is a sample book description., bk_image: sample1.jpg'),(2851,'book_before','2024-05-01 11:18:41','Insert New Row'),(2852,'book_after','2024-05-01 11:18:41','bk_id: 2, bk_pricing_id: 2, bk_titel: Sample Book 2, bk_weight: 0.6000, bk_description: This is another sample book description., bk_image: sample2.jpg'),(2853,'book_before','2024-05-01 11:18:41','Insert New Row'),(2854,'book_after','2024-05-01 11:18:41','bk_id: 3, bk_pricing_id: 3, bk_titel: Sample Book 3, bk_weight: 0.7000, bk_description: Yet another sample book description., bk_image: sample3.jpg'),(2855,'book_before','2024-05-01 11:18:41','Insert New Row'),(2856,'book_after','2024-05-01 11:18:41','bk_id: 4, bk_pricing_id: 4, bk_titel: Sample Book 4, bk_weight: 0.8000, bk_description: One more sample book description., bk_image: sample4.jpg'),(2857,'book_before','2024-05-01 11:18:41','Insert New Row'),(2858,'book_after','2024-05-01 11:18:41','bk_id: 5, bk_pricing_id: 5, bk_titel: Sample Book 5, bk_weight: 0.9000, bk_description: Final sample book description., bk_image: sample5.jpg'),(2859,'book_before','2024-05-01 11:18:41','Insert New Row'),(2860,'book_after','2024-05-01 11:18:41','bk_id: 6, bk_pricing_id: 6, bk_titel: Sample Book 6, bk_weight: 1.0000, bk_description: Another final sample book description., bk_image: sample6.jpg'),(2861,'book_before','2024-05-01 11:18:41','Insert New Row'),(2862,'book_after','2024-05-01 11:18:41','bk_id: 7, bk_pricing_id: 7, bk_titel: Sample Book 7, bk_weight: 1.1000, bk_description: Almost final sample book description., bk_image: sample7.jpg'),(2863,'book_before','2024-05-01 11:18:41','Insert New Row'),(2864,'book_after','2024-05-01 11:18:41','bk_id: 8, bk_pricing_id: 8, bk_titel: Sample Book 8, bk_weight: 1.2000, bk_description: Nearly there sample book description., bk_image: sample8.jpg'),(2865,'book_before','2024-05-01 11:18:41','Insert New Row'),(2866,'book_after','2024-05-01 11:18:41','bk_id: 9, bk_pricing_id: 9, bk_titel: Sample Book 9, bk_weight: 1.3000, bk_description: Nearly there sample book description., bk_image: sample9.jpg'),(2867,'book_before','2024-05-01 11:18:41','Insert New Row'),(2868,'book_after','2024-05-01 11:18:41','bk_id: 10, bk_pricing_id: 10, bk_titel: Sample Book 10, bk_weight: 1.4000, bk_description: Nearly there sample book description., bk_image: sample10.jpg'),(2869,'book_author_before','2024-05-01 11:18:41','Insert New Row'),(2870,'book_author_after','2024-05-01 11:18:41','ba_id: 1, ba_book_id: 1, ba_author_name: Stephen King'),(2871,'book_author_before','2024-05-01 11:18:41','Insert New Row'),(2872,'book_author_after','2024-05-01 11:18:41','ba_id: 2, ba_book_id: 2, ba_author_name: J.K. Rowling'),(2873,'book_author_before','2024-05-01 11:18:41','Insert New Row'),(2874,'book_author_after','2024-05-01 11:18:41','ba_id: 3, ba_book_id: 3, ba_author_name: Agatha Christie'),(2875,'book_author_before','2024-05-01 11:18:41','Insert New Row'),(2876,'book_author_after','2024-05-01 11:18:41','ba_id: 4, ba_book_id: 4, ba_author_name: Dan Brown'),(2877,'book_author_before','2024-05-01 11:18:41','Insert New Row'),(2878,'book_author_after','2024-05-01 11:18:41','ba_id: 5, ba_book_id: 5, ba_author_name: Jane Austen'),(2879,'book_author_before','2024-05-01 11:18:41','Insert New Row'),(2880,'book_author_after','2024-05-01 11:18:41','ba_id: 6, ba_book_id: 6, ba_author_name: George Orwell'),(2881,'book_author_before','2024-05-01 11:18:41','Insert New Row'),(2882,'book_author_after','2024-05-01 11:18:41','ba_id: 7, ba_book_id: 7, ba_author_name: Harper Lee'),(2883,'book_author_before','2024-05-01 11:18:41','Insert New Row'),(2884,'book_author_after','2024-05-01 11:18:41','ba_id: 8, ba_book_id: 8, ba_author_name: J.R.R. Tolkien'),(2885,'book_author_before','2024-05-01 11:18:41','Insert New Row'),(2886,'book_author_after','2024-05-01 11:18:41','ba_id: 9, ba_book_id: 9, ba_author_name: Charles Dickens'),(2887,'book_author_before','2024-05-01 11:18:41','Insert New Row'),(2888,'book_author_after','2024-05-01 11:18:41','ba_id: 10, ba_book_id: 10, ba_author_name: Leo Tolstoy'),(2889,'book_genre_after','2024-05-01 11:18:41','bg_id: 1, bg_book_id: 1, bg_genre: Horror'),(2890,'book_genre_after','2024-05-01 11:18:41','bg_id: 2, bg_book_id: 2, bg_genre: Fantasy'),(2891,'book_genre_after','2024-05-01 11:18:41','bg_id: 3, bg_book_id: 3, bg_genre: Mystery'),(2892,'book_genre_after','2024-05-01 11:18:41','bg_id: 4, bg_book_id: 4, bg_genre: Thriller'),(2893,'book_genre_after','2024-05-01 11:18:41','bg_id: 5, bg_book_id: 5, bg_genre: Romance'),(2894,'book_genre_after','2024-05-01 11:18:41','bg_id: 6, bg_book_id: 6, bg_genre: Science Fiction'),(2895,'book_genre_after','2024-05-01 11:18:41','bg_id: 7, bg_book_id: 7, bg_genre: Historical Fiction'),(2896,'book_genre_after','2024-05-01 11:18:41','bg_id: 8, bg_book_id: 8, bg_genre: Biography'),(2897,'book_genre_after','2024-05-01 11:18:41','bg_id: 9, bg_book_id: 9, bg_genre: Self-Help'),(2898,'book_genre_after','2024-05-01 11:18:41','bg_id: 10, bg_book_id: 10, bg_genre: Adventure'),(2899,'book_order_after','2024-05-01 11:18:41','bo_id: 1, bo_book_id: 1, bo_ord_id: 1'),(2900,'book_order_after','2024-05-01 11:18:41','bo_id: 2, bo_book_id: 2, bo_ord_id: 2'),(2901,'book_order_after','2024-05-01 11:18:41','bo_id: 3, bo_book_id: 3, bo_ord_id: 3'),(2902,'book_order_after','2024-05-01 11:18:41','bo_id: 4, bo_book_id: 4, bo_ord_id: 4'),(2903,'book_order_after','2024-05-01 11:18:41','bo_id: 5, bo_book_id: 5, bo_ord_id: 5'),(2904,'book_order_after','2024-05-01 11:18:41','bo_id: 6, bo_book_id: 6, bo_ord_id: 6'),(2905,'book_order_after','2024-05-01 11:18:41','bo_id: 7, bo_book_id: 7, bo_ord_id: 7'),(2906,'book_order_after','2024-05-01 11:18:41','bo_id: 8, bo_book_id: 8, bo_ord_id: 8'),(2907,'book_order_after','2024-05-01 11:18:41','bo_id: 9, bo_book_id: 9, bo_ord_id: 9'),(2908,'book_order_after','2024-05-01 11:18:41','bo_id: 10, bo_book_id: 10, bo_ord_id: 10');
/*!40000 ALTER TABLE `br_bogreden_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `br_book`
--

DROP TABLE IF EXISTS `br_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `br_book` (
  `bk_id` int(11) NOT NULL AUTO_INCREMENT,
  `bk_pricing_id` int(11) DEFAULT NULL,
  `bk_titel` varchar(100) DEFAULT NULL,
  `bk_weight` decimal(6,4) DEFAULT NULL,
  `bk_description` text DEFAULT NULL,
  `bk_image` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`bk_id`),
  KEY `bk_pricing_id` (`bk_pricing_id`),
  KEY `idx_book` (`bk_id`,`bk_pricing_id`,`bk_titel`,`bk_weight`),
  CONSTRAINT `br_book_ibfk_1` FOREIGN KEY (`bk_pricing_id`) REFERENCES `br_pricing` (`pri_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `br_book`
--

LOCK TABLES `br_book` WRITE;
/*!40000 ALTER TABLE `br_book` DISABLE KEYS */;
INSERT INTO `br_book` VALUES (1,1,'Sample Book 1',0.5000,'This is a sample book description.','sample1.jpg'),(2,2,'Sample Book 2',0.6000,'This is another sample book description.','sample2.jpg'),(3,3,'Sample Book 3',0.7000,'Yet another sample book description.','sample3.jpg'),(4,4,'Sample Book 4',0.8000,'One more sample book description.','sample4.jpg'),(5,5,'Sample Book 5',0.9000,'Final sample book description.','sample5.jpg'),(6,6,'Sample Book 6',1.0000,'Another final sample book description.','sample6.jpg'),(7,7,'Sample Book 7',1.1000,'Almost final sample book description.','sample7.jpg'),(8,8,'Sample Book 8',1.2000,'Nearly there sample book description.','sample8.jpg'),(9,9,'Sample Book 9',1.3000,'Nearly there sample book description.','sample9.jpg'),(10,10,'Sample Book 10',1.4000,'Nearly there sample book description.','sample10.jpg');
/*!40000 ALTER TABLE `br_book` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_before_insert BEFORE INSERT
    ON br_book FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'book_before',
        CURRENT_TIMESTAMP(),
        'Insert New Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_insert_after AFTER INSERT
    ON br_book FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'book_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'bk_id: ', COALESCE(NEW.bk_id,"NULL"), ', ',
            'bk_pricing_id: ', COALESCE(NEW.bk_pricing_id,"NULL"), ', ',
            'bk_titel: ', COALESCE(NEW.bk_titel,"NULL"), ', ',
            'bk_weight: ', COALESCE(NEW.bk_weight,"NULL"), ', ',
            'bk_description: ', COALESCE(NEW.bk_description,"NULL"), ', ',
            'bk_image: ', COALESCE(NEW.bk_image,"NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_update_before BEFORE UPDATE
ON br_book FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'book_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'bk_id: ', COALESCE(OLD.bk_id, "NULL"), ', ',
            'bk_pricing_id: ', COALESCE(OLD.bk_pricing_id, "NULL"), ', ',
            'bk_titel: ', COALESCE(OLD.bk_titel, "NULL"), ', ',
            'bk_weight: ', COALESCE(OLD.bk_weight, "NULL"), ', ',
            'bk_description: ', COALESCE(OLD.bk_description, "NULL"), ', ',
            'bk_image: ', COALESCE(OLD.bk_image, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_bookupdate__after AFTER UPDATE
ON br_book FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'book_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'bk_id: ', COALESCE(NEW.bk_id, "NULL"), ', ',
            'bk_pricing_id: ', COALESCE(NEW.bk_pricing_id, "NULL"), ', ',
            'bk_titel: ', COALESCE(NEW.bk_titel, "NULL"), ', ',
            'bk_weight: ', COALESCE(NEW.bk_weight, "NULL"), ', ',
            'bk_description: ', COALESCE(NEW.bk_description, "NULL"), ', ',
            'bk_image: ', COALESCE(NEW.bk_image, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_before_delete BEFORE DELETE
ON br_book FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'book_after',
        CURRENT_TIMESTAMP(),
        'Deleting Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_delete_after AFTER DELETE
ON br_book FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'book_after',
        CURRENT_TIMESTAMP(),
        'Row Deleted'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `br_book_author`
--

DROP TABLE IF EXISTS `br_book_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `br_book_author` (
  `ba_id` int(11) NOT NULL AUTO_INCREMENT,
  `ba_book_id` int(11) DEFAULT NULL,
  `ba_author_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ba_id`),
  KEY `ba_book_id` (`ba_book_id`),
  KEY `ba_author_name` (`ba_author_name`),
  KEY `idx_book_author` (`ba_id`,`ba_book_id`,`ba_author_name`),
  CONSTRAINT `br_book_author_ibfk_1` FOREIGN KEY (`ba_book_id`) REFERENCES `br_book` (`bk_id`),
  CONSTRAINT `br_book_author_ibfk_2` FOREIGN KEY (`ba_author_name`) REFERENCES `br_author` (`auth_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `br_book_author`
--

LOCK TABLES `br_book_author` WRITE;
/*!40000 ALTER TABLE `br_book_author` DISABLE KEYS */;
INSERT INTO `br_book_author` VALUES (1,1,'Stephen King'),(2,2,'J.K. Rowling'),(3,3,'Agatha Christie'),(4,4,'Dan Brown'),(5,5,'Jane Austen'),(6,6,'George Orwell'),(7,7,'Harper Lee'),(8,8,'J.R.R. Tolkien'),(9,9,'Charles Dickens'),(10,10,'Leo Tolstoy');
/*!40000 ALTER TABLE `br_book_author` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_author_before_insert BEFORE INSERT
    ON br_book_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'book_author_before',
        CURRENT_TIMESTAMP(),
        'Insert New Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_author_insert_after AFTER INSERT
    ON br_book_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'book_author_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'ba_id: ', COALESCE(NEW.ba_id,"NULL"), ', ',
            'ba_book_id: ', COALESCE(NEW.ba_book_id,"NULL"), ', ',
            'ba_author_name: ', COALESCE(NEW.ba_author_name,"NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_author_update_before BEFORE UPDATE
ON br_book_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'book_author_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'ba_id: ', COALESCE(OLD.ba_id, "NULL"), ', ',
            'ba_book_id: ', COALESCE(OLD.ba_book_id, "NULL"), ', ',
            'ba_author_name: ', COALESCE(OLD.ba_author_name, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_authorupdate__after AFTER UPDATE
ON br_book_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'book_author_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'ba_id: ', COALESCE(NEW.ba_id, "NULL"), ', ',
            'ba_book_id: ', COALESCE(NEW.ba_book_id, "NULL"), ', ',
            'ba_author_name: ', COALESCE(NEW.ba_author_name, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_author_before_delete BEFORE DELETE
ON br_book_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'book_author_after',
        CURRENT_TIMESTAMP(),
        'Deleting Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_author_delete_after AFTER DELETE
ON br_book_author FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'book_author_after',
        CURRENT_TIMESTAMP(),
        'Row Deleted'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `br_book_genre`
--

DROP TABLE IF EXISTS `br_book_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `br_book_genre` (
  `bg_id` int(11) NOT NULL AUTO_INCREMENT,
  `bg_book_id` int(11) DEFAULT NULL,
  `bg_genre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`bg_id`),
  KEY `bg_book_id` (`bg_book_id`),
  KEY `bg_genre` (`bg_genre`),
  KEY `idx_book_genre` (`bg_id`,`bg_book_id`,`bg_genre`),
  CONSTRAINT `br_book_genre_ibfk_1` FOREIGN KEY (`bg_book_id`) REFERENCES `br_book` (`bk_id`),
  CONSTRAINT `br_book_genre_ibfk_2` FOREIGN KEY (`bg_genre`) REFERENCES `br_genre` (`gen_value`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `br_book_genre`
--

LOCK TABLES `br_book_genre` WRITE;
/*!40000 ALTER TABLE `br_book_genre` DISABLE KEYS */;
INSERT INTO `br_book_genre` VALUES (1,1,'Horror'),(2,2,'Fantasy'),(3,3,'Mystery'),(4,4,'Thriller'),(5,5,'Romance'),(6,6,'Science Fiction'),(7,7,'Historical Fiction'),(8,8,'Biography'),(9,9,'Self-Help'),(10,10,'Adventure');
/*!40000 ALTER TABLE `br_book_genre` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_genre_insert_after AFTER INSERT
    ON br_book_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'book_genre_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'bg_id: ', COALESCE(NEW.bg_id, "NULL"), ', ',
            'bg_book_id: ', COALESCE(NEW.bg_book_id, "NULL"), ', ',
            'bg_genre: ', COALESCE(NEW.bg_genre, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_genre_update_before BEFORE UPDATE
ON br_book_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'book_genre_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'bg_id: ', COALESCE(OLD.bg_id, "NULL"), ', ',
            'bg_book_id: ', COALESCE(OLD.bg_book_id, "NULL"), ', ',
            'bg_genre: ', COALESCE(OLD.bg_genre, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_genreupdate__after AFTER UPDATE
ON br_book_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'book_genre_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'bg_id: ', COALESCE(NEW.bg_id, "NULL"), ', ',
            'bg_book_id: ', COALESCE(NEW.bg_book_id, "NULL"), ', ',
            'bg_genre: ', COALESCE(NEW.bg_genre, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_genre_before_delete BEFORE DELETE
ON br_book_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'book_genre_after',
        CURRENT_TIMESTAMP(),
        'Deleting Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_genre_delete_after AFTER DELETE
ON br_book_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'book_genre_after',
        CURRENT_TIMESTAMP(),
        'Row Deleted'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `br_book_order`
--

DROP TABLE IF EXISTS `br_book_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `br_book_order` (
  `bo_id` int(11) NOT NULL AUTO_INCREMENT,
  `bo_book_id` int(11) DEFAULT NULL,
  `bo_ord_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`bo_id`),
  KEY `bo_book_id` (`bo_book_id`),
  KEY `bo_ord_id` (`bo_ord_id`),
  KEY `idx_book_order` (`bo_id`,`bo_book_id`,`bo_ord_id`),
  CONSTRAINT `br_book_order_ibfk_1` FOREIGN KEY (`bo_book_id`) REFERENCES `br_book` (`bk_id`),
  CONSTRAINT `br_book_order_ibfk_2` FOREIGN KEY (`bo_ord_id`) REFERENCES `br_order` (`odr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `br_book_order`
--

LOCK TABLES `br_book_order` WRITE;
/*!40000 ALTER TABLE `br_book_order` DISABLE KEYS */;
INSERT INTO `br_book_order` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10);
/*!40000 ALTER TABLE `br_book_order` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_order_insert_after AFTER INSERT
    ON br_book_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'book_order_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'bo_id: ', COALESCE(NEW.bo_id, "NULL"), ', ',
            'bo_book_id: ', COALESCE(NEW.bo_book_id, "NULL"), ', ',
            'bo_ord_id: ', COALESCE(NEW.bo_ord_id, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_order_update_before BEFORE UPDATE
ON br_book_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'book_order_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'bo_id: ', COALESCE(OLD.bo_id, "NULL"), ', ',
            'bo_book_id: ', COALESCE(OLD.bo_book_id, "NULL"), ', ',
            'bo_ord_id: ', COALESCE(OLD.bo_ord_id, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_orderupdate__after AFTER UPDATE
ON br_book_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'book_order_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'bo_id: ', COALESCE(NEW.bo_id, "NULL"), ', ',
            'bo_book_id: ', COALESCE(NEW.bo_book_id, "NULL"), ', ',
            'bo_ord_id: ', COALESCE(NEW.bo_ord_id, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_order_before_delete BEFORE DELETE
ON br_book_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'book_order_after',
        CURRENT_TIMESTAMP(),
        'Deleting Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_book_order_delete_after AFTER DELETE
ON br_book_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'book_order_after',
        CURRENT_TIMESTAMP(),
        'Row Deleted'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `br_city`
--

DROP TABLE IF EXISTS `br_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `br_city` (
  `city_postal_code` varchar(15) NOT NULL,
  `city_name` varchar(200) NOT NULL,
  PRIMARY KEY (`city_postal_code`),
  KEY `idx_city` (`city_postal_code`,`city_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `br_city`
--

LOCK TABLES `br_city` WRITE;
/*!40000 ALTER TABLE `br_city` DISABLE KEYS */;
INSERT INTO `br_city` VALUES ('0555','Scanning\r'),('0783','Facility\r'),('0784','H&M\r'),('0785','Bestseller \r'),('0800','Høje Taastrup\r'),('0877','København C\r'),('0892','Sjælland USF P\r'),('0893','Sjælland USF B\r'),('0894','Udbetaling\r'),('0899','Kommuneservice\r'),('0900','København C\r'),('0910','København C\r'),('0913','Københavns Pakkecenter\r'),('0914','Københavns Pakkecenter\r'),('0917','Københavns Pakkecenter\r'),('0918','Københavns Pakke BRC\r'),('0919','Returprint BRC\r'),('0929','København C\r'),('0960','Internationalt Postcenter\r'),('0999','København C\r'),('100','Tórshavn\r'),('1001','København K\r'),('1002','København K\r'),('1003','København K\r'),('1004','København K\r'),('1005','København K\r'),('1006','København K\r'),('1007','København K\r'),('1008','København K\r'),('1009','København K\r'),('1010','København K\r'),('1011','København K\r'),('1012','København K\r'),('1013','København K\r'),('1014','København K\r'),('1015','København K\r'),('1016','København K\r'),('1017','København K\r'),('1018','København K\r'),('1019','København K\r'),('1020','København K\r'),('1021','København K\r'),('1022','København K\r'),('1023','København K\r'),('1024','København K\r'),('1025','København K\r'),('1026','København K\r'),('1045','København K\r'),('1050','København K\r'),('1051','København K\r'),('1052','København K\r'),('1053','København K\r'),('1054','København K\r'),('1055','København K\r'),('1056','København K\r'),('1057','København K\r'),('1058','København K\r'),('1059','København K\r'),('1060','København K\r'),('1061','København K\r'),('1062','København K\r'),('1063','København K\r'),('1064','København K\r'),('1065','København K\r'),('1066','København K\r'),('1067','København K\r'),('1068','København K\r'),('1069','København K\r'),('1070','København K\r'),('1071','København K\r'),('1072','København K\r'),('1073','København K\r'),('1074','København K\r'),('1092','København K\r'),('1093','København K\r'),('1095','København K\r'),('1098','København K\r'),('110','Tórshavn \r'),('1100','København K\r'),('1101','København K\r'),('1102','København K\r'),('1103','København K\r'),('1104','København K\r'),('1105','København K\r'),('1106','København K\r'),('1107','København K\r'),('1110','København K\r'),('1111','København K\r'),('1112','København K\r'),('1113','København K\r'),('1114','København K\r'),('1115','København K\r'),('1116','København K\r'),('1117','København K\r'),('1118','København K\r'),('1119','København K\r'),('1120','København K\r'),('1121','København K\r'),('1122','København K\r'),('1123','København K\r'),('1124','København K\r'),('1125','København K\r'),('1126','København K\r'),('1127','København K\r'),('1128','København K\r'),('1129','København K\r'),('1130','København K\r'),('1131','København K\r'),('1140','København K\r'),('1147','København K\r'),('1148','København K\r'),('1150','København K\r'),('1151','København K\r'),('1152','København K\r'),('1153','København K\r'),('1154','København K\r'),('1155','København K\r'),('1156','København K\r'),('1157','København K\r'),('1158','København K\r'),('1159','København K\r'),('1160','København K\r'),('1161','København K\r'),('1162','København K\r'),('1164','København K\r'),('1165','København K\r'),('1166','København K\r'),('1167','København K\r'),('1168','København K\r'),('1169','København K\r'),('1170','København K\r'),('1171','København K\r'),('1172','København K\r'),('1173','København K\r'),('1174','København K\r'),('1175','København K\r'),('1200','København K\r'),('1201','København K\r'),('1202','København K\r'),('1203','København K\r'),('1204','København K\r'),('1205','København K\r'),('1206','København K\r'),('1207','København K\r'),('1208','København K\r'),('1209','København K\r'),('1210','København K\r'),('1211','København K\r'),('1212','København K\r'),('1213','København K\r'),('1214','København K\r'),('1215','København K\r'),('1216','København K\r'),('1217','København K\r'),('1218','København K\r'),('1219','København K\r'),('1220','København K\r'),('1221','København K\r'),('1240','København K\r'),('1250','København K\r'),('1251','København K\r'),('1252','København K\r'),('1253','København K\r'),('1254','København K\r'),('1255','København K\r'),('1256','København K\r'),('1257','København K\r'),('1259','København K\r'),('1260','København K\r'),('1261','København K\r'),('1263','København K\r'),('1264','København K\r'),('1265','København K\r'),('1266','København K\r'),('1267','København K\r'),('1268','København K\r'),('1270','København K\r'),('1271','København K\r'),('1300','København K\r'),('1301','København K\r'),('1302','København K\r'),('1303','København K\r'),('1304','København K\r'),('1306','København K\r'),('1307','København K\r'),('1308','København K\r'),('1309','København K\r'),('1310','København K\r'),('1311','København K\r'),('1312','København K\r'),('1313','København K\r'),('1314','København K\r'),('1315','København K\r'),('1316','København K\r'),('1317','København K\r'),('1318','København K\r'),('1319','København K\r'),('1320','København K\r'),('1321','København K\r'),('1322','København K\r'),('1323','København K\r'),('1324','København K\r'),('1325','København K\r'),('1326','København K\r'),('1327','København K\r'),('1328','København K\r'),('1329','København K\r'),('1350','København K\r'),('1352','København K\r'),('1353','København K\r'),('1354','København K\r'),('1355','København K\r'),('1356','København K\r'),('1357','København K\r'),('1358','København K\r'),('1359','København K\r'),('1360','København K\r'),('1361','København K\r'),('1362','København K\r'),('1363','København K\r'),('1364','København K\r'),('1365','København K\r'),('1366','København K\r'),('1367','København K\r'),('1368','København K\r'),('1369','København K\r'),('1370','København K\r'),('1371','København K\r'),('1400','København K\r'),('1401','København K\r'),('1402','København K\r'),('1403','København K\r'),('1406','København K\r'),('1407','København K\r'),('1408','København K\r'),('1409','København K\r'),('1410','København K\r'),('1411','København K\r'),('1412','København K\r'),('1413','København K\r'),('1414','København K\r'),('1415','København K\r'),('1416','København K\r'),('1417','København K\r'),('1418','København K\r'),('1419','København K\r'),('1420','København K\r'),('1421','København K\r'),('1422','København K\r'),('1423','København K\r'),('1424','København K\r'),('1425','København K\r'),('1426','København K\r'),('1427','København K\r'),('1428','København K\r'),('1429','København K\r'),('1430','København K\r'),('1432','København K\r'),('1433','København K\r'),('1434','København K\r'),('1435','København K\r'),('1436','København K\r'),('1437','København K\r'),('1438','København K\r'),('1439','København K\r'),('1440','København K\r'),('1441','København K\r'),('1448','København K\r'),('1450','København K\r'),('1451','København K\r'),('1452','København K\r'),('1453','København K\r'),('1454','København K\r'),('1455','København K\r'),('1456','København K\r'),('1457','København K\r'),('1458','København K\r'),('1459','København K\r'),('1460','København K\r'),('1461','København K\r'),('1462','København K\r'),('1463','København K\r'),('1464','København K\r'),('1465','København K\r'),('1466','København K\r'),('1467','København K\r'),('1468','København K\r'),('1470','København K\r'),('1471','København K\r'),('1472','København K\r'),('1473','København K\r'),('1500','København V\r'),('1501','København V\r'),('1502','København V\r'),('1503','København V\r'),('1504','København V\r'),('1505','København V\r'),('1506','København V\r'),('1507','København V\r'),('1508','København V\r'),('1509','København V\r'),('1510','København V\r'),('1512','Returpost\r'),('1513','Flytninger og Nejtak\r'),('1532','København V\r'),('1533','København V\r'),('1550','København V\r'),('1551','København V\r'),('1552','København V\r'),('1553','København V\r'),('1554','København V\r'),('1555','København V\r'),('1556','København V\r'),('1557','København V\r'),('1558','København V\r'),('1559','København V\r'),('1560','København V\r'),('1561','København V\r'),('1562','København V\r'),('1563','København V\r'),('1564','København V\r'),('1567','København V\r'),('1568','København V\r'),('1569','København V\r'),('1570','København V\r'),('1571','København V\r'),('1572','København V\r'),('1573','København V\r'),('1574','København V\r'),('1575','København V\r'),('1576','København V\r'),('1577','København V\r'),('1592','København V\r'),('1599','København V\r'),('160','Argir\r'),('1600','København V\r'),('1601','København V\r'),('1602','København V\r'),('1603','København V\r'),('1604','København V\r'),('1605','København V\r'),('1606','København V\r'),('1607','København V\r'),('1608','København V\r'),('1609','København V\r'),('1610','København V\r'),('1611','København V\r'),('1612','København V\r'),('1613','København V\r'),('1614','København V\r'),('1615','København V\r'),('1616','København V\r'),('1617','København V\r'),('1618','København V\r'),('1619','København V\r'),('1620','København V\r'),('1621','København V\r'),('1622','København V\r'),('1623','København V\r'),('1624','København V\r'),('1630','København V\r'),('1631','København V\r'),('1632','København V\r'),('1633','København V\r'),('1634','København V\r'),('1635','København V\r'),('165','Argir \r'),('1650','København V\r'),('1651','København V\r'),('1652','København V\r'),('1653','København V\r'),('1654','København V\r'),('1655','København V\r'),('1656','København V\r'),('1657','København V\r'),('1658','København V\r'),('1659','København V\r'),('1660','København V\r'),('1661','København V\r'),('1662','København V\r'),('1663','København V\r'),('1664','København V\r'),('1665','København V\r'),('1666','København V\r'),('1667','København V\r'),('1668','København V\r'),('1669','København V\r'),('1670','København V\r'),('1671','København V\r'),('1672','København V\r'),('1673','København V\r'),('1674','København V\r'),('1675','København V\r'),('1676','København V\r'),('1677','København V\r'),('1699','København V\r'),('1700','København V\r'),('1701','København V\r'),('1702','København V\r'),('1703','København V\r'),('1704','København V\r'),('1705','København V\r'),('1706','København V\r'),('1707','København V\r'),('1708','København V\r'),('1709','København V\r'),('1710','København V\r'),('1711','København V\r'),('1712','København V\r'),('1714','København V\r'),('1715','København V\r'),('1716','København V\r'),('1717','København V\r'),('1718','København V\r'),('1719','København V\r'),('1720','København V\r'),('1721','København V\r'),('1722','København V\r'),('1723','København V\r'),('1724','København V\r'),('1725','København V\r'),('1726','København V\r'),('1727','København V\r'),('1728','København V\r'),('1729','København V\r'),('1730','København V\r'),('1731','København V\r'),('1732','København V\r'),('1733','København V\r'),('1734','København V\r'),('1735','København V\r'),('1736','København V\r'),('1737','København V\r'),('1738','København V\r'),('1739','København V\r'),('1749','København V\r'),('175','Kirkjubøur\r'),('1750','København V\r'),('1751','København V\r'),('1752','København V\r'),('1753','København V\r'),('1754','København V\r'),('1755','København V\r'),('1756','København V\r'),('1757','København V\r'),('1758','København V\r'),('1759','København V\r'),('176','Velbastadur\r'),('1760','København V\r'),('1761','København V\r'),('1762','København V\r'),('1763','København V\r'),('1764','København V\r'),('1765','København V\r'),('1766','København V\r'),('177','Sydradalur'),('1770','København V\r'),('1771','København V\r'),('1772','København V\r'),('1773','København V\r'),('1774','København V\r'),('1775','København V\r'),('1777','København V\r'),('178','Nordradalur\r'),('1780','København V\r'),('1782','København V\r'),('1785','København V\r'),('1786','København V\r'),('1787','København V\r'),('1790','København V\r'),('1799','København V\r'),('180','Kaldbak\r'),('1800','Frederiksberg C\r'),('1801','Frederiksberg C\r'),('1802','Frederiksberg C\r'),('1803','Frederiksberg C\r'),('1804','Frederiksberg C\r'),('1805','Frederiksberg C\r'),('1806','Frederiksberg C\r'),('1807','Frederiksberg C\r'),('1808','Frederiksberg C\r'),('1809','Frederiksberg C\r'),('1810','Frederiksberg C\r'),('1811','Frederiksberg C\r'),('1812','Frederiksberg C\r'),('1813','Frederiksberg C\r'),('1814','Frederiksberg C\r'),('1815','Frederiksberg C\r'),('1816','Frederiksberg C\r'),('1817','Frederiksberg C\r'),('1818','Frederiksberg C\r'),('1819','Frederiksberg C\r'),('1820','Frederiksberg C\r'),('1822','Frederiksberg C\r'),('1823','Frederiksberg C\r'),('1824','Frederiksberg C\r'),('1825','Frederiksberg C\r'),('1826','Frederiksberg C\r'),('1827','Frederiksberg C\r'),('1828','Frederiksberg C\r'),('1829','Frederiksberg C\r'),('1835','Frederiksberg C\r'),('185','Kaldbaksbotnur\r'),('1850','Frederiksberg C\r'),('1851','Frederiksberg C\r'),('1852','Frederiksberg C\r'),('1853','Frederiksberg C\r'),('1854','Frederiksberg C\r'),('1855','Frederiksberg C\r'),('1856','Frederiksberg C\r'),('1857','Frederiksberg C\r'),('186','Sund\r'),('1860','Frederiksberg C\r'),('1861','Frederiksberg C\r'),('1862','Frederiksberg C\r'),('1863','Frederiksberg C\r'),('1864','Frederiksberg C\r'),('1865','Frederiksberg C\r'),('1866','Frederiksberg C\r'),('1867','Frederiksberg C\r'),('1868','Frederiksberg C\r'),('187','Hvitanes\r'),('1870','Frederiksberg C\r'),('1871','Frederiksberg C\r'),('1872','Frederiksberg C\r'),('1873','Frederiksberg C\r'),('1874','Frederiksberg C\r'),('1875','Frederiksberg C\r'),('1876','Frederiksberg C\r'),('1877','Frederiksberg C\r'),('1878','Frederiksberg C\r'),('1879','Frederiksberg C\r'),('188','Hoyvík\r'),('1900','Frederiksberg C\r'),('1901','Frederiksberg C\r'),('1902','Frederiksberg C\r'),('1903','Frederiksberg C\r'),('1904','Frederiksberg C\r'),('1905','Frederiksberg C\r'),('1906','Frederiksberg C\r'),('1908','Frederiksberg C\r'),('1909','Frederiksberg C\r'),('1910','Frederiksberg C\r'),('1911','Frederiksberg C\r'),('1912','Frederiksberg C\r'),('1913','Frederiksberg C\r'),('1914','Frederiksberg C\r'),('1915','Frederiksberg C\r'),('1916','Frederiksberg C\r'),('1917','Frederiksberg C\r'),('1920','Frederiksberg C\r'),('1921','Frederiksberg C\r'),('1922','Frederiksberg C\r'),('1923','Frederiksberg C\r'),('1924','Frederiksberg C\r'),('1925','Frederiksberg C\r'),('1926','Frederiksberg C\r'),('1927','Frederiksberg C\r'),('1928','Frederiksberg C\r'),('1931','Frederiksberg C\r'),('1950','Frederiksberg C\r'),('1951','Frederiksberg C\r'),('1952','Frederiksberg C\r'),('1953','Frederiksberg C\r'),('1954','Frederiksberg C\r'),('1955','Frederiksberg C\r'),('1956','Frederiksberg C\r'),('1957','Frederiksberg C\r'),('1958','Frederiksberg C\r'),('1959','Frederiksberg C\r'),('1960','Frederiksberg C\r'),('1961','Frederiksberg C\r'),('1962','Frederiksberg C\r'),('1963','Frederiksberg C\r'),('1964','Frederiksberg C\r'),('1965','Frederiksberg C\r'),('1966','Frederiksberg C\r'),('1967','Frederiksberg C\r'),('1970','Frederiksberg C\r'),('1971','Frederiksberg C\r'),('1972','Frederiksberg C\r'),('1973','Frederiksberg C\r'),('1974','Frederiksberg C\r'),('2000','Frederiksberg\r'),('210','Sandur\r'),('2100','København Ø\r'),('215','Sandur\r'),('2150','Nordhavn\r'),('220','Skálavík\r'),('2200','København N\r'),('230','Húsavík\r'),('2300','København S\r'),('235','Dalur\r'),('236','Skarvanes\r'),('240','Skopun\r'),('2400','København NV\r'),('2412','Grønland\r'),('2450','København SV\r'),('2500','Valby\r'),('260','Skúvoy\r'),('2600','Glostrup\r'),('2605','Brøndby\r'),('2610','Rødovre\r'),('2620','Albertslund\r'),('2625','Vallensbæk\r'),('2630','Taastrup\r'),('2635','Ishøj\r'),('2640','Hedehusene\r'),('2644','Spejdernes Lejr 2022\r'),('2650','Hvidovre\r'),('2660','Brøndby Strand\r'),('2665','Vallensbæk Strand\r'),('2670','Greve\r'),('2680','Solrød Strand\r'),('2690','Karlslunde\r'),('270','Nólsoy\r'),('2700','Brønshøj\r'),('2720','Vanløse\r'),('2730','Herlev\r'),('2740','Skovlunde\r'),('2750','Ballerup\r'),('2760','Måløv\r'),('2765','Smørum\r'),('2770','Kastrup\r'),('2791','Dragør\r'),('280','Hestur\r'),('2800','Kongens Lyngby\r'),('2820','Gentofte\r'),('2830','Virum\r'),('2840','Holte\r'),('285','Koltur\r'),('2850','Nærum\r'),('286','Stóra Dimun\r'),('2860','Søborg\r'),('2870','Dyssegård\r'),('2880','Bagsværd\r'),('2900','Hellerup\r'),('2920','Charlottenlund\r'),('2930','Klampenborg\r'),('2942','Skodsborg\r'),('2950','Vedbæk\r'),('2960','Rungsted Kyst\r'),('2970','Hørsholm\r'),('2980','Kokkedal\r'),('2990','Nivå\r'),('3000','Helsingør\r'),('3050','Humlebæk\r'),('3060','Espergærde\r'),('3070','Snekkersten\r'),('3080','Tikøb\r'),('3100','Hornbæk\r'),('3120','Dronningmølle\r'),('3140','Ålsgårde\r'),('3150','Hellebæk\r'),('3200','Helsinge\r'),('3210','Vejby\r'),('3220','Tisvildeleje\r'),('3230','Græsted\r'),('3250','Gilleleje\r'),('330','Stykkid\r'),('3300','Frederiksværk\r'),('3310','Ølsted\r'),('3320','Skævinge\r'),('3330','Gørløse\r'),('335','Leynar\r'),('336','Skællingur\r'),('3360','Liseleje\r'),('3370','Melby\r'),('3390','Hundested\r'),('340','Kvívík\r'),('3400','Hillerød\r'),('3450','Allerød\r'),('3460','Birkerød\r'),('3480','Fredensborg\r'),('3490','Kvistgård\r'),('350','Vestmanna\r'),('3500','Værløse\r'),('3520','Farum\r'),('3540','Lynge\r'),('355','Vestmanna\r'),('3550','Slangerup\r'),('358','Válur\r'),('360','Sandavágur\r'),('3600','Frederikssund\r'),('3630','Jægerspris\r'),('3650','Ølstykke\r'),('3660','Stenløse\r'),('3670','Veksø Sjælland\r'),('370','Midvágur\r'),('3700','Rønne\r'),('3720','Aakirkeby\r'),('3730','Nexø\r'),('3740','Svaneke\r'),('375','Midvágur\r'),('3751','Østermarie\r'),('3760','Gudhjem\r'),('3770','Allinge\r'),('3782','Klemensker\r'),('3790','Hasle\r'),('380','Sørvágur\r'),('385','Vatnsoyrar\r'),('386','Bøur\r'),('387','Gásadalur\r'),('388','Mykines\r'),('3900','Nuuk\r'),('3905','Nuussuaq\r'),('3910','Kangerlussuaq\r'),('3911','Sisimiut\r'),('3912','Maniitsoq\r'),('3913','Tasiilaq\r'),('3915','Kulusuk\r'),('3919','Alluitsup Paa\r'),('3920','Qaqortoq\r'),('3921','Narsaq\r'),('3922','Nanortalik\r'),('3923','Narsarsuaq\r'),('3924','Ikerasassuaq\r'),('3930','Kangilinnguit\r'),('3932','Arsuk\r'),('3940','Paamiut\r'),('3950','Aasiaat\r'),('3951','Qasigiannguit\r'),('3952','Ilulissat\r'),('3953','Qeqertarsuaq\r'),('3955','Kangaatsiaq\r'),('3961','Uummannaq\r'),('3962','Upernavik\r'),('3964','Qaarsut\r'),('3970','Pituffik\r'),('3971','Qaanaaq\r'),('3972','Station Nord\r'),('3980','Ittoqqortoormiit\r'),('3982','Mestersvig\r'),('3984','Danmarkshavn\r'),('3985','Constable Pynt\r'),('3992','Slædepatrulje Sirius\r'),('400','Oyrarbakki\r'),('4000','Roskilde\r'),('4030','Tune\r'),('4040','Jyllinge\r'),('405','Oyrarbakki\r'),('4050','Skibby\r'),('4060','Kirke Såby\r'),('4070','Kirke Hyllinge\r'),('410','Kollafjørdur\r'),('4100','Ringsted\r'),('4129','Ringsted\r'),('4130','Viby Sjælland\r'),('4140','Borup\r'),('415','Oyrareingir\r'),('416','Signabøur\r'),('4160','Herlufmagle\r'),('4171','Glumsø\r'),('4173','Fjenneslev\r'),('4174','Jystrup Midtsj\r'),('4180','Sorø\r'),('4190','Munke Bjergby\r'),('420','Hósvík\r'),('4200','Slagelse\r'),('4220','Korsør\r'),('4230','Skælskør\r'),('4241','Vemmelev\r'),('4242','Boeslunde\r'),('4243','Rude\r'),('4244','Agersø\r'),('4245','Omø\r'),('4250','Fuglebjerg\r'),('4261','Dalmose\r'),('4262','Sandved\r'),('4270','Høng\r'),('4281','Gørlev\r'),('4291','Ruds Vedby\r'),('4293','Dianalund\r'),('4295','Stenlille\r'),('4296','Nyrup\r'),('430','Hvalvík\r'),('4300','Holbæk\r'),('4305','Orø\r'),('4320','Lejre\r'),('4330','Hvalsø\r'),('4340','Tølløse\r'),('435','Streymnes\r'),('4350','Ugerløse\r'),('436','Saksun\r'),('4360','Kirke Eskilstrup\r'),('437','Nesvík\r'),('4370','Store Merløse\r'),('438','Langasandur\r'),('4390','Vipperød\r'),('440','Haldarsvík\r'),('4400','Kalundborg\r'),('4420','Regstrup\r'),('4440','Mørkøv\r'),('445','Tjørnuvík\r'),('4450','Jyderup\r'),('4460','Snertinge\r'),('4470','Svebølle\r'),('4480','Store Fuglede\r'),('4490','Jerslev Sjælland\r'),('450','Oyri\r'),('4500','Nykøbing Sj\r'),('4520','Svinninge\r'),('4532','Gislinge\r'),('4534','Hørve\r'),('4540','Fårevejle\r'),('4550','Asnæs\r'),('4560','Vig\r'),('4571','Grevinge\r'),('4572','Nørre Asmindrup\r'),('4573','Højby\r'),('4581','Rørvig\r'),('4583','Sjællands Odde\r'),('4591','Føllenslev\r'),('4592','Sejerø\r'),('4593','Eskebjerg\r'),('460','Nordskáli\r'),('4600','Køge\r'),('4621','Gadstrup\r'),('4622','Havdrup\r'),('4623','Lille Skensved\r'),('4632','Bjæverskov\r'),('4640','Faxe\r'),('465','Svináir\r'),('4652','Hårlev\r'),('4653','Karise\r'),('4654','Faxe Ladeplads\r'),('466','Ljósá\r'),('4660','Store Heddinge\r'),('4671','Strøby\r'),('4672','Klippinge\r'),('4673','Rødvig Stevns\r'),('4681','Herfølge\r'),('4682','Tureby\r'),('4683','Rønnede\r'),('4684','Holmegaard\r'),('4690','Haslev\r'),('470','Eidi\r'),('4700','Næstved\r'),('4720','Præstø\r'),('4733','Tappernøje\r'),('4735','Mern\r'),('4736','Karrebæksminde\r'),('475','Funningur\r'),('4750','Lundby\r'),('476','Gjógv\r'),('4760','Vordingborg\r'),('477','Funningsfjørdur\r'),('4771','Kalvehave\r'),('4772','Langebæk\r'),('4773','Stensved\r'),('478','Elduvík\r'),('4780','Stege\r'),('4791','Borre\r'),('4792','Askeby\r'),('4793','Bogø By\r'),('480','Skáli\r'),('4800','Nykøbing F\r'),('4840','Nørre Alslev\r'),('485','Skálafjørdur\r'),('4850','Stubbekøbing\r'),('4862','Guldborg\r'),('4863','Eskilstrup\r'),('4871','Horbelev\r'),('4872','Idestrup\r'),('4873','Væggerløse\r'),('4874','Gedser\r'),('4880','Nysted\r'),('4891','Toreby L\r'),('4892','Kettinge\r'),('4894','Øster Ulslev\r'),('4895','Errindlev\r'),('490','Strendur\r'),('4900','Nakskov\r'),('4912','Harpelunde\r'),('4913','Horslunde\r'),('4920','Søllested\r'),('4930','Maribo\r'),('494','Innan Glyvur\r'),('4941','Bandholm\r'),('4942','Askø og Lilleø\r'),('4943','Torrig L\r'),('4944','Fejø\r'),('4945','Femø\r'),('495','Kolbanargjógv\r'),('4951','Nørreballe\r'),('4952','Stokkemarke\r'),('4953','Vesterborg\r'),('496','Morskranes\r'),('4960','Holeby\r'),('497','Selatrad\r'),('4970','Rødby\r'),('4983','Dannemare\r'),('4990','Sakskøbing\r'),('4992','Midtsjælland USF P\r'),('5000','Odense C\r'),('5029','Odense C\r'),('510','Gøta\r'),('5100','Odense C\r'),('511','Gøtugjógv\r'),('512','Nordragøta\r'),('513','Sydrugøta\r'),('515','Gøta\r'),('520','Leirvík\r'),('5200','Odense V\r'),('5210','Odense NV\r'),('5220','Odense SØ\r'),('5230','Odense M\r'),('5240','Odense NØ\r'),('5250','Odense SV\r'),('5260','Odense S\r'),('5270','Odense N\r'),('5290','Marslev\r'),('530','Fuglafjørdur\r'),('5300','Kerteminde\r'),('5320','Agedrup\r'),('5330','Munkebo\r'),('535','Fuglafjørdur\r'),('5350','Rynkeby\r'),('5370','Mesinge\r'),('5380','Dalby\r'),('5390','Martofte\r'),('5400','Bogense\r'),('5450','Otterup\r'),('5462','Morud\r'),('5463','Harndrup\r'),('5464','Brenderup Fyn\r'),('5466','Asperup\r'),('5471','Søndersø\r'),('5474','Veflinge\r'),('5485','Skamby\r'),('5491','Blommenslyst\r'),('5492','Vissenbjerg\r'),('5500','Middelfart\r'),('5540','Ullerslev\r'),('5550','Langeskov\r'),('5560','Aarup\r'),('5580','Nørre Aaby\r'),('5591','Gelsted\r'),('5592','Ejby\r'),('5600','Faaborg\r'),('5601','Lyø\r'),('5602','Avernakø\r'),('5603','Bjørnø\r'),('5610','Assens\r'),('5620','Glamsbjerg\r'),('5631','Ebberup\r'),('5642','Millinge\r'),('5672','Broby\r'),('5683','Haarby\r'),('5690','Tommerup\r'),('5700','Svendborg\r'),('5750','Ringe\r'),('5762','Vester Skerninge\r'),('5771','Stenstrup\r'),('5772','Kværndrup\r'),('5792','Årslev\r'),('5800','Nyborg\r'),('5853','Ørbæk\r'),('5854','Gislev\r'),('5856','Ryslinge\r'),('5863','Ferritslev Fyn\r'),('5871','Frørup\r'),('5874','Hesselager\r'),('5881','Skårup Fyn\r'),('5882','Vejstrup\r'),('5883','Oure\r'),('5884','Gudme\r'),('5892','Gudbjerg Sydfyn\r'),('5900','Rudkøbing\r'),('5932','Humble\r'),('5935','Bagenkop\r'),('5943','Strynø\r'),('5953','Tranekær\r'),('5960','Marstal\r'),('5965','Birkholm\r'),('5970','Ærøskøbing\r'),('5985','Søby Ærø\r'),('600','Saltangará\r'),('6000','Kolding\r'),('6040','Egtved\r'),('6051','Almind\r'),('6052','Viuf\r'),('6064','Jordrup\r'),('6070','Christiansfeld\r'),('6091','Bjert\r'),('6092','Sønder Stenderup\r'),('6093','Sjølund\r'),('6094','Hejls\r'),('610','Saltangará\r'),('6100','Haderslev\r'),('620','Runavík\r'),('6200','Aabenraa\r'),('6210','Barsø\r'),('6230','Rødekro\r'),('6240','Løgumkloster\r'),('625','Glyvrar\r'),('626','Lambareidi\r'),('6261','Bredebro\r'),('627','Lambi\r'),('6270','Tønder\r'),('6280','Højer\r'),('6300','Gråsten\r'),('6310','Broager\r'),('6320','Egernsund\r'),('6330','Padborg\r'),('6340','Kruså\r'),('6360','Tinglev\r'),('6372','Bylderup-Bov\r'),('6392','Bolderslev\r'),('640','Rituvík\r'),('6400','Sønderborg\r'),('6430','Nordborg\r'),('6440','Augustenborg\r'),('645','Æduvík\r'),('6470','Sydals\r'),('650','Toftir\r'),('6500','Vojens\r'),('6510','Gram\r'),('6520','Toftlund\r'),('6534','Agerskov\r'),('6535','Branderup J\r'),('6541','Bevtoft\r'),('655','Nes'),('656','Saltnes\r'),('6560','Sommersted\r'),('6580','Vamdrup\r'),('660','Søldarfjørdur\r'),('6600','Vejen\r'),('6621','Gesten\r'),('6622','Bække\r'),('6623','Vorbasse\r'),('6630','Rødding\r'),('6640','Lunderskov\r'),('665','Skipanes\r'),('6650','Brørup\r'),('666','Gøtueidi\r'),('6660','Lintrup\r'),('6670','Holsted\r'),('6682','Hovborg\r'),('6683','Føvling\r'),('6690','Gørding\r'),('6700','Esbjerg\r'),('6701','Esbjerg\r'),('6705','Esbjerg Ø\r'),('6710','Esbjerg V\r'),('6715','Esbjerg N\r'),('6720','Fanø\r'),('6731','Tjæreborg\r'),('6740','Bramming\r'),('6752','Glejbjerg\r'),('6753','Agerbæk\r'),('6760','Ribe\r'),('6771','Gredstedbro\r'),('6780','Skærbæk\r'),('6792','Rømø\r'),('6800','Varde\r'),('6818','Årre\r'),('6823','Ansager\r'),('6830','Nørre Nebel\r'),('6840','Oksbøl\r'),('6851','Janderup Vestj\r'),('6852','Billum\r'),('6853','Vejers Strand\r'),('6854','Henne\r'),('6855','Outrup\r'),('6857','Blåvand\r'),('6862','Tistrup\r'),('6870','Ølgod\r'),('6880','Tarm\r'),('6893','Hemmet\r'),('690','Oyndarfjørdur\r'),('6900','Skjern\r'),('6920','Videbæk\r'),('6933','Kibæk\r'),('6940','Lem St\r'),('695','Hellur\r'),('6950','Ringkøbing\r'),('6960','Hvide Sande\r'),('6971','Spjald\r'),('6973','Ørnhøj\r'),('6980','Tim\r'),('6990','Ulfborg\r'),('700','Klaksvík\r'),('7000','Fredericia\r'),('7007','Fredericia\r'),('7017','Taulov Pakkecenter\r'),('7018','Pakker TLP\r'),('7029','Fredericia\r'),('7080','Børkop\r'),('710','Klaksvík\r'),('7100','Vejle\r'),('7120','Vejle Øst\r'),('7130','Juelsminde\r'),('7140','Stouby\r'),('7150','Barrit\r'),('7160','Tørring\r'),('7171','Uldum\r'),('7173','Vonge\r'),('7182','Bredsten\r'),('7183','Randbøl\r'),('7184','Vandel\r'),('7190','Billund\r'),('7200','Grindsted\r'),('725','Nordoyri\r'),('7250','Hejnsvig\r'),('726','Ánir\r'),('7260','Sønder Omme\r'),('727','Árnafjørdur\r'),('7270','Stakroge\r'),('7280','Sønder Felding\r'),('730','Norddepil\r'),('7300','Jelling\r'),('7321','Gadbjerg\r'),('7323','Give\r'),('7330','Brande\r'),('735','Depil\r'),('736','Nordtoftir\r'),('7361','Ejstrupholm\r'),('7362','Hampen\r'),('737','Múli\r'),('740','Hvannasund\r'),('7400','Herning\r'),('7429','Herning\r'),('7430','Ikast\r'),('7441','Bording\r'),('7442','Engesvang\r'),('7451','Sunds\r'),('7470','Karup J\r'),('7480','Vildbjerg\r'),('7490','Aulum\r'),('750','Vidareidi\r'),('7500','Holstebro\r'),('7540','Haderup\r'),('7550','Sørvad\r'),('7560','Hjerm\r'),('7570','Vemb\r'),('7600','Struer\r'),('7620','Lemvig\r'),('765','Svinoy\r'),('7650','Bøvlingbjerg\r'),('766','Kirkja\r'),('7660','Bækmarksbro\r'),('767','Hattarvík\r'),('7673','Harboøre\r'),('7680','Thyborøn\r'),('7700','Thisted\r'),('7730','Hanstholm\r'),('7741','Frøstrup\r'),('7742','Vesløs\r'),('7752','Snedsted\r'),('7755','Bedsted Thy\r'),('7760','Hurup Thy\r'),('7770','Vestervig\r'),('7790','Thyholm\r'),('780','Kunoy\r'),('7800','Skive\r'),('7830','Vinderup\r'),('7840','Højslev\r'),('785','Haraldssund\r'),('7850','Stoholm Jyll\r'),('7860','Spøttrup\r'),('7870','Roslev\r'),('7884','Fur\r'),('7900','Nykøbing M\r'),('795','Sydradalur'),('7950','Erslev\r'),('796','Húsar\r'),('7960','Karby\r'),('797','Mikladalur\r'),('7970','Redsted M\r'),('798','Trøllanes\r'),('7980','Vils\r'),('7990','Øster Assels\r'),('7992','Sydjylland/Fyn USF P\r'),('7993','Sydjylland/Fyn USF B\r'),('7996','Fakturaservice\r'),('7997','Fakturascanning\r'),('7998','Statsservice\r'),('7999','Kommunepost\r'),('800','Tvøroyri\r'),('8000','Aarhus C\r'),('810','Tvøroyri\r'),('8100','Aarhus C\r'),('8200','Aarhus N\r'),('8210','Aarhus V\r'),('8220','Brabrand\r'),('8229','Risskov Ø\r'),('8230','Åbyhøj\r'),('8240','Risskov\r'),('8245','Risskov Ø\r'),('825','Frodba\r'),('8250','Egå\r'),('826','Trongisvágur\r'),('8260','Viby J\r'),('827','Øravík\r'),('8270','Højbjerg\r'),('8300','Odder\r'),('8305','Samsø\r'),('8310','Tranbjerg J\r'),('8320','Mårslet\r'),('8330','Beder\r'),('8340','Malling\r'),('8350','Hundslund\r'),('8355','Solbjerg\r'),('8361','Hasselager\r'),('8362','Hørning\r'),('8370','Hadsten\r'),('8380','Trige\r'),('8381','Tilst\r'),('8382','Hinnerup\r'),('8400','Ebeltoft\r'),('8410','Rønde\r'),('8420','Knebel\r'),('8444','Balle\r'),('8450','Hammel\r'),('8462','Harlev J\r'),('8464','Galten\r'),('8471','Sabro\r'),('8472','Sporup\r'),('850','Hvalba\r'),('8500','Grenaa\r'),('8520','Lystrup\r'),('8530','Hjortshøj\r'),('8541','Skødstrup\r'),('8543','Hornslet\r'),('8544','Mørke\r'),('8550','Ryomgård\r'),('8560','Kolind\r'),('8570','Trustrup\r'),('8581','Nimtofte\r'),('8585','Glesborg\r'),('8586','Ørum Djurs\r'),('8592','Anholt\r'),('860','Sandvík\r'),('8600','Silkeborg\r'),('8620','Kjellerup\r'),('8632','Lemming\r'),('8641','Sorring\r'),('8643','Ans By\r'),('8653','Them\r'),('8654','Bryrup\r'),('8660','Skanderborg\r'),('8670','Låsby\r'),('8680','Ry\r'),('870','Fámjin\r'),('8700','Horsens\r'),('8721','Daugård\r'),('8722','Hedensted\r'),('8723','Løsning\r'),('8732','Hovedgård\r'),('8740','Brædstrup\r'),('8751','Gedved\r'),('8752','Østbirk\r'),('8762','Flemming\r'),('8763','Rask Mølle\r'),('8765','Klovborg\r'),('8766','Nørre Snede\r'),('8781','Stenderup\r'),('8783','Hornsyld\r'),('8789','Endelave\r'),('8799','Tunø\r'),('8800','Viborg\r'),('8830','Tjele\r'),('8831','Løgstrup\r'),('8832','Skals\r'),('8840','Rødkærsbro\r'),('8850','Bjerringbro\r'),('8860','Ulstrup\r'),('8870','Langå\r'),('8881','Thorsø\r'),('8882','Fårvang\r'),('8883','Gjern\r'),('8900','Randers C\r'),('8920','Randers NV\r'),('8930','Randers NØ\r'),('8940','Randers SV\r'),('8950','Ørsted\r'),('8960','Randers SØ\r'),('8961','Allingåbro\r'),('8963','Auning\r'),('8970','Havndal\r'),('8981','Spentrup\r'),('8983','Gjerlev J\r'),('8990','Fårup\r'),('900','Vágur\r'),('9000','Aalborg\r'),('9029','Aalborg\r'),('910','Vágur\r'),('9100','Aalborg\r'),('9200','Aalborg SV\r'),('9210','Aalborg SØ\r'),('9220','Aalborg Øst\r'),('9230','Svenstrup J\r'),('9240','Nibe\r'),('925','Nes'),('926','Lopra\r'),('9260','Gistrup\r'),('927','Akrar\r'),('9270','Klarup\r'),('928','Vikarbyrgi\r'),('9280','Storvorde\r'),('9293','Kongerslev\r'),('9300','Sæby\r'),('9310','Vodskov\r'),('9320','Hjallerup\r'),('9330','Dronninglund\r'),('9340','Asaa\r'),('9352','Dybvad\r'),('9362','Gandrup\r'),('9370','Hals\r'),('9380','Vestbjerg\r'),('9381','Sulsted\r'),('9382','Tylstrup\r'),('9400','Nørresundby\r'),('9430','Vadum\r'),('9440','Aabybro\r'),('9460','Brovst\r'),('9480','Løkken\r'),('9490','Pandrup\r'),('9492','Blokhus\r'),('9493','Saltum\r'),('950','Porkeri\r'),('9500','Hobro\r'),('9510','Arden\r'),('9520','Skørping\r'),('9530','Støvring\r'),('9541','Suldrup\r'),('9550','Mariager\r'),('9560','Hadsund\r'),('9574','Bælum\r'),('9575','Terndrup\r'),('960','Hov\r'),('9600','Aars\r'),('9610','Nørager\r'),('9620','Aalestrup\r'),('9631','Gedsted\r'),('9632','Møldrup\r'),('9640','Farsø\r'),('9670','Løgstør\r'),('9681','Ranum\r'),('9690','Fjerritslev\r'),('970','Sumba\r'),('9700','Brønderslev\r'),('9740','Jerslev J\r'),('9750','Østervrå\r'),('9760','Vrå\r'),('9800','Hjørring\r'),('9830','Tårs\r'),('9850','Hirtshals\r'),('9870','Sindal\r'),('9881','Bindslev\r'),('9900','Frederikshavn\r'),('9940','Læsø\r'),('9970','Strandby\r'),('9981','Jerup\r'),('9982','Ålbæk\r'),('9990','Skagen\r'),('9992','Jylland USF P\r'),('9993','Jylland USF B\r'),('9996','Fakturaservice\r'),('9997','Fakturascanning\r'),('9998','Borgerservice\r');
/*!40000 ALTER TABLE `br_city` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_city_before_insert BEFORE INSERT
    ON br_city FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'city_before',
        CURRENT_TIMESTAMP(),
        'Insert New Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_city_insert_after AFTER INSERT
    ON br_city FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'city_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'city_postal_code: ', COALESCE(NEW.city_postal_code, "NULL"), ', ',
            'city_name: ', COALESCE(NEW.city_name, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_city_update_before BEFORE UPDATE
ON br_city FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'city_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'city_postal_code: ', COALESCE(OLD.city_postal_code, "NULL"), ', ',
            'city_name: ', COALESCE(OLD.city_name, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_cityupdate__after AFTER UPDATE
ON br_city FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'city_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'city_postal_code: ', COALESCE(NEW.city_postal_code, "NULL"), ', ',
            'city_name: ', COALESCE(NEW.city_name, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_city_before_delete BEFORE DELETE
ON br_city FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'city_after',
        CURRENT_TIMESTAMP(),
        'Deleting Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_city_delete_after AFTER DELETE
ON br_city FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'city_after',
        CURRENT_TIMESTAMP(),
        'Row Deleted'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `br_genre`
--

DROP TABLE IF EXISTS `br_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `br_genre` (
  `gen_value` varchar(100) NOT NULL,
  PRIMARY KEY (`gen_value`),
  KEY `idx_genre` (`gen_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `br_genre`
--

LOCK TABLES `br_genre` WRITE;
/*!40000 ALTER TABLE `br_genre` DISABLE KEYS */;
INSERT INTO `br_genre` VALUES ('Adventure'),('Biography'),('Fantasy'),('Historical Fiction'),('Horror'),('Mystery'),('Romance'),('Science Fiction'),('Self-Help'),('Thriller');
/*!40000 ALTER TABLE `br_genre` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_genre_before_insert BEFORE INSERT
    ON br_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'genre_before',
        CURRENT_TIMESTAMP(),
        CONCAT('gen_value: ', NEW.gen_value)
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_genre_insert_after AFTER INSERT
    ON br_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'genre_after',
        CURRENT_TIMESTAMP(),
        CONCAT('gen_value: ', COALESCE(NEW.gen_value, "NULL"))
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_genre_update_before BEFORE UPDATE
ON br_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'genre_after',
        CURRENT_TIMESTAMP(),
        CONCAT('gen_value: ', COALESCE(NEW.gen_value, "NULL"))
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_genreupdate__after AFTER UPDATE
ON br_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'genre_after',
        CURRENT_TIMESTAMP(),
        CONCAT('gen_value: ', COALESCE(NEW.gen_value, "NULL"))
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_genre_before_delete BEFORE DELETE
ON br_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'genre_after',
        CURRENT_TIMESTAMP(),
        'Delete Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_genre_delete_after AFTER DELETE
ON br_genre FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'genre_after',
        CURRENT_TIMESTAMP(),
        'Row Deleted'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `br_order`
--

DROP TABLE IF EXISTS `br_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `br_order` (
  `odr_id` int(11) NOT NULL AUTO_INCREMENT,
  `odr_user_id` int(11) DEFAULT NULL,
  `odr_shipping_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `odr_sold_price` decimal(6,2) DEFAULT NULL,
  `odr_status` enum('Received','Processed','Shipped','Delivered','Cancelled','Returned','Failed','On Hold') DEFAULT NULL,
  PRIMARY KEY (`odr_id`),
  KEY `odr_user_id` (`odr_user_id`),
  KEY `idx_order` (`odr_id`,`odr_user_id`,`odr_shipping_date`,`odr_sold_price`,`odr_status`),
  CONSTRAINT `br_order_ibfk_1` FOREIGN KEY (`odr_user_id`) REFERENCES `br_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `br_order`
--

LOCK TABLES `br_order` WRITE;
/*!40000 ALTER TABLE `br_order` DISABLE KEYS */;
INSERT INTO `br_order` VALUES (1,1,'2024-04-25 10:00:00',100.00,'Shipped'),(2,2,'2024-04-26 10:00:00',150.00,'Processed'),(3,3,'2024-04-27 10:00:00',200.00,'Shipped'),(4,4,'2024-04-28 10:00:00',250.00,'Delivered'),(5,5,'2024-04-29 10:00:00',300.00,'Cancelled'),(6,6,'2024-04-30 10:00:00',350.00,'Returned'),(7,7,'2024-05-01 10:00:00',400.00,'Failed'),(8,8,'2024-05-02 10:00:00',450.00,'On Hold'),(9,9,'2024-05-03 10:00:00',500.00,'Shipped'),(10,10,'2024-05-04 10:00:00',550.00,'Processed');
/*!40000 ALTER TABLE `br_order` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_order_before_insert BEFORE INSERT
    ON br_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'order_before',
        CURRENT_TIMESTAMP(),
        'Insert New Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_order_insert_after AFTER INSERT
ON br_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (log_id, log_table_key, log_time_stamp, log_message)
    VALUES (
        NULL,
        'order_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'odr_id: ', NEW.odr_id, ', ',
            'odr_user_id: ', NEW.odr_user_id, ', ',
            'odr_shipping_date: ', NEW.odr_shipping_date, ', ',
            'odr_sold_price: ', NEW.odr_sold_price, ', ',
            'odr_status: ', NEW.odr_status, ', '
        )
    );

    -- handle taxes - this could have been made as a separate trigger.
    IF NEW.odr_status = 'Received' THEN 
        -- Add the final tax to the br_taxes.accumi_tax
        UPDATE br_taxes
        SET accumi_tax = COALESCE(accumi_tax + (
                NEW.odr_sold_price - (
                    SELECT br_pricing.pri_purchase_price
                    FROM br_book_order
                    JOIN br_book ON br_book_order.bo_book_id = br_book.bk_id
                    JOIN br_pricing ON br_book.bk_pricing_id = br_pricing.pri_id
                    LIMIT 1
                )
            ) * ((SELECT tax_rate FROM br_tax WHERE tax_name = 'moms')/100), accumi_tax),
            last_update = NOW()
        WHERE pri_id = 1;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_order_update_before BEFORE UPDATE
ON br_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'order_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'odr_id: ', COALESCE(OLD.odr_id, "NULL"), ', ',
            'odr_user_id: ', COALESCE(OLD.odr_user_id, "NULL"), ', ',
            'odr_shipping_date: ', COALESCE(OLD.odr_shipping_date, "NULL"), ', ',
            'odr_sold_price: ', COALESCE(OLD.odr_sold_price, "NULL"), ', ',
            'odr_status: ', COALESCE(OLD.odr_status, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_orderupdate__after AFTER UPDATE
ON br_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'order_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'odr_id: ', COALESCE(NEW.odr_id, "NULL"), ', ',
            'odr_user_id: ', COALESCE(NEW.odr_user_id, "NULL"), ', ',
            'odr_shipping_date: ', COALESCE(NEW.odr_shipping_date, "NULL"), ', ',
            'odr_sold_price: ', COALESCE(NEW.odr_sold_price, "NULL"), ', ',
            'odr_status: ', COALESCE(NEW.odr_status, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_order_before_delete BEFORE DELETE
ON br_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'order_after',
        CURRENT_TIMESTAMP(),
        'Deleting Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_order_delete_after AFTER DELETE
ON br_order FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'order_after',
        CURRENT_TIMESTAMP(),
        'Row Deleted'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `br_pricing`
--

DROP TABLE IF EXISTS `br_pricing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `br_pricing` (
  `pri_id` int(11) NOT NULL AUTO_INCREMENT,
  `pri_purchase_price` decimal(6,2) NOT NULL,
  `pri_sales_price` decimal(6,2) NOT NULL,
  `pri_sale_percentage` decimal(5,2) DEFAULT NULL,
  `pri_price_reduction` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`pri_id`),
  KEY `idx_pricing` (`pri_id`,`pri_purchase_price`,`pri_sales_price`,`pri_sale_percentage`,`pri_price_reduction`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `br_pricing`
--

LOCK TABLES `br_pricing` WRITE;
/*!40000 ALTER TABLE `br_pricing` DISABLE KEYS */;
INSERT INTO `br_pricing` VALUES (1,50.00,75.00,20.00,10.00),(2,60.00,90.00,25.00,15.00),(3,70.00,100.00,30.00,20.00),(4,80.00,110.00,35.00,25.00),(5,90.00,120.00,40.00,30.00),(6,100.00,130.00,45.00,35.00),(7,110.00,140.00,50.00,40.00),(8,120.00,150.00,55.00,45.00),(9,130.00,160.00,60.00,50.00),(10,140.00,170.00,65.00,55.00);
/*!40000 ALTER TABLE `br_pricing` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_pricing_before_insert BEFORE INSERT
    ON br_pricing FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'pricing_before',
        CURRENT_TIMESTAMP(),
        'Insert New Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_pricing_insert_after AFTER INSERT
    ON br_pricing FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'pricing_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'pri_id: ', COALESCE(NEW.pri_id,"NULL"), ', ',
            'pri_purchase_price: ', COALESCE(NEW.pri_purchase_price,"NULL"), ', ',
            'pri_sales_price: ', COALESCE(NEW.pri_sales_price,"NULL"), ', ',
            'pri_sale_percentage: ', COALESCE(NEW.pri_sale_percentage,"NULL"), ', ',
            'pri_price_reduction: ', COALESCE(NEW.pri_price_reduction,"NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_pricing_update_before BEFORE UPDATE
ON br_pricing FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'pricing_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'pri_id: ', COALESCE(OLD.pri_id, "NULL"), ', ',
            'pri_purchase_price: ', COALESCE(OLD.pri_purchase_price, "NULL"), ', ',
            'pri_sales_price: ', COALESCE(OLD.pri_sales_price, "NULL"), ', ',
            'pri_sale_percentage: ', COALESCE(OLD.pri_sale_percentage, "NULL"), ', ',
            'pri_price_reduction: ', COALESCE(OLD.pri_price_reduction, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_pricingupdate__after AFTER UPDATE
ON br_pricing FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'pricing_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'pri_id: ', COALESCE(NEW.pri_id, "NULL"), ', ',
            'pri_purchase_price: ', COALESCE(NEW.pri_purchase_price, "NULL"), ', ',
            'pri_sales_price: ', COALESCE(NEW.pri_sales_price, "NULL"), ', ',
            'pri_sale_percentage: ', COALESCE(NEW.pri_sale_percentage, "NULL"), ', ',
            'pri_price_reduction: ', COALESCE(NEW.pri_price_reduction, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_pricing_before_delete BEFORE DELETE
ON br_pricing FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'pricing_after',
        CURRENT_TIMESTAMP(),
        'Deleting Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_pricing_delete_after AFTER DELETE
ON br_pricing FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'pricing_after',
        CURRENT_TIMESTAMP(),
        'Row Deleted'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `br_tax`
--

DROP TABLE IF EXISTS `br_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `br_tax` (
  `tax_id` int(11) NOT NULL AUTO_INCREMENT,
  `tax_rate` decimal(6,2) NOT NULL,
  `tax_name` varchar(100) DEFAULT NULL,
  `tax_incoming` tinyint(1) NOT NULL,
  PRIMARY KEY (`tax_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `br_tax`
--

LOCK TABLES `br_tax` WRITE;
/*!40000 ALTER TABLE `br_tax` DISABLE KEYS */;
INSERT INTO `br_tax` VALUES (1,25.00,'moms',1);
/*!40000 ALTER TABLE `br_tax` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_tax_before_insert BEFORE INSERT
    ON br_tax FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'tax_before',
        CURRENT_TIMESTAMP(),
        'Insert New Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_tax_insert_after AFTER INSERT
    ON br_tax FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'tax_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'tax_id: ', COALESCE(NEW.tax_id, "NULL"), ', ',
            'tax_rate: ', COALESCE(NEW.tax_rate, "NULL"), ', ',
            'tax_name: ', COALESCE(NEW.tax_name, "NULL"), ', ',
            'tax_incoming: ', COALESCE(NEW.tax_incoming, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_tax_update_before BEFORE UPDATE
ON br_tax FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'tax_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'tax_id: ', COALESCE(OLD.tax_id, "NULL"), ', ',
            'tax_rate: ', COALESCE(OLD.tax_rate, "NULL"), ', ',
            'tax_name: ', COALESCE(OLD.tax_name, "NULL"), ', ',
            'tax_incoming: ', COALESCE(OLD.tax_incoming, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_tax_update_after AFTER UPDATE
    ON br_tax FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'tax_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'tax_id: ', COALESCE(NEW.tax_id,"NULL"), ', ',
            'tax_rate: ', COALESCE(NEW.tax_rate,"NULL"), ', ',
            'tax_name: ', COALESCE(NEW.tax_name,"NULL"), ', ',
            'tax_incoming: ', COALESCE(NEW.tax_incoming,"NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_tax_insert_before BEFORE DELETE
    ON br_tax FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'tax_after',
        CURRENT_TIMESTAMP(),
        'Deleting Row'

    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_tax_delete_before AFTER DELETE
    ON br_tax FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'tax_after',
        CURRENT_TIMESTAMP(),
        'Row Deleted'

    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `br_taxes`
--

DROP TABLE IF EXISTS `br_taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `br_taxes` (
  `pri_id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_tax_id` int(11) NOT NULL,
  `Accumi_tax` decimal(6,2) DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `last_tax_paid` datetime DEFAULT NULL,
  PRIMARY KEY (`pri_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `br_taxes`
--

LOCK TABLES `br_taxes` WRITE;
/*!40000 ALTER TABLE `br_taxes` DISABLE KEYS */;
INSERT INTO `br_taxes` VALUES (1,1,0.00,'2024-05-01 13:18:41','2024-05-01 13:18:41');
/*!40000 ALTER TABLE `br_taxes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_taxes_before_insert BEFORE INSERT
    ON br_taxes FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'taxes_before',
        CURRENT_TIMESTAMP(),
        'Insert New Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_taxes_insert_after AFTER INSERT
    ON br_taxes FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'taxes_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'pri_id: ', COALESCE(NEW.pri_id, "NULL"), ', ',
            'fk_tax_id: ', COALESCE(NEW.fk_tax_id, "NULL"), ', ',
            'Accumi_tax: ', COALESCE(NEW.Accumi_tax, "NULL"), ', ',
            'last_update: ', COALESCE(NEW.last_update, "NULL"), ', ',
            'last_tax_paid: ', COALESCE(NEW.last_tax_paid, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_taxes_update_before BEFORE UPDATE
ON br_taxes FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'taxes_before',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'pri_id: ', COALESCE(OLD.pri_id, "NULL"), ', ',
            'fk_tax_id: ', COALESCE(OLD.fk_tax_id, "NULL"), ', ',
            'Accumi_tax: ', COALESCE(OLD.Accumi_tax, "NULL"), ', ',
            'last_update: ', COALESCE(OLD.last_update, "NULL"), ', ',
            'last_tax_paid: ', COALESCE(OLD.last_tax_paid, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_taxes_update_after AFTER UPDATE
    ON br_taxes FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'taxes_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'pri_id: ', COALESCE(NEW.pri_id, 'NULL'), ', ',
            'fk_tax_id: ', COALESCE(NEW.fk_tax_id, 'NULL'), ', ',
            'Accumi_tax: ', COALESCE(NEW.Accumi_tax, 'NULL'), ', ',
            'last_update: ', COALESCE(NEW.last_update, 'NULL'), ', ',
            'last_tax_paid: ', COALESCE(NEW.last_tax_paid, 'NULL')
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_taxes_insert_before BEFORE DELETE
    ON br_taxes FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'taxes_after',
        CURRENT_TIMESTAMP(),
        'Deleting Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_taxes_delete_before AFTER DELETE
    ON br_taxes FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'taxes_after',
        CURRENT_TIMESTAMP(),
        'Row Deleted'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `br_user`
--

DROP TABLE IF EXISTS `br_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `br_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_first_name` varchar(50) NOT NULL,
  `user_last_name` varchar(50) NOT NULL,
  `user_username` varchar(50) NOT NULL,
  `user_password` varchar(250) NOT NULL,
  `user_email` varchar(254) NOT NULL,
  `user_phone_number` varchar(25) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_username` (`user_username`),
  UNIQUE KEY `user_email` (`user_email`),
  UNIQUE KEY `user_phone_number` (`user_phone_number`),
  KEY `idx_user` (`user_id`,`user_first_name`,`user_last_name`,`user_username`,`user_password`,`user_email`,`user_phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `br_user`
--

LOCK TABLES `br_user` WRITE;
/*!40000 ALTER TABLE `br_user` DISABLE KEYS */;
INSERT INTO `br_user` VALUES (1,'John','Doe','johndoe','password123','john@example.com','1234567890'),(2,'Jane','Smith','janesmith','password456','jane@example.com','9876543210'),(3,'Alice','Johnson','alicej','password789','alice@example.com','5555555555'),(4,'Bob','Brown','bobb','passwordabc','bob@example.com','7777777777'),(5,'Emma','White','emmaw','passwordxyz','emma@example.com','9999999999'),(6,'Michael','Lee','michaell','pass123word','michael@example.com','1111111111'),(7,'Sarah','Taylor','saraht','pass456word','sarah@example.com','2222222222'),(8,'David','Martinez','davidm','pass789word','david@example.com','3333333333'),(9,'Sophia','Garcia','sophiag','passabcword','sophia@example.com','4444444444'),(10,'Daniel','Lopez','daniell','passxyzword','daniel@example.com','6666666666');
/*!40000 ALTER TABLE `br_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_user_before_insert BEFORE INSERT
    ON br_user FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'user_before',
        CURRENT_TIMESTAMP(),
        'Insert New Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_user_insert_after AFTER INSERT
    ON br_user FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'user_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'user_id: ', COALESCE(NEW.user_id), ', ',
            'user_first_name: ', COALESCE(NEW.user_first_name,"NULL"), ', ',
            'user_last_name: ', COALESCE(NEW.user_last_name,"NULL"), ', ',
            'user_username: ', COALESCE(NEW.user_username,"NULL"), ', ',
            'user_password: ', COALESCE(NEW.user_password,"NULL"), ', ',
            'user_email: ', COALESCE(NEW.user_email,"NULL"), ', ',
            'user_phone_number: ', COALESCE(NEW.user_phone_number,"NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_user_update_before BEFORE UPDATE
ON br_user FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'user_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'user_id: ', COALESCE(OLD.user_id, "NULL"), ', ',
            'user_first_name: ', COALESCE(OLD.user_first_name, "NULL"), ', ',
            'user_last_name: ', COALESCE(OLD.user_last_name, "NULL"), ', ',
            'user_username: ', COALESCE(OLD.user_username, "NULL"), ', ',
            'user_password: ', COALESCE(OLD.user_password, "NULL"), ', ',
            'user_email: ', COALESCE(OLD.user_email, "NULL"), ', ',
            'user_phone_number: ', COALESCE(OLD.user_phone_number, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_userupdate__after AFTER UPDATE
ON br_user FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES
    (
        NULL,
        'user_after',
        CURRENT_TIMESTAMP(),
        CONCAT(
            'user_id: ', COALESCE(NEW.user_id, "NULL"), ', ',
            'user_first_name: ', COALESCE(NEW.user_first_name, "NULL"), ', ',
            'user_last_name: ', COALESCE(NEW.user_last_name, "NULL"), ', ',
            'user_username: ', COALESCE(NEW.user_username, "NULL"), ', ',
            'user_password: ', COALESCE(NEW.user_password, "NULL"), ', ',
            'user_email: ', COALESCE(NEW.user_email, "NULL"), ', ',
            'user_phone_number: ', COALESCE(NEW.user_phone_number, "NULL")
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_user_before_delete BEFORE DELETE
ON br_user FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'user_after',
        CURRENT_TIMESTAMP(),
        'Deleting Row'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_user_delete_after AFTER DELETE
ON br_user FOR EACH ROW BEGIN
    INSERT INTO br_bogreden_log (
        log_id,
        log_table_key,
        log_time_stamp,
        log_message
    )
    VALUES (
        NULL,
        'user_after',
        CURRENT_TIMESTAMP(),
        'Row Deleted'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'bogreden'
--

--
-- Dumping routines for database 'bogreden'
--
/*!50003 DROP PROCEDURE IF EXISTS `delete_address` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_address`(IN `id` INT)
BEGIN
    SET @sql = 'DELETE FROM br_address WHERE adr_id = ?';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `id`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_author` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_author`(IN `name` VARCHAR(100))
BEGIN
    SET @sql = 'DELETE FROM br_author WHERE auth_name = ?';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `name`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_book` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_book`(IN `id` INT)
BEGIN
    SET @sql = 'DELETE FROM br_book WHERE bk_id = ?';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `id`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_genre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_genre`(IN `value` VARCHAR(100))
BEGIN
    SET @sql = 'DELETE FROM br_genre WHERE gen_value = ?';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `value`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_order`(IN `id` INT)
BEGIN
    SET @sql = 'DELETE FROM br_order WHERE order_id = ?';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `id`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user`(IN `id` INT)
BEGIN
    SET @sql = 'DELETE FROM br_user WHERE user_id = ?';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `id`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_new_address` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_new_address`(
    IN `postal_code` VARCHAR(15),
    IN `user_id` INT,
    IN `street_address` VARCHAR(100),
    IN `country` varchar(60),
    IN `is_billing_address` BOOLEAN
)
BEGIN
    SET @sql = 'INSERT INTO br_address (adr_postal_code, adr_user_id, adr_street_address, adr_country, adr_is_billing_address) VALUES (?, ?, ?, ?, ?)';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `postal_code`, `user_id`, `street_address`, `country`, `is_billing_address`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_new_author` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_new_author`(
    IN `name` VARCHAR(100)
)
BEGIN
    SET @sql = 'INSERT INTO br_author (auth_name) VALUES (?)';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `name`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_new_book` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_new_book`(
    IN `pricing_id` INT,
    IN `title` VARCHAR(100),
    IN `weight` DECIMAL(6, 4),
    IN `description` TEXT,
    IN `image` VARCHAR(50)
)
BEGIN
    SET @sql = 'INSERT INTO br_book (bk_pricing_id, bk_titel, bk_weight, bk_description, bk_image) VALUES (?, ?, ?, ?, ?)';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `pricing_id`, `title`, `weight`, `description`, `image`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_new_book_author` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_new_book_author`(
    IN `book_id` INT,
    IN `author_name` VARCHAR(100)
)
BEGIN
    SET @sql = 'INSERT INTO br_book_author (ba_book_id, ba_author_name) VALUES (?, ?)';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `book_id`, `author_name`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_new_book_genre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_new_book_genre`(
    IN `book_id` INT,
    IN `genre` VARCHAR(100)
)
BEGIN
    SET @sql = 'INSERT INTO br_book_genre (bg_book_id, bg_genre) VALUES (?, ?)';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `book_id`, `genre`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_new_book_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_new_book_order`(
    IN `book_id` INT,
    IN `order_id` INT
)
BEGIN
    SET @sql = 'INSERT INTO br_book_order (bo_book_id, bo_ord_id) VALUES (?, ?)';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `book_id`, `order_id`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_new_genre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_new_genre`(
    IN `value` VARCHAR(100)
)
BEGIN
    SET @sql = 'INSERT INTO br_genre (gen_value) VALUES (?)';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `value`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_new_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_new_order`(
    IN `user_id` INT,
    IN `shipping_date` TIMESTAMP,
    IN `sold_price` DECIMAL(6, 2),
    IN `status` ENUM('Received', 'Processed', 'Shipped', 'Delivered', 'Cancelled', 'Returned', 'Failed', 'On Hold')
)
BEGIN
    SET @sql = 'INSERT INTO br_order(odr_user_id, odr_shipping_date, odr_sold_price, odr_status) VALUES (?, ?, ?, ?)';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `user_id`, `shipping_date`, `sold_price`, `status`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_new_pricing` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_new_pricing`(
    IN `purchase_price` DECIMAL(6, 2),
    IN `sales_price` DECIMAL(6, 2),
    IN `sale_percentage` DECIMAL(5, 2),
    IN `price_reduction` DECIMAL(6, 2)
)
BEGIN
    SET @sql = 'INSERT INTO br_pricing (pri_purchase_price, pri_sales_price, pri_sale_percentage, pri_price_reduction) VALUES (?, ?, ?, ?)';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `purchase_price`, `sales_price`, `sale_percentage`, `price_reduction`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_new_tax` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_new_tax`(
    IN `rate` DECIMAL(6,2),
    IN `name` VARCHAR(100),
    IN `incoming` BOOLEAN
)
BEGIN
    SET @sql = 'INSERT INTO br_tax(tax_rate, tax_name, tax_incoming) VALUES (?, ?, ?)';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `rate`, `name`, `incoming`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_new_taxes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_new_taxes`()
BEGIN
    INSERT INTO br_taxes(
        fk_tax_id,
        Accumi_tax,
        last_update,
        last_tax_paid
    )
    VALUES(
        1,
        0,
        NOW(),
        NOW()
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_new_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_new_user`(
    IN `first_name` VARCHAR(50),
    IN `last_name` VARCHAR(50),
    IN `username` VARCHAR(50),
    IN `password` VARCHAR(250),
    IN `confirm_password` VARCHAR(250),
    IN `email` VARCHAR(254),
    IN `phone_number` VARCHAR(25)
)
BEGIN
    IF `password` = `confirm_password` THEN
        SET @sql = 'INSERT INTO br_user (user_first_name, user_last_name, user_username, user_password, user_email, user_phone_number) VALUES (?, ?, ?, ?, ?, ?)';
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING `first_name`, `last_name`, `username`, `password`, `email`, `phone_number`;
        DEALLOCATE PREPARE stmt;
    ELSE
        SELECT 'Passwords do not match' AS ErrorMessage;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_address` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_address`(
    IN `id` INT,
    IN `postal_code` VARCHAR(15),
    IN `street_address` VARCHAR(100),
    IN `country` VARCHAR(60),
    IN `is_billing_address` BOOLEAN
)
BEGIN
    SET @sql = 'UPDATE br_address SET adr_postal_code = ?, adr_street_address = ?, adr_country = ?, adr_is_billing_address = ? WHERE adr_id = ?';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `postal_code`, `street_address`, `country`, `is_billing_address`, `id`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_author` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_author`(
    IN `current_name` VARCHAR(100),
    IN `new_name` VARCHAR(100)
)
BEGIN
    SET @sql = 'UPDATE br_author SET auth_name = ? WHERE auth_name = ?';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `new_name`, `current_name`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_genre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_genre`(
    IN `current_value` VARCHAR(100),
    IN `new_value` VARCHAR(100)
)
BEGIN
    SET @sql = 'UPDATE br_genre SET gen_value = ? WHERE gen_value = ?';
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING `new_value`, `current_value`;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user`(
    IN `id` INT,
    IN `first_name` VARCHAR(50),
    IN `last_name` VARCHAR(50),
    IN `username` VARCHAR(50),
    IN `password` VARCHAR(250),
    IN `confirm_password` VARCHAR(250),
    IN `email` VARCHAR(254),
    IN `phone_number` VARCHAR(25)
)
BEGIN
    IF `password` IS NOT NULL THEN
        IF `password` = `confirm_password` THEN
            SET @sql = 'UPDATE br_user SET user_password = ?, user_first_name = ?, user_last_name = ?, user_username = ?, user_email = ?, user_phone_number = ? WHERE user_id = ?';
            PREPARE stmt FROM @sql;
            EXECUTE stmt USING `password`, `first_name`, `last_name`, `username`, `email`, `phone_number`, `id`;
            DEALLOCATE PREPARE stmt;
        ELSE
            SELECT 'Passwords do not match' AS ErrorMessage;
        END IF;
    ELSE
        SELECT 'Password cannot be empty' AS ErrorMessage;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-01 13:22:28
