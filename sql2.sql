show databases;
use information_schema;
show tables;
select * from character_sets;
select description, maxlen from character_sets;
select * from character_sets;
select distinct maxlen from character_sets;
select maxlen from character_sets where character_set_name="big5";
select * from character_sets where character_set_name="big5";
use performance_schema;
show tables;
select * from accounts;