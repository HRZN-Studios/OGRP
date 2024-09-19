CREATE TABLE IF NOT EXISTS `qf_mdt_ems_annoucements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext NOT NULL ,
  `content` longtext NOT NULL,
  `time` int(11) NOT NULL DEFAULT 0,
  `annid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `qf_mdt_ems_citizen_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `date` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `reason` longtext NOT NULL,
  `officer` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `qf_mdt_ems_evidences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext NOT NULL,
  `subtitle` longtext NOT NULL,
  `creator` varchar(50) NOT NULL,
  `officer_involved` longtext,
  `citizen_involved` longtext,
  `images` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `qf_mdt_ems_fines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `reason` longtext NOT NULL,
  `fine` int(11) NOT NULL DEFAULT 0,
  `date` int(11) NOT NULL DEFAULT 0,
  `officer` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `qf_mdt_ems_housenotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `house_name` varchar(50) DEFAULT NULL,
  `date` int(11) DEFAULT 0,
  `note` longtext DEFAULT NULL,
  `officer` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `qf_mdt_ems_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `title` longtext NOT NULL,
  `content` longtext NOT NULL,
  `time` int(11) NOT NULL DEFAULT 0,
  `annid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `qf_mdt_ems_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `mdt_color` varchar(50) DEFAULT '#0D141F',
  `main_color` varchar(50) DEFAULT '#111925',
  `second_color` varchar(50) DEFAULT '#0D141F',
  `third_color` varchar(50) DEFAULT '#1E2839',
  `fourth_color` varchar(50) DEFAULT '#316BFF',
  `language` varchar(50) DEFAULT 'en',
  `mdtscale` varchar(50) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `qf_mdt_ems_vehicle_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(15) NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT 0,
  `date` int(11) NOT NULL DEFAULT 0,
  `note` longtext NOT NULL,
  `officer` varchar(60) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `plate` (`plate`),
  KEY `note` (`note`(768)),
  KEY `officer` (`officer`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `qf_mdt_ems_warrants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext NOT NULL,
  `subtitle` longtext NOT NULL,
  `creator` varchar(50) NOT NULL DEFAULT '',
  `officer_involved` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `citizen_involved` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `qf_mdt_ems_time` (
  `identifier` varchar(46) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `users` ADD `mdt_ems_picture` longtext DEFAULT NULL, ADD `mdt_ems_searched` int(11) DEFAULT 0;