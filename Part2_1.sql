CREATE DEFINER=`root`@`localhost` PROCEDURE `newPenna`()
newPenna:BEGIN
	# NEED TO SET DBMS CONNECTION READ TIMEOUT TO 0, THIS WILL TAKE 30+ MIN
    # AN IMPROVEMENT WOULD BE TO ONLY INSERT TIMES WHERE THE VOTES CHANGED
    # BUT THE ASSIGNMENT ASKED FOR EVERY TIMESTAMP
    
	DECLARE ID INT(100);
    DECLARE timestamp DATETIME;
    DECLARE precinct VARCHAR(100);
    DECLARE totalvotes INT(10);
    DECLARE biden INT(10);
    DECLARE trump INT(10);
    
    DECLARE prev_precinct VARCHAR(100);
    DECLARE prev_totalvotes INT(10);
    DECLARE prev_biden INT(10);
    DECLARE prev_trump INT(10);
    
    DECLARE newvotes INT(10);
    DECLARE new_Biden INT(10);
    DECLARE new_Trump INT(10);
    
    DECLARE done INT DEFAULT FALSE;

    DECLARE cur CURSOR FOR SELECT tempTable.ID, tempTable.Timestamp, tempTable.precinct, tempTable.totalVotes, tempTable.Biden, tempTable.Trump FROM (SELECT * FROM penna ORDER BY ID, Timestamp ASC) AS tempTable ORDER BY tempTable.ID, tempTable.Timestamp;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
	DROP TABLE IF EXISTS newPenna;
    
    CREATE TABLE newPenna
    (
      precinct VARCHAR(100),
      Timestamp DATETIME,
      newvotes INT(10),
      new_Biden INT(10),
      new_Trump INT(10)
	);
    
    OPEN cur;
    
    FETCH NEXT FROM cur INTO ID, timestamp, precinct, totalvotes, biden, trump;

	SET prev_precinct = "";
    
	cursor_loop: WHILE done = 0 DO
        IF precinct != prev_precinct THEN
			SET prev_precinct = precinct;
            SET prev_totalvotes = 0;
            SET prev_biden = 0;
            SET prev_trump = 0;
		END IF;
        
        SET newvotes = (totalvotes - prev_totalvotes);
        SET new_Biden = (biden - prev_biden);
        SET new_Trump = (trump - prev_trump);
        
        INSERT INTO newPenna(precinct, Timestamp, newvotes, new_Biden, new_Trump) VALUES (precinct, timestamp, newvotes, new_Biden, new_Trump);
        
        SET prev_precinct = precinct;
		SET prev_totalvotes = totalvotes;
		SET prev_biden = biden;
		SET prev_trump = trump;
        
        FETCH NEXT FROM cur INTO ID, timestamp, precinct, totalvotes, biden, trump;
	END WHILE;

	CLOSE cur;

END