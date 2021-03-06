-- Patches per computer patched and not patched
-- for patches in a given label
-- includes count and titles of patches
-- Poasted as solution for https://www.itninja.com/question/patch-report-request


Select M.NAME as MACHINE_NAME, SUM(MS.STATUS='PATCHED') AS PATCHED, 
SUM(MS.STATUS='NOTPATCHED') AS NOT_PATCHED,
GROUP_CONCAT(CASE WHEN MS.STATUS = 'PATCHED' THEN PP.TITLE END) AS 'Titles Patched',
GROUP_CONCAT(CASE WHEN MS.STATUS = 'NOTPATCHED' THEN PP.TITLE END) AS 'Titles Not Patched'

FROM ORG1.PATCHLINK_MACHINE_STATUS MS 
JOIN ORG1.MACHINE M ON M.ID = MS.MACHINE_ID 
JOIN KBSYS.PATCHLINK_PATCH PP ON PP.UID = MS.PATCHUID 
JOIN PATCHLINK_PATCH_STATUS PPS ON PPS.PATCHUID = PP.UID 
JOIN PATCHLINK_PATCH_LABEL_JT ON PATCHLINK_PATCH_LABEL_JT.PATCHUID = PP.UID
JOIN LABEL ON LABEL.ID = PATCHLINK_PATCH_LABEL_JT.LABEL_ID
where PPS.STATUS = 0 /* 0=active patches */ 
AND LABEL.NAME = "Adobe Patches" 
group by MACHINE_NAME
order by MACHINE_NAME, PP.TITLE