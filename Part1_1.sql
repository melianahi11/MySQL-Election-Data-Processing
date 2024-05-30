CREATE DEFINER=`root`@`localhost` PROCEDURE `API1`(
	IN _candidate VARCHAR(100), 
    IN _timestamp VARCHAR(100), 
    IN _precinct VARCHAR(100)
    )
api1:BEGIN
	DECLARE votes INT(10) DEFAULT 0;
    DECLARE exception VARCHAR(100);
    
    # Exception handling for candidate
    IF _candidate != 'Biden' AND _candidate != 'Trump' THEN
		SET exception = 'candidate does not exist';
		SELECT exception;
		LEAVE api1;
	END IF;
    
    # Exception handling for date
    IF (SELECT _timestamp REGEXP '(\\d{4})-(\\d{2})-(\\d{2}) (\\d{2}):(\\d{2}):(\\d{2})') != 1 THEN
		SET exception = 'datetime format incorrect';
		SELECT exception;
		LEAVE api1;
	END IF;
    
    # Exception handling for precinct
    IF (SELECT COUNT(*) FROM penna WHERE precinct = _precinct) < 1 THEN
		SET exception = 'precinct does not exist';
		SELECT exception;
		LEAVE api1;
	END IF;
    
    # Query handling
	IF _candidate = 'Biden' THEN
		SET votes = (SELECT Biden FROM penna WHERE precinct = _precinct AND Timestamp <= _timestamp ORDER BY Timestamp DESC LIMIT 1);
	ELSEIF _candidate = 'Trump' THEN
		SET votes = (SELECT Trump FROM penna WHERE precinct = _precinct AND Timestamp <= _timestamp ORDER BY Timestamp DESC LIMIT 1);
	END IF;
    
    SELECT votes;
END