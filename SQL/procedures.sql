create or replace PROCEDURE add_repair_job ( 
    p_repair_id IN repair_job.repair_id%TYPE, 
    p_date_of_service IN repair_job.date_of_service%TYPE, 
    p_phone_number IN customer.phone_number%TYPE, 
    p_machine_id IN service_item.item_id%TYPE, 
    p_type_of_service IN repair_job.type_of_service%TYPE, 
    p_parts_list IN my_varray_type,
    p_out_name OUT customer.name%TYPE, 
    p_out_phone_number OUT customer.phone_number%TYPE, 
    p_out_address OUT customer.address%TYPE, 
    p_out_date_of_service OUT repair_job.date_of_service%TYPE, 
    p_out_machine_id OUT service_item.item_id%TYPE, 
    p_out_type_of_service OUT repair_job.type_of_service%TYPE,
    p_out_service_item_covered OUT VARCHAR, 
    p_out_itemised_charges OUT repair_job.itemised_bill%TYPE)
AS
    var_device_type service_item.device_type%TYPE;
    var_rate fee.rate%TYPE;
    var_count NUMBER;
    var_labour_rate NUMBER;
    var_total NUMBER;
    var_itemised_bill repair_job.itemised_bill%TYPE;
    var_service_item_covered VARCHAR(3);
BEGIN
    DBMS_OUTPUT.PUT_LINE('**************');
    var_total:=0;

    -- select to get active status from service_contract
    SELECT COUNT(*) INTO var_count FROM service_contract WHERE p_machine_id = contract_id and status = 'active';

    -- select to get device_type from inventory info using item_id passed by user
    select device_type into var_device_type from service_item where p_machine_id = item_id and rownum = 1;

    -- select to get labour rate
    select rate into var_labour_rate from fee where type_of_service = 'labour' and var_device_type = device and rownum = 1;
    -- loop for summation of all parts used for repair

    -- select name, address using phone_number from customer table
    SELECT name, address INTO p_out_name, p_out_address FROM customer WHERE phone_number = p_phone_number;

    FOR i IN 1..p_parts_list.COUNT LOOP
        -- select to get price of each part from fee table
        select rate into var_rate from fee where p_type_of_service = type_of_service and p_parts_list(i) = device and rownum = 1;

        var_itemised_bill := var_itemised_bill || p_parts_list(i) ||':' || var_rate || ','; 
        var_total := var_total + var_rate;
        DBMS_OUTPUT.PUT_LINE('The rate for part: ' || p_parts_list(i) || ' is ' || var_rate);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('The total bill is: ' || var_total);

    -- If count is = 0 then contract is not active include labour charges
    if var_count = 0 THEN
        var_service_item_covered := 'no';
        var_total := var_total + var_labour_rate;
        var_itemised_bill := var_itemised_bill || 'labour' ||':' || var_labour_rate || ','; 
        DBMS_OUTPUT.PUT_LINE('The labour rate is ' || var_labour_rate);
        DBMS_OUTPUT.PUT_LINE('Not in Contract the total rate with labour is ' || var_total);
    ELSE
        var_service_item_covered := 'yes';
        DBMS_OUTPUT.PUT_LINE('In Contract the total rate is ' || var_total);
    END IF;    
    DBMS_OUTPUT.PUT_LINE('Itemised Bill: ' || var_itemised_bill);

    -- insert into repair_job
    INSERT INTO repair_job (repair_id, bill, itemised_bill, date_of_service, phone_number, machine_id, type_of_service) VALUES (p_repair_id, var_total, var_itemised_bill, p_date_of_service, p_phone_number, p_machine_id, p_type_of_service);

    --Loading all remaining values that are not loaded in any sql statements
    p_out_phone_number := p_phone_number;
    p_out_date_of_service := SYSDATE;
    p_out_machine_id := p_machine_id;
    p_out_type_of_service := p_type_of_service;
    p_out_service_item_covered := var_service_item_covered;
    p_out_itemised_charges := var_itemised_bill;
    
    --printing all output values
    DBMS_OUTPUT.PUT_LINE('**** Priniting all add_repair_job output values ****');
    DBMS_OUTPUT.PUT_LINE('Name: ' || p_out_name);
    DBMS_OUTPUT.PUT_LINE('Phone Number: ' || p_out_phone_number);
    DBMS_OUTPUT.PUT_LINE('Address: ' || p_out_address);
    DBMS_OUTPUT.PUT_LINE('Date of Service: ' || p_out_date_of_service);
    DBMS_OUTPUT.PUT_LINE('Machine Id: ' || p_out_machine_id);
    DBMS_OUTPUT.PUT_LINE('Type of Service: ' || p_out_type_of_service);
    DBMS_OUTPUT.PUT_LINE('Service Item Covered: ' || p_out_service_item_covered);
    DBMS_OUTPUT.PUT_LINE('Itemised Charges: ' || p_out_itemised_charges);

END;

SET SERVEROUTPUT ON
-- Running Procedure
DECLARE
    var_name customer.name%TYPE;
    var_phone_number customer.phone_number%TYPE;
    var_address customer.address%TYPE;
    var_date_of_service repair_job.date_of_service%TYPE;
    var_machine_id service_item.item_id%TYPE;
    var_type_of_service repair_job.type_of_service%TYPE;
    var_service_item_covered varchar(3);
    var_itemised_charges repair_job.itemised_bill%TYPE;
BEGIN
    -- In contract
    add_repair_job(1, '08-03-2023', '0874559138', 3, 'hardware', my_varray_type('powercable', 'processor'),var_name, var_phone_number, var_address, var_date_of_service, var_machine_id, var_type_of_service, var_service_item_covered, var_itemised_charges);
    -- Not in contract
    add_repair_job(2, '08-03-2023', '0874559138', 112, 'hardware', my_varray_type('powercable'),var_name, var_phone_number, var_address, var_date_of_service, var_machine_id, var_type_of_service, var_service_item_covered, var_itemised_charges);
    -- Printing all output values
    DBMS_OUTPUT.PUT_LINE('**** Priniting all output values ****');
    DBMS_OUTPUT.PUT_LINE('Name: ' || var_name);
    DBMS_OUTPUT.PUT_LINE('Phone Number: ' || var_phone_number);
    DBMS_OUTPUT.PUT_LINE('Address: ' || var_address);
    DBMS_OUTPUT.PUT_LINE('Date of Service: ' || var_date_of_service);
    DBMS_OUTPUT.PUT_LINE('Machine Id: ' || var_machine_id);
    DBMS_OUTPUT.PUT_LINE('Type of Service: ' || var_type_of_service);
    DBMS_OUTPUT.PUT_LINE('Service Item Covered: ' || var_service_item_covered);
    DBMS_OUTPUT.PUT_LINE('Itemised Charges: ' || var_itemised_charges);
END;