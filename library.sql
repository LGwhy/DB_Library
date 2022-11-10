CREATE DATABASE  IF NOT EXISTS `library` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `library`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: library
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `ISBN号` varchar(15) NOT NULL,
  `书名` varchar(30) NOT NULL,
  `作者` varchar(20) DEFAULT NULL,
  `类型` varchar(15) DEFAULT NULL,
  `价格` float DEFAULT NULL,
  `出版社` varchar(45) DEFAULT NULL,
  `摘要` varchar(50) DEFAULT NULL,
  `馆藏册数` int DEFAULT NULL,
  `在馆册数` int DEFAULT NULL,
  `书架号` varchar(15) DEFAULT NULL,
  `被借次数` int DEFAULT NULL,
  PRIMARY KEY (`ISBN号`),
  KEY `书架号_idx` (`书架号`),
  CONSTRAINT `书架号` FOREIGN KEY (`书架号`) REFERENCES `bookshelfs` (`书架号`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES ('9787029385749','大学物理','王少杰','物理类',59,'科学出版社','“十二五”规划教材',6,6,'P01',0),('9787030284464','高等数学','上海交通大学编','数学类',49,'科学出版社','21实际高等院校教材',5,5,'M01',0),('9787115230843','脚本编程','阮文江','计算机类',32,'人民邮电出版社','21世纪高等学校计算机规划教材',1,0,'C01',1),('978711537465','软件测试','佟伟光','计算机类',39.8,'人民邮电出版社','“十二五”规划教材',4,4,'C01',0),('9787121282720','软件构造','李劲华','计算机类',45,'电子工业出版社','高等学校计算机规划教材',5,5,'C01',0),('9787201088945','皮囊','蔡崇达','哲学类',49,'天津人民出版社','刻在骨头里的故事',3,3,'P02',1),('9787544646840','视听说教程','孙倚娜','英语类',45,'上海外语教育出版社','全新版大学进阶英语',2,2,'L01',0);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookshelfs`
--

DROP TABLE IF EXISTS `bookshelfs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookshelfs` (
  `书架号` varchar(10) NOT NULL,
  `书籍类型` varchar(45) NOT NULL,
  PRIMARY KEY (`书架号`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookshelfs`
--

LOCK TABLES `bookshelfs` WRITE;
/*!40000 ALTER TABLE `bookshelfs` DISABLE KEYS */;
INSERT INTO `bookshelfs` VALUES ('C01','计算机类'),('L01','外语类'),('M01','数学类'),('P01','物理类'),('P02','哲学类');
/*!40000 ALTER TABLE `bookshelfs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrow`
--

DROP TABLE IF EXISTS `borrow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrow` (
  `ID` varchar(15) NOT NULL,
  `ISBN号` varchar(15) NOT NULL,
  `借书时间` date NOT NULL,
  PRIMARY KEY (`ID`,`ISBN号`,`借书时间`),
  KEY `书号_idx` (`ISBN号`),
  CONSTRAINT `ID` FOREIGN KEY (`ID`) REFERENCES `readers` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `书号` FOREIGN KEY (`ISBN号`) REFERENCES `books` (`ISBN号`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='		';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrow`
--

LOCK TABLES `borrow` WRITE;
/*!40000 ALTER TABLE `borrow` DISABLE KEYS */;
INSERT INTO `borrow` VALUES ('201701630','9787115230843','2021-12-28');
/*!40000 ALTER TABLE `borrow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `bookid` varchar(15) NOT NULL,
  `ID` varchar(15) NOT NULL,
  `time` date NOT NULL,
  `type` enum('borrow','return') NOT NULL,
  PRIMARY KEY (`bookid`,`ID`,`time`,`type`),
  KEY `readerid_idx` (`ID`),
  CONSTRAINT `bookid` FOREIGN KEY (`bookid`) REFERENCES `books` (`ISBN号`),
  CONSTRAINT `readerid` FOREIGN KEY (`ID`) REFERENCES `readers` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES ('9787030284464','201701601','2021-12-28','borrow');
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loginrecord`
--

DROP TABLE IF EXISTS `loginrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loginrecord` (
  `ID` varchar(15) DEFAULT NULL,
  `time` date NOT NULL,
  `number` int NOT NULL,
  PRIMARY KEY (`time`,`number`),
  KEY `readerid_idx` (`ID`),
  CONSTRAINT `readerid2` FOREIGN KEY (`ID`) REFERENCES `readers` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loginrecord`
--

LOCK TABLES `loginrecord` WRITE;
/*!40000 ALTER TABLE `loginrecord` DISABLE KEYS */;
INSERT INTO `loginrecord` VALUES ('201701601','2021-12-28',1),('201701601','2021-12-28',9),('201701630','2021-12-28',2),('201701630','2021-12-28',3),('201701630','2021-12-28',4),('201701630','2021-12-28',5),('201701630','2021-12-28',6),('201701630','2021-12-28',7),('201701630','2021-12-28',8),('201701630','2021-12-29',1),('201701630','2021-12-29',2);
/*!40000 ALTER TABLE `loginrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `readers`
--

DROP TABLE IF EXISTS `readers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `readers` (
  `ID` varchar(15) NOT NULL,
  `姓名` varchar(20) NOT NULL,
  `性别` enum('男','女') DEFAULT NULL,
  `学院` varchar(45) DEFAULT NULL,
  `读者类型` varchar(45) DEFAULT NULL,
  `可借册数` int DEFAULT NULL,
  `在借册数` int DEFAULT NULL,
  `password` varchar(20) NOT NULL DEFAULT '123456',
  `欠款` float DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='				';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `readers`
--

LOCK TABLES `readers` WRITE;
/*!40000 ALTER TABLE `readers` DISABLE KEYS */;
INSERT INTO `readers` VALUES ('201701601','王明阳','男','资源与环境学院','本科生',10,0,'123456',0),('201701602','王新萍','女','资源与环境学院','本科生',10,0,'123456',0),('201701603','卢俊兆','男','资源与环境学院','本科生',10,0,'123456',0),('201701604','齐凯','男','资源与环境学院','本科生',10,0,'123456',0),('201701605','李星阳','男','资源与环境学院','本科生',10,0,'123456',0),('201701611','黄永明','男','水资源学院','本科生',10,0,'123456',0),('201701630','曾祥龙','男','信息工程学院','本科生',9,1,'123',0),('201917401','王博','男','信息工程学院','本科生',10,0,'123456',0),('201917402','王云龙','男','信息工程学院','本科生',10,0,'123456',0),('201917403','冯宇航','男','信息工程学院','本科生',10,0,'123456',0),('201917404','王理想','男','信息工程学院','本科生',10,0,'123456',0);
/*!40000 ALTER TABLE `readers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `readertype`
--

DROP TABLE IF EXISTS `readertype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `readertype` (
  `读者类型` varchar(10) NOT NULL,
  `借书时间` int DEFAULT NULL,
  `最多在借册数` int DEFAULT NULL,
  PRIMARY KEY (`读者类型`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `readertype`
--

LOCK TABLES `readertype` WRITE;
/*!40000 ALTER TABLE `readertype` DISABLE KEYS */;
INSERT INTO `readertype` VALUES ('教师',3,30),('本科生',1,10),('研究生',2,20);
/*!40000 ALTER TABLE `readertype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workers`
--

DROP TABLE IF EXISTS `workers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workers` (
  `ID` varchar(15) NOT NULL,
  `姓名` varchar(20) NOT NULL,
  `type` enum('图书管理员','系统管理员') NOT NULL,
  `password` varchar(20) NOT NULL DEFAULT '123456',
  PRIMARY KEY (`ID`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workers`
--

LOCK TABLES `workers` WRITE;
/*!40000 ALTER TABLE `workers` DISABLE KEYS */;
INSERT INTO `workers` VALUES ('1','曾祥龙','图书管理员','1'),('1','曾祥龙','系统管理员','1'),('2','王惠叶','图书管理员','2'),('3','老狗','图书管理员','3');
/*!40000 ALTER TABLE `workers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-29 11:43:52
