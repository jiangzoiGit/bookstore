/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Version : 50623
 Source Host           : localhost
 Source Database       : test

 Target Server Version : 50623
 File Encoding         : utf-8

 Date: 06/26/2015 08:57:27 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `orderinfoitem`
-- ----------------------------
DROP TABLE IF EXISTS `orderinfoitem`;
CREATE TABLE `orderinfoitem` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderid` int DEFAULT NULL,
  `bookid` int NOT NULL,
  `booknum` int NOT NULL,
  `singleprice` double DEFAULT NULL,
  `totalprice` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`orderid`) REFERENCES `orderinfo` (`id`)
);

-- ----------------------------
--  Records of `orderinfoitem`
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
