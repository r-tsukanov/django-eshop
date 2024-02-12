-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               8.0.33 - MySQL Community Server - GPL
-- Операционная система:         Win64
-- HeidiSQL Версия:              12.4.0.6659
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Дамп структуры базы данных django_eshop
CREATE DATABASE IF NOT EXISTS `django_eshop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `django_eshop`;

-- Дамп структуры для таблица django_eshop.auth_group
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.auth_group: ~0 rows (приблизительно)
DELETE FROM `auth_group`;

-- Дамп структуры для таблица django_eshop.auth_group_permissions
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.auth_group_permissions: ~0 rows (приблизительно)
DELETE FROM `auth_group_permissions`;

-- Дамп структуры для таблица django_eshop.auth_permission
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.auth_permission: ~64 rows (приблизительно)
DELETE FROM `auth_permission`;
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(1, 'Can add log entry', 1, 'add_logentry'),
	(2, 'Can change log entry', 1, 'change_logentry'),
	(3, 'Can delete log entry', 1, 'delete_logentry'),
	(4, 'Can view log entry', 1, 'view_logentry'),
	(5, 'Can add permission', 2, 'add_permission'),
	(6, 'Can change permission', 2, 'change_permission'),
	(7, 'Can delete permission', 2, 'delete_permission'),
	(8, 'Can view permission', 2, 'view_permission'),
	(9, 'Can add group', 3, 'add_group'),
	(10, 'Can change group', 3, 'change_group'),
	(11, 'Can delete group', 3, 'delete_group'),
	(12, 'Can view group', 3, 'view_group'),
	(13, 'Can add user', 4, 'add_user'),
	(14, 'Can change user', 4, 'change_user'),
	(15, 'Can delete user', 4, 'delete_user'),
	(16, 'Can view user', 4, 'view_user'),
	(17, 'Can add content type', 5, 'add_contenttype'),
	(18, 'Can change content type', 5, 'change_contenttype'),
	(19, 'Can delete content type', 5, 'delete_contenttype'),
	(20, 'Can view content type', 5, 'view_contenttype'),
	(21, 'Can add session', 6, 'add_session'),
	(22, 'Can change session', 6, 'change_session'),
	(23, 'Can delete session', 6, 'delete_session'),
	(24, 'Can view session', 6, 'view_session'),
	(25, 'Can add brand', 7, 'add_brand'),
	(26, 'Can change brand', 7, 'change_brand'),
	(27, 'Can delete brand', 7, 'delete_brand'),
	(28, 'Can view brand', 7, 'view_brand'),
	(29, 'Can add category', 8, 'add_category'),
	(30, 'Can change category', 8, 'change_category'),
	(31, 'Can delete category', 8, 'delete_category'),
	(32, 'Can view category', 8, 'view_category'),
	(33, 'Can add color', 9, 'add_color'),
	(34, 'Can change color', 9, 'change_color'),
	(35, 'Can delete color', 9, 'delete_color'),
	(36, 'Can view color', 9, 'view_color'),
	(37, 'Can add product', 10, 'add_product'),
	(38, 'Can change product', 10, 'change_product'),
	(39, 'Can delete product', 10, 'delete_product'),
	(40, 'Can view product', 10, 'view_product'),
	(41, 'Can add size', 11, 'add_size'),
	(42, 'Can change size', 11, 'change_size'),
	(43, 'Can delete size', 11, 'delete_size'),
	(44, 'Can view size', 11, 'view_size'),
	(45, 'Can add product_ images', 12, 'add_product_images'),
	(46, 'Can change product_ images', 12, 'change_product_images'),
	(47, 'Can delete product_ images', 12, 'delete_product_images'),
	(48, 'Can view product_ images', 12, 'view_product_images'),
	(49, 'Can add wishlist', 13, 'add_wishlist'),
	(50, 'Can change wishlist', 13, 'change_wishlist'),
	(51, 'Can delete wishlist', 13, 'delete_wishlist'),
	(52, 'Can view wishlist', 13, 'view_wishlist'),
	(53, 'Can add profile', 14, 'add_profile'),
	(54, 'Can change profile', 14, 'change_profile'),
	(55, 'Can delete profile', 14, 'delete_profile'),
	(56, 'Can view profile', 14, 'view_profile'),
	(57, 'Can add order', 15, 'add_order'),
	(58, 'Can change order', 15, 'change_order'),
	(59, 'Can delete order', 15, 'delete_order'),
	(60, 'Can view order', 15, 'view_order'),
	(61, 'Can add order item', 16, 'add_orderitem'),
	(62, 'Can change order item', 16, 'change_orderitem'),
	(63, 'Can delete order item', 16, 'delete_orderitem'),
	(64, 'Can view order item', 16, 'view_orderitem');

-- Дамп структуры для таблица django_eshop.auth_user
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.auth_user: ~1 rows (приблизительно)
DELETE FROM `auth_user`;
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(1, 'pbkdf2_sha256$600000$8Mv4hq0nKkMOczO1F3fNXD$/Q1Hr7Vg9AXqOSyHQqAW0U1UQGawV/wmg+cwtZyEjSo=', '2024-02-12 15:32:52.095466', 1, 'admin', '', '', 'asd@gfh.ru', 1, 1, '2023-11-30 10:46:14.559897');

-- Дамп структуры для таблица django_eshop.auth_user_groups
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.auth_user_groups: ~0 rows (приблизительно)
DELETE FROM `auth_user_groups`;

-- Дамп структуры для таблица django_eshop.auth_user_user_permissions
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.auth_user_user_permissions: ~0 rows (приблизительно)
DELETE FROM `auth_user_user_permissions`;

-- Дамп структуры для таблица django_eshop.django_admin_log
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.django_admin_log: ~39 rows (приблизительно)
DELETE FROM `django_admin_log`;
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
	(1, '2023-11-30 10:56:54.465760', '1', 'Мужчинам', 1, '[{"added": {}}]', 8, 1),
	(2, '2023-11-30 10:57:04.538860', '2', 'Женщинам', 1, '[{"added": {}}]', 8, 1),
	(3, '2023-11-30 10:57:13.558160', '3', 'Куртки', 1, '[{"added": {}}]', 8, 1),
	(4, '2023-11-30 11:55:33.096339', '4', 'Ветровки', 1, '[{"added": {}}]', 8, 1),
	(5, '2023-11-30 18:32:27.737308', '1', 'Ralph Lauren', 1, '[{"added": {}}]', 7, 1),
	(6, '2023-11-30 18:33:12.931481', '1', 'синий', 1, '[{"added": {}}]', 9, 1),
	(7, '2023-11-30 18:33:24.043147', '1', 'M', 1, '[{"added": {}}]', 11, 1),
	(8, '2023-11-30 18:33:37.223510', '1', 'Поло Ralph Lauren', 1, '[{"added": {}}, {"added": {"name": "product_ images", "object": "Product_Images object (1)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (2)"}}]', 10, 1),
	(9, '2023-11-30 18:34:33.046651', '5', 'Футболки и поло', 1, '[{"added": {}}]', 8, 1),
	(10, '2023-11-30 18:34:44.685794', '1', 'Поло Ralph Lauren', 2, '[{"changed": {"fields": ["Category"]}}]', 10, 1),
	(11, '2023-11-30 21:27:48.437634', '2', 'L', 1, '[{"added": {}}]', 11, 1),
	(12, '2023-11-30 21:28:23.783817', '2', 'Футболка Ralph Lauren', 1, '[{"added": {}}, {"added": {"name": "product_ images", "object": "Product_Images object (3)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (4)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (5)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (6)"}}]', 10, 1),
	(13, '2023-11-30 21:35:05.076184', '3', 'Футболка Ralph Lauren', 1, '[{"added": {}}, {"added": {"name": "product_ images", "object": "Product_Images object (7)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (8)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (9)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (10)"}}]', 10, 1),
	(14, '2023-11-30 21:36:47.081463', '3', 'Футболка2 Ralph Lauren', 2, '[{"changed": {"fields": ["Name", "Slug"]}}]', 10, 1),
	(15, '2023-11-30 21:37:26.137701', '3', 'Футболка Ralph Lauren', 2, '[{"changed": {"fields": ["Name", "Slug"]}}]', 10, 1),
	(16, '2023-11-30 22:14:41.925943', '2', 'черный', 1, '[{"added": {}}]', 9, 1),
	(17, '2023-11-30 22:14:48.470418', '3', 'S', 1, '[{"added": {}}]', 11, 1),
	(18, '2023-11-30 22:15:25.394537', '4', 'Поло с длинным рукавом Ralph Lauren', 1, '[{"added": {}}, {"added": {"name": "product_ images", "object": "Product_Images object (11)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (12)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (13)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (14)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (15)"}}]', 10, 1),
	(19, '2023-11-30 22:18:27.902003', '1', 'Поло Ralph Lauren', 2, '[{"deleted": {"name": "product_ images", "object": "Product_Images object (None)"}}, {"deleted": {"name": "product_ images", "object": "Product_Images object (None)"}}]', 10, 1),
	(20, '2023-11-30 22:20:32.820886', '1', 'Поло Ralph Lauren', 2, '[{"added": {"name": "product_ images", "object": "Product_Images object (16)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (17)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (18)"}}]', 10, 1),
	(21, '2023-11-30 22:20:58.964930', '2', 'Футболка Ralph Lauren', 2, '[{"deleted": {"name": "product_ images", "object": "Product_Images object (None)"}}, {"deleted": {"name": "product_ images", "object": "Product_Images object (None)"}}, {"deleted": {"name": "product_ images", "object": "Product_Images object (None)"}}, {"deleted": {"name": "product_ images", "object": "Product_Images object (None)"}}]', 10, 1),
	(22, '2023-11-30 22:21:24.135685', '3', 'Футболка Ralph Lauren', 2, '[{"deleted": {"name": "product_ images", "object": "Product_Images object (None)"}}, {"deleted": {"name": "product_ images", "object": "Product_Images object (None)"}}, {"deleted": {"name": "product_ images", "object": "Product_Images object (None)"}}, {"deleted": {"name": "product_ images", "object": "Product_Images object (None)"}}]', 10, 1),
	(23, '2023-11-30 22:22:21.815596', '2', 'Футболка Ralph Lauren', 2, '[{"added": {"name": "product_ images", "object": "Product_Images object (19)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (20)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (21)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (22)"}}]', 10, 1),
	(24, '2023-11-30 22:22:45.391194', '3', 'Футболка Ralph Lauren', 2, '[{"added": {"name": "product_ images", "object": "Product_Images object (23)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (24)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (25)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (26)"}}]', 10, 1),
	(25, '2023-11-30 23:03:55.885763', '4', 'Поло с длинным рукавом Ralph Lauren', 2, '[{"changed": {"fields": ["Category"]}}]', 10, 1),
	(26, '2023-11-30 23:59:03.067896', '6', 'Куртки', 1, '[{"added": {}}]', 8, 1),
	(27, '2023-12-01 00:06:54.268083', '2', 'Calvin Klein', 1, '[{"added": {}}]', 7, 1),
	(28, '2023-12-01 00:08:12.521074', '3', 'Зеленый', 1, '[{"added": {}}]', 9, 1),
	(29, '2023-12-01 00:10:03.041820', '5', 'Женский пуховик Calvin Klein', 1, '[{"added": {}}, {"added": {"name": "product_ images", "object": "Product_Images object (27)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (28)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (29)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (30)"}}]', 10, 1),
	(30, '2023-12-01 00:11:57.455396', '6', 'Пуховики', 2, '[{"changed": {"fields": ["Name", "Slug"]}}]', 8, 1),
	(31, '2023-12-01 16:17:28.115958', '7', 'Пальто', 1, '[{"added": {}}]', 8, 1),
	(32, '2023-12-01 16:17:59.441707', '4', 'Коричневый', 1, '[{"added": {}}]', 9, 1),
	(33, '2023-12-01 16:19:54.811704', '6', 'Женское пальто Calvin Klein', 1, '[{"added": {}}, {"added": {"name": "product_ images", "object": "Product_Images object (31)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (32)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (33)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (34)"}}]', 10, 1),
	(34, '2023-12-01 16:32:32.914462', '5', 'Желтый', 1, '[{"added": {}}]', 9, 1),
	(35, '2023-12-01 16:33:12.457028', '7', 'Женский пуховик Calvin Klein', 1, '[{"added": {}}, {"added": {"name": "product_ images", "object": "Product_Images object (35)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (36)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (37)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (38)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (39)"}}, {"added": {"name": "product_ images", "object": "Product_Images object (40)"}}]', 10, 1),
	(36, '2024-02-12 15:33:13.520641', '1', 'Заказ 1', 3, '', 15, 1),
	(37, '2024-02-12 15:33:30.584323', '2', 'Oleg', 3, '', 4, 1),
	(38, '2024-02-12 15:36:41.955323', '1', 'admin', 2, '[{"changed": {"fields": ["Last name", "Address"]}}]', 14, 1),
	(39, '2024-02-12 15:48:47.664579', '4', 'Ветровка Ralph Lauren', 2, '[{"changed": {"fields": ["Name", "Slug"]}}]', 10, 1);

-- Дамп структуры для таблица django_eshop.django_content_type
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.django_content_type: ~16 rows (приблизительно)
DELETE FROM `django_content_type`;
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(1, 'admin', 'logentry'),
	(3, 'auth', 'group'),
	(2, 'auth', 'permission'),
	(4, 'auth', 'user'),
	(5, 'contenttypes', 'contenttype'),
	(15, 'orders', 'order'),
	(16, 'orders', 'orderitem'),
	(6, 'sessions', 'session'),
	(7, 'shop', 'brand'),
	(8, 'shop', 'category'),
	(9, 'shop', 'color'),
	(10, 'shop', 'product'),
	(12, 'shop', 'product_images'),
	(11, 'shop', 'size'),
	(14, 'users', 'profile'),
	(13, 'users', 'wishlist');

-- Дамп структуры для таблица django_eshop.django_migrations
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.django_migrations: ~21 rows (приблизительно)
DELETE FROM `django_migrations`;
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'contenttypes', '0001_initial', '2023-11-30 10:45:40.858770'),
	(2, 'auth', '0001_initial', '2023-11-30 10:45:41.210857'),
	(3, 'admin', '0001_initial', '2023-11-30 10:45:41.285068'),
	(4, 'admin', '0002_logentry_remove_auto_add', '2023-11-30 10:45:41.293805'),
	(5, 'admin', '0003_logentry_add_action_flag_choices', '2023-11-30 10:45:41.300806'),
	(6, 'contenttypes', '0002_remove_content_type_name', '2023-11-30 10:45:41.350591'),
	(7, 'auth', '0002_alter_permission_name_max_length', '2023-11-30 10:45:41.384275'),
	(8, 'auth', '0003_alter_user_email_max_length', '2023-11-30 10:45:41.408275'),
	(9, 'auth', '0004_alter_user_username_opts', '2023-11-30 10:45:41.416267'),
	(10, 'auth', '0005_alter_user_last_login_null', '2023-11-30 10:45:41.449638'),
	(11, 'auth', '0006_require_contenttypes_0002', '2023-11-30 10:45:41.452753'),
	(12, 'auth', '0007_alter_validators_add_error_messages', '2023-11-30 10:45:41.460651'),
	(13, 'auth', '0008_alter_user_username_max_length', '2023-11-30 10:45:41.497751'),
	(14, 'auth', '0009_alter_user_last_name_max_length', '2023-11-30 10:45:41.532124'),
	(15, 'auth', '0010_alter_group_name_max_length', '2023-11-30 10:45:41.547860'),
	(16, 'auth', '0011_update_proxy_permissions', '2023-11-30 10:45:41.554758'),
	(17, 'auth', '0012_alter_user_first_name_max_length', '2023-11-30 10:45:41.591760'),
	(18, 'shop', '0001_initial', '2023-11-30 10:45:42.015113'),
	(19, 'users', '0001_initial', '2023-11-30 10:45:42.143094'),
	(20, 'orders', '0001_initial', '2023-11-30 10:45:42.301243'),
	(21, 'sessions', '0001_initial', '2023-11-30 10:45:42.329808');

-- Дамп структуры для таблица django_eshop.django_session
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.django_session: ~2 rows (приблизительно)
DELETE FROM `django_session`;
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('rq9en79o4aqrq2sq57jytgkn2mjj1dkb', '.eJxVjEEOgyAQRe8y64YwIhRddt8zkGEYqm0jCerKePfWxI3b_977GzDVBfptv0GgdRnCOksNY4IeEC5bJP7IdID0pulVFJdpqWNUh6JOOqtnSfJ9nO7lYKB5-NcmijPY2jY1Qp4QsbGZjfYOncsmO9NxIt_xnbhBjiRJSzbSWkSNQrD_ACG5O18:1rG3AG:pQtSD-7dX4WWm1ScY49GCLz1LgmQ_KYnnHgbQYUzzfQ', '2024-01-03 20:27:36.232057'),
	('zvbprg7gydds2vhhpm58g29un6cf9wmf', '.eJxVjEEOgyAQRe8y64YwIhRddt8zkGEYqm0jCerKePfWxI3b_977GzDVBfptv0GgdRnCOksNY4IeEC5bJP7IdID0pulVFJdpqWNUh6JOOqtnSfJ9nO7lYKB5-NcmijPY2jY1Qp4QsbGZjfYOncsmO9NxIt_xnbhBjiRJSzbSWkSNQrD_ACG5O18:1rZYY3:1xCCVNf06bJSCK-EU5QG-fPT8v29M6jUQdmf6NEi2P8', '2024-02-26 15:48:47.788766');

-- Дамп структуры для таблица django_eshop.orders_order
CREATE TABLE IF NOT EXISTS `orders_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `contact_number` varchar(12) NOT NULL,
  `email` varchar(254) NOT NULL,
  `address` varchar(250) NOT NULL,
  `city` varchar(100) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `paid` tinyint(1) NOT NULL,
  `profile_id` bigint DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_order_profile_id_0f98db0f_fk_users_profile_id` (`profile_id`),
  KEY `orders_order_user_id_e9b59eb1_fk_auth_user_id` (`user_id`),
  CONSTRAINT `orders_order_profile_id_0f98db0f_fk_users_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `users_profile` (`id`),
  CONSTRAINT `orders_order_user_id_e9b59eb1_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.orders_order: ~0 rows (приблизительно)
DELETE FROM `orders_order`;

-- Дамп структуры для таблица django_eshop.orders_orderitem
CREATE TABLE IF NOT EXISTS `orders_orderitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `color` varchar(100) NOT NULL,
  `size` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int unsigned NOT NULL,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_orderitem_order_id_fe61a34d_fk_orders_order_id` (`order_id`),
  KEY `orders_orderitem_product_id_afe4254a_fk_shop_product_id` (`product_id`),
  CONSTRAINT `orders_orderitem_order_id_fe61a34d_fk_orders_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`id`),
  CONSTRAINT `orders_orderitem_product_id_afe4254a_fk_shop_product_id` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`),
  CONSTRAINT `orders_orderitem_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.orders_orderitem: ~0 rows (приблизительно)
