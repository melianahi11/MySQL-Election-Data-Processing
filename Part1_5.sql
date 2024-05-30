CREATE DEFINER=`root`@`localhost` PROCEDURE `API5`(
    IN _string VARCHAR(100)
    )
api5:BEGIN
	DECLARE candidate VARCHAR(100);
	DECLARE votes VARCHAR(100);
    DECLARE exception VARCHAR(100);
    
    DECLARE tempBiden INT(10);
    DECLARE tempTrump INT(10);
    
    # Exception handling for string
    IF _string = '' THEN
		SET exception = 'string cannot be empty';
		SELECT exception;
		LEAVE api5;
	ELSEIF (SELECT COUNT(*) FROM penna WHERE precinct LIKE CONCAT('%', _string, '%')) < 1 THEN
		SET exception = 'substring does not exist';
		SELECT exception;
		LEAVE api5;
	END IF;
    
    # Query handling
    SET tempBiden = (SELECT SUM(Biden) FROM (SELECT DISTINCT(precinct), Biden, Trump FROM penna GROUP BY precinct ORDER BY Timestamp DESC) AS tempTable WHERE precinct LIKE CONCAT('%', _string, '%'));
    SET tempTrump = (SELECT SUM(Trump) FROM (SELECT DISTINCT(precinct), Biden, Trump FROM penna GROUP BY precinct ORDER BY Timestamp DESC) AS tempTable WHERE precinct LIKE CONCAT('%', _string, '%'));
    
    IF tempBiden > tempTrump THEN
		SET candidate = 'Biden';
        SET votes = tempBiden;
	ELSEIF tempTrump > tempBiden THEN
		SET candidate = 'Trump';
        SET votes = tempTrump;
	ELSE
		SET candidate = 'Biden/Trump Tie';
        SET votes = tempBiden;
	END IF;
    
    SELECT candidate, votes;
END