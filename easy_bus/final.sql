/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 10.4.25-MariaDB : Database - easy_bus
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`easy_bus` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `easy_bus`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add buses',7,'add_buses'),
(26,'Can change buses',7,'change_buses'),
(27,'Can delete buses',7,'delete_buses'),
(28,'Can view buses',7,'view_buses'),
(29,'Can add login',8,'add_login'),
(30,'Can change login',8,'change_login'),
(31,'Can delete login',8,'delete_login'),
(32,'Can view login',8,'view_login'),
(33,'Can add other_places',9,'add_other_places'),
(34,'Can change other_places',9,'change_other_places'),
(35,'Can delete other_places',9,'delete_other_places'),
(36,'Can view other_places',9,'view_other_places'),
(37,'Can add places',10,'add_places'),
(38,'Can change places',10,'change_places'),
(39,'Can delete places',10,'delete_places'),
(40,'Can view places',10,'view_places'),
(41,'Can add routes',11,'add_routes'),
(42,'Can change routes',11,'change_routes'),
(43,'Can delete routes',11,'delete_routes'),
(44,'Can view routes',11,'view_routes'),
(45,'Can add stationmaster',12,'add_stationmaster'),
(46,'Can change stationmaster',12,'change_stationmaster'),
(47,'Can delete stationmaster',12,'delete_stationmaster'),
(48,'Can view stationmaster',12,'view_stationmaster'),
(49,'Can add stations',13,'add_stations'),
(50,'Can change stations',13,'change_stations'),
(51,'Can delete stations',13,'delete_stations'),
(52,'Can view stations',13,'view_stations'),
(53,'Can add trips',14,'add_trips'),
(54,'Can change trips',14,'change_trips'),
(55,'Can delete trips',14,'delete_trips'),
(56,'Can view trips',14,'view_trips'),
(57,'Can add tb_customer',15,'add_tb_customer'),
(58,'Can change tb_customer',15,'change_tb_customer'),
(59,'Can delete tb_customer',15,'delete_tb_customer'),
(60,'Can view tb_customer',15,'view_tb_customer'),
(61,'Can add tb_complaints',16,'add_tb_complaints'),
(62,'Can change tb_complaints',16,'change_tb_complaints'),
(63,'Can delete tb_complaints',16,'delete_tb_complaints'),
(64,'Can view tb_complaints',16,'view_tb_complaints'),
(65,'Can add stops',17,'add_stops'),
(66,'Can change stops',17,'change_stops'),
(67,'Can delete stops',17,'delete_stops'),
(68,'Can view stops',17,'view_stops'),
(69,'Can add reservations',18,'add_reservations'),
(70,'Can change reservations',18,'change_reservations'),
(71,'Can delete reservations',18,'delete_reservations'),
(72,'Can view reservations',18,'view_reservations'),
(73,'Can add payment',19,'add_payment'),
(74,'Can change payment',19,'change_payment'),
(75,'Can delete payment',19,'delete_payment'),
(76,'Can view payment',19,'view_payment');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `auth_user` */

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(7,'my_application','buses'),
(8,'my_application','login'),
(9,'my_application','other_places'),
(19,'my_application','payment'),
(10,'my_application','places'),
(18,'my_application','reservations'),
(11,'my_application','routes'),
(12,'my_application','stationmaster'),
(13,'my_application','stations'),
(17,'my_application','stops'),
(16,'my_application','tb_complaints'),
(15,'my_application','tb_customer'),
(14,'my_application','trips'),
(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2023-07-14 15:45:27.939549'),
(2,'auth','0001_initial','2023-07-14 15:45:28.170147'),
(3,'admin','0001_initial','2023-07-14 15:45:28.233092'),
(4,'admin','0002_logentry_remove_auto_add','2023-07-14 15:45:28.240124'),
(5,'admin','0003_logentry_add_action_flag_choices','2023-07-14 15:45:28.245455'),
(6,'contenttypes','0002_remove_content_type_name','2023-07-14 15:45:28.283200'),
(7,'auth','0002_alter_permission_name_max_length','2023-07-14 15:45:28.314552'),
(8,'auth','0003_alter_user_email_max_length','2023-07-14 15:45:28.326591'),
(9,'auth','0004_alter_user_username_opts','2023-07-14 15:45:28.336597'),
(10,'auth','0005_alter_user_last_login_null','2023-07-14 15:45:28.359169'),
(11,'auth','0006_require_contenttypes_0002','2023-07-14 15:45:28.361168'),
(12,'auth','0007_alter_validators_add_error_messages','2023-07-14 15:45:28.372194'),
(13,'auth','0008_alter_user_username_max_length','2023-07-14 15:45:28.381696'),
(14,'auth','0009_alter_user_last_name_max_length','2023-07-14 15:45:28.393207'),
(15,'auth','0010_alter_group_name_max_length','2023-07-14 15:45:28.406208'),
(16,'auth','0011_update_proxy_permissions','2023-07-14 15:45:28.412080'),
(17,'auth','0012_alter_user_first_name_max_length','2023-07-14 15:45:28.423089'),
(18,'my_application','0001_initial','2023-07-14 15:45:28.797676'),
(19,'sessions','0001_initial','2023-07-14 15:45:28.820119'),
(20,'my_application','0002_reservations_payment','2023-07-17 12:31:14.506996');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('ld6rvpf2khyzbfsjbua0kl56tof80suh','eyJsb2dpbl9pZCI6NH0:1qLglJ:45opaIUKoLOVRCI4x5ga5PIcWsvsDomFY4yb5-XlrrQ','2023-08-01 09:12:53.082934');

/*Table structure for table `my_application_buses` */

DROP TABLE IF EXISTS `my_application_buses`;

CREATE TABLE `my_application_buses` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bus_name` varchar(50) NOT NULL,
  `registration_number` varchar(40) NOT NULL,
  `seat_count` varchar(5) NOT NULL,
  `default_seat_count` varchar(5) NOT NULL,
  `fare_rate` varchar(4) NOT NULL,
  `station_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_application_buses_station_id_aacaccbb_fk_my_applic` (`station_id`),
  CONSTRAINT `my_application_buses_station_id_aacaccbb_fk_my_applic` FOREIGN KEY (`station_id`) REFERENCES `my_application_stations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_buses` */

insert  into `my_application_buses`(`id`,`bus_name`,`registration_number`,`seat_count`,`default_seat_count`,`fare_rate`,`station_id`) values 
(1,'FAST PASSENGER','KL-22-F-3211','72','79','30',2);

/*Table structure for table `my_application_login` */

DROP TABLE IF EXISTS `my_application_login`;

CREATE TABLE `my_application_login` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `usertype` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_login` */

insert  into `my_application_login`(`id`,`username`,`password`,`usertype`) values 
(1,'admin','admin','admin'),
(2,'usain','usain4989','station_master'),
(3,'Salal','Salal2222','station_master'),
(4,'manu','manu','user');

/*Table structure for table `my_application_other_places` */

DROP TABLE IF EXISTS `my_application_other_places`;

CREATE TABLE `my_application_other_places` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `other_places_name` varchar(50) NOT NULL,
  `other_places_type` varchar(50) NOT NULL,
  `latitude` varchar(40) NOT NULL,
  `longitude` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_other_places` */

/*Table structure for table `my_application_payment` */

DROP TABLE IF EXISTS `my_application_payment`;

CREATE TABLE `my_application_payment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `payment_method` varchar(20) NOT NULL,
  `amount` varchar(5) NOT NULL,
  `payment_date` varchar(10) NOT NULL,
  `reservation_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_application_payme_reservation_id_665d7209_fk_my_applic` (`reservation_id`),
  CONSTRAINT `my_application_payme_reservation_id_665d7209_fk_my_applic` FOREIGN KEY (`reservation_id`) REFERENCES `my_application_reservations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_payment` */

insert  into `my_application_payment`(`id`,`payment_method`,`amount`,`payment_date`,`reservation_id`) values 
(1,'debit card','120','2023-07-18',1),
(2,'upi','180','2023-07-18',2),
(3,'debit card','60','2023-07-18',3),
(4,'debit card','120','2023-07-18',4);

/*Table structure for table `my_application_places` */

DROP TABLE IF EXISTS `my_application_places`;

CREATE TABLE `my_application_places` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `place_name` varchar(50) NOT NULL,
  `latitude` varchar(40) NOT NULL,
  `longitude` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_places` */

insert  into `my_application_places`(`id`,`place_name`,`latitude`,`longitude`) values 
(1,'THRISSUR','9.979458995120675','76.29476923815919'),
(2,'ERNAKULAM','9.97565502996352','76.29197115457164'),
(3,'KOZHIKODE','9.965679977073501','76.29926676309215'),
(4,'ALUVA','9.97371076394999','76.30450243508922');

/*Table structure for table `my_application_reservations` */

DROP TABLE IF EXISTS `my_application_reservations`;

CREATE TABLE `my_application_reservations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `no_of_seats` varchar(3) NOT NULL,
  `reservation_amount` varchar(5) NOT NULL,
  `reservation_status` varchar(15) NOT NULL,
  `from_stop_id` bigint(20) NOT NULL,
  `to_stop_id` bigint(20) NOT NULL,
  `trip_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_application_reser_from_stop_id_b9c21245_fk_my_applic` (`from_stop_id`),
  KEY `my_application_reser_to_stop_id_261028ee_fk_my_applic` (`to_stop_id`),
  KEY `my_application_reser_trip_id_959fd7dd_fk_my_applic` (`trip_id`),
  KEY `my_application_reser_user_id_91de0e0d_fk_my_applic` (`user_id`),
  CONSTRAINT `my_application_reser_from_stop_id_b9c21245_fk_my_applic` FOREIGN KEY (`from_stop_id`) REFERENCES `my_application_stops` (`id`),
  CONSTRAINT `my_application_reser_to_stop_id_261028ee_fk_my_applic` FOREIGN KEY (`to_stop_id`) REFERENCES `my_application_stops` (`id`),
  CONSTRAINT `my_application_reser_trip_id_959fd7dd_fk_my_applic` FOREIGN KEY (`trip_id`) REFERENCES `my_application_trips` (`id`),
  CONSTRAINT `my_application_reser_user_id_91de0e0d_fk_my_applic` FOREIGN KEY (`user_id`) REFERENCES `my_application_tb_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_reservations` */

insert  into `my_application_reservations`(`id`,`no_of_seats`,`reservation_amount`,`reservation_status`,`from_stop_id`,`to_stop_id`,`trip_id`,`user_id`) values 
(1,'2','120','Confirmed',1,3,1,1),
(2,'3','180','Confirmed',1,3,1,1),
(3,'2','60','Confirmed',1,2,1,1),
(4,'2','120','Confirmed',1,3,1,1);

/*Table structure for table `my_application_routes` */

DROP TABLE IF EXISTS `my_application_routes`;

CREATE TABLE `my_application_routes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `route_name` varchar(50) NOT NULL,
  `ending_place_id` bigint(20) NOT NULL,
  `starting_place_id` bigint(20) NOT NULL,
  `station_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_application_route_station_id_3f6dc727_fk_my_applic` (`station_id`),
  KEY `my_application_route_ending_place_id_715ea38d_fk_my_applic` (`ending_place_id`),
  KEY `my_application_route_starting_place_id_bb359616_fk_my_applic` (`starting_place_id`),
  CONSTRAINT `my_application_route_ending_place_id_715ea38d_fk_my_applic` FOREIGN KEY (`ending_place_id`) REFERENCES `my_application_places` (`id`),
  CONSTRAINT `my_application_route_starting_place_id_bb359616_fk_my_applic` FOREIGN KEY (`starting_place_id`) REFERENCES `my_application_places` (`id`),
  CONSTRAINT `my_application_route_station_id_3f6dc727_fk_my_applic` FOREIGN KEY (`station_id`) REFERENCES `my_application_stations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_routes` */

insert  into `my_application_routes`(`id`,`route_name`,`ending_place_id`,`starting_place_id`,`station_id`) values 
(1,'THRISSUR-ERNAKULAM',2,1,2);

/*Table structure for table `my_application_stationmaster` */

DROP TABLE IF EXISTS `my_application_stationmaster`;

CREATE TABLE `my_application_stationmaster` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(60) NOT NULL,
  `last_name` varchar(60) NOT NULL,
  `dob` varchar(20) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `place` varchar(40) NOT NULL,
  `login_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_application_stati_login_id_8f957aca_fk_my_applic` (`login_id`),
  CONSTRAINT `my_application_stati_login_id_8f957aca_fk_my_applic` FOREIGN KEY (`login_id`) REFERENCES `my_application_login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_stationmaster` */

insert  into `my_application_stationmaster`(`id`,`first_name`,`last_name`,`dob`,`gender`,`phone`,`email`,`place`,`login_id`) values 
(1,'usain','bolt','2023-07-20','Male','4989','manu165@gmail.com','Kochi',2),
(2,'Salal','Tess','2023-07-19','Female','84622222','anntreesa@123','Pala',3);

/*Table structure for table `my_application_stations` */

DROP TABLE IF EXISTS `my_application_stations`;

CREATE TABLE `my_application_stations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `place_id` bigint(20) NOT NULL,
  `stationmaster_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_application_stati_place_id_bfb333a2_fk_my_applic` (`place_id`),
  KEY `my_application_stati_stationmaster_id_2f39be09_fk_my_applic` (`stationmaster_id`),
  CONSTRAINT `my_application_stati_place_id_bfb333a2_fk_my_applic` FOREIGN KEY (`place_id`) REFERENCES `my_application_places` (`id`),
  CONSTRAINT `my_application_stati_stationmaster_id_2f39be09_fk_my_applic` FOREIGN KEY (`stationmaster_id`) REFERENCES `my_application_stationmaster` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_stations` */

insert  into `my_application_stations`(`id`,`place_id`,`stationmaster_id`) values 
(1,2,1),
(2,1,2);

/*Table structure for table `my_application_stops` */

DROP TABLE IF EXISTS `my_application_stops`;

CREATE TABLE `my_application_stops` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `time` varchar(10) NOT NULL,
  `place_id` bigint(20) NOT NULL,
  `trip_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_application_stops_place_id_f83f4ee3_fk_my_applic` (`place_id`),
  KEY `my_application_stops_trip_id_0f8868f3_fk_my_application_trips_id` (`trip_id`),
  CONSTRAINT `my_application_stops_place_id_f83f4ee3_fk_my_applic` FOREIGN KEY (`place_id`) REFERENCES `my_application_places` (`id`),
  CONSTRAINT `my_application_stops_trip_id_0f8868f3_fk_my_application_trips_id` FOREIGN KEY (`trip_id`) REFERENCES `my_application_trips` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_stops` */

insert  into `my_application_stops`(`id`,`time`,`place_id`,`trip_id`) values 
(1,'23:32',1,1),
(2,'12:32',4,1),
(3,'13:32',2,1);

/*Table structure for table `my_application_tb_complaints` */

DROP TABLE IF EXISTS `my_application_tb_complaints`;

CREATE TABLE `my_application_tb_complaints` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL,
  `reply` varchar(100) NOT NULL,
  `complaint_date` varchar(10) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_application_tb_co_customer_id_d93ee941_fk_my_applic` (`customer_id`),
  CONSTRAINT `my_application_tb_co_customer_id_d93ee941_fk_my_applic` FOREIGN KEY (`customer_id`) REFERENCES `my_application_tb_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_tb_complaints` */

/*Table structure for table `my_application_tb_customer` */

DROP TABLE IF EXISTS `my_application_tb_customer`;

CREATE TABLE `my_application_tb_customer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(60) NOT NULL,
  `last_name` varchar(60) NOT NULL,
  `dob` varchar(20) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `login_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_application_tb_cu_login_id_03a879c4_fk_my_applic` (`login_id`),
  CONSTRAINT `my_application_tb_cu_login_id_03a879c4_fk_my_applic` FOREIGN KEY (`login_id`) REFERENCES `my_application_login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_tb_customer` */

insert  into `my_application_tb_customer`(`id`,`first_name`,`last_name`,`dob`,`gender`,`phone`,`email`,`login_id`) values 
(1,'Manu','Abraham','2023-07-25','Male','98543552','manuabraham165@gmail.com',4);

/*Table structure for table `my_application_trips` */

DROP TABLE IF EXISTS `my_application_trips`;

CREATE TABLE `my_application_trips` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `starting_time` varchar(15) NOT NULL,
  `ending_time` varchar(15) NOT NULL,
  `no_of_stops` varchar(10) NOT NULL,
  `trip_date` varchar(20) NOT NULL,
  `bus_id` bigint(20) NOT NULL,
  `route_id` bigint(20) NOT NULL,
  `station_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_application_trips_bus_id_9a18f08e_fk_my_application_buses_id` (`bus_id`),
  KEY `my_application_trips_route_id_ab6d011a_fk_my_applic` (`route_id`),
  KEY `my_application_trips_station_id_9719d3a9_fk_my_applic` (`station_id`),
  CONSTRAINT `my_application_trips_bus_id_9a18f08e_fk_my_application_buses_id` FOREIGN KEY (`bus_id`) REFERENCES `my_application_buses` (`id`),
  CONSTRAINT `my_application_trips_route_id_ab6d011a_fk_my_applic` FOREIGN KEY (`route_id`) REFERENCES `my_application_routes` (`id`),
  CONSTRAINT `my_application_trips_station_id_9719d3a9_fk_my_applic` FOREIGN KEY (`station_id`) REFERENCES `my_application_stations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_trips` */

insert  into `my_application_trips`(`id`,`starting_time`,`ending_time`,`no_of_stops`,`trip_date`,`bus_id`,`route_id`,`station_id`) values 
(1,'23:32','13:32','3','2023-07-16',1,1,2);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
