CREATE TABLE StateArea(
  State_Name VARCHAR2(20) CONSTRAINT StateAreaKey PRIMARY KEY,
  State_Area NUMBER
);



CREATE TABLE CountyArea(
  County_id VARCHAR2(40) CONSTRAINT CountyAreaKey PRIMARY KEY,
  County VARCHAR2(40),
  State_Name VARCHAR2(20),
  County_Area NUMBER
);          

DROP TABLE CountyArea;
DROP TABLE StateArea;
DROP TABLE Accident;


SELECT * FROM StateArea;
SELECT * FROM CountyArea;
SELECT * FROM Accident;

select count(*) FROM Accident;

TRUNCATE TABLE Accident;

commit;

CREATE TABLE Accident(
    Accident_ID VARCHAR2(40) CONSTRAINT AccidentKey PRIMARY KEY,
    Severity NUMBER CONSTRAINT AccidentSeverity CHECK(
    (Severity >= 1)
    AND (Severity <= 4)
    ),
    Distance_Affected NUMBER,
    Start_Time TIMESTAMP,
    End_Time TIMESTAMP,
    Weather_ID VARCHAR(40),
    Location_ID VARCHAR(40)
);

