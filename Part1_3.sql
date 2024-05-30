CREATE DEFINER=`root`@`localhost` PROCEDURE `API3`(
	IN _candidate VARCHAR(100)
    )
api3:BEGIN
    DECLARE exception VARCHAR(100);
    
    # Exception handling for candidate
    IF _candidate != 'Biden' AND _candidate != 'Trump' THEN
		SET exception = 'candidate does not exist';
		SELECT exception;
		LEAVE api3;
	END IF;
    
    # Query handling
	IF _candidate = 'Biden' THEN
		SELECT DISTINCT(precinct) FROM penna WHERE (Biden > Trump) ORDER BY totalVotes DESC LIMIT 10;
	ELSEIF _candidate = 'Trump' THEN
		SELECT DISTINCT(precinct) FROM penna WHERE (Trump > Biden) ORDER BY totalVotes DESC LIMIT 10;
	END IF;

END