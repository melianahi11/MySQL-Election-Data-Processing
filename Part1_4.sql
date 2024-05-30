CREATE DEFINER=`root`@`localhost` PROCEDURE `API4`(
    IN _precinct VARCHAR(100)
    )
api4:BEGIN
	DECLARE candidate VARCHAR(100);
	DECLARE percentage VARCHAR(100);
    DECLARE exception VARCHAR(100);
    
    DECLARE tempBiden INT(10);
    DECLARE tempTrump INT(10);
    DECLARE tempTotal INT(10);
    
    # Exception handling for precinct
    IF (SELECT COUNT(*) FROM penna WHERE precinct = _precinct) < 1 THEN
		SET exception = 'precinct does not exist';
		SELECT exception;
		LEAVE api4;
	END IF;
    
    # Query handling
	SET tempTotal = (SELECT totalVotes FROM penna WHERE precinct = _precinct ORDER BY Timestamp DESC LIMIT 1);
    SET tempBiden = (SELECT Biden FROM penna WHERE precinct = _precinct ORDER BY Timestamp DESC LIMIT 1);
    SET tempTrump = (SELECT Trump FROM penna WHERE precinct = _precinct ORDER BY Timestamp DESC LIMIT 1);
    
    IF tempBiden > tempTrump THEN
		SET candidate = 'Biden';
        SET percentage = CONCAT((tempBiden * 100 / tempTotal), '%');
	ELSEIF tempTrump > tempBiden THEN
		SET candidate = 'Trump';
        SET percentage = CONCAT((tempTrump * 100 / tempTotal), '%');
	ELSE
		SET candidate = 'Biden/Trump Tie';
        SET percentage = CONCAT((tempBiden * 100 / tempTotal), '%');
	END IF;
    
    SELECT candidate, percentage;
END