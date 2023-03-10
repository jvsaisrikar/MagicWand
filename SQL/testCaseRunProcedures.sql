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
    add_repair_job(1, '0874559138', 3, 'hardware', my_varray_type('powercable', 'processor'),var_name, var_phone_number, var_address, var_date_of_service, var_machine_id, var_type_of_service, var_service_item_covered, var_itemised_charges);
    -- Not in contract
    add_repair_job(2, '0874559138', 112, 'hardware', my_varray_type('powercable'),var_name, var_phone_number, var_address, var_date_of_service, var_machine_id, var_type_of_service, var_service_item_covered, var_itemised_charges);
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