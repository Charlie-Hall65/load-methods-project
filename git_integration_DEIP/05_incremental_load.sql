/*
config table steps:
1. make config table to source id and timestamp of last load
2. make procedure to update config table with new timestamp after load
3. make procedure to get last load timestamp from config table
4. make procedure to get new records from source table based on last load timestamp
*/

create or replace procedure add_data(
    p_id int,
    p_timestamp timestamp,
    p_name varchar(255),
    p_job_title varchar(255),
    in_source_table varchar
)
language plpgsql --Need plpgsql to use execute format and exception handling
as $$
begin
    --Use execute format to dynamically construct the SQL statement for inserting or updating records in the source table based on the provided parameters. The ON CONFLICT clause ensures that if a record with the same ID already exists, it will be updated with the new values instead of inserting a duplicate.
    execute format(
        'INSERT INTO %s (id, name, job_title, updated_at)
        VALUES (%s, %L, %L, %L)
        ON CONFLICT (id) DO UPDATE SET
            name = EXCLUDED.name,
            job_title = EXCLUDED.job_title,
            updated_at = EXCLUDED.updated_at',
        in_source_table,
        p_id,
        p_name,
        p_job_title,
        p_timestamp
    );
end;
$$;

create or replace procedure incremental_load()
language plpgsql
as $$
declare
    v_last_load_timestamp timestamp; --Variable to store the last load timestamp retrieved from the config table
begin
    --Retrieve the last load timestamp from the config table to determine which records in the source table are new or have been updated since the last load. This timestamp will be used to filter the records that need to be loaded into the target table.
    select max(last_load_timestamp) into v_last_load_timestamp 
    from staging.inc_config_table;
    insert into staging.incremental_target (id, name, job_title, updated_at)
    select * from landing.incremental_source l
    where l.updated_at > v_last_load_timestamp
    on conflict (id) do update set
        name = EXCLUDED.name,
        job_title = EXCLUDED.job_title,
        updated_at = EXCLUDED.updated_at;
    update staging.inc_config_table 
    set last_load_timestamp = (select max(l.updated_at)
    from landing.incremental_source l
    where l.updated_at > v_last_load_timestamp);

    --Log the operation in the audit table
    insert into audit.audit_log (table_name, operation, timestamp, success, error_message)
    values ('staging.incremental_target', 'INCREMENTAL_LOAD', now(), true, null);
exception when others then
    insert into audit.audit_log (table_name, operation, timestamp, success, error_message)
    values ('staging.incremental_target', 'INCREMENTAL_LOAD', now(), false, SQLERRM);
end;
$$;

--Incremental load test
select * from landing.incremental_source;
select * from staging.incremental_target;
call incremental_load();
select * from staging.incremental_target;
