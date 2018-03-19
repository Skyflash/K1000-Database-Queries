-- Request on ITNinja site
SELECT USER.USER_NAME, W.HD_TICKET_ID, SUM(TIMESTAMPDIFF(HOUR, W.START, W.STOP)) as "Work Hours",
SUM(ADJUSTMENT_HOURS) AS "Adjustment Hours"
FROM ORG1.HD_WORK W
JOIN USER on W.USER_ID = USER.ID
WHERE W.STOP > DATE_SUB(NOW(), INTERVAL 7 DAY)
GROUP BY W.HD_TICKET_ID
