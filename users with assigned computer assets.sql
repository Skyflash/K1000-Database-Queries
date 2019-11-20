SELECT USER.USER_NAME, USER.FULL_NAME, USER.EMAIL,
COUNT(M.ID) as ComputersCount,
GROUP_CONCAT(M.NAME) as Computers
FROM ASSET
LEFT JOIN USER on USER.ID = ASSET.OWNER_ID
LEFT JOIN MACHINE M on M.ID = ASSET.MAPPED_ID and ASSET_TYPE_ID = 5
WHERE 
ASSET_TYPE_ID = 5
and OWNER_ID != 0
and USER.USER_NAME not like '%computer'

GROUP BY OWNER_ID
HAVING ComputersCount >= 1
ORDER BY USER.USER_NAME