CREATE LOGIN NandaSurendra

WITH PASSWORD = 'MI$T353Instructor';

CREATE USER NandaSurendra

FOR LOGIN NandaSurendra;



ALTER ROLE db_owner ADD MEMBER NandaSurendra;






/* 
create table test_table (
    id int primary key,
    name varchar(255) not null,
    created_at timestamp -- default current_timestamp
);
*/