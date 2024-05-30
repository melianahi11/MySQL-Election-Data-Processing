CREATE DEFINER=`root`@`localhost` TRIGGER `penna_AFTER_INSERT` AFTER INSERT ON `penna` FOR EACH ROW BEGIN
	INSERT INTO penna.insertedtuples VALUES (NEW.ID, NEW.Timestamp, NEW.state, NEW.locality, NEW.precinct, NEW.geo, NEW.totalvotes, NEW.Biden, NEW.Trump, NEW.filestamp);
END