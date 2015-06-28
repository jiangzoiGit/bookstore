/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Version : 50623
 Source Host           : localhost
 Source Database       : test

 Target Server Version : 50623
 File Encoding         : utf-8

 Date: 06/26/2015 08:57:22 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `orderinfo`
-- ----------------------------
DROP TABLE IF EXISTS `orderinfo`;
CREATE TABLE `orderinfo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userid` int DEFAULT NULL,
  `ordertime` datetime DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ----------------------------
--  Records of `orderinfo`
-- ----------------------------


SET FOREIGN_KEY_CHECKS = 1;
