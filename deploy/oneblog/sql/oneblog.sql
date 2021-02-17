/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50640
 Source Host           : localhost:3306
 Source Schema         : oneblog

 Target Server Type    : MySQL
 Target Server Version : 50640
 File Encoding         : 65001

 Date: 04/01/2019 15:45:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for biz_article
-- ----------------------------
DROP TABLE IF EXISTS `biz_article`;
CREATE TABLE `biz_article`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文章标题',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户ID',
  `cover_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文章封面图片',
  `qrcode_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文章专属二维码地址',
  `is_markdown` tinyint(1) UNSIGNED NULL DEFAULT 1,
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '文章内容',
  `content_md` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT 'markdown版的文章内容',
  `top` tinyint(1) NULL DEFAULT 0 COMMENT '是否置顶',
  `type_id` bigint(20) UNSIGNED NOT NULL COMMENT '类型',
  `status` tinyint(1) UNSIGNED NULL DEFAULT NULL COMMENT '状态',
  `recommended` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '是否推荐',
  `original` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '是否原创',
  `description` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文章简介，最多200字',
  `keywords` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文章关键字，优化搜索',
  `comment` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '是否开启评论',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for biz_article_look
-- ----------------------------
DROP TABLE IF EXISTS `biz_article_look`;
CREATE TABLE `biz_article_look`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `article_id` bigint(20) UNSIGNED NOT NULL COMMENT '文章ID',
  `user_id` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '已登录用户ID',
  `user_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户IP',
  `look_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '浏览时间',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for biz_article_love
-- ----------------------------
DROP TABLE IF EXISTS `biz_article_love`;
CREATE TABLE `biz_article_love`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `article_id` bigint(20) UNSIGNED NOT NULL COMMENT '文章ID',
  `user_id` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '已登录用户ID',
  `user_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户IP',
  `love_time` datetime(0) NULL DEFAULT NULL COMMENT '浏览时间',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for biz_article_tags
-- ----------------------------
DROP TABLE IF EXISTS `biz_article_tags`;
CREATE TABLE `biz_article_tags`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag_id` bigint(20) UNSIGNED NOT NULL COMMENT '标签表主键',
  `article_id` bigint(20) UNSIGNED NOT NULL COMMENT '文章ID',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for biz_comment
