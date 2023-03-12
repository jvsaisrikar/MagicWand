-- To Run Procedure Repair Job
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
    var_total_bill repair_job.bill%TYPE;
BEGIN
    -- In contract
    add_repair_job(1, '10-11-22', '0874559138', 3, 'hardware', my_varray_type('powercable', 'processor'),var_name, var_phone_number, var_address, var_date_of_service, var_machine_id, var_type_of_service, var_service_item_covered, var_itemised_charges, var_total_bill);
    -- Not in contract
    add_repair_job(2, '11-12-22', '0874559138', 112, 'hardware', my_varray_type('powercable'),var_name, var_phone_number, var_address, var_date_of_service, var_machine_id, var_type_of_service, var_service_item_covered, var_itemised_charges, var_total_bill);
    --- In contract but no inbetween start date and end date  
    add_repair_job(10, '12-03-23', '0239363595', 10, 'hardware', my_varray_type('powercable'),var_name, var_phone_number, var_address, var_date_of_service, var_machine_id, var_type_of_service, var_service_item_covered, var_itemised_charges, var_total_bill);
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
    DBMS_OUTPUT.PUT_LINE('Total Bill: ' || var_total_bill);
END;

-------------
SAMPLE OUTPUT 
-------------
**************
The rate for part: powercable is 7
The rate for part: processor is 100
The total bill is: 107
In Contract the total rate is 107
Itemised Bill: powercable:7,processor:100,
**** Priniting all add_repair_job output values ****
Name: Fay Henderson
Phone Number: 874559138
Address: 629-8745 Convallis Road
Date of Service: 10-11-22
Machine Id: 3
Type of Service: hardware
Service Item Covered: yes
Itemised Charges: powercable:7,processor:100,
Total Bill: 107
**************
The rate for part: powercable is 7
The total bill is: 7
The labour rate is 15
Not in Contract the total rate with labour is 22
Itemised Bill: powercable:7,labour:15,
**** Priniting all add_repair_job output values ****
Name: Fay Henderson
Phone Number: 874559138
Address: 629-8745 Convallis Road
Date of Service: 11-12-22
Machine Id: 112
Type of Service: hardware
Service Item Covered: no
Itemised Charges: powercable:7,labour:15,
Total Bill: 22
**************
Repair job request not in between contract date startdate and enddate autoclosing contract marking status Inactive
The rate for part: powercable is 7
The total bill is: 7
The labour rate is 20
Not in Contract the total rate with labour is 27
Itemised Bill: powercable:7,labour:20,
**** Priniting all add_repair_job output values ****
Name: Yoko Rivera
Phone Number: 239363595
Address: P.O. Box 703, 9964 Fusce St.
Date of Service: 12-03-23
Machine Id: 10
Type of Service: hardware
Service Item Covered: no
Itemised Charges: powercable:7,labour:20,
Total Bill: 27
**** Priniting all output values ****
Name: Yoko Rivera
Phone Number: 239363595
Address: P.O. Box 703, 9964 Fusce St.
Date of Service: 12-03-23
Machine Id: 10
Type of Service: hardware
Service Item Covered: no
Itemised Charges: powercable:7,labour:20,
Total Bill: 27


-- *************************************************************************************


--c) Sample Input to display a service contract by contract id.
SET SERVEROUTPUT ON
DECLARE
v_cursor SYS_REFCURSOR;
--sample contractID here
v_contract_id service_contract.contract_id%TYPE := 1;
contract_id service_contract.contract_id%TYPE;
start_date service_contract.start_date%TYPE;
end_date service_contract.end_date%TYPE;
status service_contract.status%TYPE;
phone_number service_contract.phone_number%TYPE;
BEGIN
display_service_contract_by_id(p_contract_id => v_contract_id, p_cursor => v_cursor);
LOOP
FETCH v_cursor INTO contract_id, start_date, end_date, status, phone_number;
EXIT WHEN v_cursor%NOTFOUND;
-- Print the results
DBMS_OUTPUT.PUT_LINE('Contract Details:');
DBMS_OUTPUT.PUT_LINE('******************');
DBMS_OUTPUT.PUT_LINE('Contract ID: ' || contract_id);
DBMS_OUTPUT.PUT_LINE('Start Date: ' || start_date);
DBMS_OUTPUT.PUT_LINE('End Date: ' || end_date);
DBMS_OUTPUT.PUT_LINE('Status: ' || status);
DBMS_OUTPUT.PUT_LINE('Phone Number: ' || phone_number);
END LOOP;
-- Close the cursor
CLOSE v_cursor;
END;
/

---------------
SAMPLE OUTPUT C
---------------

Contract Details:
******************
Contract ID: 1
Start Date: 01-04-22
End Date: 01-04-23
Status: active
Phone Number: 874559138

-- *************************************************************************************

