ALTER TABLE users ADD wonder_apartments VARCHAR(32) NOT NULL DEFAULT 'no';

CREATE TABLE IF NOT EXISTS `wonder_apartments` (
  `identifier` varchar(46) NOT NULL,
  `apartmentid` int(50) NOT NULL AUTO_INCREMENT,
  `purchased` varchar(50) NOT NULL DEFAULT 'no',
  `size` varchar(50) NOT NULL,
  `pincode` int(4) DEFAULT NULL,
  PRIMARY KEY (`apartmentid`) USING BTREE
);

