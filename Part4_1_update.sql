CREATE DEFINER=`root`@`localhost` TRIGGER `penna_BEFORE_UPDATE` BEFORE UPDATE ON `penna` FOR EACH ROW BEGIN
	INSERT INTO penna.updatedtuples VALUES (OLD.ID, OLD.Timestamp, OLD.state, OLD.locality, OLD.precinct, OLD.geo, OLD.totalvotes, OLD.Biden, OLD.Trump, OLD.filestamp);
END