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
language plpgsql
as $$
begin
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
    v_last_load_timestamp timestamp;
begin
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

    insert into audit.audit_log (table_name, operation, timestamp, success, error_message)
    values ('staging.incremental_target', 'INCREMENTAL_LOAD', now(), true, null);
exception when others then
    insert into audit.audit_log (table_name, operation, timestamp, success, error_message)
    values ('staging.incremental_target', 'INCREMENTAL_LOAD', now(), false, SQLERRM);
end;
$$;

select * from landing.incremental_source;
select * from staging.incremental_target;
call incremental_load();
select * from staging.incremental_target;