DELETE FROM `orders_orderitem`;

-- Дамп структуры для таблица django_eshop.shop_brand
CREATE TABLE IF NOT EXISTS `shop_brand` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.shop_brand: ~2 rows (приблизительно)
DELETE FROM `shop_brand`;
INSERT INTO `shop_brand` (`id`, `name`, `slug`, `description`) VALUES
	(1, 'Ralph Lauren', 'ralph-lauren', 'Ralph Lauren заимствует идеи из английского «кантри», вдохновляясь традиционным обликом английских землевладельцев и стилем их усадебной жизни. Другой его источник — американский стиль «вестерн» с его сапогами, джинсами и кожаными куртками с бахромой: облагороженный, он становится неотъемлемой частью американского имиджа.'),
	(2, 'Calvin Klein', 'calvin-klein', 'Компания Calvin Klein, Ltd была основана в 1968 году Келвином Кляйном и его другом детства Барри Шварцем в Нью-Йорке. Сначала ателье выпускало мужскую верхнюю одежду, затем постепенно перешло к дизайну одежды для женщин. В 1970-е для женской моды был адаптирован классический мужской костюм; представленное в 1970 году двубортное короткое пальто с широкими лацканами не только стало хитом сезона, но и оказало сильное влияние на моду верхней женской одежды почти на десятилетие. В 1974 году Кляйн создал коллекцию аксессуаров и меховой одежды');

