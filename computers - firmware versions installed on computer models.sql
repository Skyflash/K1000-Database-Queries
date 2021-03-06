SELECT BIOS_VERSION, 
COUNT(DISTINCT(MACHINE.ID)), 
GROUP_CONCAT(DISTINCT(CS_MODEL)) as Models, 
GROUP_CONCAT(DISTINCT(OS_NUMBER)) as OSVersions,
GROUP_CONCAT(DISTINCT(SUBSTRING_INDEX(MACHINE.NAME, "-", 1))) as Computers
FROM ORG1.MACHINE
JOIN MACHINE_LABEL_JT on MACHINE_LABEL_JT.MACHINE_ID = MACHINE.ID
JOIN LABEL on LABEL.ID = MACHINE_LABEL_JT.LABEL_ID
WHERE CS_MANUFACTURER like "Apple%"

-- and LABEL.NAME like "%Lab Systems OU%"
and MACHINE.NAME not like "%-bc%"
GROUP BY BIOS_VERSION

-- HAVING OSVersions like "10.13.%"

ORDER BY BIOS_VERSION
;