
CREATE DATABASE  IF NOT EXISTS `im_test2` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `im_test2`;
-- MySQL dump 10.13  Distrib 5.6.19, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: im_test2
-- ------------------------------------------------------
-- Server version	5.6.21-enterprise-commercial-advanced-log

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
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cities` (
  `id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `region_id` int(11) DEFAULT NULL,
  `name` varchar(65) NOT NULL,
  `iso_code` varchar(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cities_countries_idx` (`country_id`),
  KEY `fk_cities_regions_idx` (`region_id`),
  CONSTRAINT `fk_cities_countries` FOREIGN KEY (`country_id`) REFERENCES `countries` (`idCountries`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cities_regions` FOREIGN KEY (`region_id`) REFERENCES `regions` (`idregions`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `idCountries` int(11) NOT NULL,
  `iso2` varchar(45) NOT NULL,
  `iso3` varchar(45) NOT NULL,
  `name` varchar(75) NOT NULL,
  `targetable` int(11) NOT NULL,
  PRIMARY KEY (`idCountries`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regions`
--

DROP TABLE IF EXISTS `regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regions` (
  `idregions` int(11) NOT NULL,
  `idCountries` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `iso_code` varchar(45) NOT NULL,
  PRIMARY KEY (`idregions`),
  KEY `fk_regions_cities_idx` (`idCountries`),
  CONSTRAINT `fk_regions_countries` FOREIGN KEY (`idCountries`) REFERENCES `countries` (`idCountries`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regions`
--

LOCK TABLES `regions` WRITE;
/*!40000 ALTER TABLE `regions` DISABLE KEYS */;
/*!40000 ALTER TABLE `regions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-11-09 23:30:35
CREATE DATABASE  IF NOT EXISTS `im_data` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `im_data`;
-- MySQL dump 10.13  Distrib 5.6.19, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: im_data
-- ------------------------------------------------------
-- Server version	5.6.21-enterprise-commercial-advanced-log

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
-- Table structure for table `campaigns`
--

DROP TABLE IF EXISTS `campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaigns` (
  `campaign_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `client_id` int(11) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`campaign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaigns`
--

LOCK TABLES `campaigns` WRITE;
/*!40000 ALTER TABLE `campaigns` DISABLE KEYS */;
INSERT INTO `campaigns` VALUES (5555,'Audience',1,'2012-06-07 00:00:00','2012-09-30 00:00:00'),(12345,'Prospecting',5,'2012-10-12 00:00:00','2012-06-22 00:00:00'),(33333,'Retargeting',5,'2012-04-06 00:00:00','2012-07-06 00:00:00');
/*!40000 ALTER TABLE `campaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `client_id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Dell','USA'),(2,'TotemFilms','London'),(3,'TrottersInc','Shephards Bush'),(4,'Mary\'s Cafe','London'),(5,'Tom\'s Trucks','London');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_cost_by_day`
--

DROP TABLE IF EXISTS `data_cost_by_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_cost_by_day` (
  `date` date NOT NULL,
  `campaign_id` int(11) NOT NULL,
  `cost` decimal(19,0) DEFAULT '0',
  PRIMARY KEY (`date`,`campaign_id`),
  KEY `fk_data_cost_by_day_campaigns_idx` (`campaign_id`),
  CONSTRAINT `fk_data_cost_by_day_campaigns` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`campaign_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_cost_by_day`
--

LOCK TABLES `data_cost_by_day` WRITE;
/*!40000 ALTER TABLE `data_cost_by_day` DISABLE KEYS */;
INSERT INTO `data_cost_by_day` VALUES ('2014-11-09',12345,0);
/*!40000 ALTER TABLE `data_cost_by_day` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datapartners`
--

DROP TABLE IF EXISTS `datapartners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datapartners` (
  `idDataPartners` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `accountNumber` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idDataPartners`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datapartners`
--

LOCK TABLES `datapartners` WRITE;
/*!40000 ALTER TABLE `datapartners` DISABLE KEYS */;
/*!40000 ALTER TABLE `datapartners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_by_day`
--

DROP TABLE IF EXISTS `delivery_by_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery_by_day` (
  `date` datetime NOT NULL,
  `campaign_id` int(11) NOT NULL,
  `media_cost` decimal(19,0) NOT NULL,
  `cost_to_client` decimal(19,0) NOT NULL,
  `delivered_impressions` int(11) NOT NULL,
  `clicks` int(11) NOT NULL,
  `third_party_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`date`,`campaign_id`),
  KEY `fk_del_by_day_campaigns_idx` (`campaign_id`),
  KEY `fk_del_by_day_third_party_idx` (`third_party_id`),
  CONSTRAINT `fk_del_by_day_campaigns` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`campaign_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_del_by_day_third_party` FOREIGN KEY (`third_party_id`) REFERENCES `third_parties` (`third_party_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_by_day`
--

LOCK TABLES `delivery_by_day` WRITE;
/*!40000 ALTER TABLE `delivery_by_day` DISABLE KEYS */;
INSERT INTO `delivery_by_day` VALUES ('2012-06-09 00:00:00',5555,553,664,733543,280,NULL),('2012-06-09 00:00:00',12345,124,149,432845,902,2),('2012-06-09 00:00:00',33333,662,795,865123,321,3),('2012-06-10 00:00:00',5555,982,1179,1111321,333,2),('2012-06-10 00:00:00',12345,121,146,351984,1232,1),('2012-06-10 00:00:00',33333,165,199,550352,542,3),('2014-11-09 22:15:51',12345,150,180,100000,50,NULL);
/*!40000 ALTER TABLE `delivery_by_day` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger addDataCosts
	before insert on delivery_by_day
		for each row
			begin
				if (new.third_party_id is null)  then	 -- if the type is null (no metric) then zero data cost
					insert into data_cost_by_day (date, campaign_id, cost) values (now(), new.campaign_id, 0);
                
				elseif (select metric_type from third_parties where third_party_id = new.third_party_id = "CPC") -- if the type is CPC
				then	
					insert into data_cost_by_day (date, campaign_id, cost)
					values (now(), new.campaign_id, new.clicks * (
															(select rate_paid_to_third_party from third_parties where third_party_id = new.third_party_id)  
                                                            ));
				else		-- otherwise it is percent revenue
					insert into data_cost_by_day (date, campaign_id, cost) 
                    values (now(), new.campaign_id, new.delivered_impressions * (
															(select rate_paid_to_third_party from third_parties where third_party_id = new.third_party_id)  
                                                            ));
                end if;
			end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `log_third_parties`
--

DROP TABLE IF EXISTS `log_third_parties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_third_parties` (
  `idlog_third_party` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(45) NOT NULL,
  `date` date NOT NULL,
  `action` varchar(45) NOT NULL,
  `third_party_id` int(11) NOT NULL,
  PRIMARY KEY (`idlog_third_party`),
  KEY `fk_log_third_third_idx` (`third_party_id`),
  CONSTRAINT `fk_log_third_third` FOREIGN KEY (`third_party_id`) REFERENCES `third_parties` (`third_party_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_third_parties`
--

LOCK TABLES `log_third_parties` WRITE;
/*!40000 ALTER TABLE `log_third_parties` DISABLE KEYS */;
INSERT INTO `log_third_parties` VALUES (1,'root','2014-11-09','INSERT',5),(3,'root','2014-11-09','INSERT',6),(4,'root','2014-11-09','INSERT',5);
/*!40000 ALTER TABLE `log_third_parties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `third_parties`
--

DROP TABLE IF EXISTS `third_parties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `third_parties` (
  `third_party_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `metric_type` varchar(13) NOT NULL,
  `rate_paid_to_third_party` decimal(5,2) NOT NULL,
  `rate_charged_to_client` decimal(5,2) NOT NULL,
  `campaign_id` int(11) NOT NULL,
  `date_start` datetime NOT NULL,
  `date_end` datetime DEFAULT NULL,
  `active` bit(1) NOT NULL,
  PRIMARY KEY (`third_party_id`),
  KEY `kf_metric_campaign_idx` (`campaign_id`),
  CONSTRAINT `kf_metric_campaign` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`campaign_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `third_parties`
--

LOCK TABLES `third_parties` WRITE;
/*!40000 ALTER TABLE `third_parties` DISABLE KEYS */;
INSERT INTO `third_parties` VALUES (1,'eXelate-Interest','Revenue Share',10.00,10.00,12345,'2011-12-12 00:00:00','2099-12-30 00:00:00','\0'),(2,'eXcelate-demo','Revenue Share',20.00,5.00,33333,'2012-04-06 00:00:00','2099-12-30 00:00:00','\0'),(3,'MarketS','CPC',0.10,0.05,5555,'2012-06-07 00:00:00','2012-09-30 00:00:00','\0'),(4,'iDataFolk','CPC',0.12,0.10,12345,'2012-06-05 00:00:00','2099-12-30 00:00:00','\0'),(5,'foo','CPC',0.10,0.75,12345,'2012-06-06 00:00:00','2099-06-06 00:00:00','\0'),(6,'foo','CPC',0.10,0.75,12345,'2012-06-06 00:00:00','2099-06-06 00:00:00','');
/*!40000 ALTER TABLE `third_parties` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger logThirdPartyChangeInsert
	before insert on third_parties
		for each row
			insert into log_third_parties (user, date, action, third_party_id)
            values ((SELECT SUBSTRING_INDEX(USER(),'@',1) from dual), now(), 'INSERT', new.third_party_id) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger logThirdPartyChangeUpdate
	before update on third_parties
		for each row
			insert into log_third_parties (user, date, action, third_party_id)
            values ((SELECT SUBSTRING_INDEX(USER(),'@',1) from dual), now(), 'UPDATE', new.third_party_id) */;;
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

-- Dump completed on 2014-11-09 23:30:35
