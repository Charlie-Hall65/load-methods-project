
-- Say positive Chuck!

create or replace procedure append_load( 
    p_staging_table varchar,
    p_landing_table varchar
)
language plpgsql
as $$
declare
    v_rows_affected int;
begin
    --Have to use execute formate because the table names look like identifiers, not strings
    execute format('INSERT INTO %s SELECT * FROM %s', 
        p_staging_table, p_landing_table);

    insert into audit.audit_log (table_name, operation,timestamp, success, error_message)
    values (p_staging_table, 'APPEND', now(), true, null);
exception when others then
    insert into audit.audit_log (table_name, operation, timestamp, success, error_message)
    values (p_staging_table, 'APPEND', now(), false, SQLERRM);
end;
$$;

select * from staging.append_target;
select * from landing.append_source;
call append_load('staging.append_target', 'landing.append_source');
select * from staging.append_target;
select * from landing.append_source;

