CREATE DEFINER=`root`@`localhost` PROCEDURE `API2`(
    IN _date VARCHAR(100)
    )
api2:BEGIN
	DECLARE candidate VARCHAR(100);
    DECLARE votes INT(10) DEFAULT 0;
    DECLARE exception VARCHAR(100);
    
    DECLARE tempBiden INT(10) DEFAULT 0;
    DECLARE tempTrump INT(10) DEFAULT 0;
    
    # Exception handling for date
    IF (SELECT _date REGEXP '(\\d{4})-(\\d{2})-(\\d{2})') != 1 THEN
		SET exception = 'date format incorrect';
		SELECT exception;
		LEAVE api2;
	END IF;
    
    # Query handling
	SET tempBiden = (SELECT Biden FROM penna WHERE DATE(Timestamp) <= _date ORDER BY Timestamp DESC LIMIT 1);
	SET tempTrump = (SELECT Trump FROM penna WHERE DATE(Timestamp) <= _date ORDER BY Timestamp DESC LIMIT 1);
    
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