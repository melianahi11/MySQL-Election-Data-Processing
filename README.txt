Project 1 README

* For all of these files, there is no delimiter start or end as 
it was not specified how the files would be tested/where they should be created. 
To run these files, add them to schema Penna's "Stored Procedures" and 
table penna's triggers.MySQL Workbench will automatically add in the correct 
delimiter lines.


Part2_1: 
newPenna() instructions specified that we were supposed to show the change 
"between timestamp T and the last timestamp DIRECTLY preceding". As such, my newPenna
shows the change between every single timestamp and the one DIRECTLY preceding it even
if no change in count was made. This procedure will take a long time to run (30+ minutes)
so you will need to set DBMS CONNECTION READ TIMEOUT to 0 (so it doesn't timeout).

An improvement in the assignment would have been to specify to ONLY insert times where a 
change in votes occured.

Part3:
MySQL boolean values present as 0 and 1. I really hope the assignment didn't mean for us 
to return the String "TRUE" and "FALSE".

Part4_1:
The triggers don't actually create the updatedtuples, insertedtuples, and deletedtuples 
tables. You'll have to create them yourself using:

CREATE TABLE `updatedtuples` (
  `ID` int(11) DEFAULT NULL,
  `Timestamp` datetime DEFAULT NULL,
  `state` varchar(10) DEFAULT NULL,
  `locality` varchar(100) DEFAULT NULL,
  `precinct` varchar(100) DEFAULT NULL,
  `geo` varchar(100) DEFAULT NULL,
  `totalvotes` int(11) DEFAULT NULL,
  `Biden` int(11) DEFAULT NULL,
  `Trump` int(11) DEFAULT NULL,
  `filestamp` varchar(200) DEFAULT NULL,
  KEY `indp` (`precinct`),
  KEY `indtemp` (`Timestamp`),
  KEY `indprecon` (`precinct`)
);

CREATE TABLE `insertedtuples` (
  `ID` int(11) DEFAULT NULL,
  `Timestamp` datetime DEFAULT NULL,
  `state` varchar(10) DEFAULT NULL,
  `locality` varchar(100) DEFAULT NULL,
  `precinct` varchar(100) DEFAULT NULL,
  `geo` varchar(100) DEFAULT NULL,
  `totalvotes` int(11) DEFAULT NULL,
  `Biden` int(11) DEFAULT NULL,
  `Trump` int(11) DEFAULT NULL,
  `filestamp` varchar(200) DEFAULT NULL,
  KEY `indp` (`precinct`),
  KEY `indtemp` (`Timestamp`),
  KEY `indprecon` (`precinct`)
);

CREATE TABLE `deletedtuples` (
  `ID` int(11) DEFAULT NULL,
  `Timestamp` datetime DEFAULT NULL,
  `state` varchar(10) DEFAULT NULL,
  `locality` varchar(100) DEFAULT NULL,
  `precinct` varchar(100) DEFAULT NULL,
  `geo` varchar(100) DEFAULT NULL,
  `totalvotes` int(11) DEFAULT NULL,
  `Biden` int(11) DEFAULT NULL,
  `Trump` int(11) DEFAULT NULL,
  `filestamp` varchar(200) DEFAULT NULL,
  KEY `indp` (`precinct`),
  KEY `indtemp` (`Timestamp`),
  KEY `indprecon` (`precinct`)
);