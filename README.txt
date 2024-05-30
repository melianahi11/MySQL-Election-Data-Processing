## Project 1 README

This repository contains files and instructions for implementing various procedures and triggers in MySQL related to election data processing. Below are details regarding each part of the project along with specific instructions and considerations.

### General Notes

- **Delimiters**: For all provided files, there is no delimiter specified at the start or end, as the testing methodology was not explicitly outlined. To execute these files, add them to the schema Penna's "Stored Procedures" and table penna's triggers. MySQL Workbench will automatically add the correct delimiter lines.

---

### Part2_1

#### Procedure: `newPenna()`

Instructions specified that we were supposed to show the change "between timestamp T and the last timestamp DIRECTLY preceding". As such, my `newPenna` procedure shows the change between every single timestamp and the one DIRECTLY preceding it even if no change in count was made. This procedure will take a long time to run (30+ minutes), so you will need to set DBMS CONNECTION READ TIMEOUT to 0 (so it doesn't timeout).

An improvement in the assignment would have been to specify to ONLY insert times where a change in votes occurred.

---

### Part3

- **Boolean Values**: MySQL boolean values present as 0 and 1. I really hope the assignment didn't mean for us to return the String "TRUE" and "FALSE".

---

### Part4_1

#### Triggers: `updatedtuples`, `insertedtuples`, `deletedtuples`

The triggers don't actually create the `updatedtuples`, `insertedtuples`, and `deletedtuples` tables. You'll have to create them yourself using the following SQL commands:

```sql
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
```