-- Дамп структуры для таблица django_eshop.shop_category
CREATE TABLE IF NOT EXISTS `shop_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `url_path` longtext NOT NULL,
  `lft` int unsigned NOT NULL,
  `rght` int unsigned NOT NULL,
  `tree_id` int unsigned NOT NULL,
  `level` int unsigned NOT NULL,
  `parent_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shop_category_slug_4508178e` (`slug`),
  KEY `shop_category_tree_id_c48d9e64` (`tree_id`),
  KEY `shop_category_parent_id_901626c9` (`parent_id`),
  CONSTRAINT `shop_category_parent_id_901626c9_fk_shop_category_id` FOREIGN KEY (`parent_id`) REFERENCES `shop_category` (`id`),
  CONSTRAINT `shop_category_chk_1` CHECK ((`lft` >= 0)),
  CONSTRAINT `shop_category_chk_2` CHECK ((`rght` >= 0)),
  CONSTRAINT `shop_category_chk_3` CHECK ((`tree_id` >= 0)),
  CONSTRAINT `shop_category_chk_4` CHECK ((`level` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.shop_category: ~7 rows (приблизительно)
DELETE FROM `shop_category`;
INSERT INTO `shop_category` (`id`, `name`, `slug`, `url_path`, `lft`, `rght`, `tree_id`, `level`, `parent_id`) VALUES
	(1, 'Мужчинам', 'muzhchinam', 'muzhchinam', 1, 8, 2, 0, NULL),
	(2, 'Женщинам', 'zhenshinam', 'zhenshinam', 1, 6, 1, 0, NULL),
	(3, 'Куртки', 'kurtki', 'muzhchinam/kurtki', 2, 5, 2, 1, 1),
	(4, 'Ветровки', 'vetrovki', 'muzhchinam/kurtki/vetrovki', 3, 4, 2, 2, 3),
	(5, 'Футболки и поло', 'futbolki-i-polo', 'muzhchinam/futbolki-i-polo', 6, 7, 2, 1, 1),
	(6, 'Пуховики', 'puhoviki', 'zhenshinam/puhoviki', 4, 5, 1, 1, 2),
	(7, 'Пальто', 'palto', 'zhenshinam/palto', 2, 3, 1, 1, 2);

-- Дамп структуры для таблица django_eshop.shop_color
CREATE TABLE IF NOT EXISTS `shop_color` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `color_name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.shop_color: ~5 rows (приблизительно)
DELETE FROM `shop_color`;
INSERT INTO `shop_color` (`id`, `color_name`, `slug`) VALUES
	(1, 'синий', 'blue'),
	(2, 'черный', 'black'),
	(3, 'Зеленый', 'green'),
	(4, 'Коричневый', 'brown'),
	(5, 'Желтый', 'yellow');

