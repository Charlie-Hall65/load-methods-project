-- ============================================================
-- FULL LOAD TABLES
-- ============================================================

drop table if exists staging.full_load_source;
create table if not exists landing.full_load_source (
    id int primary key,
    name varchar(255),
    job_title varchar(255)
);

insert into landing.full_load_source (id, name, job_title) values
(1,  'Alice',     'Data Engineer'),
(2,  'Bob',       'Data Scientist'),
(3,  'Charlie',   'Data Analyst'),
(4,  'David',     'Data Architect'),
(5,  'Eve',       'Data Engineer'),
(6,  'Frank',     'Data Scientist'),
(7,  'Grace',     'Data Analyst'),
(8,  'Heidi',     'ML Engineer'),
(9,  'Ivan',      'Data Engineer'),
(10, 'Judy',      'Analytics Engineer'),
(11, 'Kevin',     'Data Architect'),
(12, 'Laura',     'Data Scientist'),
(13, 'Mallory',   'Data Analyst'),
(14, 'Niaj',      'Data Engineer'),
(15, 'Olivia',    'ML Engineer'),
(16, 'Peggy',     'Analytics Engineer'),
(17, 'Quinn',     'Data Scientist'),
(18, 'Rupert',    'Data Engineer')
on conflict (id) do nothing;

drop table if exists landing.full_load_target;
create table if not exists staging.full_load_target (
    id int primary key,
    name varchar(255),
    job_title varchar(255)
);

insert into staging.full_load_target (id, name, job_title) values
(1,  'Alice',     'Data Engineer'),
(2,  'Bob',       'Data Scientist'),
(3,  'Charlie',   'Data Analyst'),
(4,  'David',     'Data Architect'),
(5,  'Eve',       'Data Engineer'),
(6,  'Frank',     'Data Scientist'),
(7,  'Grace',     'Data Analyst'),
(8,  'Heidi',     'ML Engineer'),
(9,  'Ivan',      'Data Engineer'),
(10, 'Judy',      'Analytics Engineer'),
(11, 'Kevin',     'Data Architect'),
(12, 'Laura',     'Data Scientist')
on conflict (id) do nothing;


-- ============================================================
-- UPSERT TABLES
-- ============================================================

drop table if exists staging.upsert_source;
create table if not exists landing.upsert_source (
    id int primary key,
    name varchar(255),
    job_title varchar(255)
);

insert into landing.upsert_source (id, name, job_title) values
(1,  'Alice',     'Senior Data Engineer'),
(2,  'Bob',       'Lead Data Scientist'),
(3,  'Charlie',   'Senior Data Analyst'),
(5,  'Eve',       'Lead Data Engineer'),
(7,  'Grace',     'Data Analyst'),
(8,  'Heidi',     'Senior ML Engineer'),
(9,  'Ivan',      'Staff Data Engineer'),
(12, 'Laura',     'Principal Data Scientist'),
(15, 'Olivia',    'Lead ML Engineer'),
(19, 'Sam',       'Data Engineer'),
(20, 'Tina',      'Data Scientist'),
(21, 'Uma',       'Analytics Engineer'),
(22, 'Victor',    'Data Analyst'),
(23, 'Wendy',     'Data Architect'),
(24, 'Xena',      'Data Engineer'),
(25, 'Yusuf',     'Data Scientist')
on conflict (id) do nothing;

drop table if exists landing.upsert_target;
create table if not exists staging.upsert_target (
    id int primary key,
    name varchar(255),
    job_title varchar(255)
);

insert into staging.upsert_target (id, name, job_title) values
(1,  'Alice',     'Data Engineer'),
(2,  'Bob',       'Data Scientist'),
(3,  'Charlie',   'Data Analyst'),
(4,  'David',     'Data Architect'),
(5,  'Eve',       'Data Engineer'),
(6,  'Frank',     'Data Scientist'),
(7,  'Grace',     'Data Analyst'),
(8,  'Heidi',     'ML Engineer'),
(9,  'Ivan',      'Data Engineer'),
(10, 'Judy',      'Analytics Engineer'),
(11, 'Kevin',     'Data Architect'),
(12, 'Laura',     'Data Scientist'),
(13, 'Mallory',   'Data Analyst'),
(14, 'Niaj',      'Data Engineer'),
(15, 'Olivia',    'ML Engineer')
on conflict (id) do nothing;


