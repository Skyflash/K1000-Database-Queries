SELECT SVTS.NAME, YEAR(START) as "Year", MONTH(START) as "Month", count(SMD.ID) as "Launches", ROUND(AVG(SECONDS_USED)/60, 2) as "Average Minutes"
FROM SAM_METER_DATA SMD
JOIN SAM_VIEW_TITLED_SOFTWARE SVTS on SMD.TITLED_APPLICATION_ID = SVTS.ID
JOIN MACHINE on SMD.MACHINE_ID = MACHINE.ID

WHERE SVTS.NAME like "%SPSS%"
GROUP BY YEAR(START), MONTH(START)
ORDER BY YEAR(START), MONTH(START)