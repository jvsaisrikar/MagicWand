-- extra credit feature, display customer with max repairs, favourite customer
CREATE OR REPLACE PROCEDURE max_repairs_customer(
    var_phone_number OUT customer.phone_number%TYPE,
    var_name OUT customer.name%TYPE,
    var_address OUT customer.address%TYPE,
    var_repair_count OUT NUMBER
)
AS
BEGIN
    SELECT c.phone_number, c.name, c.address, r.repair_count
    INTO var_phone_number, var_name, var_address, var_repair_count
    FROM customer c
    INNER JOIN (
        SELECT phone_number, COUNT(*) AS repair_count
        FROM repair_job
        GROUP BY phone_number
        ORDER BY repair_count DESC
        FETCH FIRST 1 ROW ONLY
    ) r ON c.phone_number = r.phone_number;
    
    DBMS_OUTPUT.PUT_LINE('**** Procedure Output ****');
    DBMS_OUTPUT.PUT_LINE('Phone Number: ' || var_phone_number);
    DBMS_OUTPUT.PUT_LINE('Name: ' || var_name);
    DBMS_OUTPUT.PUT_LINE('Address: ' || var_address);
    DBMS_OUTPUT.PUT_LINE('Repair Count: ' || var_repair_count);
END;