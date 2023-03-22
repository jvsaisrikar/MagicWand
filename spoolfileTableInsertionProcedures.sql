SPOOL /Users/saisrikar/Projects/MagicWand/spoolfileOutputTableInsertionProcedures.txt

-- Table 1 customer Form
create table customer (
    phone_number number not null primary key,
    name varchar(30) not null,
    address varchar(30) not null
);

-- Table 2 service_contract Form
-- contract status: Active/Inactive
-- when contract is Terminated end date should be changed, this same end date will be used in contract_deleted table.
create table service_contract (
    contract_id number not null primary key,
    start_date date not null,
    end_date date not null,
    status varchar(10) not null,
    phone_number number not null,
    constraint FK_service_contract foreign key (phone_number) references customer(phone_number)
);

-- Table 3 contract_deleted
create table contract_deleted (
    name varchar(30) not null,
    address varchar(30) not null,
    phone_number number not null,
    date_of_cancellation date not null
);

-- Table 4 service_item Form
create table service_item (
    item_id number not null primary key,
    device_type varchar(15) not null,
    "year" number not null,
    make varchar(20) not null,
    "model" varchar(20) not null
);

-- Table 5 repair_job Form
create table repair_job (
    repair_id number not null primary key,
    bill number not null,
    itemised_bill varchar(100) not null,
    date_of_service date not null,
    phone_number number not null,
    machine_id number not null,
    type_of_service varchar(20) not null,
    constraint FK_repair_job foreign key (phone_number) references customer(phone_number),
    constraint FK_repair_job1 foreign key (machine_id) references service_item(item_id)
);

-- Table 6 Fee
CREATE TABLE Fee (
    device varchar(15) not null,
    rate number not null,
    type_of_service varchar(15) not null CHECK (type_of_service IN ('hardware', 'software', 'labour'))
);

-- Table 7 Monitor Form
CREATE TABLE Monitor (
  monitor_id NUMBER NOT NULL PRIMARY KEY,
  "size" NUMBER NOT NULL,
  "year" DATE NOT NULL,
  CONSTRAINT fk_service_item
    FOREIGN KEY (monitor_id)
    REFERENCES service_item (item_id)
);

-- Below is the Sample Data for few tables.
-- some data is added from UI.
-- adding some data directly here for few tables as we are creating those tables newly above to show output for spool file; even though we add it from UI.
-- some data is added using procedures mentioned below.
-- Customer Data
INSERT INTO CUSTOMER (name,phone_number,address) VALUES ('Fay Henderson','0874559138','629-8745 Convallis Road');
INSERT INTO CUSTOMER (name,phone_number,address) VALUES ('Jackson Combs','0257792152','Ap #852-5409 Lacus. St.');
INSERT INTO CUSTOMER (name,phone_number,address) VALUES ('Yoko Rivera','0239363595','P.O. Box 703, 9964 Fusce St.');
INSERT INTO CUSTOMER (name,phone_number,address) VALUES ('Margaret Chambers','0209889102','929-6487 Vivamus Rd.');
INSERT INTO CUSTOMER (name,phone_number,address) VALUES ('Dorothy Madden','0560246527','201-7082 Dolor Av.');
INSERT INTO CUSTOMER (name,phone_number,address) VALUES ('Hector Scott','0837364289','Ap #590-6330 Aliquet. St.');
INSERT INTO CUSTOMER (name,phone_number,address) VALUES ('Ashley Martinez','0784329857','P.O. Box 315, 9643 Integer Rd.');
INSERT INTO CUSTOMER (name,phone_number,address) VALUES ('Clifford Nguyen','0861234567','Ap #123-4567 Egestas Rd.');


