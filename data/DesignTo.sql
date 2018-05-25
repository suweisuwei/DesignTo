-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: DesignTo
-- ------------------------------------------------------
-- Server version	5.7.22

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
-- Table structure for table `custom_design`
--

DROP TABLE IF EXISTS `custom_design`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_design` (
  `cid` int(8) NOT NULL COMMENT '需求作品ID',
  `rid` int(8) NOT NULL COMMENT '主题ID',
  `uid` int(8) NOT NULL COMMENT '用户ID',
  `img` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '作品图像',
  `desp` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '作品描述',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_design`
--

LOCK TABLES `custom_design` WRITE;
/*!40000 ALTER TABLE `custom_design` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_design` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `like_op`
--

DROP TABLE IF EXISTS `like_op`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `like_op` (
  `uid` int(8) NOT NULL COMMENT '用户ID',
  `pid` int(8) NOT NULL COMMENT '作品ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like_op`
--

LOCK TABLES `like_op` WRITE;
/*!40000 ALTER TABLE `like_op` DISABLE KEYS */;
/*!40000 ALTER TABLE `like_op` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `public_design`
--

DROP TABLE IF EXISTS `public_design`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `public_design` (
  `pid` int(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `theme` int(8) DEFAULT NULL,
  `desp` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `img` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `count` int(8) DEFAULT NULL,
  PRIMARY KEY (`pid`),
  KEY `theme` (`theme`),
  CONSTRAINT `public_design_ibfk_1` FOREIGN KEY (`theme`) REFERENCES `theme` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `public_design`
--

LOCK TABLES `public_design` WRITE;
/*!40000 ALTER TABLE `public_design` DISABLE KEYS */;
/*!40000 ALTER TABLE `public_design` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requirement`
--

DROP TABLE IF EXISTS `requirement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `requirement` (
  `rid` int(8) NOT NULL AUTO_INCREMENT,
  `theme` int(8) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `deadline` datetime DEFAULT NULL,
  `budget` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `desp` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`rid`),
  KEY `theme` (`theme`),
  CONSTRAINT `requirement_ibfk_1` FOREIGN KEY (`theme`) REFERENCES `theme` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requirement`
--

LOCK TABLES `requirement` WRITE;
/*!40000 ALTER TABLE `requirement` DISABLE KEYS */;
/*!40000 ALTER TABLE `requirement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `theme`
--

DROP TABLE IF EXISTS `theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `theme` (
  `tid` int(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `img` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `theme`
--

LOCK TABLES `theme` WRITE;
/*!40000 ALTER TABLE `theme` DISABLE KEYS */;
/*!40000 ALTER TABLE `theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `uid` int(8) NOT NULL COMMENT '用户ID',
  `username` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `password` varchar(255) COLLATE utf8_bin NOT NULL COMMENT ' 密码',
  ` tel` char(13) COLLATE utf8_bin NOT NULL COMMENT '电话',
  `email` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '邮箱',
  `sex` char(1) COLLATE utf8_bin NOT NULL COMMENT ' 性别',
  `header` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '用户头像',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-24  1:02:41
