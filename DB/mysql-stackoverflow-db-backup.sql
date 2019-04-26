-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: stackoverflow
-- ------------------------------------------------------
-- Server version	5.7.20-log

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
-- Table structure for table `acceptedanswer`
--

DROP TABLE IF EXISTS `acceptedanswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acceptedanswer` (
  `acceptedansid` int(11) NOT NULL AUTO_INCREMENT,
  `createdon` datetime(6) DEFAULT NULL,
  `updatedon` datetime(6) DEFAULT NULL,
  `ansid` int(11) DEFAULT NULL,
  `queid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  PRIMARY KEY (`acceptedansid`),
  KEY `acceptedanswer_ansid_2d69ab62_fk_answer_ansid` (`ansid`),
  KEY `acceptedanswer_queid_3f39c1c1_fk_question_queid` (`queid`),
  KEY `acceptedanswer_userid_be9cfac5_fk_auth_user_id` (`userid`),
  CONSTRAINT `acceptedanswer_ansid_2d69ab62_fk_answer_ansid` FOREIGN KEY (`ansid`) REFERENCES `answer` (`ansid`),
  CONSTRAINT `acceptedanswer_queid_3f39c1c1_fk_question_queid` FOREIGN KEY (`queid`) REFERENCES `question` (`queid`),
  CONSTRAINT `acceptedanswer_userid_be9cfac5_fk_auth_user_id` FOREIGN KEY (`userid`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acceptedanswer`
--

LOCK TABLES `acceptedanswer` WRITE;
/*!40000 ALTER TABLE `acceptedanswer` DISABLE KEYS */;
INSERT INTO `acceptedanswer` VALUES (1,'2019-04-25 23:57:02.023130','2019-04-25 23:57:02.023130',1,1,2);
/*!40000 ALTER TABLE `acceptedanswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer` (
  `ansid` int(11) NOT NULL AUTO_INCREMENT,
  `ans_desc` longtext,
  `total_upvote` int(11) DEFAULT NULL,
  `total_downvote` int(11) DEFAULT NULL,
  `createdon` datetime(6) DEFAULT NULL,
  `updatedon` datetime(6) DEFAULT NULL,
  `createdby` int(11) DEFAULT NULL,
  `queid` int(11) DEFAULT NULL,
  PRIMARY KEY (`ansid`),
  KEY `answer_createdby_eb269bd2_fk_auth_user_id` (`createdby`),
  KEY `answer_queid_a46d26ac_fk_question_queid` (`queid`),
  CONSTRAINT `answer_createdby_eb269bd2_fk_auth_user_id` FOREIGN KEY (`createdby`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `answer_queid_a46d26ac_fk_question_queid` FOREIGN KEY (`queid`) REFERENCES `question` (`queid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES (1,'Good',0,0,'2019-04-25 23:55:40.556353','2019-04-25 23:55:40.556353',2,1),(2,'byyy',0,0,'2019-04-25 23:56:17.067560','2019-04-25 23:56:17.067560',2,1),(3,'FINE ',1,0,'2019-04-26 01:02:10.877730','2019-04-26 01:02:39.205761',1,1),(4,'majama',1,0,'2019-04-26 01:06:26.146438','2019-04-26 01:06:54.926369',1,2),(5,'Fine',1,0,'2019-04-26 01:08:50.281725','2019-04-26 01:09:10.860658',1,3),(6,'kskankjsanns',1,0,'2019-04-26 01:14:08.491569','2019-04-26 01:14:24.183137',1,4);
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add accept answer',1,'add_acceptanswer'),(2,'Can change accept answer',1,'change_acceptanswer'),(3,'Can delete accept answer',1,'delete_acceptanswer'),(4,'Can add answer',2,'add_answer'),(5,'Can change answer',2,'change_answer'),(6,'Can delete answer',2,'delete_answer'),(7,'Can add comment on answer',3,'add_commentonanswer'),(8,'Can change comment on answer',3,'change_commentonanswer'),(9,'Can delete comment on answer',3,'delete_commentonanswer'),(10,'Can add downvote answer',4,'add_downvoteanswer'),(11,'Can change downvote answer',4,'change_downvoteanswer'),(12,'Can delete downvote answer',4,'delete_downvoteanswer'),(13,'Can add favourite answer',5,'add_favouriteanswer'),(14,'Can change favourite answer',5,'change_favouriteanswer'),(15,'Can delete favourite answer',5,'delete_favouriteanswer'),(16,'Can add question',6,'add_question'),(17,'Can change question',6,'change_question'),(18,'Can delete question',6,'delete_question'),(19,'Can add upvote answer',7,'add_upvoteanswer'),(20,'Can change upvote answer',7,'change_upvoteanswer'),(21,'Can delete upvote answer',7,'delete_upvoteanswer'),(22,'Can add user profile',8,'add_userprofile'),(23,'Can change user profile',8,'change_userprofile'),(24,'Can delete user profile',8,'delete_userprofile'),(25,'Can add log entry',9,'add_logentry'),(26,'Can change log entry',9,'change_logentry'),(27,'Can delete log entry',9,'delete_logentry'),(28,'Can add permission',10,'add_permission'),(29,'Can change permission',10,'change_permission'),(30,'Can delete permission',10,'delete_permission'),(31,'Can add group',11,'add_group'),(32,'Can change group',11,'change_group'),(33,'Can delete group',11,'delete_group'),(34,'Can add user',12,'add_user'),(35,'Can change user',12,'change_user'),(36,'Can delete user',12,'delete_user'),(37,'Can add content type',13,'add_contenttype'),(38,'Can change content type',13,'change_contenttype'),(39,'Can delete content type',13,'delete_contenttype'),(40,'Can add session',14,'add_session'),(41,'Can change session',14,'change_session'),(42,'Can delete session',14,'delete_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$acjZyf4Hd5yV$mNSUmWdf4Bikpf7p0Uu7JezYXrm9TGSIW7QqZrcmATA=','2019-04-25 19:44:00.951647',0,'dhaval','','','',0,1,'2019-04-25 18:21:09.216518'),(2,'pbkdf2_sha256$36000$9tY9cUIPEtVC$jj3CewTOiHSSM+Hr4z545+NgZb+wZXasxEciD3yWHus=','2019-04-25 19:44:15.482737',0,'admin','','','',0,1,'2019-04-25 18:24:58.021138');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commentonanswer`
--

DROP TABLE IF EXISTS `commentonanswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commentonanswer` (
  `cmtid` int(11) NOT NULL AUTO_INCREMENT,
  `cmt_desc` longtext,
  `createdon` datetime(6) DEFAULT NULL,
  `updatedon` datetime(6) DEFAULT NULL,
  `ansid` int(11) DEFAULT NULL,
  `queid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cmtid`),
  KEY `commentonanswer_ansid_f6cd0523_fk_answer_ansid` (`ansid`),
  KEY `commentonanswer_queid_a46b0e56_fk_question_queid` (`queid`),
  KEY `commentonanswer_userid_329b2328_fk_auth_user_id` (`userid`),
  CONSTRAINT `commentonanswer_ansid_f6cd0523_fk_answer_ansid` FOREIGN KEY (`ansid`) REFERENCES `answer` (`ansid`),
  CONSTRAINT `commentonanswer_queid_a46b0e56_fk_question_queid` FOREIGN KEY (`queid`) REFERENCES `question` (`queid`),
  CONSTRAINT `commentonanswer_userid_329b2328_fk_auth_user_id` FOREIGN KEY (`userid`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commentonanswer`
--

LOCK TABLES `commentonanswer` WRITE;
/*!40000 ALTER TABLE `commentonanswer` DISABLE KEYS */;
INSERT INTO `commentonanswer` VALUES (1,'hhhh','2019-04-26 00:13:30.327750','2019-04-26 00:13:30.327750',1,1,2),(2,'broooooo','2019-04-26 00:38:08.801506','2019-04-26 00:38:08.801506',1,1,2),(3,'good','2019-04-26 00:43:30.556889','2019-04-26 00:43:30.556889',2,1,2);
/*!40000 ALTER TABLE `commentonanswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (9,'admin','logentry'),(1,'app','acceptanswer'),(2,'app','answer'),(3,'app','commentonanswer'),(4,'app','downvoteanswer'),(5,'app','favouriteanswer'),(6,'app','question'),(7,'app','upvoteanswer'),(8,'app','userprofile'),(11,'auth','group'),(10,'auth','permission'),(12,'auth','user'),(13,'contenttypes','contenttype'),(14,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-04-25 18:18:53.060810'),(2,'auth','0001_initial','2019-04-25 18:18:55.022032'),(3,'admin','0001_initial','2019-04-25 18:18:55.485674'),(4,'admin','0002_logentry_remove_auto_add','2019-04-25 18:18:55.501302'),(5,'app','0001_initial','2019-04-25 18:19:01.393645'),(6,'contenttypes','0002_remove_content_type_name','2019-04-25 18:19:01.709615'),(7,'auth','0002_alter_permission_name_max_length','2019-04-25 18:19:01.885501'),(8,'auth','0003_alter_user_email_max_length','2019-04-25 18:19:02.111873'),(9,'auth','0004_alter_user_username_opts','2019-04-25 18:19:02.155899'),(10,'auth','0005_alter_user_last_login_null','2019-04-25 18:19:02.318826'),(11,'auth','0006_require_contenttypes_0002','2019-04-25 18:19:02.339031'),(12,'auth','0007_alter_validators_add_error_messages','2019-04-25 18:19:02.383028'),(13,'auth','0008_alter_user_username_max_length','2019-04-25 18:19:02.573525'),(14,'sessions','0001_initial','2019-04-25 18:19:02.742939');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('vaflep77dqre6m49absrr02zojj47vgx','MTVmMjJlY2RlMzUzNWY2NmJjY2ZjMDFjMDBmMzhjZWZkYzkzNWMzYzp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkOGVhNDFiZDUxNTA2YTcxNmQzYmFiYjgxM2Y1MDc3MTA2NTFkZTQ3In0=','2019-05-09 19:44:15.490737');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `downvoteanswer`
--

DROP TABLE IF EXISTS `downvoteanswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `downvoteanswer` (
  `upvoteid` int(11) NOT NULL AUTO_INCREMENT,
  `createdon` datetime(6) DEFAULT NULL,
  `updatedon` datetime(6) DEFAULT NULL,
  `ansid` int(11) DEFAULT NULL,
  `queid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  PRIMARY KEY (`upvoteid`),
  KEY `downvoteanswer_ansid_5f46b168_fk_answer_ansid` (`ansid`),
  KEY `downvoteanswer_queid_168b2b2b_fk_question_queid` (`queid`),
  KEY `downvoteanswer_userid_1e164dce_fk_auth_user_id` (`userid`),
  CONSTRAINT `downvoteanswer_ansid_5f46b168_fk_answer_ansid` FOREIGN KEY (`ansid`) REFERENCES `answer` (`ansid`),
  CONSTRAINT `downvoteanswer_queid_168b2b2b_fk_question_queid` FOREIGN KEY (`queid`) REFERENCES `question` (`queid`),
  CONSTRAINT `downvoteanswer_userid_1e164dce_fk_auth_user_id` FOREIGN KEY (`userid`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `downvoteanswer`
--

LOCK TABLES `downvoteanswer` WRITE;
/*!40000 ALTER TABLE `downvoteanswer` DISABLE KEYS */;
/*!40000 ALTER TABLE `downvoteanswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favouriteanswer`
--

DROP TABLE IF EXISTS `favouriteanswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favouriteanswer` (
  `favid` int(11) NOT NULL AUTO_INCREMENT,
  `createdon` datetime(6) DEFAULT NULL,
  `updatedon` datetime(6) DEFAULT NULL,
  `ansid` int(11) DEFAULT NULL,
  `queid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  PRIMARY KEY (`favid`),
  KEY `favouriteanswer_ansid_00573464_fk_answer_ansid` (`ansid`),
  KEY `favouriteanswer_queid_1ca12e19_fk_question_queid` (`queid`),
  KEY `favouriteanswer_userid_79450bd5_fk_auth_user_id` (`userid`),
  CONSTRAINT `favouriteanswer_ansid_00573464_fk_answer_ansid` FOREIGN KEY (`ansid`) REFERENCES `answer` (`ansid`),
  CONSTRAINT `favouriteanswer_queid_1ca12e19_fk_question_queid` FOREIGN KEY (`queid`) REFERENCES `question` (`queid`),
  CONSTRAINT `favouriteanswer_userid_79450bd5_fk_auth_user_id` FOREIGN KEY (`userid`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favouriteanswer`
--

LOCK TABLES `favouriteanswer` WRITE;
/*!40000 ALTER TABLE `favouriteanswer` DISABLE KEYS */;
/*!40000 ALTER TABLE `favouriteanswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question` (
  `queid` int(11) NOT NULL AUTO_INCREMENT,
  `que_title` varchar(200) DEFAULT NULL,
  `que_desc` longtext,
  `que_tag` varchar(45) DEFAULT NULL,
  `createdon` datetime(6) DEFAULT NULL,
  `updatedon` datetime(6) DEFAULT NULL,
  `createdby` int(11) DEFAULT NULL,
  PRIMARY KEY (`queid`),
  KEY `question_createdby_467ce8fc_fk_auth_user_id` (`createdby`),
  CONSTRAINT `question_createdby_467ce8fc_fk_auth_user_id` FOREIGN KEY (`createdby`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,'hello','How are you?',NULL,'2019-04-25 23:53:28.010977','2019-04-25 23:53:28.010977',1),(2,'guj','Kem cho',NULL,'2019-04-26 01:05:51.922862','2019-04-26 01:05:51.922862',2),(3,'New que','How do you do?',NULL,'2019-04-26 01:08:12.349222','2019-04-26 01:08:12.349222',2),(4,'zzzzz','hhuhxhxh',NULL,'2019-04-26 01:13:44.668201','2019-04-26 01:13:44.668201',2);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upvoteanswer`
--

DROP TABLE IF EXISTS `upvoteanswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upvoteanswer` (
  `upvoteid` int(11) NOT NULL AUTO_INCREMENT,
  `createdon` datetime(6) DEFAULT NULL,
  `updatedon` datetime(6) DEFAULT NULL,
  `ansid` int(11) DEFAULT NULL,
  `queid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  PRIMARY KEY (`upvoteid`),
  KEY `upvoteanswer_ansid_a88f0eff_fk_answer_ansid` (`ansid`),
  KEY `upvoteanswer_queid_98801aa0_fk_question_queid` (`queid`),
  KEY `upvoteanswer_userid_8fc015c0_fk_auth_user_id` (`userid`),
  CONSTRAINT `upvoteanswer_ansid_a88f0eff_fk_answer_ansid` FOREIGN KEY (`ansid`) REFERENCES `answer` (`ansid`),
  CONSTRAINT `upvoteanswer_queid_98801aa0_fk_question_queid` FOREIGN KEY (`queid`) REFERENCES `question` (`queid`),
  CONSTRAINT `upvoteanswer_userid_8fc015c0_fk_auth_user_id` FOREIGN KEY (`userid`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upvoteanswer`
--

LOCK TABLES `upvoteanswer` WRITE;
/*!40000 ALTER TABLE `upvoteanswer` DISABLE KEYS */;
INSERT INTO `upvoteanswer` VALUES (1,'2019-04-26 01:02:39.193759','2019-04-26 01:02:39.193759',3,1,2),(2,'2019-04-26 01:06:54.908369','2019-04-26 01:06:54.908369',4,2,2),(3,'2019-04-26 01:09:10.848661','2019-04-26 01:09:10.848661',5,3,2),(4,'2019-04-26 01:14:24.169143','2019-04-26 01:14:24.169143',6,4,2);
/*!40000 ALTER TABLE `upvoteanswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userprofile`
--

DROP TABLE IF EXISTS `userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reputationpoint` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `userprofile_user_id_7b9586be_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userprofile`
--

LOCK TABLES `userprofile` WRITE;
/*!40000 ALTER TABLE `userprofile` DISABLE KEYS */;
INSERT INTO `userprofile` VALUES (1,2,1),(2,3,2);
/*!40000 ALTER TABLE `userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'stackoverflow'
--

--
-- Dumping routines for database 'stackoverflow'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-26  8:58:39
