CREATE PROCEDURE add_repair_job (p_repair_id IN INT, p_date_of_service IN DATE, p_phone_number IN NUMBER, p_machine_id IN INT, p_type_of_service IN VARCHAR)    
AS
    var_contract_status varchar(10);
    var_device_type varchar(15);
    var_rate number;
BEGIN
    select status into var_contract_status from service_contract where p_machine_id = contract_id and rownum = 1;
    select device_type into var_device_type from service_item where p_machine_id = item_id and rownum = 1;
    if var_contract_status = 'active' THEN
        select rate into var_rate from fee where p_type_of_service = type_of_service and var_device_type = device and rownum = 1;
        DBMS_OUTPUT.PUT_LINE('The rate is ' || var_rate);
    END IF;    
       
    DBMS_OUTPUT.PUT_LINE('The value of contract_status is ' || var_contract_status);
    
    --INSERT INTO RepairJobs (repair_id, bill, date_of_service, phone_number, machine_id, type_of_service) VALUES (p_repair_id, p_bill, p_date_of_service, p_phone_number, p_machine_id, p_type_of_service);

END;

-- To Run add_repair_job
SET SERVEROUTPUT ON
-- Running Procedure
BEGIN
    add_repair_job(1, '08-03-2023', '0874559138', 3, 'hardware');
END;


