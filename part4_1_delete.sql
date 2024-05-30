CREATE DEFINER=`root`@`localhost` TRIGGER `penna_AFTER_DELETE` AFTER DELETE ON `penna` FOR EACH ROW BEGIN
	INSERT INTO penna.deletedtuples VALUES (OLD.ID, OLD.Timestamp, OLD.state, OLD.locality, OLD.precinct, OLD.geo, OLD.totalvotes, OLD.Biden, OLD.Trump, OLD.filestamp);
END