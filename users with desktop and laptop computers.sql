-- Some of our users have desktop and laptop computers, this report finds them
-- (assuming the computers were named according to our naming policy)
SELECT M2.NAME AS LAPTOP, M2.LAST_SYNC AS LAPTOP_LASTSYNC, M.NAME AS DESKTOP,M.LAST_SYNC as DESKTOP_LASTSYNC

FROM MACHINE M
JOIN MACHINE M2 on M2.NAME like concat(M.NAME, '%') and M2.NAME != M.NAME

WHERE M2.NAME like "%-nb%"

ORDER BY M.NAME
