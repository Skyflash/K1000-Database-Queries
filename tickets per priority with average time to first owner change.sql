SELECT 
Q.NAME, P.NAME, COUNT(T.ID), AVG(TIMEDIFF(C.TIMESTAMP, T.CREATED)), TIME_FORMAT(SEC_TO_TIME(AVG(TIMEDIFF(C.TIMESTAMP, T.CREATED))),"%H:%i:%s")
FROM HD_TICKET T
JOIN HD_TICKET_CHANGE C on C.HD_TICKET_ID = T.ID 
JOIN HD_TICKET_CHANGE_FIELD CF on CF.HD_TICKET_CHANGE_ID = C.ID AND FIELD_CHANGED = "OWNER_ID" and CF.BEFORE_VALUE = 0
JOIN HD_TICKET_CHANGE_FIELD A on A.HD_TICKET_CHANGE_ID = C.ID AND FIELD_CHANGED = "APPROVAL" and CF.AFTER_VALUE = "approved"
JOIN HD_PRIORITY P on P.ID = T.HD_PRIORITY_ID
JOIN HD_QUEUE Q on Q.ID = T.HD_QUEUE_ID
WHERE
T.CREATED > NOW() - INTERVAL 31 DAY
GROUP BY P.ID
ORDER BY Q.NAME, P.NAME