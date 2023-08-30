/*
SQLyog Community
MySQL - 10.4.25-MariaDB : Database - django_easy_bus
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`django_easy_bus` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `django_easy_bus`;

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
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4;

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
(57,'Can add tbl_conductor',15,'add_tbl_conductor'),
(58,'Can change tbl_conductor',15,'change_tbl_conductor'),
(59,'Can delete tbl_conductor',15,'delete_tbl_conductor'),
(60,'Can view tbl_conductor',15,'view_tbl_conductor'),
(61,'Can add tbl_bus_location',16,'add_tbl_bus_location'),
(62,'Can change tbl_bus_location',16,'change_tbl_bus_location'),
(63,'Can delete tbl_bus_location',16,'delete_tbl_bus_location'),
(64,'Can view tbl_bus_location',16,'view_tbl_bus_location'),
(65,'Can add tb_customer',17,'add_tb_customer'),
(66,'Can change tb_customer',17,'change_tb_customer'),
(67,'Can delete tb_customer',17,'delete_tb_customer'),
(68,'Can view tb_customer',17,'view_tb_customer'),
(69,'Can add tb_complaints',18,'add_tb_complaints'),
(70,'Can change tb_complaints',18,'change_tb_complaints'),
(71,'Can delete tb_complaints',18,'delete_tb_complaints'),
(72,'Can view tb_complaints',18,'view_tb_complaints'),
(73,'Can add stops',19,'add_stops'),
(74,'Can change stops',19,'change_stops'),
(75,'Can delete stops',19,'delete_stops'),
(76,'Can view stops',19,'view_stops'),
(77,'Can add reservations',20,'add_reservations'),
(78,'Can change reservations',20,'change_reservations'),
(79,'Can delete reservations',20,'delete_reservations'),
(80,'Can view reservations',20,'view_reservations'),
(81,'Can add payment',21,'add_payment'),
(82,'Can change payment',21,'change_payment'),
(83,'Can delete payment',21,'delete_payment'),
(84,'Can view payment',21,'view_payment');

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;

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
(21,'my_application','payment'),
(10,'my_application','places'),
(20,'my_application','reservations'),
(11,'my_application','routes'),
(12,'my_application','stationmaster'),
(13,'my_application','stations'),
(19,'my_application','stops'),
(16,'my_application','tbl_bus_location'),
(15,'my_application','tbl_conductor'),
(18,'my_application','tb_complaints'),
(17,'my_application','tb_customer'),
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2023-07-19 06:45:11.336200'),
(2,'auth','0001_initial','2023-07-19 06:45:11.542651'),
(3,'admin','0001_initial','2023-07-19 06:45:11.601223'),
(4,'admin','0002_logentry_remove_auto_add','2023-07-19 06:45:11.609239'),
(5,'admin','0003_logentry_add_action_flag_choices','2023-07-19 06:45:11.614604'),
(6,'contenttypes','0002_remove_content_type_name','2023-07-19 06:45:11.647678'),
(7,'auth','0002_alter_permission_name_max_length','2023-07-19 06:45:11.677500'),
(8,'auth','0003_alter_user_email_max_length','2023-07-19 06:45:11.690109'),
(9,'auth','0004_alter_user_username_opts','2023-07-19 06:45:11.696311'),
(10,'auth','0005_alter_user_last_login_null','2023-07-19 06:45:11.722489'),
(11,'auth','0006_require_contenttypes_0002','2023-07-19 06:45:11.724495'),
(12,'auth','0007_alter_validators_add_error_messages','2023-07-19 06:45:11.729512'),
(13,'auth','0008_alter_user_username_max_length','2023-07-19 06:45:11.738495'),
(14,'auth','0009_alter_user_last_name_max_length','2023-07-19 06:45:11.745879'),
(15,'auth','0010_alter_group_name_max_length','2023-07-19 06:45:11.762973'),
(16,'auth','0011_update_proxy_permissions','2023-07-19 06:45:11.772224'),
(17,'auth','0012_alter_user_first_name_max_length','2023-07-19 06:45:11.781526'),
(18,'my_application','0001_initial','2023-07-19 06:45:12.339260'),
(19,'sessions','0001_initial','2023-07-19 06:45:12.359976');

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
('35za40bexdk62gncekn3xmxni5k98yoc','eyJsb2dpbl9pZCI6Mn0:1qMBR8:78zCiY4NvEdKONjJ1_Pf1gdKX7djPQxAKCp_W5ndm-8','2023-08-02 17:58:06.031646'),
('6urxan8k84e5yye4z4fc22weho3woyq6','eyJsb2dpbl9pZCI6MX0:1qML9i:OhW7MoBh_ySL4oUi2B9ToQZY4DV33w5hj4qzPeUuAUg','2023-08-03 04:20:46.829481'),
('yqbgzigczg2fqjv9shz5725o6z1tob7q','eyJsb2dpbl9pZCI6MX0:1qM33q:OXRQTDsgQl8vED72r2B25hotaQ3LtRyrtABCvcgVT7c','2023-08-02 09:01:30.532469');

/*Table structure for table `my_application_buses` */

DROP TABLE IF EXISTS `my_application_buses`;

