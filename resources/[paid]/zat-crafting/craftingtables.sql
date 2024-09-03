CREATE TABLE `craftingtables` (
  `id` varchar(255) NOT NULL,
  `coords` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `rot` varchar(255) DEFAULT NULL,
  `bucket` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE `craftingtables`
  ADD PRIMARY KEY (`id`);
COMMIT;