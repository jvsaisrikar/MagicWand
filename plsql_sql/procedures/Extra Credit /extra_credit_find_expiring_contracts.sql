-- extra credit feature, find contracts that are about to expire pass in number of days as input like(30), (80)
create or replace PROCEDURE find_expiring_contracts(
    p_interval NUMBER,
    p_cursor OUT SYS_REFCURSOR
)
IS
    current_date DATE := SYSDATE;
BEGIN
    OPEN p_cursor FOR
        SELECT *
        FROM service_contract
        WHERE status = 'active'
        AND end_date >= current_date
        AND end_date <= current_date + NUMTODSINTERVAL(p_interval, 'DAY');
END;