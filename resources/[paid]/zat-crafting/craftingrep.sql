CREATE TABLE `craftingrep` (
  `id` varchar(255) NOT NULL,
  `cid` varchar(255) NOT NULL,
  `rep` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `craftingrep`
  ADD PRIMARY KEY (`id`);
COMMIT;

ALTER TABLE `craftingrep`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;
