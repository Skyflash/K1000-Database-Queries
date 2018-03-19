-- Custom inventory rule contains SPSS license information
SELECT DISTINCT(MACHINE.NAME), MACHINE.OS_NAME,
CASE
    WHEN OS_ARCH = "x86" THEN L32.STR_FIELD_VALUE
    WHEN OS_ARCH = "x64" THEN L64.STR_FIELD_VALUE
END AS SPSSLicenseStatus
FROM MACHINE
LEFT JOIN MACHINE_CUSTOM_INVENTORY L32 on MACHINE.ID = L32.ID and L32.SOFTWARE_ID = 69610
LEFT JOIN MACHINE_CUSTOM_INVENTORY L64 on MACHINE.ID = L64.ID and L64.SOFTWARE_ID = 69787

HAVING SPSSLicenseStatus like "%Local license%"
ORDER BY MACHINE.NAME
