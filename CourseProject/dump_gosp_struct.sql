CREATE DATABASE  IF NOT EXISTS `gosp`;
USE `gosp`;
--
-- Table structure for table `codyvmp`
--

DROP TABLE IF EXISTS `codyvmp`;
CREATE TABLE `codyvmp` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `year` smallint DEFAULT NULL,
  `group_id` int unsigned DEFAULT NULL,
  `cod` varchar(20) NOT NULL,
  `is_local` tinyint unsigned DEFAULT '0',
  `description` varchar(100) DEFAULT NULL,
  `sort_order` tinyint unsigned NOT NULL DEFAULT '250',
  `uid` int unsigned NOT NULL,
  `edit_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cod` (`cod`,`group_id`,`year`),
  KEY `group_id` (`group_id`),
  KEY `year` (`year`),
  KEY `cod_2` (`cod`),
  KEY `uid` (`uid`),
  CONSTRAINT `codyvmp_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `vmp_groups` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

--
-- Table structure for table `diagnoz`
--

DROP TABLE IF EXISTS `diagnoz`;
CREATE TABLE `diagnoz` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `cod` varchar(10) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `uid` int unsigned NOT NULL,
  `edit_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cod` (`cod`)
) ENGINE=InnoDB AUTO_INCREMENT=438 DEFAULT CHARSET=utf8;

--
-- Table structure for table `edit_blocks`
--

DROP TABLE IF EXISTS `edit_blocks`;
CREATE TABLE `edit_blocks` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `table` varchar(20) NOT NULL,
  `tid` int unsigned NOT NULL,
  `uid` int unsigned NOT NULL,
  `blocking_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `table_2` (`table`,`tid`),
  KEY `table` (`table`),
  KEY `tid` (`tid`),
  KEY `uid` (`uid`),
  CONSTRAINT `edit_blocks_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5039 DEFAULT CHARSET=utf8;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `event_date` date NOT NULL,
  `description` varchar(250) NOT NULL,
  `uid` int unsigned NOT NULL,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `event_date` (`event_date`,`description`),
  KEY `uid` (`uid`),
  FULLTEXT KEY `description` (`description`)
) ENGINE=MyISAM AUTO_INCREMENT=728 DEFAULT CHARSET=utf8;

--
-- Table structure for table `main`
--

DROP TABLE IF EXISTS `main`;
CREATE TABLE `main` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `talon_num` char(19) DEFAULT NULL,
  `talon_st_id` int unsigned DEFAULT NULL,
  `doc_date` date DEFAULT NULL,
  `gosp_date` date DEFAULT NULL,
  `gosp_time` time DEFAULT NULL,
  `defer_date` date DEFAULT NULL,
  `reject_year` smallint unsigned DEFAULT NULL,
  `pid` int unsigned NOT NULL,
  `diag_id` int unsigned DEFAULT NULL,
  `op_id` int unsigned DEFAULT NULL,
  `vmp_id` int unsigned DEFAULT NULL,
  `dep_id` tinyint unsigned DEFAULT '0',
  `revision` tinyint unsigned NOT NULL DEFAULT '0',
  `attention` tinyint unsigned NOT NULL DEFAULT '0',
  `accepted` tinyint unsigned NOT NULL DEFAULT '0',
  `invite_early` tinyint unsigned NOT NULL DEFAULT '0',
  `over_list` tinyint unsigned NOT NULL DEFAULT '0',
  `pre_gosp` tinyint unsigned NOT NULL DEFAULT '0',
  `vmp_changed` tinyint unsigned NOT NULL DEFAULT '0',
  `state_id` int unsigned DEFAULT NULL,
  `reject` tinyint unsigned DEFAULT '0' COMMENT 'Ставится галочка для тех, кому планируется отказать.',
  `edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uid` int unsigned NOT NULL,
  `remote_ip` varchar(12) DEFAULT NULL,
  `login` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `talon_num_2` (`talon_num`),
  KEY `pid` (`pid`),
  KEY `diag_id` (`diag_id`),
  KEY `op_id` (`op_id`),
  KEY `vmp_id` (`vmp_id`),
  KEY `dep_id` (`dep_id`),
  KEY `state_id` (`state_id`),
  KEY `uid` (`uid`),
  KEY `talon_st_id` (`talon_st_id`),
  KEY `gosp_time` (`gosp_time`),
  KEY `over_list` (`over_list`),
  KEY `pre_gosp` (`pre_gosp`),
  KEY `defer_date` (`defer_date`),
  KEY `gosp_date` (`gosp_date`),
  KEY `reject_year` (`reject_year`),
  CONSTRAINT `main_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `patient` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `main_ibfk_2` FOREIGN KEY (`dep_id`) REFERENCES `otdelenie` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `main_ibfk_3` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `main_ibfk_4` FOREIGN KEY (`vmp_id`) REFERENCES `codyvmp` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `main_ibfk_5` FOREIGN KEY (`state_id`) REFERENCES `statusy` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31560 DEFAULT CHARSET=utf8;