-- Service Contract
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('1','01-04-2022','01-04-2023','active','0874559138');
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('2','01-05-2022','01-05-2023','active','0874559138');
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('3','01-06-2022','01-06-2023','active','0874559138');
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('4','01-06-2022','01-06-2023','active','0257792152');
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('5','01-07-2022','01-07-2023','active','0239363595');
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('6','01-08-2022','01-08-2023','active','0209889102');
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('7','01-09-2022','01-09-2023','active','0209889102');
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('8','01-10-2022','01-10-2023','active','0560246527');
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('9','01-11-2022','01-11-2023','active','0874559138');
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('10','01-03-2022','01-03-2023','active','0239363595');


--Fee
-- no rate hardware and software
INSERT INTO FEE(device,rate,type_of_service) values ('desktop',15,'hardware');
INSERT INTO FEE(device,rate,type_of_service) values ('laptop',10,'hardware');
INSERT INTO FEE(device,rate,type_of_service) values ('desktop',15,'software');
INSERT INTO FEE(device,rate,type_of_service) values ('laptop',10,'software');
INSERT INTO FEE(device,rate,type_of_service) values ('printer',5,'hardware');
-- Parts Cost
INSERT INTO FEE(device,rate,type_of_service) values ('powercable', 7, 'hardware');
INSERT INTO FEE(device,rate,type_of_service) values ('harddrive', 30, 'hardware');
INSERT INTO FEE(device,rate,type_of_service) values ('heatsink', 12, 'hardware');
INSERT INTO FEE(device,rate,type_of_service) values ('processor', 100, 'hardware');
-- Labour Cost (For case which are not in contract)
INSERT INTO FEE(device,rate,type_of_service) values ('desktop',20,'labour');
INSERT INTO FEE(device,rate,type_of_service) values ('laptop',25,'labour');
INSERT INTO FEE(device,rate,type_of_service) values ('printer',15,'labour');
-- Software Cost
INSERT INTO FEE(device,rate,type_of_service) values ('antivirus', 10, 'software');
INSERT INTO FEE(device,rate,type_of_service) values ('microsoft', 15, 'software');
INSERT INTO FEE(device,rate,type_of_service) values ('gta5', 20, 'software');

-- Service Item //This is a inventory if the item_id here matches with contractId and Contract status is active it is part of Contract, if no match not part of contract.
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('1', 'desktop', '2015', 'LG', 'model1');
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('2', 'laptop', '2018', 'Dell', 'model2');
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('3', 'printer', '2019', 'HP', 'model3');
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('4', 'desktop', '2017', 'Lenovo', 'model4');
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('5', 'laptop', '2020', 'Apple', 'model5');
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('6', 'printer', '2016', 'Canon', 'model6');
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('7', 'desktop', '2019', 'Acer', 'model7');
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('8', 'laptop', '2018', 'Asus', 'model8');
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('9', 'printer', '2021', 'Brother', 'model9');
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('10', 'desktop', '2016', 'HP', 'model10');
---- Numbers above 100 are not in service contract
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('111', 'laptop', '2018', 'Dell', 'model2');
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('112', 'printer', '2019', 'HP', 'model3');
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('113', 'desktop', '2017', 'Lenovo', 'model4');
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('114', 'laptop', '2020', 'Apple', 'model5');
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('115', 'printer', '2016', 'Canon', 'model6');
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('116', 'desktop', '2019', 'Acer', 'model7');
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('117', 'laptop', '2018', 'Asus', 'model8');
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('119', 'printer', '2021', 'Brother', 'model9');
INSERT INTO service_item(item_id, device_type, "year", make, "model") VALUES ('110', 'desktop', '2016', 'HP', 'model10');


--Repair Job
-- For repair job entries might not be in SYNC with here deleting and adding directly in backend for testing
-- In Contract
INSERT INTO repair_job (repair_id, bill, itemised_bill, date_of_service, phone_number, machine_id, type_of_service) VALUES (1, 100, 'powercable:50,processor:50,', '03-03-2023', 0874559138, 1, 'hardware');
INSERT INTO repair_job (repair_id, bill, itemised_bill, date_of_service, phone_number, machine_id, type_of_service) VALUES (3, 112, 'powercable:50,processor:50,heatsink:12', '04-03-2023', 0874559138, 1, 'hardware');
-- without contract
INSERT INTO repair_job (repair_id, bill, itemised_bill, date_of_service, phone_number, machine_id, type_of_service) VALUES (4, 50, 'antivirus:10,microsoft:15,labour:25', '22-03-2023', 0874559138, 117, 'software');