-- Дамп структуры для таблица django_eshop.shop_product
CREATE TABLE IF NOT EXISTS `shop_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `brand_name` varchar(250) NOT NULL,
  `description` longtext NOT NULL,
  `additional_description` longtext NOT NULL,
  `gender` varchar(6) NOT NULL,
  `composition` varchar(100) NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `brand_id` bigint DEFAULT NULL,
  `category_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shop_product_brand_id_505fec11_fk_shop_brand_id` (`brand_id`),
  KEY `shop_product_category_id_14d7eea8_fk_shop_category_id` (`category_id`),
  KEY `shop_product_slug_30bd2d5d` (`slug`),
  CONSTRAINT `shop_product_brand_id_505fec11_fk_shop_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `shop_brand` (`id`),
  CONSTRAINT `shop_product_category_id_14d7eea8_fk_shop_category_id` FOREIGN KEY (`category_id`) REFERENCES `shop_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.shop_product: ~7 rows (приблизительно)
DELETE FROM `shop_product`;
INSERT INTO `shop_product` (`id`, `name`, `slug`, `brand_name`, `description`, `additional_description`, `gender`, `composition`, `price`, `brand_id`, `category_id`) VALUES
	(1, 'Поло', 'polo', 'Ralph Lauren', '', '', 'men', 'хлопок', 3000, 1, 5),
	(2, 'Футболка', 'futbolka', 'Ralph Lauren', '', '', 'men', 'хлопок', 2000, 1, 5),
	(3, 'Футболка', 'futbolka', 'Ralph Lauren', '', '', 'men', 'хлопок', 2500, 1, 5),
	(4, 'Ветровка', 'vetrovka', 'Ralph Lauren', '', '', 'men', 'хлопок', 4000, 1, 4),
	(5, 'Женский пуховик', 'zhenskij-puhovik', 'Calvin Klein', '', '', 'woman', 'полиэстер', 6000, 2, 6),
	(6, 'Женское пальто', 'zhenskoe-palto', 'Calvin Klein', '', '', 'woman', 'хлопок', 5000, 2, 7),
	(7, 'Женский пуховик', 'zhenskij-puhovik', 'Calvin Klein', '', '', 'woman', 'полиэстер', 6000, 2, 6);

-- Дамп структуры для таблица django_eshop.shop_product_color
CREATE TABLE IF NOT EXISTS `shop_product_color` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `color_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `shop_product_color_product_id_color_id_c285191e_uniq` (`product_id`,`color_id`),
  KEY `shop_product_color_color_id_fcc51a16_fk_shop_color_id` (`color_id`),
  CONSTRAINT `shop_product_color_color_id_fcc51a16_fk_shop_color_id` FOREIGN KEY (`color_id`) REFERENCES `shop_color` (`id`),
  CONSTRAINT `shop_product_color_product_id_22aa5dd7_fk_shop_product_id` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.shop_product_color: ~7 rows (приблизительно)