-- ============================================================
-- APPEND TABLES
-- ============================================================

drop table if exists staging.append_source;
create table if not exists landing.append_source (
    id int primary key,
    name varchar(255),
    job_title varchar(255)
);

insert into landing.append_source (id, name, job_title) values
(1,  'Alice',     'Data Engineer'),
(2,  'Bob',       'Data Scientist'),
(3,  'Charlie',   'Data Analyst'),
(4,  'David',     'Data Architect'),
(5,  'Eve',       'Data Engineer'),
(6,  'Frank',     'Data Scientist'),
(7,  'Grace',     'Data Analyst'),
(8,  'Heidi',     'ML Engineer'),
(9,  'Ivan',      'Data Engineer'),
(10, 'Judy',      'Analytics Engineer'),
(11, 'Kevin',     'Data Architect'),
(12, 'Laura',     'Data Scientist'),
(13, 'Mallory',   'Data Analyst'),
(14, 'Niaj',      'Data Engineer'),
(15, 'Olivia',    'ML Engineer')
on conflict (id) do nothing;

drop table if exists landing.append_target;
create table if not exists staging.append_target (
    id int primary key,
    name varchar(255),
    job_title varchar(255)
);

insert into staging.append_target (id, name, job_title) values
(16, 'Peggy',     'Analytics Engineer'),
(17, 'Quinn',     'Data Scientist'),
(18, 'Rupert',    'Data Engineer'),
(19, 'Sam',       'Data Analyst'),
(20, 'Tina',      'Data Architect'),
(21, 'Uma',       'ML Engineer'),
(22, 'Victor',    'Data Engineer'),
(23, 'Wendy',     'Analytics Engineer'),
(24, 'Xena',      'Data Scientist'),
(25, 'Yusuf',     'Data Analyst'),
(26, 'Zara',      'Data Engineer'),
(27, 'Aaron',     'Data Architect'),
(28, 'Bianca',    'ML Engineer'),
(29, 'Carlos',    'Data Scientist'),
(30, 'Diana',     'Analytics Engineer')
on conflict (id) do nothing;


-- ============================================================
-- IUD (INSERT / UPDATE / DELETE) TABLES
-- ============================================================

drop table if exists staging.iud_source;
create table if not exists landing.IUD_source (
    id int primary key,
    name varchar(255),
    job_title varchar(255)
);

insert into landing.IUD_source (id, name, job_title) values
(1,  'Alice',     'Senior Data Engineer'),
(2,  'Bob',       'Lead Data Scientist'),
(3,  'Charlie',   'Data Analyst'),
(4,  'David',     'Data Architect'),
(5,  'Eve',       'Data Engineer'),
(6,  'Frank',     'Data Scientist'),
(7,  'Grace',     'Data Analyst'),
(8,  'Heidi',     'ML Engineer'),
(9,  'Ivan',      'Staff Data Engineer'),
(10, 'Judy',      'Analytics Engineer'),
(11, 'Kevin',     'Senior Data Architect'),
(12, 'Laura',     'Principal Data Scientist'),
(13, 'Mallory',   'Data Analyst'),
(14, 'Niaj',      'Data Engineer'),
(15, 'Olivia',    'Lead ML Engineer'),
(16, 'Peggy',     'Analytics Engineer'),
(17, 'Quinn',     'Data Scientist'),
(18, 'Rupert',    'Data Engineer')
on conflict (id) do nothing;

drop table if exists landing.IUD_target;
create table if not exists staging.IUD_target (
    id int primary key,
    name varchar(255),
    job_title varchar(255)
);

