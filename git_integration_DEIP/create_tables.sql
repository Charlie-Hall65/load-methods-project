drop table if exists staging.full_load_source;
create table if not exists landing.full_load_source (
    id int primary key,
    name varchar(255),
    job_title varchar(255)
);  

insert into landing.full_load_source (id, name, job_title) values
(1, 'Alice', 'Data Engineer'),
(2, 'Bob', 'Data Scientist'),
(3, 'Charlie', 'Data Analyst'),
(4, 'David', 'Data Architect'),
(5, 'Eve', 'Data Engineer'),
(6, 'Frank', 'Data Scientist')
on conflict (id) do nothing;

drop table if exists landing.full_load_target;
create table if not exists staging.full_load_target (
    id int primary key,
    name varchar(255),
    job_title varchar(255)
);

insert into staging.full_load_target (id, name, job_title) values
(1, 'Alice', 'Data Engineer'),
(2, 'Bob', 'Data Scientist'),
(3, 'Charlie', 'Data Analyst')
on conflict (id) do nothing;


drop table if exists staging.upsert_source;
create table if not exists landing.upsert_source (
    id int primary key,
    name varchar(255),
    job_title varchar(255)
);

insert into landing.upsert_source (id, name, job_title) values
(1, 'Alice', 'Senior Data Engineer'),
(2, 'Bob', 'Lead Data Scientist'),
(7, 'Grace', 'Data Analyst')
on conflict (id) do nothing;

drop table if exists landing.upsert_target;
create table if not exists staging.upsert_target (
    id int primary key,
    name varchar(255),
    job_title varchar(255)
);

insert into staging.upsert_target (id, name, job_title) values
(1, 'Alice', 'Data Engineer'),
(2, 'Bob', 'Data Scientist'),
(3, 'Charlie', 'Data Analyst')
on conflict (id) do nothing;

drop table if exists staging.append_source;
create table if not exists landing.append_source (
    id int primary key,
    name varchar(255),
    job_title varchar(255)
);

insert into landing.append_source (id, name, job_title) values
(1, 'Alice', 'Data Engineer'),
(2, 'Bob', 'Data Scientist'),
(3, 'Charlie', 'Data Analyst')
on conflict (id) do nothing;

drop table if exists landing.append_target;
create table if not exists staging.append_target (
    id int primary key,
    name varchar(255),
    job_title varchar(255)
);

insert into staging.append_target (id, name, job_title) values
(4, 'David', 'Data Architect'),
(5, 'Eve', 'Data Engineer'),
(6, 'Frank', 'Data Scientist')
on conflict (id) do nothing;

drop table if exists staging.iud_source;
create table if not exists landing.IUD_source (
    id int primary key,
    name varchar(255),
    job_title varchar(255)
);  

insert into landing.IUD_source (id, name, job_title) values
(1, 'Alice', 'Senior Data Engineer'),
(2, 'Bob', 'Lead Data Scientist'),
(3, 'Charlie', 'Data Analyst'),
(4, 'David', 'Data Architect'),
(5, 'Eve', 'Data Engineer'),
(6, 'Frank', 'Data Scientist'),
(7, 'Grace', 'Data Analyst')
on conflict (id) do nothing;

drop table if exists landing.IUD_target;
create table if not exists staging.IUD_target (
    id int primary key,
    name varchar(255),
    job_title varchar(255)
);

insert into staging.IUD_target (id, name, job_title) values
(1, 'Zerry', 'Data Engineer'),
(2, 'Yanel', 'Data Scientist'),
(3, 'Xander', 'Data Analyst'),
(6, 'Kyle', 'Data Scientist'),
(8, 'Heidi', 'Data Engineer')
on conflict (id) do nothing;


drop table if exists staging.incremental_source;
create table if not exists landing.incremental_source (
    id int primary key,
    name varchar(255),
    job_title varchar(255),
    updated_at timestamp
);

insert into landing.incremental_source (id, name, job_title, updated_at) values
(1, 'Alice', 'Data Engineer', '2024-01-01 10:00:00'),
(2, 'Bob', 'Data Scientist', '2024-01-01 11:00:00'),
(3, 'Charlie', 'Data Analyst', '2024-01-01 12:00:00'),
(4, 'David', 'Data Architect', '2024-01-01 13:00:00'),
(5, 'Eve', 'Data Engineer', '2024-01-01 14:00:00'),
(6, 'Frank', 'Data Scientist', '2024-01-01 14:50:00')
on conflict (id) do nothing;

drop table if exists landing.incremental_target;
create table if not exists staging.incremental_target (
    id int primary key,
    name varchar(255),
    job_title varchar(255),
    updated_at timestamp
);

insert into staging.incremental_target (id, name, job_title, updated_at) values
(1, 'Alice', 'Data Engineer', '2024-01-01 10:00:00'),
(2, 'Bob', 'Data Scientist', '2024-01-01 11:00:00'),
(3, 'Charlie', 'Data Analyst', '2024-01-01 12:00:00')
on conflict (id) do nothing;

create table if not exists staging.inc_config_table (
    last_load_timestamp timestamp,
    id int primary key
);
insert into staging.inc_config_table (id, last_load_timestamp) values
(1, '2024-01-01 11:00:00')
on conflict (id) do update set last_load_timestamp = EXCLUDED.last_load_timestamp;

