/*
SQLyog Community v13.0.1 (64 bit)
MySQL - 5.1.32-community : Database - bus_safety
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`bus_safety` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `bus_safety`;

/*Table structure for table `accident_details` */

DROP TABLE IF EXISTS `accident_details`;

CREATE TABLE `accident_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `busregno` varchar(100) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` varchar(100) DEFAULT NULL,
  `speed` float DEFAULT NULL,
  `weight_status` varchar(50) DEFAULT NULL,
  `lati` float DEFAULT NULL,
  `long` float DEFAULT NULL,
  `bus_loginid` int(11) DEFAULT NULL,
  `notification` varchar(100) DEFAULT NULL,
  `door_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `accident_details` */

insert  into `accident_details`(`id`,`busregno`,`date`,`time`,`speed`,`weight_status`,`lati`,`long`,`bus_loginid`,`notification`,`door_status`) values 
(2,'KL11D9870','2024-11-06','08:30',60,'low',89.9,77.8,28,'aaa','closed');

/*Table structure for table `account` */

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `accountbalance` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `account` */

insert  into `account`(`id`,`user_id`,`accountbalance`) values 
(3,26,7200),
(4,27,10000);

/*Table structure for table `bus_details` */

DROP TABLE IF EXISTS `bus_details`;

CREATE TABLE `bus_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bus_name` varchar(100) DEFAULT NULL,
  `busregnum` varchar(100) DEFAULT NULL,
  `ownername` varchar(100) DEFAULT NULL,
  `mobnu` bigint(20) DEFAULT NULL,
  `from` varchar(100) DEFAULT NULL,
  `to` varchar(100) DEFAULT NULL,
  `departure` varchar(100) DEFAULT NULL,
  `arrival` varchar(100) DEFAULT NULL,
  `trh` varchar(100) DEFAULT NULL,
  `fare` varchar(100) DEFAULT NULL,
  `fi` varchar(100) DEFAULT NULL,
  `fac` varchar(100) DEFAULT NULL,
  `bus_loginid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `bus_details` */

insert  into `bus_details`(`id`,`bus_name`,`busregnum`,`ownername`,`mobnu`,`from`,`to`,`departure`,`arrival`,`trh`,`fare`,`fi`,`fac`,`bus_loginid`) values 
(3,'cccccc','KL11C5788','Ramesh',8129883763,'thiruvanathapuram','kozhikode','2024-11-13T16:39','2024-11-15T05:40','37.02','2800','buss.jpg','wifi,ac',28);

/*Table structure for table `buslist` */

DROP TABLE IF EXISTS `buslist`;

CREATE TABLE `buslist` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `bus_name` varchar(100) DEFAULT NULL,
  `regno` varchar(100) DEFAULT NULL,
  `owner_name` varchar(100) DEFAULT NULL,
  `mob_no` varchar(100) DEFAULT NULL,
  `source` varchar(100) DEFAULT NULL,
  `destination` varchar(50) DEFAULT NULL,
  `depature` date DEFAULT NULL,
  `arrival` date DEFAULT NULL,
  `bus_loginid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `buslist` */

insert  into `buslist`(`id`,`bus_name`,`regno`,`owner_name`,`mob_no`,`source`,`destination`,`depature`,`arrival`,`bus_loginid`) values 
(1,'a','10','x','987','abc',NULL,'2024-11-18','2024-11-21',3),
(2,'b','11','y','978','bcd',NULL,NULL,NULL,NULL),
(3,'c','12','z','789','cde',NULL,NULL,NULL,NULL);

/*Table structure for table `complaints` */

DROP TABLE IF EXISTS `complaints`;

CREATE TABLE `complaints` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `complaint` varchar(50) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `replay` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `complaints` */

/*Table structure for table `feedback` */

DROP TABLE IF EXISTS `feedback`;

CREATE TABLE `feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `feedback` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `feedback` */

insert  into `feedback`(`id`,`user_id`,`feedback`) values 
(1,26,'kkk');

/*Table structure for table `hospital_details` */

DROP TABLE IF EXISTS `hospital_details`;

CREATE TABLE `hospital_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hos_name` varchar(100) DEFAULT NULL,
  `hos_plc` varchar(100) DEFAULT NULL,
  `monb` varchar(100) DEFAULT NULL,
  `lati` varchar(100) DEFAULT NULL,
  `longi` varchar(100) DEFAULT NULL,
  `fi` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `hospital_details` */

insert  into `hospital_details`(`id`,`hos_name`,`hos_plc`,`monb`,`lati`,`longi`,`fi`) values 
(1,'babymemorial','kozhikode','8129883763','asdf','hjk','buss.jpg');

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(25) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `user_type` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

/*Data for the table `login` */

insert  into `login`(`id`,`username`,`password`,`user_type`) values 
(26,'anu','1234','user'),
(28,'ccc','1234','bus'),
(29,'admin','123','admin');

/*Table structure for table `notification_table` */

DROP TABLE IF EXISTS `notification_table`;

CREATE TABLE `notification_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `notification` varchar(500) DEFAULT NULL,
  `bus_loginid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `notification_table` */

insert  into `notification_table`(`id`,`date`,`notification`,`bus_loginid`) values 
(1,'2024-11-06','overspeed',16),
(2,'2024-11-03','overspeed',17),
(3,'2024-11-20','kkkk',16),
(4,'2024-11-27','kkkkkkkkk',28);

/*Table structure for table `payment_details` */

DROP TABLE IF EXISTS `payment_details`;

CREATE TABLE `payment_details` (
  `p_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `bus_id` int(11) DEFAULT NULL,
  `amount` varchar(50) DEFAULT NULL,
  `upinumber` varchar(20) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `new_account_balance` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`p_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `payment_details` */

insert  into `payment_details`(`p_id`,`user_id`,`bus_id`,`amount`,`upinumber`,`status`,`new_account_balance`) values 
(1,26,28,'2800','4566','paid','7200');

/*Table structure for table `police_details` */

DROP TABLE IF EXISTS `police_details`;

CREATE TABLE `police_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pstn_name` varchar(100) DEFAULT NULL,
  `stn_plc` varchar(100) DEFAULT NULL,
  `mob` varchar(100) DEFAULT NULL,
  `lati` float DEFAULT NULL,
  `longi` float DEFAULT NULL,
  `sid` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `police_details` */

insert  into `police_details`(`id`,`pstn_name`,`stn_plc`,`mob`,`lati`,`longi`,`sid`) values 
(3,'town','kozhikode','8129883763',NULL,NULL,'1245600');

/*Table structure for table `registration` */

DROP TABLE IF EXISTS `registration`;

CREATE TABLE `registration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  `dob` varchar(20) DEFAULT NULL,
  `gender` varchar(15) DEFAULT NULL,
  `mstatus` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `guard` varchar(100) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `loginid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `registration` */

insert  into `registration`(`id`,`name`,`dob`,`gender`,`mstatus`,`phone`,`guard`,`type`,`loginid`) values 
(11,'anaswara','2024-11-25','Female','Single','9834556677',NULL,'Passport',26);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