insert into staging.IUD_target (id, name, job_title) values
(1,  'Zerry',     'Data Engineer'),
(2,  'Yanel',     'Data Scientist'),
(3,  'Xander',    'Data Analyst'),
(4,  'Willa',     'Data Architect'),
(5,  'Vince',     'Data Engineer'),
(6,  'Kyle',      'Data Scientist'),
(7,  'Uma',       'Data Analyst'),
(8,  'Tomas',     'ML Engineer'),
(9,  'Sara',      'Data Engineer'),
(10, 'Rosa',      'Analytics Engineer'),
(14, 'Niaj',      'Data Engineer'),
(19, 'Sam',       'Data Engineer'),
(20, 'Tina',      'Data Scientist'),
(21, 'Uma',       'Analytics Engineer'),
(22, 'Victor',    'Data Analyst')
on conflict (id) do nothing;


-- ============================================================
-- INCREMENTAL TABLES
-- ============================================================

drop table if exists staging.incremental_source;
create table if not exists landing.incremental_source (
    id int primary key,
    name varchar(255),
    job_title varchar(255),
    updated_at timestamp
);

insert into landing.incremental_source (id, name, job_title, updated_at) values
(1,  'Alice',     'Data Engineer',         '2024-01-01 10:00:00'),
(2,  'Bob',       'Data Scientist',         '2024-01-01 11:00:00'),
(3,  'Charlie',   'Data Analyst',           '2024-01-01 12:00:00'),
(4,  'David',     'Data Architect',         '2024-01-01 13:00:00'),
(5,  'Eve',       'Data Engineer',          '2024-01-01 14:00:00'),
(6,  'Frank',     'Data Scientist',         '2024-01-01 14:50:00'),
(7,  'Grace',     'Data Analyst',           '2024-01-01 15:30:00'),
(8,  'Heidi',     'ML Engineer',            '2024-01-01 16:00:00'),
(9,  'Ivan',      'Data Engineer',          '2024-01-01 16:45:00'),
(10, 'Judy',      'Analytics Engineer',     '2024-01-01 17:00:00'),
(11, 'Kevin',     'Data Architect',         '2024-01-01 17:30:00'),
(12, 'Laura',     'Data Scientist',         '2024-01-01 18:00:00'),
(13, 'Mallory',   'Data Analyst',           '2024-01-01 18:20:00'),
(14, 'Niaj',      'Data Engineer',          '2024-01-01 18:45:00'),
(15, 'Olivia',    'ML Engineer',            '2024-01-01 19:00:00'),
(16, 'Peggy',     'Analytics Engineer',     '2024-01-01 19:15:00'),
(17, 'Quinn',     'Data Scientist',         '2024-01-01 19:30:00'),
(18, 'Rupert',    'Data Engineer',          '2024-01-01 20:00:00')
on conflict (id) do nothing;

drop table if exists landing.incremental_target;
create table if not exists staging.incremental_target (
    id int primary key,
    name varchar(255),
    job_title varchar(255),
    updated_at timestamp
);

insert into staging.incremental_target (id, name, job_title, updated_at) values
(1,  'Alice',     'Data Engineer',         '2024-01-01 10:00:00'),
(2,  'Bob',       'Data Scientist',         '2024-01-01 11:00:00'),
(3,  'Charlie',   'Data Analyst',           '2024-01-01 12:00:00'),
(4,  'David',     'Data Architect',         '2024-01-01 13:00:00'),
(5,  'Eve',       'Data Engineer',          '2024-01-01 14:00:00'),
(6,  'Frank',     'Data Scientist',         '2024-01-01 14:50:00'),
(7,  'Grace',     'Data Analyst',           '2024-01-01 15:30:00'),
(8,  'Heidi',     'ML Engineer',            '2024-01-01 16:00:00'),
(9,  'Ivan',      'Data Engineer',          '2024-01-01 16:45:00'),
(10, 'Judy',      'Analytics Engineer',     '2024-01-01 17:00:00'),
(11, 'Kevin',     'Data Architect',         '2024-01-01 17:30:00'),
(12, 'Laura',     'Data Scientist',         '2024-01-01 18:00:00')
on conflict (id) do nothing;

-- Config table (unchanged — single-row control record)
create table if not exists staging.inc_config_table (
    last_load_timestamp timestamp,
    id int primary key
);
insert into staging.inc_config_table (id, last_load_timestamp) values
(1, '2024-01-01 14:00:00')
on conflict (id) do update set last_load_timestamp = EXCLUDED.last_load_timestamp;
