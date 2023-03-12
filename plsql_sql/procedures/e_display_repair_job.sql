-- e) Display a repair job. This should include all the information about customer, each repair item and the itemized bill.
CREATE OR REPLACE PROCEDURE display_repair_job (
  p_repair_id IN repair_job.repair_id%TYPE,
  p_out_customer_name OUT customer.name%TYPE,
  p_out_phone_number OUT customer.phone_number%TYPE,
  p_out_customer_address OUT customer.address%TYPE,
  p_out_device_type OUT service_item.device_type%TYPE,
  p_out_make OUT service_item.make%TYPE,
  p_out_model OUT service_item.model%TYPE,
  p_out_year OUT service_item.year%TYPE,
  p_out_total_bill OUT repair_job.bill%TYPE,
  p_out_itemised_bill OUT repair_job.itemised_bill%TYPE,
  p_out_date_of_service OUT repair_job.date_of_service%TYPE,
  p_out_type_of_service OUT repair_job.type_of_service%TYPE
) AS
  v_rate Fee.rate%TYPE;
  v_type_of_service Fee.type_of_service%TYPE;
BEGIN

  -- customer info
  SELECT c.name, c.phone_number, c.address
  INTO p_out_customer_name, p_out_phone_number, p_out_customer_address
  FROM customer c, repair_job rj
  WHERE c.phone_number = rj.phone_number
  AND rj.repair_id = p_repair_id;

  -- service item/inventory info
  SELECT si.device_type, si.make, si.model, si.year
  INTO p_out_device_type, p_out_make, p_out_model, p_out_year
  FROM service_item si, repair_job rj
  WHERE si.item_id = rj.machine_id
  AND rj.repair_id = p_repair_id;
 
  -- repair job details
  SELECT rj.itemised_bill, rj.bill, rj.date_of_service, rj.type_of_service
  INTO p_out_itemised_bill, p_out_total_bill, p_out_date_of_service, p_out_type_of_service
  FROM repair_job rj
  WHERE rj.repair_id = p_repair_id;

  DBMS_OUTPUT.PUT_LINE('**** Priniting fetched output ****');
  DBMS_OUTPUT.PUT_LINE('Customer Name: ' || p_out_customer_name);
  DBMS_OUTPUT.PUT_LINE('Phone Number: ' || p_out_phone_number);
  DBMS_OUTPUT.PUT_LINE('Customer Address: ' || p_out_customer_address); 
  DBMS_OUTPUT.PUT_LINE('Device Type: ' || p_out_device_type);
  DBMS_OUTPUT.PUT_LINE('Make: ' || p_out_make);
  DBMS_OUTPUT.PUT_LINE('Model: ' || p_out_model);
  DBMS_OUTPUT.PUT_LINE('Year: ' || p_out_year);
  DBMS_OUTPUT.PUT_LINE('Date of Service: ' || p_out_date_of_service);
  DBMS_OUTPUT.PUT_LINE('Type of Service: ' || p_out_type_of_service);
  DBMS_OUTPUT.PUT_LINE('Repair Itemised Bill: ' || p_out_itemised_bill);
  DBMS_OUTPUT.PUT_LINE('Total Bill: ' || p_out_total_bill);
  
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No repair job found with ID ' || p_repair_id);
END;
/