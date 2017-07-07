CREATE DATABASE  IF NOT EXISTS `clubedapizza` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `clubedapizza`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: clubedapizza
-- ------------------------------------------------------
-- Server version	5.5.27

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
-- Table structure for table `atendentes`
--

DROP TABLE IF EXISTS `atendentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `atendentes` (
  `idatendentes` int(11) NOT NULL AUTO_INCREMENT,
  `nomeatendente` varchar(45) NOT NULL,
  `codigo` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`idatendentes`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atendentes`
--

LOCK TABLES `atendentes` WRITE;
/*!40000 ALTER TABLE `atendentes` DISABLE KEYS */;
INSERT INTO `atendentes` VALUES (1,'jorge','AB1'),(2,'Paulo','CD2'),(3,'Ana','FG1'),(4,'Paula','CD4');
/*!40000 ALTER TABLE `atendentes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itens`
--

DROP TABLE IF EXISTS `itens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itens` (
  `idpedidos` int(10) unsigned NOT NULL,
  `idpizzas` int(11) NOT NULL,
  `qtde` int(11) DEFAULT NULL,
  `tipo` int(11) DEFAULT '1',
  PRIMARY KEY (`idpedidos`,`idpizzas`),
  KEY `fk_pedidos_has_pizzas_pizzas1_idx` (`idpizzas`),
  KEY `fk_pedidos_has_pizzas_pedidos1_idx` (`idpedidos`),
  CONSTRAINT `fk_pedidos_has_pizzas_pedidos1` FOREIGN KEY (`idpedidos`) REFERENCES `pedidos` (`idpedidos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_has_pizzas_pizzas1` FOREIGN KEY (`idpizzas`) REFERENCES `pizzas` (`idpizzas`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itens`
--

LOCK TABLES `itens` WRITE;
/*!40000 ALTER TABLE `itens` DISABLE KEYS */;
INSERT INTO `itens` VALUES (1,1,2,1),(1,3,4,2),(2,2,3,1),(2,3,4,1),(3,2,5,2),(4,2,5,2),(4,3,4,2),(5,3,2,1),(5,4,2,1),(6,4,5,2),(6,5,3,2),(7,3,4,1),(7,4,10,2),(8,2,1,2),(8,3,2,2),(12,3,3,2);
/*!40000 ALTER TABLE `itens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidos` (
  `idatendentes` int(11) NOT NULL,
  `idsocios` int(11) NOT NULL,
  `idpedidos` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `datapedido` date DEFAULT NULL,
  `valor_total` float DEFAULT '0',
  PRIMARY KEY (`idpedidos`),
  KEY `fk_atendentes_has_socios_socios1_idx` (`idsocios`),
  KEY `fk_atendentes_has_socios_atendentes1_idx` (`idatendentes`),
  CONSTRAINT `fk_atendentes_has_socios_atendentes1` FOREIGN KEY (`idatendentes`) REFERENCES `atendentes` (`idatendentes`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_atendentes_has_socios_socios1` FOREIGN KEY (`idsocios`) REFERENCES `socios` (`idsocios`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,1,1,'2016-01-01',100),(1,1,2,'2016-01-02',100),(1,1,3,'2016-01-03',100),(1,2,4,'2016-01-04',100),(1,2,5,'2016-02-05',100),(1,2,6,'2016-02-06',100),(2,3,7,'2016-03-07',100),(2,3,8,'2016-04-08',100),(1,6,9,'2016-04-09',100),(1,6,10,'2016-05-01',100),(2,4,11,'2016-05-02',100),(2,4,12,'2016-05-03',100),(2,5,13,'2016-01-04',100),(3,6,14,'2016-06-05',100),(3,6,15,'2016-06-03',100),(1,6,16,'2016-03-06',100),(2,4,17,'2016-03-09',100),(2,4,18,'2016-02-10',100),(2,5,19,'2016-02-11',100),(3,6,20,'2016-04-12',100),(3,6,21,'2016-01-14',100);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pizzas`
--

DROP TABLE IF EXISTS `pizzas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pizzas` (
  `idpizzas` int(11) NOT NULL AUTO_INCREMENT,
  `saborpizza` varchar(45) DEFAULT NULL,
  `preco` float DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `quantidade_critica` int(11) DEFAULT '10',
  PRIMARY KEY (`idpizzas`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pizzas`
--

LOCK TABLES `pizzas` WRITE;
/*!40000 ALTER TABLE `pizzas` DISABLE KEYS */;
INSERT INTO `pizzas` VALUES (1,'mussarela',40,60,10),(2,'calabresa',35,60,10),(3,'4 queijos',40,60,10),(4,'baiana',45,60,10),(5,'portuguesa',30,60,10),(6,'frango com catupiri',50,90,10),(7,'mista de 4 queijos e sardinha',50,100,10),(8,'portuguesa com calabresa',60,50,10);
/*!40000 ALTER TABLE `pizzas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socios`
--

DROP TABLE IF EXISTS `socios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socios` (
  `idsocios` int(11) NOT NULL AUTO_INCREMENT,
  `nomesocio` varchar(45) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `idtipo_socio` int(11) NOT NULL,
  PRIMARY KEY (`idsocios`,`idtipo_socio`),
  KEY `fk_socios_tipo_socios_idx` (`idtipo_socio`),
  CONSTRAINT `fk_socios_tipo_socios` FOREIGN KEY (`idtipo_socio`) REFERENCES `tipo_socios` (`idtipo_socio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socios`
--

LOCK TABLES `socios` WRITE;
/*!40000 ALTER TABLE `socios` DISABLE KEYS */;
INSERT INTO `socios` VALUES (1,'Flavia','12345','9999-5555',1),(2,'Fernando','23456','8888-5555',1),(3,'Lilian','34567','7777-5555',1),(4,'Renato','45678','6666-5555',2),(5,'Rafaela','56789','9988-5555',2),(6,'Yasmin','67890','9911-5555',3),(7,'Lane','78901','9966-5555',3),(8,'Alisson','89012','9900-5555',3);
/*!40000 ALTER TABLE `socios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_socios`
--

DROP TABLE IF EXISTS `tipo_socios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_socios` (
  `idtipo_socio` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_socio` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idtipo_socio`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_socios`
--

LOCK TABLES `tipo_socios` WRITE;
/*!40000 ALTER TABLE `tipo_socios` DISABLE KEYS */;
INSERT INTO `tipo_socios` VALUES (1,'ouro'),(2,'prata'),(3,'bronze');
/*!40000 ALTER TABLE `tipo_socios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'clubedapizza'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-08 23:08:40
