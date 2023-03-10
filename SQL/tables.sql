-- Table 1 customer Form
create table customer (
    phone_number number not null primary key,
    name varchar(30) not null,
    address varchar(30) not null
);

-- Table 2 service_contract Form
-- .. contract status: Active/Inactive
-- .. when contract is Terminated end date should be changed, this same end date will be used in contract_deleted table.
create table service_contract (
    contract_id number not null primary key,
    start_date date not null,
    end_date date not null,
    status varchar(10) not null,
    phone_number number not null,
    constraint FK_service_contract foreign key (phone_number) references customer(phone_number)
);

-- Table 3 contract_deleted
--Changing name and address to varchar(30) here as customer table has 30 limit
create table contract_deleted (
    name varchar(30) not null,
    address varchar(30) not null,
    phone_number number not null,
    date_of_cancellation date not null
);

-- Table 4 repair_job Form
-- changing adding machine_id as foreign key to service_item item_id, when ever a machine_id is entered as part of repair job it should exist in Service Item Table.
-- changing added itemised_bill varchar(100) not null,
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

-- Table 5 service_item Form
-- wrong in crows foot number stored as number(4) <- this doesn't exist in sql
-- wrong service_item as foreign key
-- ** This table working without quotes not sure why where as monitor doesn't work
create table service_item (
    item_id number not null primary key,
    device_type varchar(15) not null,
    "year" number not null,
    make varchar(20) not null,
    "model" varchar(20) not null
);

-- Table 6 Fee
CREATE TABLE Fee (
    device varchar(15) not null,
    rate number not null,
    type_of_service varchar(15) not null CHECK (type_of_service IN ('hardware', 'software', 'labour'))
);

-- Table 7 Monitor Form
-- ** This table doesn't work without quotes; need to check
create table Monitor (
    "model" varchar(20) not null,
    make varchar(20) not null,
    "size" number not null,
    "year" date not null
);

-- Asumptions:
This can be same
Table service_contract    repair_job      service_item
      contract_id =       machine_id =    item_id
