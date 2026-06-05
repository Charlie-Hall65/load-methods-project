insert into staging.incremental_source (id, name, job_title, updated_at) values
(3, 'Charlie', 'Data Analyst', '2024-01-01 12:00:00'),
(4, 'David', 'Data Architect', '2024-01-01 13:00:00'),
(5, 'Eve', 'Data Engineer', '2024-01-01 14:00:00'), 
(6, 'Frank', 'Data Scientist', '2024-01-01 14:50:00')  
on conflict (id) do update set
    name = EXCLUDED.name,
    job_title = EXCLUDED.job_title,
    updated_at = EXCLUDED.updated_at;