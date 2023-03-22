-- b) Creating at least two repair jobs, where one repair job has a repair item that is included in a service contract and one repair job that has a repair item with no service contract.
CREATE OR REPLACE PROCEDURE add_repair_job ( 
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
    p_out_itemised_charges OUT repair_job.itemised_bill%TYPE,
    p_out_total_bill OUT repair_job.bill%TYPE)
AS
    var_device_type service_item.device_type%TYPE;
    var_rate fee.rate%TYPE;
    var_count NUMBER;
    var_labour_rate NUMBER;
    var_total NUMBER;
    var_itemised_bill repair_job.itemised_bill%TYPE;
    var_service_item_covered VARCHAR(3);
    var_today DATE := SYSDATE;
    var_start_date service_contract.start_date%TYPE;
    var_end_date service_contract.end_date%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('**************');
    var_total:=0;

    -- select to get active status from service_contract
    SELECT COUNT(*) INTO var_count FROM service_contract WHERE p_machine_id = contract_id and status = 'active';

    -- corner case status active but not between contract start date and end date update status
    if var_count > 0 THEN
        -- select start_date, end_date
        SELECT start_date, end_date INTO var_start_date, var_end_date FROM service_contract WHERE contract_id = p_machine_id;

        -- Incase the current date is not in between contract startdate and end date update status to inactive
        if var_today NOT BETWEEN var_start_date AND var_end_date THEN
            -- set var_count = 0
            var_count := 0;
            UPDATE service_contract SET status = 'inactive' WHERE contract_id = p_machine_id;
            DBMS_OUTPUT.PUT_LINE('Repair job request not in between contract date startdate and enddate autoclosing contract marking status Inactive');
        END IF;
    END IF;     

    -- select to get device_type from inventory info using item_id passed by user
    select device_type into var_device_type from service_item where p_machine_id = item_id and rownum = 1;

    -- select to get labour rate
    select rate into var_labour_rate from fee where type_of_service = 'labour' and var_device_type = device and rownum = 1;

    -- select name, address using phone_number from customer table
    SELECT name, address INTO p_out_name, p_out_address FROM customer WHERE phone_number = p_phone_number;

    -- loop for summation of all parts used for repair
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
    p_out_date_of_service := p_date_of_service;
    p_out_phone_number := p_phone_number;
    p_out_machine_id := p_machine_id;
    p_out_type_of_service := p_type_of_service;
    p_out_service_item_covered := var_service_item_covered;
    p_out_itemised_charges := var_itemised_bill;
    p_out_total_bill := var_total;

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
    DBMS_OUTPUT.PUT_LINE('Total Bill: ' || p_out_total_bill);

END;