-- Procedures in Page 3 Some implementation specifics, are covered in a-g procedures files
-- These procedures are being directly called python code as we are using the UI. 

-- a) Creating customers and at least three service contracts. One of the service contracts should include multiple service items (a laptop, desktop etc).
-- Insertion of the data is done through the UI so the given constraints can be satisfied by submitting the data from the form.
CREATE OR REPLACE PROCEDURE service_contract_data(
    p_contract_id IN NUMBER,
    p_start_date IN DATE,
    p_end_date IN DATE,
    p_status IN VARCHAR2,
    p_phone_number IN NUMBER
)
AS
BEGIN
    INSERT INTO service_contract(contract_id, start_date, end_date, status, phone_number)
    VALUES (p_contract_id, p_start_date, p_end_date, p_status, p_phone_number);
    COMMIT;
END;
/

-- b) Creating at least two repair jobs, where one repair job has a repair item that is included in a service contract and one repair job that has a repair item with no service contract.
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
/

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
/

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
/

-- e) Display a repair job. This should include all the information about customer, each repair item and the itemized bill.
CREATE OR REPLACE PROCEDURE display_repair_job (
  p_repair_id IN repair_job.repair_id%TYPE,
  p_out_customer_name OUT customer.name%TYPE,
  p_out_phone_number OUT customer.phone_number%TYPE,
  p_out_customer_address OUT customer.address%TYPE,
  p_out_device_type OUT service_item.device_type%TYPE,
  p_out_make OUT service_item.make%TYPE,
  p_out_model OUT service_item."model"%TYPE,
  p_out_year OUT service_item."year"%TYPE,
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
  SELECT si.device_type, si.make, si."model", si."year"
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

-- f) Display the number of active service contracts and the total revenue generated each month by these contracts.
CREATE OR REPLACE PROCEDURE display_all_active_service_contract_revenue (
    p_cursor OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cursor FOR
    SELECT 
    EXTRACT(year FROM rj.date_of_service) year,
    EXTRACT(month FROM rj.date_of_service) month, 
    COUNT(rj.repair_id) AS active_contract_count, 
    SUM(rj.bill) AS total_revenue 
    FROM service_contract sc 
    JOIN service_item si ON sc.contract_id = si.item_id
    JOIN repair_job rj ON si.item_id = rj.machine_id
    WHERE sc.status = 'active'
    GROUP BY EXTRACT(YEAR FROM rj.date_of_service),
    EXTRACT(MONTH FROM rj.date_of_service)
ORDER BY year DESC, month;
END;
/

--g) Display the total revenue generated in a specific month by all the repair jobs.
CREATE OR REPLACE PROCEDURE get_total_repair_job_revenue_specified_month_year(
    p_month IN NUMBER,
    p_year IN NUMBER,
    p_total_revenue OUT NUMBER
)
IS
BEGIN
    SELECT SUM(bill) INTO p_total_revenue
    FROM repair_job_view
    WHERE EXTRACT(MONTH FROM date_of_service) = p_month
    AND EXTRACT(YEAR FROM date_of_service) = p_year;
END;
/

-- extra credit
-- extra credit feature, to display the average bill in repair job
CREATE OR REPLACE PROCEDURE get_avg_repair_bill (
    p_out_avg_bill OUT repair_job.bill%TYPE
) AS
BEGIN
    SELECT AVG(bill) INTO p_out_avg_bill FROM repair_job_bill;
END;
/

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
/

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
/

SPOOL OFF;