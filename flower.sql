/*
 Navicat MySQL Data Transfer

 Source Server         : hei
 Source Server Type    : MySQL
 Source Server Version : 50729
 Source Host           : localhost:3306
 Source Schema         : foot

 Target Server Type    : MySQL
 Target Server Version : 50729
 File Encoding         : 65001

 Date: 12/04/2020 19:45:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for buy
-- ----------------------------
DROP TABLE IF EXISTS `buy`;
CREATE TABLE `buy` (
  `buy_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `flower_id` int(11) DEFAULT NULL,
  `creat_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int(10) DEFAULT NULL,
  PRIMARY KEY (`buy_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `food_id` (`flower_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of buy
-- ----------------------------
BEGIN;
INSERT INTO `buy` VALUES (23, 17, 14, '2020-04-11 17:40:41', 2);
INSERT INTO `buy` VALUES (24, 17, NULL, '2020-04-11 17:46:16', 0);
INSERT INTO `buy` VALUES (25, 18, NULL, '2020-04-11 19:45:02', 0);
INSERT INTO `buy` VALUES (27, 18, NULL, '2020-04-11 19:46:09', 0);
INSERT INTO `buy` VALUES (29, 18, 12, '2020-04-11 19:51:05', 2);
INSERT INTO `buy` VALUES (30, 18, 12, '2020-04-11 19:54:54', 2);
INSERT INTO `buy` VALUES (33, 18, 15, '2020-04-12 12:28:49', 2);
INSERT INTO `buy` VALUES (34, 18, 15, '2020-04-12 12:28:52', 2);
INSERT INTO `buy` VALUES (35, 18, 14, '2020-04-12 16:55:17', 1);
INSERT INTO `buy` VALUES (36, 18, 14, '2020-04-12 16:54:40', 0);
INSERT INTO `buy` VALUES (37, 19, 28, '2020-04-12 18:22:15', 2);
INSERT INTO `buy` VALUES (38, 19, 27, '2020-04-12 18:25:48', 2);
COMMIT;

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect` (
  `collect_id` int(11) NOT NULL AUTO_INCREMENT,
  `creat_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) DEFAULT NULL,
  `flower_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`collect_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `food_id` (`flower_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of collect
-- ----------------------------
BEGIN;
INSERT INTO `collect` VALUES (21, '2020-04-11 17:40:06', 17, 14);
INSERT INTO `collect` VALUES (25, '2020-04-11 19:49:57', 18, 14);
INSERT INTO `collect` VALUES (30, '2020-04-12 12:28:10', 18, 15);
INSERT INTO `collect` VALUES (31, '2020-04-12 12:31:25', 18, 17);
INSERT INTO `collect` VALUES (32, '2020-04-12 16:53:30', 18, 14);
INSERT INTO `collect` VALUES (33, '2020-04-12 18:20:51', 19, 28);
COMMIT;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `star` int(10) DEFAULT NULL,
  `comment_desc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creat_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) DEFAULT NULL,
  `flower_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`comment_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `food_id` (`flower_id`) USING BTREE,
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`flower_id`) REFERENCES `flower` (`flower_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
BEGIN;
INSERT INTO `comment` VALUES (37, 5, '还可以', '2020-04-11 17:39:09', 17, 14);
INSERT INTO `comment` VALUES (38, 2, '垃圾', '2020-04-11 17:39:14', 17, 14);
INSERT INTO `comment` VALUES (42, 3, '真好池啊', '2020-04-12 12:29:18', 18, 15);
INSERT INTO `comment` VALUES (43, 0, NULL, '2020-04-12 16:28:07', 19, 14);
INSERT INTO `comment` VALUES (44, 0, 'fd', '2020-04-12 16:28:10', 19, 14);
INSERT INTO `comment` VALUES (45, 3, NULL, '2020-04-12 16:33:18', 19, 14);
INSERT INTO `comment` VALUES (46, 0, 'f', '2020-04-12 16:43:03', 19, 14);
INSERT INTO `comment` VALUES (47, 0, 'test', '2020-04-12 16:45:47', 18, 14);
COMMIT;

-- ----------------------------
-- Table structure for flower
-- ----------------------------
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

-- ----------------------------
-- Records of flower
-- ----------------------------
BEGIN;
INSERT INTO `flower` VALUES (12, '白玫瑰', 70, NULL, 10, 'index693.jpg', 11, 7);
INSERT INTO `flower` VALUES (14, '百合', 200, NULL, 20, 'u=2284181755,3276016697&fm=26&gp=07315.jpg', 13, 8);
INSERT INTO `flower` VALUES (15, '红玫瑰', 30, NULL, 10, 'u=3700304464,2518924328&fm=26&gp=05914.jpg', 14, 10);
INSERT INTO `flower` VALUES (16, '月季', 150, NULL, 20, 'u=1310495342,3655470264&fm=26&gp=0822.jpg', 15, 0);
INSERT INTO `flower` VALUES (17, '牵牛花', 70, NULL, 20, 'u=2656640060,1151593688&fm=26&gp=079.jpg', 17, 0);
INSERT INTO `flower` VALUES (18, '水仙花', 10, NULL, 10, 'Screenshot_20200311_2222122380.png', 11, 0);
INSERT INTO `flower` VALUES (23, 'new flower', 12121, NULL, 10, 'test4974.jpg', 12, 0);
INSERT INTO `flower` VALUES (24, 'ff', 300, NULL, 10, 'test8385.jpg', 13, 0);
INSERT INTO `flower` VALUES (25, 'huahua', 100, NULL, 1, '78381.jpeg', 12, 0);
INSERT INTO `flower` VALUES (26, '玫瑰花', 100, NULL, 10, '14264.jpg', 21, 0);
INSERT INTO `flower` VALUES (27, '百合花', 100, NULL, 10, '28463.jpeg', 21, 1);
INSERT INTO `flower` VALUES (28, '菊花', 300, NULL, 10, '33047.jpeg', 22, 1);
INSERT INTO `flower` VALUES (29, '桃花', 300, NULL, 30, '44865.jpeg', 23, 0);
INSERT INTO `flower` VALUES (30, '樱花', 300, NULL, 30, '54189.jpeg', 23, 0);
INSERT INTO `flower` VALUES (31, 'hh', 20, NULL, 60, '55497.jpeg', 24, 0);
COMMIT;

-- ----------------------------
-- Table structure for flower_type
-- ----------------------------
DROP TABLE IF EXISTS `flower_type`;
CREATE TABLE `flower_type` (
  `flower_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`flower_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of flower_type
-- ----------------------------
BEGIN;
INSERT INTO `flower_type` VALUES (21, '玫瑰');
INSERT INTO `flower_type` VALUES (22, '月季');
INSERT INTO `flower_type` VALUES (23, '花毛峰');
INSERT INTO `flower_type` VALUES (24, '好看的花');
COMMIT;

-- ----------------------------
-- Table structure for restaurant
-- ----------------------------
-- DROP TABLE IF EXISTS `restaurant`;
-- CREATE TABLE `restaurant` (
--   `restaurant_id` int(11) NOT NULL AUTO_INCREMENT,
--   `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
--   `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
--   `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
--   `user_id` int(11) DEFAULT NULL,
--   `head_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
--   PRIMARY KEY (`restaurant_id`) USING BTREE,
--   KEY `user_id` (`user_id`) USING BTREE,
--   CONSTRAINT `restaurant_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
-- ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
--
-- -- ----------------------------
-- -- Records of restaurant
-- -- ----------------------------
-- BEGIN;
-- INSERT INTO `restaurant` VALUES (1, NULL, '1', '1', 1, '1');
-- COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
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

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (1, 'admin', 'admin', '22', '22', '22222', 0, '66697.jpeg');
INSERT INTO `user` VALUES (17, 'uzi', 'uzi', '得到', '得到', '刘备', 1, 'uzi225973.jpg');
INSERT INTO `user` VALUES (18, 'user1', 'user1', '153332', '南天们大街1号', '张飞d2', 1, 'fcfaaf51f3deb48f3f9c42daf91f3a292df578397518.png');
INSERT INTO `user` VALUES (19, 'aa', '12345678', '1', '1', '1', 1, '49401.jpeg');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
