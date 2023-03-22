--c) Display a service contract by contract id.
CREATE OR REPLACE PROCEDURE display_service_contract_by_id (
    p_contract_id IN service_contract.contract_id%TYPE,
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR 
    SELECT * FROM service_contract WHERE contract_id = p_contract_id;
    
    EXCEPTION
		WHEN NO_DATA_FOUND THEN
		     RAISE_APPLICATION_ERROR(-20001, 'Invalid contract ID');
END;