-- d) Sample Input to  display all the service contracts for a specific customer (by phone)
DECLARE
    v_cursor SYS_REFCURSOR;
    v_phone_number customer.phone_number%TYPE := '0874559138';
    contract_id service_contract.contract_id%TYPE;
    start_date service_contract.start_date%TYPE;
    end_date service_contract.end_date%TYPE;
    status service_contract.status%TYPE;
    phone_number service_contract.phone_number%TYPE;
BEGIN
    display_all_service_contracts_by_customer(p_phone_number => v_phone_number, p_cursor => v_cursor);
    -- Print the results
    DBMS_OUTPUT.PUT_LINE('Printing Service Contracts:');
    LOOP
        FETCH v_cursor INTO contract_id, start_date, end_date, status, phone_number; 
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('*******************');
        DBMS_OUTPUT.PUT_LINE('Contract ID: ' || contract_id);
        DBMS_OUTPUT.PUT_LINE('Start Date: ' || start_date);
        DBMS_OUTPUT.PUT_LINE('End Date: ' || end_date);
        DBMS_OUTPUT.PUT_LINE('Status: ' || status);
        DBMS_OUTPUT.PUT_LINE('Phone Number: ' || phone_number);
    END LOOP;
    -- Close the cursor
    CLOSE v_cursor;
END;
/

---------------
SAMPLE OUTPUT D
---------------

Printing Service Contracts:
*******************
Contract ID: 1
Start Date: 01-04-22
End Date: 01-04-23
Status: active
Phone Number: 874559138
*******************
Contract ID: 2
Start Date: 01-05-22
End Date: 01-05-23
Status: active
Phone Number: 874559138
*******************
Contract ID: 3
Start Date: 01-06-22
End Date: 01-06-23
Status: active
Phone Number: 874559138
*******************
Contract ID: 9
Start Date: 01-11-22
End Date: 01-11-23
Status: active
Phone Number: 874559138

-- *************************************************************************************


-- e) Display a repair job. This should include all the information about customer, each repair item and the itemized bill.
SET SERVEROUTPUT ON
DECLARE
  v_customer_name customer.name%TYPE;
  v_customer_address customer.address%TYPE;
  v_phone_number customer.phone_number%TYPE;
  v_itemised_bill repair_job.itemised_bill%TYPE;
  v_date_of_service repair_job.date_of_service%TYPE;
  v_type_of_service repair_job.type_of_service%TYPE;
  v_device_type service_item.device_type%TYPE;
  v_make service_item.make%TYPE;
  v_model service_item.model%TYPE;
  v_year service_item.year%TYPE;
BEGIN
  display_repair_job(3, v_customer_name, v_phone_number, v_customer_address, v_device_type, v_make, v_model, v_year, v_itemised_bill, v_date_of_service, v_type_of_service);
END;
/

---------------
SAMPLE OUTPUT E
---------------

**** Priniting fetched output ****
Customer Name: Fay Henderson
Phone Number: 874559138
Customer Address: 629-8745 Convallis Road
Device Type: laptop
Make: Apple
Model: model5
Year: 2020
Date of Service: 18-07-22
Type of Service: software
Repair Itemised Bill: gta5:20,labour:25,
Total Bill: 45

-- *************************************************************************************


-- f) Display the number of active service contracts and the total revenue generated each month by these contracts.
DECLARE
  c_result SYS_REFCURSOR;
  v_active_contract_count NUMBER;
  v_month NUMBER;
  v_year NUMBER;
  v_total_revenue NUMBER;
BEGIN
  display_all_active_service_contract_revenue(c_result);
  LOOP
    FETCH c_result INTO v_year, v_month, v_active_contract_count, v_total_revenue;
    EXIT WHEN c_result%NOTFOUND;
    -- Print the values
    DBMS_OUTPUT.PUT_LINE('Year: ' || v_year || ', Month: ' || v_month || ', Active Contract Count: ' || v_active_contract_count || ', Total Revenue: ' || v_total_revenue);
  END LOOP;

  -- Close the cursor
  CLOSE c_result;
END;

---------------
SAMPLE OUTPUT F
---------------

Year: 2023, Month: 3, Active Contract Count: 1, Total Revenue: 27
Year: 2022, Month: 6, Active Contract Count: 1, Total Revenue: 12
Year: 2022, Month: 11, Active Contract Count: 1, Total Revenue: 107

-- *************************************************************************************


--g) Display the total revenue generated in a specific month by all the repair jobs.
DECLARE
    v_month NUMBER := 7; 
    v_year NUMBER := 2022;
    v_total_revenue NUMBER;
BEGIN
    get_total_repair_job_revenue_specified_month_year(v_month, v_year, v_total_revenue);
    DBMS_OUTPUT.PUT_LINE('Total revenue for ' || v_month || '/' || v_year || ': $' || v_total_revenue);
END;


---------------
SAMPLE OUTPUT G
---------------

Total revenue for 7/2022: $57


-- *************************************************************************************
