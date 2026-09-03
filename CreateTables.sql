create table test_table (
    id int primary key,
    name varchar(255) not null,
    created_at timestamp -- default current_timestamp
);