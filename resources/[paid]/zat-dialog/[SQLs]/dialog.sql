CREATE TABLE `dialog` (
  `id` int(11) NOT NULL,
  `cid` varchar(255) NOT NULL,
  `rep` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `dialog`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `dialog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
COMMIT;

