-- f) Display the number of active service contracts and the total revenue generated each month by these contracts.
CREATE OR REPLACE PROCEDURE display_all_active_service_contract_revenue (
    p_cursor OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cursor FOR
    SELECT 
    EXTRACT(year FROM rj.date_of_service) year,
    EXTRACT(month FROM rj.date_of_service) month, 
    COUNT(rj.repair_id) AS active_contract_count, 
    SUM(rj.bill) AS total_revenue 
    FROM service_contract sc 
    JOIN service_item si ON sc.contract_id = si.item_id
    JOIN repair_job rj ON si.item_id = rj.machine_id
    WHERE sc.status = 'active'
    GROUP BY EXTRACT(YEAR FROM rj.date_of_service),
    EXTRACT(MONTH FROM rj.date_of_service)
ORDER BY year DESC, month;
END;