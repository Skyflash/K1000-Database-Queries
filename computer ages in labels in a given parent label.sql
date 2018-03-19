--  Pulls data from Dell asset tables
--  Counts number of computers shipped per year
--  Restricted to a specific label group 
--  proposed answer for http://www.itninja.com/question/run-a-report-with-ship-date-by-label

SELECT LABEL.NAME as "Lab", COUNT(MACHINE.NAME) as Count,
SUM(CASE
	when YEAR(SHIP_DATE) = 2018 THEN 1 ELSE 0
END) as "2018",
SUM(CASE
	when YEAR(SHIP_DATE) = 2017 THEN 1 ELSE 0
END) as "2017",
SUM(CASE
	when YEAR(SHIP_DATE) = 2016 THEN 1 ELSE 0
END) as "2016",
SUM(CASE
	when YEAR(SHIP_DATE) < 2016 THEN 1 ELSE 0
END) as "< 2016"

    
FROM MACHINE
LEFT JOIN DELL_ASSET DA on MACHINE.BIOS_SERIAL_NUMBER = DA.SERVICE_TAG

JOIN MACHINE_LABEL_JT on MACHINE_LABEL_JT.MACHINE_ID = MACHINE.ID
JOIN LABEL on LABEL.ID = MACHINE_LABEL_JT.LABEL_ID
JOIN LABEL_LABEL_JT on LABEL.ID = LABEL_LABEL_JT.CHILD_LABEL_ID
JOIN LABEL PARENT on PARENT.ID = LABEL_LABEL_JT.LABEL_ID
WHERE MACHINE.CS_MANUFACTURER like 'Dell%'
and PARENT.NAME = "Kaufman Labs"
GROUP BY LABEL.NAME
ORDER BY LABEL.NAME

