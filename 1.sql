/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.5.40 : Database - foot
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`foot` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `foot`;

/*Table structure for table `buy` */

DROP TABLE IF EXISTS `buy`;

CREATE TABLE `buy` (
  `buy_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `flower_id` int(11) DEFAULT NULL,
  `creat_time` datetime DEFAULT NULL,
  `status` int(10) DEFAULT NULL,
  PRIMARY KEY (`buy_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `food_id` (`flower_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `buy` */

insert  into `buy`(`buy_id`,`user_id`,`flower_id`,`creat_time`,`status`) values (23,17,14,'2020-04-11 17:40:41',2),(24,17,NULL,'2020-04-11 17:46:16',0),(25,18,NULL,'2020-04-11 19:45:02',0),(27,18,NULL,'2020-04-11 19:46:09',0),(29,18,12,'2020-04-11 19:51:05',2),(30,18,12,'2020-04-11 19:54:54',2),(33,18,15,'2020-04-12 12:28:49',2),(34,18,15,'2020-04-12 12:28:52',2),(35,18,14,'2020-04-12 16:55:17',1),(36,18,14,'2020-04-12 16:54:40',0),(37,19,28,'2020-04-12 18:22:15',2),(38,19,27,'2020-04-12 18:25:48',2),(39,19,28,NULL,0),(40,19,27,NULL,1);

/*Table structure for table `collect` */

DROP TABLE IF EXISTS `collect`;

CREATE TABLE `collect` (
  `collect_id` int(11) NOT NULL AUTO_INCREMENT,
  `creat_date` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `flower_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`collect_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `food_id` (`flower_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `collect` */

insert  into `collect`(`collect_id`,`creat_date`,`user_id`,`flower_id`) values (21,'2020-04-11 17:40:06',17,14),(25,'2020-04-11 19:49:57',18,14),(30,'2020-04-12 12:28:10',18,15),(31,'2020-04-12 12:31:25',18,17),(32,'2020-04-12 16:53:30',18,14),(33,'2020-04-12 18:20:51',19,28),(35,NULL,19,28),(36,NULL,19,27);

/*Table structure for table `comment` */

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `star` int(10) DEFAULT NULL,
  `comment_desc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creat_time` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `flower_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`comment_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `food_id` (`flower_id`) USING BTREE,
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`flower_id`) REFERENCES `flower` (`flower_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `comment` */

insert  into `comment`(`comment_id`,`star`,`comment_desc`,`creat_time`,`user_id`,`flower_id`) values (37,5,'还可以','2020-04-11 17:39:09',17,14),(38,2,'垃圾','2020-04-11 17:39:14',17,14),(42,3,'真好池啊','2020-04-12 12:29:18',18,15),(43,0,NULL,'2020-04-12 16:28:07',19,14),(44,0,'fd','2020-04-12 16:28:10',19,14),(45,3,NULL,'2020-04-12 16:33:18',19,14),(46,0,'f','2020-04-12 16:43:03',19,14),(47,0,'test','2020-04-12 16:45:47',18,14);

/*Table structure for table `flower` */

DROP TABLE IF EXISTS `flower`;

CREATE TABLE `flower` (
  `flower_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` int(20) DEFAULT NULL,
  `restaurant_id` int(11) DEFAULT NULL,
  `discount` int(10) DEFAULT NULL,
  `flower_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flower_type_id` int(11) DEFAULT NULL,
  `sell_times` int(10) DEFAULT NULL COMMENT '成交的次数',
  PRIMARY KEY (`flower_id`) USING BTREE,
  KEY `restaurant_id` (`restaurant_id`) USING BTREE,
  KEY `food_type_id` (`flower_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `flower` */

insert  into `flower`(`flower_id`,`name`,`price`,`restaurant_id`,`discount`,`flower_image`,`flower_type_id`,`sell_times`) values (12,'白玫瑰',70,NULL,10,'whiteRose.jpg',11,7),(14,'百合',200,NULL,20,'lily.jpg',13,8),(15,'红玫瑰',30,NULL,10,'redRose.jpg',14,10),(16,'月季',150,NULL,20,'rose.jpg',15,0),(17,'牵牛花',70,NULL,20,'morningGlory.jpg',17,0),(18,'水仙花',10,NULL,10,'daffodil.jpg',11,0),(23,'new flower',12121,NULL,10,'test4974.jpg',12,0),(24,'ff',300,NULL,10,'test8385.jpg',13,0),(25,'huahua',100,NULL,1,'78381.jpeg',12,0),(26,'玫瑰花',100,NULL,10,'redRose.jpg',21,0),(27,'百合花',100,NULL,10,'lily.jpg',21,1),(28,'菊花',300,NULL,10,'mum.jpg',22,1),(29,'桃花',300,NULL,30,'peachBlossom.jpg',23,0),(30,'樱花',300,NULL,30,'cherryBlossom.jpeg',23,0),(31,'hh',20,NULL,60,'55497.jpeg',24,0);

/*Table structure for table `flower_type` */

DROP TABLE IF EXISTS `flower_type`;

CREATE TABLE `flower_type` (
  `flower_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`flower_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `flower_type` */

insert  into `flower_type`(`flower_type_id`,`name`) values (21,'玫瑰'),(22,'月季'),(23,'花毛峰'),(24,'好看的花');

/*Table structure for table `restaurant` */

DROP TABLE IF EXISTS `restaurant`;

CREATE TABLE `restaurant` (
  `restaurant_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `head_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`restaurant_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `restaurant_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `restaurant` */

insert  into `restaurant`(`restaurant_id`,`name`,`address`,`phone`,`user_id`,`head_image`) values (1,NULL,'1','1',1,'1');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` int(10) DEFAULT NULL COMMENT '角色：\r\n0：商家\r\n1：买家',
  `head_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `user` */

insert  into `user`(`user_id`,`username`,`password`,`phone`,`address`,`name`,`role`,`head_image`) values (1,'admin','admin','22','22','22222',0,'66697.jpeg'),(17,'uzi','uzi','得到','得到','刘备',1,'uzi225973.jpg'),(18,'user1','user1','153332','南天们大街1号','张飞d2',1,'fcfaaf51f3deb48f3f9c42daf91f3a292df578397518.png'),(19,'aa','12345678','1','1','1',1,'49401.jpeg');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