-- ----------------------------
DROP TABLE IF EXISTS `biz_comment`;
CREATE TABLE `biz_comment`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sid` bigint(20) NULL DEFAULT NULL COMMENT '被评论的文章或者页面的ID',
  `user_id` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '评论人的ID',
  `pid` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '父级评论的id',
  `qq` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论人的QQ（未登录用户）',
  `nickname` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论人的昵称（未登录用户）',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论人的头像地址',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论人的邮箱地址（未登录用户）',
  `url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论人的网站地址（未登录用户）',
  `status` enum('VERIFYING','APPROVED','REJECT','DELETED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'VERIFYING' COMMENT '评论的状态',
  `ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论时的ip',
  `lng` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '经度',
  `lat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '纬度',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论时的地址',
  `os` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论时的系统类型',
  `os_short_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论时的系统的简称',
  `browser` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论时的浏览器类型',
  `browser_short_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论时的浏览器的简称',
  `content` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论的内容',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注（审核不通过时添加）',
  `support` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '支持（赞）',
  `oppose` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '反对（踩）',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for biz_tags
-- ----------------------------
DROP TABLE IF EXISTS `biz_tags`;
CREATE TABLE `biz_tags`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '书签名',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for biz_type
-- ----------------------------
DROP TABLE IF EXISTS `biz_type`;
CREATE TABLE `biz_type`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章类型名',
  `description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型介绍',
  `sort` int(10) NULL DEFAULT NULL COMMENT '排序',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `available` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '是否可用',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `config_key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置关键字',
  `config_value` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '配置项内容',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_link
-- ----------------------------
DROP TABLE IF EXISTS `sys_link`;
CREATE TABLE `sys_link`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '链接地址',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '链接名',
  `description` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '链接介绍',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '友链站长邮箱',
  `qq` varchar(13) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '友链站长QQ',
  `favicon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '状态',
  `home_page_display` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '是否首页显示',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `source` enum('ADMIN','AUTOMATIC') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'ADMIN' COMMENT '来源：管理员添加、自动申请',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '已登录用户ID',
  `type` enum('SYSTEM','VISIT','ERROR') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'SYSTEM' COMMENT '日志类型（系统操作日志，用户访问日志，异常记录日志）',
  `log_level` enum('ERROR','WARN','INFO') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'INFO' COMMENT '日志级别',
  `content` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志内容（业务操作）',
  `params` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求参数（业务操作）',
  `spider_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '爬虫类型（当访问者被鉴定为爬虫时该字段表示爬虫的类型）',
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作用户的ip',
  `ua` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作用户的user_agent',
  `os` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论时的系统类型',
  `browser` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论时的浏览器类型',
  `request_url` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求的路径',
  `referer` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求来源地址',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '被通知的用户ID',
  `status` enum('RELEASE','NOT_RELEASE') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'NOT_RELEASE' COMMENT '通知状态',
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通知的标题',
  `content` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通知的内容',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_resources
-- ----------------------------
DROP TABLE IF EXISTS `sys_resources`;
CREATE TABLE `sys_resources`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `permission` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED NULL DEFAULT 0,
  `sort` int(10) UNSIGNED NULL DEFAULT NULL,
  `external` tinyint(1) UNSIGNED NULL DEFAULT NULL COMMENT '是否外部链接',
  `available` tinyint(1) UNSIGNED NULL DEFAULT 0,
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sys_resource_parent_id`(`parent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `available` tinyint(1) NULL DEFAULT 0,
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_role_resources
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_resources`;
CREATE TABLE `sys_role_resources`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `resources_id` bigint(20) UNSIGNED NOT NULL,
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_template
-- ----------------------------
DROP TABLE IF EXISTS `sys_template`;
CREATE TABLE `sys_template`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ref_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '键',
  `ref_value` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '模板内容',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_update_recorde
-- ----------------------------
DROP TABLE IF EXISTS `sys_update_recorde`;
CREATE TABLE `sys_update_recorde`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `version` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新版本',
  `description` varchar(2500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新记录备注',
  `recorde_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '项目更新时间',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录密码',
  `nickname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '昵称',
  `mobile` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱地址',
  `qq` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'QQ',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `gender` smallint(2) NULL DEFAULT NULL COMMENT '性别',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像地址',
  `user_type` enum('ROOT','ADMIN','USER') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'ADMIN' COMMENT '超级管理员、管理员、普通用户',
  `company` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司',
  `blog` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个人博客地址',
  `location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `source` enum('GITHUB','GITEE','WEIBO','DINGTALK','BAIDU','CSDN','CODING','OSCHINA','TENCENT_CLOUD','ALIPAY','TAOBAO','QQ','WECHAT','GOOGLE','FACEBOOK') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户来源',
  `uuid` varchar(50) NULL COMMENT '用户唯一表示(第三方网站)',
  `privacy` tinyint(2) NULL DEFAULT NULL COMMENT '隐私（1：公开，0：不公开）',
  `notification` tinyint(2) UNSIGNED NULL DEFAULT NULL COMMENT '通知：(1：通知显示消息详情，2：通知不显示详情)',
  `score` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '金币值',
  `experience` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '经验值',
  `reg_ip` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注册IP',
  `last_login_ip` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最近登录IP',
  `last_login_time` datetime(0) NULL DEFAULT NULL COMMENT '最近登录时间',
  `login_count` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '登录次数',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户备注',
  `status` int(1) UNSIGNED NULL DEFAULT NULL COMMENT '用户状态',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for biz_file
-- ----------------------------
DROP TABLE IF EXISTS `biz_file`;
CREATE TABLE `biz_file`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `storage_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `original_file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `size` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `suffix` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `width` int(10) UNSIGNED NULL DEFAULT NULL,
  `height` int(10) UNSIGNED NULL DEFAULT NULL,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `full_file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `file_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `upload_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `upload_start_time` datetime(0) NULL DEFAULT NULL,
  `upload_end_time` datetime(0) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 0 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;


SET FOREIGN_KEY_CHECKS = 1;



###################################  readme  ###################################
#
#  该文件只用来初始化数据库内容，需要有权限执行创建数据库
#
###################################  readme  ###################################
# 清空标签表
TRUNCATE TABLE `oneblog`.`biz_tags`;
# 初始化标签
INSERT INTO `oneblog`.`biz_tags` VALUES ('1', 'Shell', null, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`biz_tags` VALUES ('2', 'Linux', null, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`biz_tags` VALUES ('3', 'Docker', null, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`biz_tags` VALUES ('4', 'K8S', null, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`biz_tags` VALUES ('5', 'Algorithm', null, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`biz_tags` VALUES ('6', '其他', null, '2020-07-09 11:59:23', '2020-07-09 11:59:23');

# 清空文章分类表
TRUNCATE TABLE `oneblog`.`biz_type`;
# 初始化文章分类
INSERT INTO `oneblog`.`biz_type` VALUES ('1', null, '博客', '主要收集、整理在工作和生活中开发所需的基础的文章总结', '1', 'fa fa-css3', '1', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`biz_type` VALUES ('2', null, '分享', '主要收集和整理一些资源进行分享和备注,记录网站建设以及日常工作、学习中的闲言碎语和个人笔记等文章', '2', 'fa fa-coffee', '1', '2020-07-09 11:59:23', '2020-07-09 11:59:23');

# 清空系统配置表
TRUNCATE TABLE `oneblog`.`sys_config`;
# 初始化系统配置
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (1, 'homeDesc', '回首来时的路,我希望,还能看见走过的足迹', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (2, 'homeKeywords', 'darebeat,个人博客', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (3, 'domain', 'darebeat.cn', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (4, 'cmsUrl', 'http://localhost:8085', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (5, 'siteUrl', 'http://localhost:8443', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (6, 'siteName', 'A Personal Blog Of Darebeat', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (7, 'siteDesc', 'darebeat, 做一个有内涵的个人博客,趁年轻,做一些自己力所能及的事情', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (8, 'siteFavicon', 'https://sm.darebeat.cn/images/2021/02/16/DT.png', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (9, 'staticWebSite', 'http://localhost:8443', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (10, 'authorName', 'darebeat', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (11, 'authorEmail', 'darebeat@126.com', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (12, 'wxCode', 'https://sm.darebeat.cn/images/2020/11/09/qrcode_for_wechar.jpg', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (13, 'qq', '871731559', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (14, 'weibo', 'http://weibo.com', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (15, 'github', 'https://github.com/darebeat', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (16, 'maintenance', '0', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (17, 'maintenanceDate', '2020-07-09 11:59:23', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (18, 'comment', '1', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (19, 'qiniuBasePath', NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (20, 'qiniuAccessKey', NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (21, 'qiniuSecretKey', NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (22, 'qiniuBucketName', NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (23, 'baiduPushToken', NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (24, 'wxPraiseCode', NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (25, 'zfbPraiseCode', NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (26, 'baiduApiAk', 'NwHaYlGalDEpgxm46xBaC3T9', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (27, 'spiderConfig', '{\r\n            imooc: {\r\n                domain: \"www.imooc.com\",\r\n                titleRegex: \"//span[@class=js-title]/html()\",\r\n                authorRegex: \"//div[@class=name_con]/p[@class=name]/a[@class=nick]/html()\",\r\n                releaseDateRegex: \"//div[@class=\'dc-profile\']/div[@class=\'l\']/span[@class=\'spacer\']/text()\",\r\n                contentRegex: \"//div[@class=detail-content]/html()\",\r\n                targetLinksRegex: \"/article/[0-9]{1,10}\",\r\n                tagRegex: \"//div[@class=cat-box]/div[@class=cat-wrap]/a[@class=cat]/html()\",\r\n                header: [\r\n                    \"Host=www.imooc.com\",\r\n                    \"Referer=https://www.imooc.com\"\r\n                ],\r\n                entryUrls: \'https://www.imooc.com/u/{uid}/articles?page={curPage}\'\r\n            },\r\n            csdn: {\r\n                domain: \"blog.csdn.net\",\r\n                titleRegex: \"//h1[@class=title-article]/html()\",\r\n                authorRegex: \"//a[@class=follow-nickName]/html()\",\r\n                releaseDateRegex: \"//div[@class=\'article-bar-top\']/span[@class=\'time\']/text()\",\r\n                contentRegex: \"//div[@class=article_content]/html()\",\r\n                targetLinksRegex: \".*blog\\\\.csdn\\\\.net/{uid}/article/details/[0-9a-zA-Z]{1,15}\",\r\n                tagRegex: \"//span[@class=artic-tag-box]/a[@class=tag-link]/html()\",\r\n                header: [\r\n                    \"Host=blog.csdn.net\",\r\n                    \"Referer=https://blog.csdn.net/{uid}/article/list/1\"\r\n                ],\r\n                entryUrls: \'https://blog.csdn.net/{uid}/article/list/{curPage}\'\r\n            },\r\n            iteye: {\r\n                domain: \"{uid}.iteye.com\",\r\n                titleRegex: \"//div[@class=blog_title]/h3/a/html()\",\r\n                authorRegex: \"//div[@id=blog_owner_name]/html()\",\r\n                releaseDateRegex: \"//div[@class=blog_bottom]/ul/li/html()\",\r\n                contentRegex: \"//div[@class=blog_content]/html()\",\r\n                targetLinksRegex: \".*{uid}\\\\.iteye\\\\.com/blog/[0-9]+\",\r\n                tagRegex: \"//div[@class=news_tag]/a/html()\",\r\n                header: [\r\n                    \"Host={uid}.iteye.com\",\r\n                    \"Referer=http://{uid}.iteye.com/\"\r\n                ],\r\n                entryUrls: \'http://{uid}.iteye.com/?page={curPage}\'\r\n            },\r\n            csblogs: {\r\n                domain: \"www.cnblogs.com\",\r\n                titleRegex: \"//a[@id=cb_post_title_url]/html()\",\r\n                authorRegex: \"//div[@class=postDesc]/a[1]/html()\",\r\n                releaseDateRegex: \"//span[@id=post-date]/html()\",\r\n                contentRegex: \"//div[@id=cnblogs_post_body]/html()\",\r\n                targetLinksRegex: \".*www\\\\.cnblogs\\\\.com/{uid}/p/[\\\\w\\\\d]+\\\\.html\",\r\n                tagRegex: \"//div[@id=EntryTag]/a/html()\",\r\n                header: [\r\n                    \"Host=www.cnblogs.com\",\r\n                    \"Referer=https://www.cnblogs.com/\"\r\n                ],\r\n                entryUrls: \'https://www.cnblogs.com/{uid}/default.html?page={curPage}\'\r\n            }\r\n        }', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (28, 'anonymous', '1', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (29, 'editorPlaceholder', '说点什么吧', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (30, 'editorAlert', '讲文明、要和谐', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (31, 'defaultUserAvatar', '[\r\n  \"http://localhost:8443/img/random/user/1.jpg\",\r\n  \"http://localhost:8443/img/random/user/2.jpg\",\r\n  \"http://localhost:8443/img/random/user/3.jpg\",\r\n  \"http://localhost:8443/img/random/user/4.jpg\",\r\n  \"http://localhost:8443/img/random/user/5.jpg\",\r\n  \"http://localhost:8443/img/random/user/6.jpg\",\r\n  \"http://localhost:8443/img/random/user/7.jpg\",\r\n  \"http://localhost:8443/img/random/user/8.jpg\",\r\n  \"http://localhost:8443/img/random/user/9.jpg\",\r\n  \"http://localhost:8443/img/random/user/10.jpg\",\r\n \"http://localhost:8443/img/random/user/11.jpg\",\r\n \"http://localhost:8443/img/random/user/12.jpg\",\r\n \"http://localhost:8443/img/random/user/13.jpg\",\r\n \"http://localhost:8443/img/random/user/14.jpg\",\r\n \"http://localhost:8443/img/random/user/15.jpg\",\r\n \"http://localhost:8443/img/random/user/16.jpg\",\r\n \"http://localhost:8443/img/random/user/17.jpg\",\r\n \"http://localhost:8443/img/random/user/18.jpg\",\r\n \"http://localhost:8443/img/random/user/19.jpg\",\r\n \"http://localhost:8443/img/random/user/20.jpg\"\r\n]', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (32, 'sessionTimeOut', '5', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (33, 'sessionTimeOutUnit', 'MINUTES', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (34, 'loginRetryNum', '5', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (35, 'installdate', '2020-07-09 11:59:23', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (36, 'copyright', 'Copyright darebeat.cn', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_config`(`id`, `config_key`, `config_value`, `create_time`, `update_time`) VALUES (37, 'dynamicTitle', '您有一条新消息', '2020-07-09 11:59:23', '2020-07-09 11:59:23');

# 清空友情链接表
TRUNCATE TABLE `oneblog`.`sys_link`;
# 初始化友情链接
INSERT INTO `oneblog`.`sys_link` VALUES ('1', 'https://blog.darebeat.cn', "darebeat's blog", '一个程序员的个人博客', 'darebeat@126.com', null, 'https://static.zhyd.me/static/img/favicon.ico', '1', '1', null, 'ADMIN', '2020-07-09 11:59:23', '2020-07-09 11:59:23');

# 清空系统通知表
TRUNCATE TABLE `oneblog`.`sys_notice`;
# 初始化系统通知
INSERT INTO `oneblog`.`sys_notice` VALUES (1, 1, 'RELEASE', '问题反馈', '在使用过程中，有问题请先参考相关文档，确实无法解决的，请优先提Issue，感谢各位老铁', '2020-07-09 11:59:23', '2020-07-09 11:59:23');

# 清空系统模板表
TRUNCATE TABLE `oneblog`.`sys_template`;
# 初始化系统模板
INSERT INTO `oneblog`.`sys_template` VALUES ('1', 'TM_SITEMAP_XML', '<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<urlset xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\" xsi:schemaLocation=\"http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd\">\r\n  <url>\r\n   <loc>${config.siteUrl}</loc>\r\n    <priority>1.0</priority>\r\n    <lastmod>${.now?string(\"yyyy-MM-dd\")}</lastmod>\r\n   <changefreq>daily</changefreq>\r\n  </url>\r\n  <url>\r\n   <loc>${config.siteUrl}/about</loc>\r\n    <priority>0.6</priority>\r\n    <lastmod>${.now?string(\"yyyy-MM-dd\")}</lastmod>\r\n   <changefreq>daily</changefreq>\r\n  </url>\r\n  <url>\r\n   <loc>${config.siteUrl}/links</loc>\r\n    <priority>0.6</priority>\r\n    <lastmod>${.now?string(\"yyyy-MM-dd\")}</lastmod>\r\n   <changefreq>daily</changefreq>\r\n  </url>\r\n  <url>\r\n   <loc>${config.siteUrl}/guestbook</loc>\r\n    <priority>0.6</priority>\r\n    <lastmod>${.now?string(\"yyyy-MM-dd\")}</lastmod>\r\n   <changefreq>daily</changefreq>\r\n  </url>\r\n  <url>\r\n   <loc>${config.siteUrl}/updateLog</loc>\r\n    <priority>0.6</priority>\r\n    <lastmod>${.now?string(\"yyyy-MM-dd\")}</lastmod>\r\n   <changefreq>daily</changefreq>\r\n  </url>\r\n  <url>\r\n   <loc>${config.siteUrl}/recommended</loc>\r\n    <priority>0.6</priority>\r\n    <lastmod>${.now?string(\"yyyy-MM-dd\")}</lastmod>\r\n   <changefreq>daily</changefreq>\r\n  </url>\r\n  <#list articleList as item>\r\n   <url>\r\n     <loc>${config.siteUrl}/article/${item.id}</loc>\r\n     <priority>0.6</priority>\r\n      <lastmod>${item.updateTime?string(\"yyyy-MM-dd\")}</lastmod>\r\n      <changefreq>daily</changefreq>\r\n    </url>\r\n  </#list>\r\n  <#list articleTypeList as item>\r\n    <url>\r\n      <loc>${config.siteUrl}/type/${item.id}</loc>\r\n      <priority>0.6</priority>\r\n      <lastmod>${item.updateTime?string(\"yyyy-MM-dd\")}</lastmod>\r\n      <changefreq>daily</changefreq>\r\n    </url>\r\n  </#list>\r\n  \r\n  <#list articleTagsList as item>\r\n    <url>\r\n      <loc>${config.siteUrl}/tag/${item.id}</loc>\r\n     <priority>0.6</priority>\r\n      <lastmod>${item.updateTime?string(\"yyyy-MM-dd\")}</lastmod>\r\n      <changefreq>daily</changefreq>\r\n    </url>\r\n  </#list>\r\n</urlset>', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_template` VALUES ('2', 'TM_SITEMAP_TXT', '${config.siteUrl}\r\n${config.siteUrl}/about\r\n${config.siteUrl}/links\r\n${config.siteUrl}/guestbook\r\n${config.siteUrl}/updateLog\r\n${config.siteUrl}/recommended\r\n<#list articleList as item>\r\n${config.siteUrl}/article/${item.id}\r\n</#list>\r\n<#list articleTypeList as item>\r\n${config.siteUrl}/type/${item.id}\r\n</#list>\r\n<#list articleTagsList as item>\r\n${config.siteUrl}/tag/${item.id}\r\n</#list>', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_template` VALUES ('3', 'TM_SITEMAP_HTML', '<!DOCTYPE html>\r\n<html lang=\"zh-CN\">\r\n<head>\r\n    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/>\r\n    <title>${config.siteName} 网站地图</title>\r\n    <meta name=\"author\" content=\"SiteMapX.com\"/>\r\n    <meta name=\"robots\" content=\"index,follow\"/>\r\n    <style type=\"text/css\">\r\n        body {\r\n            color: #000000;\r\n            background: #ffffff;\r\n            margin: 20px;\r\n            font-family: Verdana, Arial, Helvetica, sans-serif;\r\n            font-size: 12px;\r\n        }\r\n\r\n        #myTable {\r\n            list-style: none;\r\n            margin: 10px 0px 10px 0px;\r\n            padding: 0px;\r\n            width: 100%;\r\n            min-width: 804px;\r\n        }\r\n\r\n        #myTable li {\r\n            list-style-type: none;\r\n            width: 100%;\r\n            min-width: 404px;\r\n            height: 20px;\r\n            line-height: 20px;\r\n        }\r\n\r\n        .pull-left{\r\n            float: left!important;\r\n        }\r\n        .pull-right{\r\n            float: right!important;\r\n        }\r\n\r\n        #myTable li .T1-h {\r\n            font-weight: bold;\r\n            min-width: 300px;\r\n        }\r\n\r\n        #myTable li .T2-h {\r\n            width: 200px;\r\n            font-weight: bold;\r\n        }\r\n\r\n        #myTable li .T3-h {\r\n            width: 200px;\r\n            font-weight: bold;\r\n        }\r\n\r\n        #myTable li .T4-h {\r\n            width: 100px;\r\n            font-weight: bold;\r\n        }\r\n\r\n        #myTable li .T1 {\r\n            min-width: 300px;\r\n        }\r\n\r\n        #myTable li .T2 {\r\n            width: 200px;\r\n        }\r\n\r\n        #myTable li .T3 {\r\n            width: 200px;\r\n        }\r\n\r\n        #myTable li .T4 {\r\n            width: 100px;\r\n        }\r\n\r\n        #footer {\r\n            padding: 2px;\r\n            margin: 0px;\r\n            font-size: 8pt;\r\n            color: gray;\r\n            min-width: 900px;\r\n        }\r\n\r\n        #footer a {\r\n            color: gray;\r\n        }\r\n\r\n        .myClear {\r\n            clear: both;\r\n        }\r\n\r\n        #nav, #content, #footer {padding: 8px; border: 1px solid #EEEEEE; clear: both; width: 95%; margin: auto; margin-top: 10px;}\r\n\r\n    </style>\r\n</head>\r\n<body>\r\n<h2 style=\"text-align: center; margin-top: 20px\">${config.siteName?if_exists} 网站地图 </h2>\r\n<div id=\"nav\"><a href=\"${config.siteUrl?if_exists}\"><strong>${config.siteName?if_exists}</strong></a> &raquo; <a href=\"${config.siteUrl?if_exists}/sitemap.html\">站点地图</a></div>\r\n<div id=\"content\">\r\n    <h3>最新文章</h3>\r\n    <ul id=\"myTable\">\r\n        <li>\r\n            <div class=\"T1-h pull-left\">URL</div>\r\n            <div class=\"T2-h pull-right\">Last Change</div>\r\n            <div class=\"T3-h pull-right\">Change Frequency</div>\r\n            <div class=\"T4-h pull-right\">Priority</div>\r\n        </li>\r\n        <div class=\"myClear\"></div>\r\n        <li>\r\n            <div class=\"T1 pull-left\"><a href=\"${config.siteUrl}\" title=\"${config.siteName}\">${config.siteName} | 一个程序员的个人博客</a></div>\r\n            <div class=\"T2 pull-right\">${.now?string(\"yyyy-MM-dd\")}</div>\r\n            <div class=\"T3 pull-right\">daily</div>\r\n            <div class=\"T4 pull-right\">1</div>\r\n        </li>\r\n        <div class=\"myClear\"></div>\r\n        <li>\r\n            <div class=\"T1 pull-left\"><a href=\"${config.siteUrl}/about\" title=\"${config.siteName}\">关于 | ${config.siteName}</a></div>\r\n            <div class=\"T2 pull-right\">${.now?string(\"yyyy-MM-dd\")}</div>\r\n            <div class=\"T3 pull-right\">daily</div>\r\n            <div class=\"T4 pull-right\">0.6</div>\r\n        </li>\r\n        <div class=\"myClear\"></div>\r\n        <li>\r\n            <div class=\"T1 pull-left\"><a href=\"${config.siteUrl}/links\" title=\"${config.siteName}\">友情链接 | ${config.siteName}</a></div>\r\n            <div class=\"T2 pull-right\">${.now?string(\"yyyy-MM-dd\")}</div>\r\n            <div class=\"T3 pull-right\">daily</div>\r\n            <div class=\"T4 pull-right\">0.6</div>\r\n        </li>\r\n        <div class=\"myClear\"></div>\r\n        <li>\r\n            <div class=\"T1 pull-left\"><a href=\"${config.siteUrl}/guestbook\" title=\"${config.siteName}\">留言板 | ${config.siteName}</a></div>\r\n            <div class=\"T2 pull-right\">${.now?string(\"yyyy-MM-dd\")}</div>\r\n            <div class=\"T3 pull-right\">daily</div>\r\n            <div class=\"T4 pull-right\">0.6</div>\r\n        </li>\r\n        <div class=\"myClear\"></div>\r\n        <li>\r\n            <div class=\"T1 pull-left\"><a href=\"${config.siteUrl}/updateLog\" title=\"${config.siteName}\">网站更新记录 | ${config.siteName}</a></div>\r\n            <div class=\"T2 pull-right\">${.now?string(\"yyyy-MM-dd\")}</div>\r\n            <div class=\"T3 pull-right\">daily</div>\r\n            <div class=\"T4 pull-right\">0.6</div>\r\n        </li>\r\n    <div class=\"myClear\"></div>\r\n        <li>\r\n            <div class=\"T1 pull-left\"><a href=\"${config.siteUrl}/recommended\" title=\"${config.siteName}\">站长推荐 | ${config.siteName}</a></div>\r\n            <div class=\"T2 pull-right\">${.now?string(\"yyyy-MM-dd\")}</div>\r\n            <div class=\"T3 pull-right\">daily</div>\r\n            <div class=\"T4 pull-right\">0.6</div>\r\n        </li>\r\n        <div class=\"myClear\"></div>\r\n        <#list articleList as item>\r\n            <li>\r\n                <div class=\"T1 pull-left\"><a href=\"${config.siteUrl}/article/${item.id}\" title=\"${item.title}\">${item.title} | ${config.siteName}</a></div>\r\n                <div class=\"T2 pull-right\">${item.updateTime?string(\"yyyy-MM-dd\")}</div>\r\n                <div class=\"T3 pull-right\">daily</div>\r\n                <div class=\"T4 pull-right\">0.6</div>\r\n            </li>\r\n            <div class=\"myClear\"></div>\r\n        </#list>\r\n    </ul>\r\n</div>\r\n<div id=\"content\">\r\n    <h3>分类目录</h3>\r\n    <ul id=\"myTable\">\r\n        <#list articleTypeList as item>\r\n            <li>\r\n                <div class=\"T1 pull-left\"><a href=\"${config.siteUrl}/type/${item.id}\" title=\"${item.name}\">${item.name} | ${config.siteName}</a></div>\r\n                <div class=\"T2 pull-right\">${item.updateTime?string(\"yyyy-MM-dd\")}</div>\r\n                <div class=\"T3 pull-right\">daily</div>\r\n                <div class=\"T4 pull-right\">0.6</div>\r\n            </li>\r\n            <div class=\"myClear\"></div>\r\n        </#list>\r\n    </ul>\r\n</div>\r\n<div id=\"content\">\r\n    <h3>标签目录</h3>\r\n    <ul id=\"myTable\">\r\n        <#list articleTagsList as item>\r\n            <li>\r\n                <div class=\"T1 pull-left\"><a href=\"${config.siteUrl}/tag/${item.id}\" title=\"${item.name}\">${item.name} | ${config.siteName}</a></div>\r\n                <div class=\"T2 pull-right\">${item.updateTime?string(\"yyyy-MM-dd\")}</div>\r\n                <div class=\"T3 pull-right\">daily</div>\r\n                <div class=\"T4 pull-right\">0.6</div>\r\n            </li>\r\n            <div class=\"myClear\"></div>\r\n        </#list>\r\n    </ul>\r\n</div>\r\n<div id=\"footer\">\r\n    该文件由<a href=\"${config.siteUrl}\" title=\"${config.siteName}\">${config.siteName}</a>网站自动生成。\r\n</div>\r\n</body>\r\n</html>', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_template` VALUES ('4', 'TM_ROBOTS', 'Crawl-delay: 5\r\nSitemap: ${config.cmsUrl}/sitemap.txt\r\nSitemap: ${config.cmsUrl}/sitemap.xml\r\nSitemap: ${config.cmsUrl}/sitemap.html\r\n', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_template` VALUES ('5', 'TM_LINKS', '<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n    <meta charset=\"UTF-8\">\r\n    <title>友情链接操作通知</title>\r\n</head>\r\n<body>\r\n<div style=\"border-radius:5px;font-size:13px;width:680px;font-family:微软雅黑,\'Helvetica Neue\',Arial,sans-serif;margin:10px auto 0px;border:1px solid #eee;max-width:100%\">\r\n    <div style=\"width:100%;background:#2f889a;color:#ffffff;border-radius:5px 5px 0 0\">\r\n        <p style=\"font-size:15px;word-break:break-all;padding:20px 32px;margin:0\">\r\n            友情链接操作通知\r\n        </p>\r\n    </div>\r\n    <div style=\"margin:0px auto;width:90%\">\r\n        <p>站长<a href=\"${link.url?if_exists}\" target=\"_blank\">${link.name?if_exists}</a>，您好!</p>\r\n        <p>您于 ${link.createTime?string(\'yyyy-MM-dd HH:mm:ss\')} 提交的友链申请已通过系统审核。以下为您提交的信息，请确认（如有误，请联系我）！</p>\r\n        <p>\r\n        <ul>\r\n            <li>${link.name?if_exists}</li>\r\n            <li>${link.url?if_exists}</li>\r\n            <li>${link.description?if_exists}</li>\r\n            <li>${link.email?if_exists}</li>\r\n            <li>${link.qq?if_exists}</li>\r\n            <li><img src=\"${link.favicon?if_exists}\" width=\"100\" alt=\"LOGO\"></li>\r\n        </ul>\r\n        </p>\r\n        <p>本站会不定期检查连接有效性，如果因为贵站改版、服务到期等原因导致无法正常访问的，我会暂时停掉贵站友链，待贵站可以正常访问后，本站会继续启用贵站友链。</p>\r\n        <p>特别注意：以下情况，本站将在不做任何通知下，<strong>取消友链</strong>！</p>\r\n        <ul>\r\n            <li>私自取消本站友情链接</li>\r\n            <li>更换域名且未通知本站</li>\r\n            <li>网站内容长期不更新</li>\r\n            <li>友链上使用诸如nofollow之类的属性</li>\r\n        </ul>\r\n        <p>感谢您对 <a style=\"text-decoration:none;\" href=\"${config.siteUrl?if_exists}\" target=\"_blank\">${config.siteName?if_exists}</a> 的关注，如您有任何疑问，欢迎来我网站<a style=\"text-decoration:none;\" href=\"${config.siteUrl}/guestbook\" target=\"_blank\">留言</a>。</p>\r\n        <p>（注：此邮件由系统自动发出，请勿回复。）</p>\r\n    </div>\r\n    <div class=\"adL\">\r\n    </div>\r\n</div>\r\n</body>\r\n</html>', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_template` VALUES ('6', 'TM_COMMENT_AUDIT', '<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n    <meta charset=\"UTF-8\">\r\n    <title>评论审核结果通知</title>\r\n</head>\r\n<body>\r\n<div style=\"border-radius:5px;font-size:13px;width:680px;font-family:微软雅黑,\'Helvetica Neue\',Arial,sans-serif;margin:10px auto 0px;border:1px solid #eee;max-width:100%\">\r\n    <div style=\"width:100%;background:#2f889a;color:#ffffff;border-radius:5px 5px 0 0\">\r\n        <p style=\"font-size:15px;word-break:break-all;padding:20px 32px;margin:0\">\r\n            评论审核结果通知\r\n        </p>\r\n    </div>\r\n    <div style=\"margin:0px auto;width:90%\">\r\n        <p>${comment.nickname?if_exists}，您好!</p>\r\n        <p>\r\n            您于 ${comment.createTime?string(\'yyyy-MM-dd HH:mm:ss\')} 在文章《${config.siteUrl?if_exists}${comment.sourceUrl?if_exists}》 上发表的<span class=\"il\">评论</span>：\r\n        </p>\r\n        <div style=\"background:#efefef;margin:15px 0px;padding:1px 15px;border-radius:5px;font-size:14px;color:#333\">${comment.content}</div>\r\n        <#if comment.status == \'APPROVED\'>\r\n        <p>已通过管理员审核并显示。</p>\r\n        <p>\r\n            您可以点击 <a style=\"text-decoration:none;\" href=\"${config.siteUrl}${comment.sourceUrl}\" target=\"_blank\">链接</a>查看回复的完整內容。\r\n        </p>\r\n        <#elseif comment.status == \'REJECT\'>\r\n        <p>审核失败！失败原因：</p>\r\n        <p style=\"background:#efefef;margin:15px 0px;padding:1px 15px;border-radius:5px;font-size:14px;color:#333\">${comment.remark}</p>\r\n        <#elseif comment.status == \'DELETED\'>\r\n        <p>已被管理员删除！删除原因：</p>\r\n        <p style=\"background:#efefef;margin:15px 0px;padding:1px 15px;border-radius:5px;font-size:14px;color:#333\">${comment.remark}</p>\r\n        <#else>\r\n        <p>管理员正在审核中！审核通过后将给您及时发送通知！</p>\r\n        </#if>\r\n        <p>感谢您对 <a style=\"text-decoration:none;\" href=\"${config.siteUrl}\" target=\"_blank\">${config.siteName}</a> 的关注，如您有任何疑问，欢迎来我网站<a style=\"text-decoration:none;\" href=\"${config.siteUrl}/guestbook\" target=\"_blank\">留言</a>。</p>\r\n        <p>（注：此邮件由系统自动发出，请勿回复。）</p>\r\n    </div>\r\n    <div class=\"adL\">\r\n    </div>\r\n</div>\r\n</body>\r\n</html>', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_template` VALUES ('7', 'TM_COMMENT_REPLY', '<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n    <meta charset=\"UTF-8\">\r\n    <title>评论回复通知</title>\r\n</head>\r\n<body>\r\n<div style=\"border-radius:5px;font-size:13px;width:680px;font-family:微软雅黑,\'Helvetica Neue\',Arial,sans-serif;margin:10px auto 0px;border:1px solid #eee;max-width:100%\">\r\n    <div style=\"width:100%;background:#2f889a;color:#ffffff;border-radius:5px 5px 0 0\">\r\n        <p style=\"font-size:15px;word-break:break-all;padding:20px 32px;margin:0\">\r\n            评论回复通知\r\n        </p>\r\n    </div>\r\n    <div style=\"margin:0px auto;width:90%\">\r\n        <p>${comment.nickname}，您好!</p>\r\n        <p>\r\n            您于 ${comment.createTime?string(\'yyyy-MM-dd HH:mm:ss\')} 在文章《${config.siteUrl}${comment.sourceUrl}》 上发表的<span class=\"il\">评论</span>：\r\n        </p>\r\n        <div style=\"background:#efefef;margin:15px 0px;padding:1px 15px;border-radius:5px;font-size:14px;color:#333\">${comment.content}</div>\r\n        <p>\r\n            有了 <strong>新的回复</strong>！您可以点击 <a style=\"text-decoration:none;\" href=\"${config.siteUrl}${comment.sourceUrl}\" target=\"_blank\">链接</a>查看回复的完整內容。\r\n        </p>\r\n        <p>感谢您对 <a style=\"text-decoration:none;\" href=\"${config.siteUrl}\" target=\"_blank\">${config.siteName}</a> 的关注，如您有任何疑问，欢迎来我网站<a style=\"text-decoration:none;\" href=\"${config.siteUrl}/guestbook\" target=\"_blank\">留言</a>。</p>\r\n        <p>（注：此邮件由系统自动发出，请勿回复。）</p>\r\n    </div>\r\n    <div class=\"adL\">\r\n    </div>\r\n</div>\r\n</body>\r\n</html>', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_template` VALUES ('8', 'TM_LINKS_TO_ADMIN', '<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n    <meta charset=\"UTF-8\">\r\n    <title>友情链接操作通知</title>\r\n</head>\r\n<body>\r\n<div style=\"border-radius:5px;font-size:13px;width:680px;font-family:微软雅黑,\'Helvetica Neue\',Arial,sans-serif;margin:10px auto 0px;border:1px solid #eee;max-width:100%\">\r\n    <div style=\"width:100%;background:#2f889a;color:#ffffff;border-radius:5px 5px 0 0\">\r\n        <p style=\"font-size:15px;word-break:break-all;padding:20px 32px;margin:0\">\r\n            友情链接操作通知\r\n        </p>\r\n    </div>\r\n    <div style=\"margin:0px auto;width:90%\">\r\n        <p>有新的友情链接加入，信息如下</p>\r\n        <p>\r\n        <ul>\r\n            <li>${link.name?if_exists}</li>\r\n            <li>${link.url?if_exists}</li>\r\n            <li>${link.description?if_exists}</li>\r\n            <#if link.favicon?exists><li><img src=\"${link.favicon?if_exists}\" width=\"100\" alt=\"LOGO\"></li></#if>\r\n        </ul>\r\n        </p>\r\n        <p><a style=\"text-decoration:none;\" href=\"${config.cmsUrl}\" target=\"_blank\">去后台继续审核</a>。</p>\r\n        <p>（注：此邮件由系统自动发出，请勿回复。）</p>\r\n    </div>\r\n    <div class=\"adL\">\r\n    </div>\r\n</div>\r\n</body>\r\n</html>', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_template` VALUES ('9', 'TM_NEW_COMMENT', '<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n    <meta charset=\"UTF-8\">\r\n    <title>新评论通知</title>\r\n</head>\r\n<body>\r\n<div style=\"border-radius:5px;font-size:13px;width:680px;font-family:微软雅黑,\'Helvetica Neue\',Arial,sans-serif;margin:10px auto 0px;border:1px solid #eee;max-width:100%\">\r\n    <div style=\"width:100%;background:#2f889a;color:#ffffff;border-radius:5px 5px 0 0\">\r\n        <p style=\"font-size:15px;word-break:break-all;padding:20px 32px;margin:0\">\r\n            新评论通知\r\n        </p>\r\n    </div>\r\n    <div style=\"margin:0px auto;width:90%\">\r\n        <p>\r\n            评论内容：\r\n        </p>\r\n        <div style=\"background:#efefef;margin:15px 0px;padding:1px 15px;border-radius:5px;font-size:14px;color:#333\"><#if comment?exists>${comment.content}<#else>**无评论内容**</#if></div>\r\n        <p>\r\n            <a style=\"text-decoration:none;\" href=\"${config.siteUrl}${comment.sourceUrl}\" target=\"_blank\">查看完整评论</a>\r\n        </p>\r\n        <p>（注：此邮件由系统自动发出，请勿回复。）</p>\r\n    </div>\r\n    <div class=\"adL\">\r\n    </div>\r\n</div>\r\n</body>\r\n</html>', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_template` VALUES ('10', 'TM_NGINX_FILE_SERVER', 'server {\r\n    listen 80;\r\n    server_name serverName;\r\n    root serverPath;\r\n error_page 403 /error.html;\r\n location = /error.html {\r\n    return 404;\r\n }\r\n autoindex off; \r\n autoindex_exact_size off; \r\n  autoindex_localtime off; \r\n \r\n  location ^~ / {\r\n   proxy_set_header Host $host:$server_port;\r\n    }\r\n  \r\n  location ~*\\.(jpg|gif|png|swf|flv|wma|wmv|asf|mp3|mmf|zip|rar|js|css)$ {\r\n   expires 30d;\r\n    valid_referers serverReferers;\r\n    if ($invalid_referer) {\r\n     rewrite ^/ serverLogoPath;\r\n    }\r\n    }\r\n}\r\n', '2020-07-09 11:59:23', '2020-07-09 11:59:23');

# 清空系统更新通知表
TRUNCATE TABLE `oneblog`.`sys_update_recorde`;
# 初始化系统更新通知
INSERT INTO `oneblog`.`sys_update_recorde` VALUES ('1', '2.2.2', '版本: 2.2.2', '2020-07-09 11:59:23', '2020-07-09 11:59:23', '2020-07-09 11:59:23');

# 清空系统资源表
TRUNCATE TABLE `oneblog`.`sys_resources`;
# 初始化系统资源
INSERT INTO `oneblog`.`sys_resources` VALUES (1, '用户管理', 'menu', '', '', 0, 4, 0, 1, 'fa fa-users', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (2, '用户列表', 'menu', '/users', 'users', 1, 1, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (3, '新增用户', 'button', NULL, 'user:add', 2, 2, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (4, '批量删除用户', 'button', NULL, 'user:batchDelete', 2, 3, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (5, '编辑用户', 'button', NULL, 'user:edit,user:get', 2, 4, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (6, '删除用户', 'button', NULL, 'user:delete', 2, 5, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (7, '分配用户角色', 'button', NULL, 'user:allotRole', 2, 6, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (8, '权限管理', 'menu', '', '', 0, 3, 0, 1, 'fa fa-cogs', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (9, '资源管理', 'menu', '/resources', 'resources', 8, 1, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (10, '新增资源', 'button', NULL, 'resource:add', 9, 2, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (11, '批量删除资源', 'button', NULL, 'resource:batchDelete', 9, 3, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (12, '编辑资源', 'button', NULL, 'resource:edit,resource:get', 9, 4, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (13, '删除资源', 'button', NULL, 'resource:delete', 9, 5, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (14, '角色管理', 'menu', '/roles', 'roles', 8, 2, 0, 1, '', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (15, '新增角色', 'button', NULL, 'role:add', 14, 2, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (16, '批量删除角色', 'button', NULL, 'role:batchDelete', 14, 3, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (17, '编辑角色', 'button', NULL, 'role:edit,role:get', 14, 4, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (18, '删除角色', 'button', NULL, 'role:delete', 14, 5, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (19, '分配角色资源', 'button', NULL, 'role:allotResource', 14, 6, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (20, '文章管理', 'menu', '', '', 0, 1, 0, 1, 'fa fa-list', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (21, '文章列表', 'menu', '/articles', 'articles', 20, 1, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (22, '发表文章', 'button', NULL, 'article:publish', 21, 2, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (23, '批量删除文章', 'button', NULL, 'article:batchDelete', 21, 3, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (24, '批量推送文章', 'button', NULL, 'article:batchPush', 21, 4, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (25, '推送文章', 'button', NULL, 'article:push', 21, 5, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (26, '置顶文章', 'button', NULL, 'article:top', 21, 6, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (27, '推荐文章', 'button', NULL, 'article:recommend', 21, 7, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (28, '编辑文章', 'button', NULL, 'article:edit,article:get', 21, 8, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (29, '删除文章', 'button', NULL, 'article:delete', 21, 9, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (30, '分类列表', 'menu', '/article/types', 'types', 20, 2, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (31, '添加分类', 'button', NULL, 'type:add', 30, 2, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (32, '批量删除分类', 'button', NULL, 'type:batchDelete', 30, 3, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (33, '编辑分类', 'button', NULL, 'type:edit,type:get', 30, 4, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (34, '删除分类', 'button', NULL, 'type:delete', 30, 5, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (35, '标签列表', 'menu', '/article/tags', 'tags', 20, 2, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (36, '添加标签', 'button', NULL, 'tag:add', 35, 2, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (37, '批量删除标签', 'button', NULL, 'tag:batchDelete', 35, 3, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (38, '编辑标签', 'button', NULL, 'tag:edit,tag:get', 35, 4, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (39, '删除标签', 'button', NULL, 'tag:delete', 35, 5, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (40, '网站管理', 'menu', '', '', 0, 2, 0, 1, 'fa fa-globe', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (41, '友情链接', 'menu', '/links', 'links', 40, 2, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (42, '添加友情链接', 'button', NULL, 'link:add', 41, 2, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (43, '批量删除友情链接', 'button', NULL, 'link:batchDelete', 41, 3, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (44, '编辑友情链接', 'button', NULL, 'link:edit,link:get', 41, 4, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (45, '删除友情链接', 'button', NULL, 'link:delete', 41, 5, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (46, '评论管理', 'menu', '/comments', 'comments', 40, 2, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (47, '批量删除评论', 'button', NULL, 'comment:batchDelete', 46, 2, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (48, '回复评论', 'button', NULL, 'comment:reply', 46, 3, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (49, '审核评论', 'button', NULL, 'comment:audit', 46, 4, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (50, '删除评论', 'button', NULL, 'comment:delete', 46, 5, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (51, '模板管理', 'menu', '/templates', 'templates', 40, 3, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (52, '添加模板', 'button', NULL, 'template:add', 51, 2, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (53, '批量删除模板', 'button', NULL, 'template:batchDelete', 51, 3, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (54, '编辑模板', 'button', NULL, 'template:edit,template:get', 51, 4, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (55, '删除模板', 'button', NULL, 'template:delete', 51, 5, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (56, '更新日志', 'menu', '/updates', 'updateLogs', 40, 4, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (57, '添加更新日志', 'button', NULL, 'updateLog:add', 51, 2, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (58, '批量删除更新日志', 'button', NULL, 'updateLog:batchDelete', 51, 3, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (59, '编辑更新日志', 'button', NULL, 'updateLog:edit,updateLog:get', 51, 4, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (60, '删除更新日志', 'button', NULL, 'updateLog:delete', 51, 5, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (61, '公告管理', 'menu', '/notices', 'notices', 40, 5, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (62, '添加公告', 'button', NULL, 'notice:add', 61, 2, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (63, '批量删除公告', 'button', NULL, 'notice:batchDelete', 61, 3, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (64, '编辑公告', 'button', NULL, 'notice:edit,notice:get', 61, 4, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (65, '删除公告', 'button', NULL, 'notice:delete', 61, 5, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (66, '发布公告', 'button', NULL, 'notice:release', 61, 6, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (67, '撤回公告', 'button', NULL, 'notice:withdraw', 61, 7, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (68, '测试页面', 'menu', '', '', 0, 6, 0, 1, 'fa fa-desktop', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (69, 'icons图标', 'menu', '/icons', 'icons', 68, 2, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (70, 'shiro测试', 'menu', '/shiro', 'shiro', 68, 3, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (71, '推送消息', 'menu', '/notice', 'notice', 72, NULL, 0, 1, '', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (72, '实验室', 'menu', '', '', 0, 5, 0, 1, 'fa fa-flask', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (73, '文章搬运工', 'menu', '/remover', 'remover', 72, NULL, 0, 1, '', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (74, '编辑器', 'menu', '/editor', 'editor', 68, NULL, 0, 1, '', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_resources` VALUES (75, '文件管理', 'menu', '/files', 'files', 40, 6, 0, 1, NULL, '2020-07-09 11:59:23', '2020-07-09 11:59:23');

# 清空系统角色
TRUNCATE TABLE `oneblog`.`sys_role`;
# 初始化系统角色
INSERT INTO `oneblog`.`sys_role` VALUES ('1', 'role:root', '超级管理员', '1', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role` VALUES ('2', 'role:admin', '管理员', '1', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role` VALUES ('3', 'role:comment', '评论审核管理员', '1', '2020-07-09 11:59:23', '2020-07-09 11:59:23');

# 清空角色->资源对应内容
TRUNCATE TABLE `oneblog`.`sys_role_resources`;
# 初始化角色->资源对应内容
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('1', '1', '1', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('2', '1', '2', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('3', '1', '3', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('4', '1', '4', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('5', '1', '5', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('6', '1', '6', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('7', '1', '7', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('8', '1', '8', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('9', '1', '9', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('10', '1', '10', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('11', '1', '11', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('12', '1', '12', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('13', '1', '13', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('14', '1', '14', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('15', '1', '15', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('16', '1', '16', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('17', '1', '17', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('18', '1', '18', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('19', '1', '19', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('20', '1', '20', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('21', '1', '21', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('22', '1', '22', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('23', '1', '23', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('24', '1', '24', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('25', '1', '25', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('26', '1', '26', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('27', '1', '27', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('28', '1', '28', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('29', '1', '29', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('30', '1', '30', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('31', '1', '31', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('32', '1', '32', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('33', '1', '33', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('34', '1', '34', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('35', '1', '35', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('36', '1', '36', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('37', '1', '37', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('38', '1', '38', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('39', '1', '39', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('40', '1', '40', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('41', '1', '41', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('42', '1', '42', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('43', '1', '43', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('44', '1', '44', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('45', '1', '45', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('46', '1', '46', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('47', '1', '47', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('48', '1', '48', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('49', '1', '49', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('50', '1', '50', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('51', '1', '51', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('52', '1', '52', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('53', '1', '57', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('54', '1', '53', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('55', '1', '58', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('56', '1', '54', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('57', '1', '59', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('58', '1', '55', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('59', '1', '60', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('60', '1', '56', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('61', '1', '61', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('62', '1', '62', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('63', '1', '63', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('64', '1', '64', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('65', '1', '65', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('66', '1', '66', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('67', '1', '67', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('68', '1', '68', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('69', '2', '20', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('70', '2', '21', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('71', '2', '24', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('72', '2', '25', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('73', '2', '26', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('74', '2', '27', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('75', '3', '40', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('76', '3', '46', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('77', '3', '48', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_role_resources` VALUES ('78', '3', '49', '2020-07-09 11:59:23', '2020-07-09 11:59:23');

# 清空系统用户表
TRUNCATE TABLE `oneblog`.`sys_user`;
# 初始化系统用户
INSERT INTO `oneblog`.`sys_user` VALUES (1, 'root', 'CGUx1FN++xS+4wNDFeN6DA==', '超级管理员', '18600000000', '871731559@qq.com', '871731559', NULL, NULL, 'https://static.zhyd.me/static/img/favicon.ico', 'ROOT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, '0:0:0:0:0:0:0:1', '2020-07-09 11:59:23', 254, NULL, 1, '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_user` VALUES (2, 'admin', 'gXp2EbyZ+sB/A6QUMhiUJQ==', '管理员', '18600000000', '871731559@qq.com', '871731559', NULL, NULL, NULL, 'ADMIN', NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1','2020-07-09 11:59:23', 2, NULL, 1,'2020-07-09 11:59:23','2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_user` VALUES (3, 'comment-admin', 'x9qCx3yP05yWfIE5wXbCsg==', '评论审核管理员', '', '', '', NULL, NULL, NULL, 'ADMIN', NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1','2020-07-09 11:59:23', 1, NULL, 1,'2020-07-09 11:59:23','2020-07-09 11:59:23');

# 清空用户角色关联数据
TRUNCATE TABLE `oneblog`.`sys_user_role`;
# 初始化用户角色关联数据
INSERT INTO `oneblog`.`sys_user_role` VALUES ('1', '1', '1', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_user_role` VALUES ('2', '2', '2', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
INSERT INTO `oneblog`.`sys_user_role` VALUES ('3', '3', '3', '2020-07-09 11:59:23', '2020-07-09 11:59:23');
