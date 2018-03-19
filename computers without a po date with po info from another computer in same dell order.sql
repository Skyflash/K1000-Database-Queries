-- PO information is stored in the computer asset
-- This report will find computers that don't have PO information but were ordered with a computer that does have PO data
-- Used to track down equipment that was not entered into KACE properly and need to be checked
SELECT M.ID, M.NAME, A.ID, A.NAME as "Serial Number", AD.ID, AD.FIELD_32 as PONumber, AD.FIELD_10013 as POCreated,
DA.ORDER_NUMBER,
(SELECT SERVICE_TAG FROM DELL_ASSET
JOIN ASSET_DATA_5 on ASSET_DATA_5.FIELD_10014 = DELL_ASSET.SERVICE_TAG
WHERE DELL_ASSET.SERVICE_TAG != M.BIOS_SERIAL_NUMBER
and DELL_ASSET.ORDER_NUMBER = DA.ORDER_NUMBER
and ASSET_DATA_5.FIELD_10013 is not null
LIMIT 1 ) as OTHER,
AD2.FIELD_10013,
AD2.FIELD_32
FROM ORG1.MACHINE M
JOIN DELL_ASSET DA on DA.SERVICE_TAG = M.BIOS_SERIAL_NUMBER
JOIN ASSET A on A.MAPPED_ID = M.ID and A.ASSET_TYPE_ID = 5
JOIN ASSET_DATA_5 AD on AD.ID = A.ASSET_DATA_ID
JOIN ASSET_DATA_5 AD2 on AD2.FIELD_10014 =
(SELECT SERVICE_TAG FROM DELL_ASSET
JOIN ASSET_DATA_5 on ASSET_DATA_5.FIELD_10014 = DELL_ASSET.SERVICE_TAG
WHERE DELL_ASSET.SERVICE_TAG != M.BIOS_SERIAL_NUMBER
and DELL_ASSET.ORDER_NUMBER = DA.ORDER_NUMBER
and ASSET_DATA_5.FIELD_10013 is not null
LIMIT 1 )
WHERE AD.FIELD_10013 is null
and AD2.FIELD_10013 is not null
and AD2.FIELD_10013 != "0000-00-00"
GROUP BY M.ID
