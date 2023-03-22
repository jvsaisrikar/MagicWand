-- a) Creating customers and at least three service contracts. One of the service contracts should include multiple service items (a laptop, desktop etc)
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

