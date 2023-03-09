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
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('1','01-03-2023','01-03-2024','active','0874559138');
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('2','30-03-2023','01-03-2024','active','0874559138');
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('3','30-04-2023','30-04-2024','active','0874559138');
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('4','30-05-2023','01-05-2024','active','0257792152');
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('5','30-06-2023','30-03-2024','active','0239363595');
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('6','10-07-2023','10-07-2024','active','0209889102');
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('7','10-07-2023','10-07-2024','active','0209889102');
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('8','10-07-2023','10-07-2024','active','05602465271');
INSERT INTO service_contract (contract_id,start_date,end_date,status,phone_number) VALUES ('9','30-03-2023','30-03-2024','active','0874559138');

--Fee
-- no rate hardware and software
INSERT INTO FEE(device,rate,type_of_service) values ('desktop',15,'hardware');
INSERT INTO FEE(device,rate,type_of_service) values ('laptop',10,'hardware');
INSERT INTO FEE(device,rate,type_of_service) values ('desktop',15,'software');
INSERT INTO FEE(device,rate,type_of_service) values ('laptop',10,'software');
INSERT INTO FEE(device,rate,type_of_service) values ('printer',5,'hardware');


-- Service Item //This is a inventory if the item_id here matches with contractId and Contract status is active it is part of Contract, if no match not part of contract.
INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('1', 'desktop', '2015', 'LG', 'model1');INSERT INTO service_item(item_id, device_type, year, make, model) VALUES ('2', 'laptop', '2018', 'Dell', 'model2');
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