-- d) Display all the service contracts for a specific customer (by phone).
CREATE OR REPLACE PROCEDURE display_all_service_contracts_by_customer (
    p_phone_number IN customer.phone_number%TYPE,
    p_cursor OUT SYS_REFCURSOR
)
IS
    store_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO store_count FROM customer WHERE phone_number = p_phone_number;
    
    IF store_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Customer not found with the given phone number enter a valid phone number');
    ELSE
        OPEN p_cursor FOR
        SELECT * FROM service_contract WHERE phone_number = p_phone_number;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'No service contracts are found');
END;

