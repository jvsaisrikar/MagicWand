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
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('1', 'desktop', '2015', 'LG', 'model1');
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('2', 'laptop', '2018', 'Dell', 'model2');
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('3', 'printer', '2019', 'HP', 'model3');
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('4', 'desktop', '2017', 'Lenovo', 'model4');
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('5', 'laptop', '2020', 'Apple', 'model5');
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('6', 'printer', '2016', 'Canon', 'model6');
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('7', 'desktop', '2019', 'Acer', 'model7');
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('8', 'laptop', '2018', 'Asus', 'model8');
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('9', 'printer', '2021', 'Brother', 'model9');
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('10', 'desktop', '2016', 'HP', 'model10');
---- Numbers above 100 are not in service contract
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('111', 'laptop', '2018', 'Dell', 'model2');
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('112', 'printer', '2019', 'HP', 'model3');
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('113', 'desktop', '2017', 'Lenovo', 'model4');
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('114', 'laptop', '2020', 'Apple', 'model5');
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('115', 'printer', '2016', 'Canon', 'model6');
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('116', 'desktop', '2019', 'Acer', 'model7');
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('117', 'laptop', '2018', 'Asus', 'model8');
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('119', 'printer', '2021', 'Brother', 'model9');
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('110', 'desktop', '2016', 'HP', 'model10');


--Repair Job
-- For repair job entries might not be in SYNC with here delting and adding directly in backend for testing
-- In Contract
INSERT INTO repair_job (repair_id, bill, itemised_bill, date_of_service, phone_number, machine_id, type_of_service) VALUES (1, 100, 'powercable:50,processor:50,', '03-03-2023', 0874559138, 1, 'hardware');
INSERT INTO repair_job (repair_id, bill, itemised_bill, date_of_service, phone_number, machine_id, type_of_service) VALUES (3, 112, 'powercable:50,processor:50,heatsink:12', '04-03-2023', 0874559138, 1, 'hardware');