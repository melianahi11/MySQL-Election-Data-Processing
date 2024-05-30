# Project 1 README

This repository contains files and instructions for implementing various procedures and triggers in MySQL related to election data processing. Below are details regarding each part of the project along with specific instructions and considerations. 

## General Notes:

- **Delimiters**: For all provided files, there is no delimiter specified at the start or end, as the testing methodology was not explicitly outlined. To execute these files, add them to the schema Penna's "Stored Procedures" and table penna's triggers. MySQL Workbench will automatically add the correct delimiter lines.

## Stored Procedures
### API1
Retrieves the number of votes for a candidate in a precinct at a specific timestamp.

### API2
Determines the winning candidate and their votes on a specific date.

### API3
Retrieves precincts where a candidate had more votes than their opponent.

### API4
Determines the winning candidate and their vote percentage in a precinct.

### API5
Retrieves candidate and their votes containing a specified substring in the precinct name.

## Part2_1:

### Procedure: newPenna()

Instructions specify displaying changes "between timestamp T and the last timestamp DIRECTLY preceding". The `newPenna()` procedure exhibits this by showing changes between each timestamp and its immediately preceding one, even if no change in count occurred.

**Note**: This procedure may require a significant amount of time to execute (30+ minutes). Adjust the DBMS CONNECTION READ TIMEOUT to 0 to prevent timeouts during execution.

## Part3:

- **Boolean Values**: MySQL boolean values are represented as 0 and 1. It is assumed that the assignment did not intend to return the strings "TRUE" and "FALSE".

## Part4_1:

### Triggers: updatedtuples, insertedtuples, deletedtuples

The provided triggers do not create the tables `updatedtuples`, `insertedtuples`, and `deletedtuples`. You need to create these tables manually using the following SQL commands:

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
  KEY `indprecon`
