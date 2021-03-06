-- Report of both Dell and Apple hardware
-- Includes column for Purchase Date (for Apple based on custom inventory rule)
-- Includes column for replacement date based on chassis type

-- Good example of the CASE function
SELECT DISTINCT(MACHINE.NAME), MACHINE.OS_NAME, MACHINE.CS_MANUFACTURER, MACHINE.CS_MODEL, MACHINE.CHASSIS_TYPE,
CASE
    WHEN MACHINE.CS_MANUFACTURER like 'Apple%' THEN MACHINE_CUSTOM_INVENTORY.DATE_FIELD_VALUE
    WHEN MACHINE.CS_MANUFACTURER like 'Dell%' THEN DA.SHIP_DATE
END AS PURCHASE_DATE,
CASE
    WHEN MACHINE.CHASSIS_TYPE = "desktop" and MACHINE.CS_MANUFACTURER like 'Apple%' THEN DATE_ADD(MACHINE_CUSTOM_INVENTORY.DATE_FIELD_VALUE, INTERVAL 4 YEAR)
    WHEN MACHINE.CHASSIS_TYPE = "laptop" and MACHINE.CS_MANUFACTURER like 'Apple%' THEN DATE_ADD(MACHINE_CUSTOM_INVENTORY.DATE_FIELD_VALUE, INTERVAL 3 YEAR)
    WHEN MACHINE.CHASSIS_TYPE = "desktop" and MACHINE.CS_MANUFACTURER like 'Dell%' THEN DATE_ADD(DA.SHIP_DATE, INTERVAL 4 YEAR)
    WHEN MACHINE.CHASSIS_TYPE = "laptop" and MACHINE.CS_MANUFACTURER like 'Dell%' THEN DATE_ADD(DA.SHIP_DATE, INTERVAL 3 YEAR)
    ELSE "Unknown"
END AS REPLACEMENT_DATE
FROM MACHINE
LEFT JOIN DELL_ASSET DA on MACHINE.BIOS_SERIAL_NUMBER = DA.SERVICE_TAG
LEFT JOIN MACHINE_CUSTOM_INVENTORY on MACHINE.ID = MACHINE_CUSTOM_INVENTORY.ID and SOFTWARE_ID = 25152
WHERE (MACHINE.CS_MANUFACTURER like 'Apple%' or MACHINE.CS_MANUFACTURER like 'Dell%')
AND MACHINE.NAME not like '%BC'
HAVING REPLACEMENT_DATE < NOW()
ORDER BY PURCHASE_DATE, MACHINE.NAME
