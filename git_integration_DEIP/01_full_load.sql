drop procedure if exists full_load;

create or replace procedure full_load(
    p_staging varchar,
    p_landing varchar
)
language plpgsql
as $$
declare
    v_rows_affected int;
begin
    execute format('TRUNCATE TABLE %s', p_staging);
    execute format('INSERT INTO %s SELECT * FROM %s', 
        p_staging, p_landing);
    
    insert into audit.audit_log (table_name, operation, timestamp, success, error_message)
    values (p_staging, 'FULL_LOAD', now(), true, null);
exception when others then
    insert into audit.audit_log (table_name, operation, timestamp, success, error_message)
    values (p_staging, 'FULL_LOAD', now(), false, SQLERRM);
end;
$$;


select * from landing.full_load_source;
select * from staging.full_load_target;
call full_load('staging.full_load_target', 'landing.full_load_source');
select * from landing.full_load_source;
select * from staging.full_load_target;