DELIMITER ;;
CREATE TRIGGER `main_after_delete` AFTER DELETE ON `main` FOR EACH ROW BEGIN
DELETE FROM `notes` WHERE `notes`.`gid`=OLD.`id`;
END ;;
DELIMITER ;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
CREATE TABLE `notes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `gid` int unsigned NOT NULL,
  `type` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '0 - без важности; 1- важно; 2 - примечание; 3 - заметка',
  `content` varchar(500) NOT NULL,
  `edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uid` int unsigned NOT NULL,
  `remote_ip` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `gid` (`gid`),
  KEY `uid` (`uid`),
  FULLTEXT KEY `content` (`content`)
) ENGINE=MyISAM AUTO_INCREMENT=75044 DEFAULT CHARSET=utf8;

--
-- Table structure for table `operacii`
--

DROP TABLE IF EXISTS `operacii`;
CREATE TABLE `operacii` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sort_order` int unsigned NOT NULL DEFAULT '500',
  `name` varchar(10) NOT NULL,
  `description` varchar(100) NOT NULL,
  `uid` int unsigned NOT NULL,
  `edit_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

--
-- Table structure for table `otdelenie`
--

DROP TABLE IF EXISTS `otdelenie`;
CREATE TABLE `otdelenie` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
CREATE TABLE `patient` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `md_id` int unsigned DEFAULT NULL,
  `fname` varchar(50) NOT NULL,
  `sname` varchar(50) NOT NULL,
  `patronymic` varchar(50) DEFAULT NULL,
  `bth_year` smallint unsigned DEFAULT '0',
  `region_id` int unsigned NOT NULL,
  `special_note` varchar(45) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `uid` int unsigned NOT NULL,
  `edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `remote_ip` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `md_id` (`md_id`),
  KEY `region_id` (`region_id`),
  KEY `uid` (`uid`),
  FULLTEXT KEY `fname` (`fname`),
  FULLTEXT KEY `sname` (`sname`),
  FULLTEXT KEY `patronymic` (`patronymic`)
) ENGINE=InnoDB AUTO_INCREMENT=30299 DEFAULT CHARSET=utf8;
DELIMITER ;;
CREATE TRIGGER `patient_BEFORE_DELETE` BEFORE DELETE ON `patient` FOR EACH ROW BEGIN
	DELETE FROM `gosp`.`notes` WHERE `notes`.`gid` IN (SELECT `id` FROM `gosp`.`main` WHERE `pid`=OLD.`id`);
END ;;
DELIMITER ;

--
-- Table structure for table `phone_numbers`
--

