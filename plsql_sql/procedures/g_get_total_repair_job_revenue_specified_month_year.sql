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