CREATE TABLE `my_application_buses` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bus_name` varchar(50) NOT NULL,
  `registration_number` varchar(40) NOT NULL,
  `seat_count` varchar(5) NOT NULL,
  `latitude` varchar(40) NOT NULL,
  `longitude` varchar(40) NOT NULL,
  `default_seat_count` varchar(5) NOT NULL,
  `fare_rate` varchar(4) NOT NULL,
  `station_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_application_buses_station_id_aacaccbb_fk_my_applic` (`station_id`),
  CONSTRAINT `my_application_buses_station_id_aacaccbb_fk_my_applic` FOREIGN KEY (`station_id`) REFERENCES `my_application_stations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_buses` */

insert  into `my_application_buses`(`id`,`bus_name`,`registration_number`,`seat_count`,`latitude`,`longitude`,`default_seat_count`,`fare_rate`,`station_id`) values 
(2,'FAST PASSENGER','KL-23-F-3212','61','9.9763169','76.28623','50','30',1),
(3,'ORDINARY','KL-25-45-6454','46','9.9763206','76.2862462','50','60',1);

/*Table structure for table `my_application_login` */

DROP TABLE IF EXISTS `my_application_login`;

CREATE TABLE `my_application_login` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `usertype` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_login` */

insert  into `my_application_login`(`id`,`username`,`password`,`usertype`) values 
(1,'admin','admin','admin'),
(2,'Salal','Salal2222','station_master'),
(3,'manu','manu','user'),
(5,'zAX','zAX6120','station_master'),
(9,'c1','c1','bus'),
(13,'c','c','bus');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_payment` */

insert  into `my_application_payment`(`id`,`payment_method`,`amount`,`payment_date`,`reservation_id`) values 
(1,'debit card','120','2023-07-19',1);

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
(1,'THRISSUR','9.979458995120675','76.27580065600587'),
(2,'ERNAKULAM','9.979120866683704','76.29600519693004'),
(3,'KOZHIKODE','9.98081150535732','76.30021090066539'),
(4,'ALUVA','9.96753975584866','76.30330080545055');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_reservations` */

insert  into `my_application_reservations`(`id`,`no_of_seats`,`reservation_amount`,`reservation_status`,`from_stop_id`,`to_stop_id`,`trip_id`,`user_id`) values 
(1,'2','120','Confirmed',1,3,1,1);

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_routes` */

insert  into `my_application_routes`(`id`,`route_name`,`ending_place_id`,`starting_place_id`,`station_id`) values 
(1,'ERNAKULAM-THRISSUR',1,2,1),
(2,'kollam - kochi',4,1,1),
(4,'aluva tcr',1,4,1);

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
(1,'Salal','Tess','2023-07-20','Male','84622222','manuabraham165@gmail.com','Kochi',2),
(2,'zAX','XSXSD','2023-07-22','Male','789456120','SXXS@gmail','xsax',5);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_stations` */

insert  into `my_application_stations`(`id`,`place_id`,`stationmaster_id`) values 
(1,2,1);

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_stops` */

insert  into `my_application_stops`(`id`,`time`,`place_id`,`trip_id`) values 
(1,'13:08',2,1),
(2,'15:09',4,1),
(3,'16:08',1,1),
(4,'09:10',2,2),
(5,'10:10',3,2),
(6,'11:10',2,2),
(7,'02:15',4,2);

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
(1,'Manu','Abraham','2023-07-20','Male','446684','manuabraham165@gmail.com',3);

/*Table structure for table `my_application_tbl_bus_location` */

DROP TABLE IF EXISTS `my_application_tbl_bus_location`;

CREATE TABLE `my_application_tbl_bus_location` (
  `location` int(11) NOT NULL AUTO_INCREMENT,
  `latitude` varchar(100) NOT NULL,
  `longitude` varchar(100) NOT NULL,
  `bus_id` bigint(20) NOT NULL,
  PRIMARY KEY (`location`),
  KEY `my_application_tbl_b_bus_id_e09f56e9_fk_my_applic` (`bus_id`),
  CONSTRAINT `my_application_tbl_b_bus_id_e09f56e9_fk_my_applic` FOREIGN KEY (`bus_id`) REFERENCES `my_application_buses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_tbl_bus_location` */

insert  into `my_application_tbl_bus_location`(`location`,`latitude`,`longitude`,`bus_id`) values 
(1,'9.986060881710044','76.30271716043599',2),
(2,'9.986068133138682','76.30016828130711',3);

/*Table structure for table `my_application_tbl_conductor` */

DROP TABLE IF EXISTS `my_application_tbl_conductor`;

CREATE TABLE `my_application_tbl_conductor` (
  `conductor_id` int(11) NOT NULL AUTO_INCREMENT,
  `cfname` varchar(100) NOT NULL,
  `clname` varchar(100) NOT NULL,
  `cdob` varchar(100) NOT NULL,
  `cphone` varchar(100) NOT NULL,
  `bus_id` bigint(20) NOT NULL,
  `login_id` bigint(20) NOT NULL,
  PRIMARY KEY (`conductor_id`),
  KEY `my_application_tbl_c_bus_id_2791f5ff_fk_my_applic` (`bus_id`),
  KEY `my_application_tbl_c_login_id_61cd4ab4_fk_my_applic` (`login_id`),
  CONSTRAINT `my_application_tbl_c_bus_id_2791f5ff_fk_my_applic` FOREIGN KEY (`bus_id`) REFERENCES `my_application_buses` (`id`),
  CONSTRAINT `my_application_tbl_c_login_id_61cd4ab4_fk_my_applic` FOREIGN KEY (`login_id`) REFERENCES `my_application_login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_tbl_conductor` */

insert  into `my_application_tbl_conductor`(`conductor_id`,`cfname`,`clname`,`cdob`,`cphone`,`bus_id`,`login_id`) values 
(3,'santhosh','sam','2023-07-11','9874561230',2,9),
(7,'sam','sam','2023-07-12','9874561230',3,13);

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `my_application_trips` */

insert  into `my_application_trips`(`id`,`starting_time`,`ending_time`,`no_of_stops`,`trip_date`,`bus_id`,`route_id`,`station_id`) values 
(1,'13:08','16:08','3','2023-07-20',2,1,1),
(2,'10:09','01:13','4','2023-07-22',3,4,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
