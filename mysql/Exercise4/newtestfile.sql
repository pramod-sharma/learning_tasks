-- MySQL dump 10.13  Distrib 5.5.31, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: demo
-- ------------------------------------------------------
-- Server version	5.5.31-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Testing_Tables`
--

DROP TABLE IF EXISTS `Testing_Tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Testing_Tables` (
  `username` varchar(20) DEFAULT NULL,
  `roll_no` int(11) DEFAULT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Testing_Tables`
--

LOCK TABLES `Testing_Tables` WRITE;
/*!40000 ALTER TABLE `Testing_Tables` DISABLE KEYS */;
/*!40000 ALTER TABLE `Testing_Tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mytable`
--

DROP TABLE IF EXISTS `mytable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mytable` (
  `roll_no` int(11) DEFAULT NULL,
  `fname` varchar(30) DEFAULT NULL,
  `lname` varchar(30) DEFAULT NULL,
  `serial` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`serial`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mytable`
--

LOCK TABLES `mytable` WRITE;
/*!40000 ALTER TABLE `mytable` DISABLE KEYS */;
INSERT INTO `mytable` VALUES (86,'param','sharma',1),(65,'p[ramod','',2),(26,'','singh',3);
/*!40000 ALTER TABLE `mytable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `new_test`
--

DROP TABLE IF EXISTS `new_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `new_test` (
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `roll_no` float DEFAULT NULL,
  `address` varchar(15) DEFAULT NULL,
  `fir_name` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `newi` int(5) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`newi`),
  KEY `roll_no` (`roll_no`),
  KEY `first_name` (`first_name`,`last_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `new_test`
--

LOCK TABLES `new_test` WRITE;
/*!40000 ALTER TABLE `new_test` DISABLE KEYS */;
INSERT INTO `new_test` VALUES ('shar','pra',65,NULL,NULL,NULL,1),('kum','pram',32,NULL,NULL,NULL,2),('shar','jkl',89,NULL,NULL,NULL,3),('jkl','pra',9,NULL,NULL,NULL,4),('kum','param',NULL,NULL,NULL,NULL,5),('kum','pra',NULL,NULL,NULL,NULL,6),('','',25,NULL,NULL,NULL,7),('','',25.2336,NULL,NULL,NULL,8),('abcdefghijklmnopqrst','',255,NULL,NULL,NULL,9),('abcdefghijklmnopqrst','',255,NULL,NULL,NULL,10),('abcdefghijklmnopqrst','',255,NULL,NULL,NULL,11),('abcdefghijklmnopqrst','',255,NULL,NULL,NULL,12);
/*!40000 ALTER TABLE `new_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newdata`
--

DROP TABLE IF EXISTS `newdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newdata` (
  `t` datetime DEFAULT NULL,
  `user` char(8) DEFAULT NULL,
  `host` char(20) DEFAULT NULL,
  `size` bigint(20) DEFAULT NULL,
  KEY `t` (`t`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newdata`
--

LOCK TABLES `newdata` WRITE;
/*!40000 ALTER TABLE `newdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `newdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newe`
--

DROP TABLE IF EXISTS `newe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newe` (
  `distance` int(11) DEFAULT NULL,
  `time` time DEFAULT NULL,
  `name` varchar(30) NOT NULL,
  `newcolumn` enum('string','number','char') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newe`
--

LOCK TABLES `newe` WRITE;
/*!40000 ALTER TABLE `newe` DISABLE KEYS */;
INSERT INTO `newe` VALUES (15,'17:46:37','',''),(15,NULL,'',''),(25,NULL,'',''),(45,NULL,'',''),(58,NULL,'',''),(15,NULL,'',''),(25,NULL,'',''),(45,NULL,'',''),(58,NULL,'',''),(15,NULL,'',''),(25,NULL,'',''),(45,NULL,'',''),(58,NULL,'',''),(18,'12:22:48','param',''),(18,'11:55:06','',''),(65,NULL,'',''),(65,NULL,'',''),(65,NULL,'','');
/*!40000 ALTER TABLE `newe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newtable`
--

DROP TABLE IF EXISTS `newtable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newtable` (
  `name` char(20) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newtable`
--

LOCK TABLES `newtable` WRITE;
/*!40000 ALTER TABLE `newtable` DISABLE KEYS */;
INSERT INTO `newtable` VALUES ('pramo',5),('pramn',6),('ghi',7),('pramod',8),('pra',9),('abc',10);
/*!40000 ALTER TABLE `newtable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newtesttable`
--

DROP TABLE IF EXISTS `newtesttable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newtesttable` (
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `roll_no` float DEFAULT NULL,
  `address` varchar(15) DEFAULT NULL,
  `fir_name` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `newi` int(5) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`newi`),
  KEY `roll_no` (`roll_no`),
  KEY `first_name` (`first_name`,`last_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newtesttable`
--

LOCK TABLES `newtesttable` WRITE;
/*!40000 ALTER TABLE `newtesttable` DISABLE KEYS */;
INSERT INTO `newtesttable` VALUES ('kum','pram',32,NULL,NULL,NULL,2),('shar','jkl',89,NULL,NULL,NULL,3),('jkl','pra',9,NULL,NULL,NULL,4),('kum','param',NULL,NULL,NULL,NULL,5),('kum','pra',NULL,NULL,NULL,NULL,6),('','',25,NULL,NULL,NULL,7),('','',25.2336,NULL,NULL,NULL,8),('abcdefghijklmnopqrst','',255,NULL,NULL,NULL,9),('abcdefghijklmnopqrst','',255,NULL,NULL,NULL,10),('abcdefghijklmnopqrst','',255,NULL,NULL,NULL,11),('abcdefghijklmnopqrst','',255,NULL,NULL,NULL,12);
/*!40000 ALTER TABLE `newtesttable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newtesttable2`
--

DROP TABLE IF EXISTS `newtesttable2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newtesttable2` (
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `roll_no` float DEFAULT NULL,
  `address` varchar(15) DEFAULT NULL,
  `fir_name` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `newi` int(5) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`newi`),
  KEY `roll_no` (`roll_no`),
  KEY `first_name` (`first_name`,`last_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newtesttable2`
--

LOCK TABLES `newtesttable2` WRITE;
/*!40000 ALTER TABLE `newtesttable2` DISABLE KEYS */;
INSERT INTO `newtesttable2` VALUES ('shar','pra',65,NULL,NULL,NULL,1),('kum','pram',32,NULL,NULL,NULL,2),('shar','jkl',89,NULL,NULL,NULL,3),('jkl','pra',9,NULL,NULL,NULL,4),('kum','param',NULL,NULL,NULL,NULL,5),('kum','pra',NULL,NULL,NULL,NULL,6),('','',25,NULL,NULL,NULL,7),('','',25.2336,NULL,NULL,NULL,8),('abcdefghijklmnopqrst','',255,NULL,NULL,NULL,9),('abcdefghijklmnopqrst','',255,NULL,NULL,NULL,10),('abcdefghijklmnopqrst','',255,NULL,NULL,NULL,11),('abcdefghijklmnopqrst','',255,NULL,NULL,NULL,12);
/*!40000 ALTER TABLE `newtesttable2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testing_table`
--

DROP TABLE IF EXISTS `testing_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testing_table` (
  `contact_name` varchar(30) DEFAULT NULL,
  `roll_no` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testing_table`
--

LOCK TABLES `testing_table` WRITE;
/*!40000 ALTER TABLE `testing_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `testing_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testtable`
--

DROP TABLE IF EXISTS `testtable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testtable` (
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `roll_no` float DEFAULT NULL,
  `address` varchar(15) DEFAULT NULL,
  `fir_name` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `newi` int(5) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`newi`),
  KEY `roll_no` (`roll_no`),
  KEY `first_name` (`first_name`,`last_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testtable`
--

LOCK TABLES `testtable` WRITE;
/*!40000 ALTER TABLE `testtable` DISABLE KEYS */;
INSERT INTO `testtable` VALUES ('shar','pra',65,NULL,NULL,NULL,1),('kum','pram',32,NULL,NULL,NULL,2),('shar','jkl',89,NULL,NULL,NULL,3),('jkl','pra',9,NULL,NULL,NULL,4),('kum','param',NULL,NULL,NULL,NULL,5),('kum','pra',NULL,NULL,NULL,NULL,6),('','',25,NULL,NULL,NULL,7),('','',25.2336,NULL,NULL,NULL,8),('abcdefghijklmnopqrst','',255,NULL,NULL,NULL,9),('abcdefghijklmnopqrst','',255,NULL,NULL,NULL,10),('abcdefghijklmnopqrst','',255,NULL,NULL,NULL,11),('abcdefghijklmnopqrst','',255,NULL,NULL,NULL,12);
/*!40000 ALTER TABLE `testtable` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-06-06 19:01:18
