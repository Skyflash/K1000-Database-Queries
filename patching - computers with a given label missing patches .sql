Select CASE
WHEN MACHINE.SYSTEM_DESCRIPTION = ''
  THEN MACHINE.NAME
WHEN MACHINE.SYSTEM_DESCRIPTION != ''
  THEN CONCAT(MACHINE.NAME, "\\", MACHINE.SYSTEM_DESCRIPTION)
END
AS MACHINE_NAME,P.TITLE AS DISPLAY_NAME, P.IDENTIFIER as KB_ARTICLE
from PATCHLINK_MACHINE_STATUS S 
JOIN MACHINE on MACHINE.ID = S.MACHINE_ID
JOIN KBSYS.PATCHLINK_PATCH P on S.PATCHUID = P.UID
JOIN MACHINE_LABEL_JT on MACHINE_LABEL_JT.MACHINE_ID = MACHINE.ID
JOIN LABEL on LABEL.ID = MACHINE_LABEL_JT.LABEL_ID
where

S.STATUS = 'NOTPATCHED'
and LABEL.NAME = "User Services"
order by MACHINE_NAME, P.TITLE

