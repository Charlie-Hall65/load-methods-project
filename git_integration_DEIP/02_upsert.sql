

create or replace procedure upsert_test_table(
    main_table varchar(255),
    secondary_table varchar(255)
)
language plpgsql --Need plpgsql to use execute format and exception handling
as $$
begin
    --Updates existing records in the main table with values from the secondary table where the IDs match
    execute format('UPDATE %s m 
    SET name = s.name, 
    job_title = s.job_title 
    FROM %s s 
    WHERE m.id = s.id', main_table, secondary_table);
    
    --Inserts new records from the secondary table into the main table where the IDs do not exist in the main table
    execute format('INSERT INTO %s (id, name, job_title)
    SELECT s.id, s.name, s.job_title
    FROM %s s
    LEFT JOIN %s m ON s.id = m.id
    WHERE m.id IS NULL', main_table, secondary_table, main_table);

    --Add audit log entry for the upsert operation
    INSERT INTO audit.audit_log (table_name, operation, timestamp, success, error_message)
    VALUES (main_table, 'UPSERT', now(), true, null);
exception when others then
    INSERT INTO audit.audit_log (table_name, operation, timestamp, success, error_message)
    VALUES (main_table, 'UPSERT', now(), false, SQLERRM);
end;
$$;

--upsert test
select * from staging.upsert_target;
select * from landing.upsert_source;
call upsert_test_table('staging.upsert_target', 'landing.upsert_source');
select * from staging.upsert_target;
select * from landing.upsert_source;

