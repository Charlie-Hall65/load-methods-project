

create or replace procedure upsert_test_table(
    main_table varchar(255),
    secondary_table varchar(255)
)
language plpgsql
as $$
begin
    execute format('UPDATE %s m 
    SET name = s.name, 
    job_title = s.job_title 
    FROM %s s 
    WHERE m.id = s.id', main_table, secondary_table);
   
    execute format('INSERT INTO %s (id, name, job_title)
    SELECT s.id, s.name, s.job_title
    FROM %s s
    LEFT JOIN %s m ON s.id = m.id
    WHERE m.id IS NULL', main_table, secondary_table, main_table);

    INSERT INTO audit.audit_log (table_name, operation, timestamp, success, error_message)
    VALUES (main_table, 'UPSERT', now(), true, null);
exception when others then
    INSERT INTO audit.audit_log (table_name, operation, timestamp, success, error_message)
    VALUES (main_table, 'UPSERT', now(), false, SQLERRM);
end;
$$;

select * from staging.upsert_target;
select * from landing.upsert_source;
call upsert_test_table('staging.upsert_target', 'landing.upsert_source');
select * from staging.upsert_target;
select * from landing.upsert_source;

