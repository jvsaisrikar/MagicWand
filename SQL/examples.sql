-- Sample Procedure
CREATE OR REPLACE PROCEDURE insert_data(
    p_number IN NUMBER,
    p_name IN VARCHAR2,
    p_address IN VARCHAR2
)
AS
BEGIN
    INSERT INTO CUSTOMER (phone_number, name, address) VALUES (p_number, p_name, p_address);
    COMMIT;
END;

-- Running Procedure
BEGIN
    insert_data(16, 'John Doe', '123 Main St');
END;



--Trigger which we DIDN'T use
create trigger entry_contract_deleted (
    after update of status
    on service_contract 
    for each row 
    when (new.status='Inactive')
    begin
        insert into contract_deleted(new.name, new.address, new.phone_number, new.end_date)
    
);