-- g) Display the total revenue generated in a specific month by all the repair jobs.
-- creating a view for above g to hide all unrequired coloums
CREATE OR REPLACE VIEW repair_job_view AS
SELECT bill, date_of_service, repair_id as primary_key
FROM repair_job;

-- extra credit, get average bill 
CREATE VIEW repair_job_bill AS
SELECT bill
FROM repair_job;