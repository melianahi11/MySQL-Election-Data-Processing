CREATE DEFINER=`root`@`localhost` PROCEDURE `Switch`()
switch:BEGIN
	DECLARE ID INT(100);
    DECLARE timestamp DATETIME;
    DECLARE precinct VARCHAR(100);
    DECLARE totalvotes INT(10);
    DECLARE biden INT(10);
    DECLARE trump INT(10);
    
    DECLARE final_precinct VARCHAR(100);
    DECLARE final_winner VARCHAR(100);
    DECLARE final_biden INT(10);
    DECLARE final_trump INT(10);
    
    DECLARE switch_flag INT(10);
    
	DECLARE fromCandidate VARCHAR(100);
	DECLARE toCandidate VARCHAR(100);
    
    DECLARE done INT DEFAULT FALSE;

    DECLARE cur CURSOR FOR SELECT tempTable.ID, tempTable.Timestamp, tempTable.precinct, tempTable.totalVotes, tempTable.Biden, tempTable.Trump FROM (SELECT * FROM penna ORDER BY ID, Timestamp DESC) AS tempTable ORDER BY tempTable.ID, tempTable.Timestamp;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
	DROP TABLE IF EXISTS switch;
    
    CREATE TABLE switch
    (
      precinct VARCHAR(100),
      Timestamp DATETIME,
      fromCandidate VARCHAR(100),
      toCandidate VARCHAR(100)
	);
    
    OPEN cur;
    
    FETCH NEXT FROM cur INTO ID, timestamp, precinct, totalvotes, biden, trump;

	SET final_precinct = "";
    
	cursor_loop: WHILE done = 0 DO
        IF precinct != final_precinct THEN
			SET switch_flag = FALSE;
			SET final_precinct = precinct;
            SET final_biden = biden;
            SET final_trump = trump;
            IF final_biden > final_trump THEN
				SET final_winner = 'Biden';
            ELSEIF final_trump > final_biden THEN
				SET final_winner = 'Trump';
            ELSE
				SET final_winner = 'Tie';
            END IF;    
		ELSEIF switch_flag = FALSE THEN
			IF final_winner = 'Biden' AND trump > biden THEN
				INSERT INTO Switch(precinct, Timestamp, fromCandidate, toCandidate) VALUES (precinct, Timestamp, 'Trump', final_winner);
                SET switch_flag = TRUE;
            ELSEIF final_winner = 'Trump' AND biden > trump THEN
				INSERT INTO Switch(precinct, Timestamp, fromCandidate, toCandidate) VALUES (precinct, Timestamp, 'Biden', final_winner);
                SET switch_flag = TRUE;
            END IF; 
        END IF;    
        
        FETCH NEXT FROM cur INTO ID, timestamp, precinct, totalvotes, biden, trump;
	END WHILE;

	CLOSE cur;
    
    SELECT * FROM switch;
    
    DROP TABLE IF EXISTS switch;

END