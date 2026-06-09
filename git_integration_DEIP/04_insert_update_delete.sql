create or replace procedure insert_tables(
    i_table1 varchar,
    i_table2 varchar
)
language plpgsql --Need plpgsql to use execute format and exception handling
as $$
begin
    --Using execute format to dynamically construct the SQL statement for inserting data from one table to another. The on conflict clause ensures that if there's a conflict on the id column, the insert will be ignored, preventing duplicates.
    execute format(
        'INSERT INTO %s SELECT * FROM %s 
        on conflict (id) do nothing', i_table1, i_table2);
    --Log the operation in the audit table
    insert into audit.audit_log (table_name, operation, timestamp, success, error_message)
    values (i_table1, 'INSERT', now(), true, null);
exception when others then
    insert into audit.audit_log (table_name, operation, timestamp, success, error_message)
    values (i_table1, 'INSERT', now(), false, SQLERRM);
end;
$$;

create or replace procedure update_tables(
    u_table1 varchar,
    u_table2 varchar
)
language plpgsql
as $$
begin
    --Using execute format to dynamically construct the SQL statement for updating data in one table based on another table
    execute format(
        'UPDATE %s t SET name = s.name, 
        job_title = s.job_title FROM %s s 
        WHERE t.id = s.id', u_table1, u_table2);

    --Log the operation in the audit table
    insert into audit.audit_log (table_name, operation, timestamp, success, error_message)
    values (u_table1, 'UPDATE', now(), true, null);
exception when others then
    insert into audit.audit_log (table_name, operation, timestamp, success, error_message)
    values (u_table1, 'UPDATE', now(), false, SQLERRM);
end;
$$;   

create or replace procedure delete_tables(
    d_table1 varchar,
    d_table2 varchar
)
language plpgsql
as $$
begin
    --Using execute format to dynamically construct the SQL statement for deleting data from one table based on another table
    execute format(
        'DELETE FROM %s t 
        USING %s s
        WHERE t.id = s.id', d_table1, d_table2);
    
    --Log the operation in the audit table
    insert into audit.audit_log (table_name, operation, timestamp, success, error_message)
    values (d_table1, 'DELETE', now(), true, null);
exception when others then
    insert into audit.audit_log (table_name, operation, timestamp, success, error_message)
    values (d_table1, 'DELETE', now(), false, SQLERRM);
end;
$$;   

--insert test
select * from staging.iud_target
order BY id;
select * from landing.iud_source
order BY id;
call insert_tables('staging.iud_target', 'landing.iud_source');
select * from staging.iud_target
order BY id;
select * from landing.iud_source
order BY id;


insert into landing.IUD_source (id, name, job_title) values
(1, 'Alice', 'Senior Data Engineer'),
(2, 'Bob', 'Lead Data Scientist'),
(3, 'Charlie', 'Data Analyst'),
(4, 'David', 'Data Architect'),
(5, 'Eve', 'Data Engineer'),
(6, 'Frank', 'Data Scientist'),
(7, 'Grace', 'Data Analyst')
on conflict (id) do nothing;



--update test
select * from staging.iud_target
order BY id;
select * from landing.iud_source
order BY id;
call update_tables('staging.iud_target', 'landing.iud_source');
select * from staging.iud_target
order BY id;
select * from landing.iud_source
order BY id;


insert into landing.IUD_source (id, name, job_title) values
(1, 'Alice', 'Senior Data Engineer'),
(2, 'Bob', 'Lead Data Scientist'),
(3, 'Charlie', 'Data Analyst'),
(4, 'David', 'Data Architect'),
(5, 'Eve', 'Data Engineer'),
(6, 'Frank', 'Data Scientist'),
(7, 'Grace', 'Data Analyst')
on conflict (id) do nothing;


--delete test
select * from staging.iud_target
order BY id;
select * from landing.iud_source
order BY id;
call delete_tables('staging.iud_target', 'landing.iud_source');
select * from staging.iud_target
order BY id;
select * from landing.iud_source
order BY id;

insert into landing.IUD_source (id, name, job_title) values
(1, 'Alice', 'Senior Data Engineer'),
(2, 'Bob', 'Lead Data Scientist'),
(3, 'Charlie', 'Data Analyst'),
(4, 'David', 'Data Architect'),
(5, 'Eve', 'Data Engineer'),
(6, 'Frank', 'Data Scientist'),
(7, 'Grace', 'Data Analyst')
on conflict (id) do nothing;