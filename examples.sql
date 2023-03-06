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


--Adding this line