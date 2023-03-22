-- extra credit feature, to display the average bill in repair job
CREATE OR REPLACE PROCEDURE get_avg_repair_bill (
    p_out_avg_bill OUT repair_job.bill%TYPE
) AS
BEGIN
    SELECT AVG(bill) INTO p_out_avg_bill FROM repair_job_bill;
END;