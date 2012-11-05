ALTER TABLE `consultant`
	ADD INDEX `email_index` (`email`),
	ADD UNIQUE INDEX `email_unique` (`email`),
	ADD INDEX `username_index` (`username`),
	ADD UNIQUE INDEX `username` (`username`);