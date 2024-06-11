/*FINAL 1*/ 
WITH YEAR_COUNT AS
  (SELECT COUNT(DISTINCT EXTRACT(YEAR
                                 FROM A.Start_Time)) AS NUMBER_OF_YEARS
   FROM "VKALVA".Accident A)
SELECT EXTRACT(MONTH
               FROM A.Start_Time) AS MONTH_NAME,
       COUNT(*) / (S.State_Area * YEAR_COUNT.NUMBER_OF_YEARS) AS AVG_ACCIDENT_DENSITY
FROM "VKALVA".Accident A
JOIN AccidentLocation AL ON A.Location_ID = AL.Location_ID
JOIN CountyArea C ON C.County_ID = AL.County
JOIN StateArea S ON S.State_Name = C.State_Name
CROSS JOIN YEAR_COUNT
WHERE S.State_Name = 'FL'
GROUP BY EXTRACT(MONTH
                 FROM A.Start_Time),
         YEAR_COUNT.NUMBER_OF_YEARS,
         S.State_Area
ORDER BY MONTH_NAME ASC;

/*FINAL 2*/ 
WITH Severity_Duration AS
  (SELECT Accident_ID,
          Severity,
          Start_Time
   FROM "VKALVA".Accident)
SELECT EXTRACT(MONTH
               FROM SD.Start_Time) AS MONTH_NAME,
       AVG(SD.Severity * (EXTRACT(DAY FROM (A.End_Time - A.Start_Time)) * 3600 * 24 + 
                            EXTRACT(HOUR FROM (A.End_Time - A.Start_Time)) * 3600 + 
                            EXTRACT(MINUTE FROM (A.End_Time - A.Start_Time)) * 60 + 
                            EXTRACT(SECOND FROM (A.End_Time - A.Start_Time))
                    )
        ) AS Traffic_Severity
FROM Severity_Duration SD
JOIN "VKALVA".Accident A ON A.Accident_ID = SD.Accident_ID
WHERE EXTRACT(YEAR
              FROM SD.Start_Time) = 2016
GROUP BY EXTRACT(MONTH
                 FROM SD.Start_Time)
ORDER BY MONTH_NAME ASC;

/*FINAL 3*/ 
WITH SafetyIndices AS
  (SELECT Weather_ID,
          (Visibility / (Wind_Speed + Precipitation + ((Temperature * Temperature) - (154 * Temperature) + 5929))) AS Safety_Index
   FROM WEATHER
   WHERE (Wind_Speed + Precipitation + ((Temperature * Temperature) - (154 * Temperature) + 5929) <> 0) )
SELECT EXTRACT(MONTH
               FROM A.Start_Time) AS Month_Name,
       AVG(SI.Safety_Index) AS Avg_Safety_Index
FROM "VKALVA".Accident A
JOIN SafetyIndices SI ON A.Weather_ID = SI.Weather_ID
GROUP BY EXTRACT(MONTH
                 FROM A.Start_Time)
ORDER BY Month_Name ASC;

/*FINAL 4*/ 
WITH Duration AS
  (SELECT A.Location_ID,
          A.Weather_ID,
          A.End_Time - A.Start_Time AS Duration,
          A.Start_Time
   FROM "VKALVA".Accident A
   WHERE A.Start_Time >= TO_TIMESTAMP('2016-01-01', 'YYYY-MM-DD')
     AND A.Start_Time < TO_TIMESTAMP('2024-01-01', 'YYYY-MM-DD') ),
                 AllHours AS
  (SELECT LEVEL - 1 AS HourNumber
   FROM dual CONNECT BY LEVEL <= 24)
SELECT ah.HourNumber AS HOUR,
       AVG(COALESCE(EXTRACT(DAY
                            FROM D.Duration) * 24 + EXTRACT(HOUR
                                                            FROM D.Duration) + EXTRACT(MINUTE
                                                                                       FROM D.Duration) / 60 + EXTRACT(SECOND
                                                                                                                       FROM D.Duration) / 3600, 0)) AS Avg_Road_Block_In_Hours
FROM AllHours ah
CROSS JOIN StateArea sa
LEFT JOIN Duration D ON EXTRACT(HOUR
                                FROM D.Start_Time) = ah.HourNumber
LEFT JOIN AccidentLocation al ON D.Location_ID = al.Location_ID
LEFT JOIN CountyArea ca ON al.County = ca.County_ID
GROUP BY ah.HourNumber
ORDER BY ah.HourNumber;

/*FINAL 5*/
SELECT (AVG(Severity)*COUNT(Accident_ID))/((SUM(POPULATION)/COUNT(Population))*(SUM(State_Area)/COUNT(State_Area))) * 10000000 AS AccidentProneFactor,
       AC_Year
FROM
  (SELECT Severity,
          Accident_ID,
          AC_Year
   FROM
     (SELECT Severity,
             Accident_ID,
             EXTRACT(YEAR
                     FROM Start_Time) AS AC_Year
      FROM "VKALVA".Accident) "AC") "NUME"
JOIN
  (SELECT SD.State_Area,
          SD.Year,
          SD.Population,
          SD.State_Name,
          LocaD.Location_ID
   FROM
     (SELECT SA.State_Area,
             SP.Year,
             SP.Population,
             SA.State_Name
      FROM StateArea SA
      JOIN "VKALVA".StatePopulation SP ON SA.State_Name = SP.State_Name) SD
   JOIN
     (SELECT CA.State_Name,
             AL.Location_ID
      FROM AccidentLocation AL
      JOIN CountyArea CA ON CA.County_id = AL.County) LocaD ON SD.State_Name = LocaD.State_Name) "DENO" ON DENO.Location_ID = NUME.Accident_ID
AND YEAR = AC_Year
AND State_Name = 'OH'
GROUP BY AC_Year
ORDER BY AC_Year ASC;