DELETE FROM `shop_product_color`;
INSERT INTO `shop_product_color` (`id`, `product_id`, `color_id`) VALUES
	(1, 1, 1),
	(2, 2, 1),
	(3, 3, 1),
	(4, 4, 2),
	(5, 5, 3),
	(6, 6, 4),
	(7, 7, 5);

-- Дамп структуры для таблица django_eshop.shop_product_images
CREATE TABLE IF NOT EXISTS `shop_product_images` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `position` int NOT NULL,
  `img_original` varchar(100) NOT NULL,
  `img_big` varchar(255) NOT NULL,
  `img_small` varchar(255) NOT NULL,
  `img_thumb` varchar(255) NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `shop_product_images_product_id_2558b27e_fk_shop_product_id` (`product_id`),
  CONSTRAINT `shop_product_images_product_id_2558b27e_fk_shop_product_id` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.shop_product_images: ~30 rows (приблизительно)
DELETE FROM `shop_product_images`;
INSERT INTO `shop_product_images` (`id`, `position`, `img_original`, `img_big`, `img_small`, `img_thumb`, `product_id`) VALUES
	(11, 0, 'images/e2d9290fe0d4a9f709fd0249d9e69312.jpg', '11_big.jpg', '11_small.jpg', '11_thumb.jpg', 4),
	(12, 0, 'images/d4fc5b4c206bda3d012c9c4b76dd49dd.jpg', '12_big.jpg', '12_small.jpg', '12_thumb.jpg', 4),
	(13, 0, 'images/8a89877a6b86073729d44d720b1c5617.jpg', '13_big.jpg', '13_small.jpg', '13_thumb.jpg', 4),
	(14, 0, 'images/aac72e399a22e3a788ca1ba6423cb157.jpg', '14_big.jpg', '14_small.jpg', '14_thumb.jpg', 4),
	(15, 0, 'images/d4ab61a0739c0ac571e12c455083e519.jpg', '15_big.jpg', '15_small.jpg', '15_thumb.jpg', 4),
	(16, 0, 'images/157f78971ad120c97978127f288a7cc8.jpg', '16_big.jpg', '16_small.jpg', '16_thumb.jpg', 1),
	(17, 0, 'images/c285fd5f2bc88b19d70402778e13020c.jpg', '17_big.jpg', '17_small.jpg', '17_thumb.jpg', 1),
	(18, 0, 'images/2494fee4869c8a302184f068addd5eff.jpg', '18_big.jpg', '18_small.jpg', '18_thumb.jpg', 1),
	(19, 0, 'images/46d0767bdfc371e4107498733d5317b3.jpg', '19_big.jpg', '19_small.jpg', '19_thumb.jpg', 2),
	(20, 0, 'images/5a0d8ee712d22ec7bb858a83a5fa089f.jpg', '20_big.jpg', '20_small.jpg', '20_thumb.jpg', 2),
	(21, 0, 'images/2a73d5e1753f0335d15b1056b2b0f70c.jpg', '21_big.jpg', '21_small.jpg', '21_thumb.jpg', 2),
	(22, 0, 'images/c3bf1b0fe72d561c6d32a3c78b99b90a.jpg', '22_big.jpg', '22_small.jpg', '22_thumb.jpg', 2),
	(23, 0, 'images/fe79c0c0ce24f1b7279264fb3affbb65.jpg', '23_big.jpg', '23_small.jpg', '23_thumb.jpg', 3),
	(24, 0, 'images/f2fae598082c77cff40d1b2874b2ea40.jpg', '24_big.jpg', '24_small.jpg', '24_thumb.jpg', 3),
	(25, 0, 'images/0b50ac4dcc28df2ea76ac0feb8c6e256.jpg', '25_big.jpg', '25_small.jpg', '25_thumb.jpg', 3),
	(26, 0, 'images/fd5703cc04a748e52fa7c7744835369e.jpg', '26_big.jpg', '26_small.jpg', '26_thumb.jpg', 3),
	(27, 0, 'images/86af1502b18d05ab4d343247c81f7768.jpg', '27_big.jpg', '27_small.jpg', '27_thumb.jpg', 5),
	(28, 0, 'images/2413694998196fb7c31154dada06ff51.jpg', '28_big.jpg', '28_small.jpg', '28_thumb.jpg', 5),
	(29, 0, 'images/b84498564fc61ec30bedcc4883f89a7d.jpg', '29_big.jpg', '29_small.jpg', '29_thumb.jpg', 5),
	(30, 0, 'images/9aebe938c6bc1226e97689c705db510f.jpg', '30_big.jpg', '30_small.jpg', '30_thumb.jpg', 5),
	(31, 0, 'images/48f45dea4fff1d6dc35506e3b20ff3d1.jpg', '31_big.jpg', '31_small.jpg', '31_thumb.jpg', 6),
	(32, 0, 'images/7728761010e8e2f9b5f6b295e5f49798.jpg', '32_big.jpg', '32_small.jpg', '32_thumb.jpg', 6),
	(33, 0, 'images/9561eb2df007c727957aec461ea5da54.jpg', '33_big.jpg', '33_small.jpg', '33_thumb.jpg', 6),
	(34, 0, 'images/6fde7829d7b3a9a25dfad656531bfaeb.jpg', '34_big.jpg', '34_small.jpg', '34_thumb.jpg', 6),
	(35, 0, 'images/4de3e4013a9e169a856c6c944014af1b.jpg', '35_big.jpg', '35_small.jpg', '35_thumb.jpg', 7),
	(36, 0, 'images/450e2cfdecc147908f0d6c7c61d70ebf.jpg', '36_big.jpg', '36_small.jpg', '36_thumb.jpg', 7),
	(37, 0, 'images/9d576778c0ccc30b95a193d5c54f6504.jpg', '37_big.jpg', '37_small.jpg', '37_thumb.jpg', 7),
	(38, 0, 'images/21ebc5fb10ba3688c6e90cab16528e85.jpg', '38_big.jpg', '38_small.jpg', '38_thumb.jpg', 7),
	(39, 0, 'images/6e8274f13fc83442b1941f4a8232ffa7.jpg', '39_big.jpg', '39_small.jpg', '39_thumb.jpg', 7),
	(40, 0, 'images/d52051d36e3cf518dbc30d955cd91866.jpg', '40_big.jpg', '40_small.jpg', '40_thumb.jpg', 7);

