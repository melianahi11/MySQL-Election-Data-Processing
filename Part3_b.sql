CREATE DEFINER=`root`@`localhost` PROCEDURE `Check3B`()
Check3B:BEGIN
	DECLARE ID INT(100);
    DECLARE timestamp DATETIME;
    DECLARE precinct VARCHAR(100);
    DECLARE totalvotes INT(10);
    DECLARE biden INT(10);
    DECLARE trump INT(10);
    
    DECLARE successFlag BOOLEAN;
    
    DECLARE done INT DEFAULT FALSE;

    DECLARE cur CURSOR FOR SELECT tempTable.ID, tempTable.Timestamp, tempTable.precinct, tempTable.totalVotes, tempTable.Biden, tempTable.Trump FROM (SELECT * FROM penna ORDER BY ID, Timestamp ASC) AS tempTable ORDER BY tempTable.ID, tempTable.Timestamp;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    FETCH NEXT FROM cur INTO ID, timestamp, precinct, totalvotes, biden, trump;

	SET successFlag = TRUE;
    
	cursor_loop: WHILE done = 0 DO
        IF DATE(timestamp) < '2020-11-03' || DATE(timestamp) > '2020-11-11' THEN
			SET successFlag = FALSE;
            LEAVE cursor_loop;
		END IF;
        
        FETCH NEXT FROM cur INTO ID, timestamp, precinct, totalvotes, biden, trump;
	END WHILE;

	CLOSE cur;
    
    SELECT successFlag;
END