DROP TABLE IF EXISTS `phone_numbers`;
CREATE TABLE `phone_numbers` (
  `pid` int unsigned NOT NULL,
  `phone` varchar(12) NOT NULL,
  `tries_count` tinyint unsigned NOT NULL DEFAULT '0',
  `note` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`phone`),
  KEY `pid` (`pid`),
  FULLTEXT KEY `note` (`note`),
  CONSTRAINT `phone_numbers_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `patient` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `plan`
--

DROP TABLE IF EXISTS `plan`;
CREATE TABLE `plan` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `year` smallint unsigned NOT NULL COMMENT 'Планируемый год в 4-х значном формате',
  `month` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'При отсутствии значения подразумевает годовой план',
  `group_id` int unsigned DEFAULT NULL,
  `vmp_id` int unsigned DEFAULT NULL,
  `count` smallint unsigned NOT NULL DEFAULT '0',
  `uid` int unsigned NOT NULL,
  `edit_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ch_plan` (`year`,`month`,`vmp_id`),
  UNIQUE KEY `vmp_plan` (`year`,`month`,`group_id`),
  KEY `group_id` (`group_id`),
  KEY `vmp_id` (`vmp_id`),
  CONSTRAINT `plan_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `vmp_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `plan_ibfk_2` FOREIGN KEY (`vmp_id`) REFERENCES `codyvmp` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8;

--
-- Table structure for table `regions`
--

DROP TABLE IF EXISTS `regions`;
CREATE TABLE `regions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `cod` varchar(4) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cod` (`cod`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8 COMMENT='Регионы';

--
-- Table structure for table `statusy`
--

DROP TABLE IF EXISTS `statusy`;
CREATE TABLE `statusy` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `state` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `state` (`state`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Table structure for table `talons_states`
--

DROP TABLE IF EXISTS `talons_states`;
CREATE TABLE `talons_states` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `style` varchar(100) NOT NULL DEFAULT '{color:"#000",font-weight:"normal" background-color:"inherit"}',
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `description` (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `remote_ip` varchar(12) DEFAULT NULL,
  `userLogin` varchar(50) NOT NULL,
  `pswd` varchar(32) DEFAULT NULL,
  `displayname` varchar(50) NOT NULL,
  `mail` varchar(100) DEFAULT NULL,
  `accessLevel` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '0 - только просмотр записей; 1 - просмотр и добавление записей, просмотр отчётов; 2 - 0+1+ изменение существующих и редактирование в отчётах; 3 - 2 + планирование; 4 - администратор.',
  `profile` varchar(10240) DEFAULT NULL COMMENT 'Настройки профиля пользователя в JSON формате.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userLogin` (`userLogin`),
  UNIQUE KEY `mail` (`mail`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8;

--
-- Table structure for table `vmp_groups`
--

DROP TABLE IF EXISTS `vmp_groups`;
CREATE TABLE `vmp_groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `cod` smallint unsigned NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `year` smallint unsigned NOT NULL DEFAULT '2020',
  `edit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uid` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `description` (`description`),
  KEY `uid` (`uid`),
  KEY `year` (`year`),
  KEY `cod` (`cod`),
  CONSTRAINT `vmp_groups_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- Следующие процедуры могут использоваться для безопасной и удобной вставки в таблицы main и patient

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_INS_main`(IN `t_num` CHAR(19), IN `t_st_id` INT(10) UNSIGNED, IN `doc_d` DATE, IN `gosp_d` DATE, IN `p` INT(10), IN `dg_id` INT(10) UNSIGNED, IN `o_id` INT(10) UNSIGNED, IN `vmp` INT(10) UNSIGNED, IN `dp_id` TINYINT(2) UNSIGNED, IN `atn` TINYINT(1) UNSIGNED, IN `acpt` TINYINT(1) UNSIGNED, IN `invt_early` TINYINT(1) UNSIGNED, IN `st_id` INT(10) UNSIGNED, IN `u` INT(10) UNSIGNED, IN `gosp_t` TIME, IN `rev` TINYINT(1) UNSIGNED, IN `ovrl` TINYINT(1) UNSIGNED, IN `preg` TINYINT(1) UNSIGNED, IN `vmpch` TINYINT(1) UNSIGNED, IN `reject` TINYINT(1) UNSIGNED)
    MODIFIES SQL DATA
BEGIN

	IF (SELECT `m`.`talon_num` FROM `main` AS `m` WHERE `m`.`talon_num`=t_num) IS NULL THEN INSERT INTO `main` (`id`,`talon_num`,`talon_st_id`,`doc_date`,`gosp_date`, `gosp_time`,`pid`,`diag_id`,`op_id`,`vmp_id`,`dep_id`,`attention`,`accepted`,`invite_early`,`revision`,`over_list`,`pre_gosp`,`vmp_changed`,`state_id`,`reject`,`uid`) VALUES (NULL,t_num,t_st_id,doc_d,gosp_d, gosp_t,p,dg_id,o_id,vmp,dp_id,atn,acpt,invt_early,rev,ovrl,preg,vmpch,st_id,reject,u);

    END IF;

    SELECT `id` FROM `main` ORDER BY `id` DESC LIMIT 1;

END ;;

CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_INS_patient`(IN `family_name` VARCHAR(50) CHARSET utf8, IN `self_name` VARCHAR(50) CHARSET utf8, IN `father_name` VARCHAR(50) CHARSET utf8, IN `birth_year` INT(4) UNSIGNED, IN `e_mail` VARCHAR(50) CHARSET utf8, IN `region` INT(10) UNSIGNED, IN `usr` INT(10) UNSIGNED)
    MODIFIES SQL DATA
BEGIN

	IF (SELECT `p`.`id` FROM `patient` AS `p` WHERE `p`.`fname`=family_name AND `p`.`sname`=self_name AND `p`.`patronymic` = father_name AND `p`.`bth_year`=birth_year AND `p`.`region_id`=region) IS NULL THEN 

    	INSERT INTO `patient` (`id`,`fname`,`sname`,`patronymic`,`bth_year`,`email`,`region_id`,`uid`) VALUES (NULL,family_name,self_name,father_name,birth_year,e_mail,region,usr); 

        SELECT `id` FROM `patient` ORDER BY `id` DESC LIMIT 1;

    ELSE

    	SELECT `p`.`id` FROM `patient` AS `p` WHERE `p`.`fname`=family_name AND `p`.`sname`=self_name AND `p`.`patronymic` = father_name AND `p`.`bth_year`=birth_year AND `p`.`region_id`=region ORDER BY `p`.`id` DESC LIMIT 1;

	END IF;

END ;;
DELIMITER ;