-- Дамп структуры для таблица django_eshop.shop_product_size
CREATE TABLE IF NOT EXISTS `shop_product_size` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `size_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `shop_product_size_product_id_size_id_4ca1c2c8_uniq` (`product_id`,`size_id`),
  KEY `shop_product_size_size_id_87e6d0ef_fk_shop_size_id` (`size_id`),
  CONSTRAINT `shop_product_size_product_id_d5bfa091_fk_shop_product_id` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`),
  CONSTRAINT `shop_product_size_size_id_87e6d0ef_fk_shop_size_id` FOREIGN KEY (`size_id`) REFERENCES `shop_size` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.shop_product_size: ~7 rows (приблизительно)
DELETE FROM `shop_product_size`;
INSERT INTO `shop_product_size` (`id`, `product_id`, `size_id`) VALUES
	(1, 1, 1),
	(2, 2, 2),
	(3, 3, 2),
	(4, 4, 3),
	(5, 5, 3),
	(6, 6, 3),
	(7, 7, 3);

-- Дамп структуры для таблица django_eshop.shop_size
CREATE TABLE IF NOT EXISTS `shop_size` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `size_name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.shop_size: ~3 rows (приблизительно)
DELETE FROM `shop_size`;
INSERT INTO `shop_size` (`id`, `size_name`, `slug`) VALUES
	(1, 'M', 'm'),
	(2, 'L', 'l'),
	(3, 'S', 's');

-- Дамп структуры для таблица django_eshop.users_profile
CREATE TABLE IF NOT EXISTS `users_profile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `image` varchar(100) NOT NULL,
  `contact_number` varchar(12) NOT NULL,
  `city` varchar(100) NOT NULL,
  `address` varchar(250) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `users_profile_user_id_2112e78d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.users_profile: ~1 rows (приблизительно)
DELETE FROM `users_profile`;
INSERT INTO `users_profile` (`id`, `first_name`, `last_name`, `image`, `contact_number`, `city`, `address`, `user_id`) VALUES
	(1, 'Руслан', 'Фамилия', '', '12345678910', 'Saratov', 'Ленина 1', 1);

-- Дамп структуры для таблица django_eshop.users_wishlist
CREATE TABLE IF NOT EXISTS `users_wishlist` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `added_at` datetime(6) NOT NULL,
  `product_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_wishlist_product_id_dcf62154_fk_shop_product_id` (`product_id`),
  KEY `users_wishlist_user_id_6507553e_fk_auth_user_id` (`user_id`),
  CONSTRAINT `users_wishlist_product_id_dcf62154_fk_shop_product_id` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`),
  CONSTRAINT `users_wishlist_user_id_6507553e_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_eshop.users_wishlist: ~1 rows (приблизительно)
DELETE FROM `users_wishlist`;
INSERT INTO `users_wishlist` (`id`, `added_at`, `product_id`, `user_id`) VALUES
	(3, '2023-12-01 19:41:05.488340', 2, 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
