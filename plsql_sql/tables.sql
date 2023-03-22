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
-- Asumptions:
This is same
Table service_contract    repair_job      service_item
      contract_id =       machine_id =    item_id
