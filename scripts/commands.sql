create table data-engineering-429904.raw.cycle_hire as
select *, current_timestamp() as ingested_at from bigquery-public-data.london_bicycles.cycle_hire;

$ dbt snapshot

insert into data-engineering-429904.raw.cycle_hire(rental_id, ingested_at) values
((select max(rental_id) from data-engineering-429904.raw.cycle_hire)+1, (select current_timestamp()));

$ dbt snapshot 

select creation_time, query, total_bytes_billed from `data-engineering-429904`.`region-eu`.INFORMATION_SCHEMA.JOBS_BY_PROJECT order by creation_time desc;

$ dbt run 

select creation_time, query, total_bytes_billed from `data-engineering-429904`.`region-eu`.INFORMATION_SCHEMA.JOBS_BY_PROJECT order by creation_time desc;

drop table data-engineering-429904.raw.cycle_hire;

create table data-engineering-429904.raw.cycle_hire partition by timestamp_trunc(ingested_at, day) as
select *, current_timestamp() as ingested_at from bigquery-public-data.london_bicycles.cycle_hire;

drop table data-engineering-429904.staging.cycle_hire_incremental;
drop table data-engineering-429904.snapshot.snapshot_cycle_hire_check;
drop table data-engineering-429904.snapshot.snapshot_cycle_hire_timestamp;

$ dbt build

alter table data-engineering-429904.snapshot.snapshot_cycle_hire_check rename to snapshot_cycle_hire_check_no_partition;
alter table data-engineering-429904.snapshot.snapshot_cycle_hire_timestamp rename to snapshot_cycle_hire_timestamp_no_partition;

create table data-engineering-429904.snapshot.snapshot_cycle_hire_check partition by timestamp_trunc(dbt_valid_to, day) as
select * from data-engineering-429904.snapshot.snapshot_cycle_hire_check_no_partition;

create table data-engineering-429904.snapshot.snapshot_cycle_hire_timestamp partition by timestamp_trunc(dbt_valid_to, day) as
select * from data-engineering-429904.snapshot.snapshot_cycle_hire_timestamp_no_partition;

alter table data-engineering-429904.staging.cycle_hire_incremental rename to cycle_hire_incremental_no_partition;

create table data-engineering-429904.staging.cycle_hire_incremental partition by timestamp_trunc(ingested_at, day) as 
select * from data-engineering-429904.staging.cycle_hire_incremental_no_partition;

$ dbt build

drop table data-engineering-429904.snapshot.snapshot_cycle_hire_check;
drop table data-engineering-429904.snapshot.snapshot_cycle_hire_timestamp;

create table data-engineering-429904.snapshot.snapshot_cycle_hire_check partition by timestamp_trunc(ingested_at, day) as
select * from data-engineering-429904.snapshot.snapshot_cycle_hire_check_no_partition;

create table data-engineering-429904.snapshot.snapshot_cycle_hire_timestamp partition by timestamp_trunc(ingested_at, day) as
select * from data-engineering-429904.snapshot.snapshot_cycle_hire_timestamp_no_partition;

$ dbt snapshot

drop table data-engineering-429904.raw.cycle_hire;

create table data-engineering-429904.raw.cycle_hire cluster by ingested_at as
select *, current_timestamp() as ingested_at from bigquery-public-data.london_bicycles.cycle_hire;

drop table data-engineering-429904.staging.cycle_hire_incremental;
drop table data-engineering-429904.snapshot.snapshot_cycle_hire_check;
drop table data-engineering-429904.snapshot.snapshot_cycle_hire_timestamp;

$ dbt build 

insert into data-engineering-429904.raw.cycle_hire(rental_id, ingested_at) values
((select max(rental_id) from data-engineering-429904.raw.cycle_hire)+1, (select current_timestamp()));

$ dbt build 

alter table data-engineering-429904.snapshot.snapshot_cycle_hire_check rename to snapshot_cycle_hire_check_no_cluster;
alter table data-engineering-429904.snapshot.snapshot_cycle_hire_timestamp rename to snapshot_cycle_hire_timestamp_no_cluster;

create table data-engineering-429904.snapshot.snapshot_cycle_hire_check cluster by dbt_valid_to as
select * from data-engineering-429904.snapshot.snapshot_cycle_hire_check_no_cluster;

create table data-engineering-429904.snapshot.snapshot_cycle_hire_timestamp cluster by dbt_valid_to as
select * from data-engineering-429904.snapshot.snapshot_cycle_hire_timestamp_no_cluster;

$ dbt snapshot

alter table data-engineering-429904.staging.cycle_hire_incremental rename to cycle_hire_incremental_no_cluster;

create table data-engineering-429904.staging.cycle_hire_incremental cluster by ingested_at as
select * from data-engineering-429904.staging.cycle_hire_incremental_no_cluster;

$ dbt run

drop table data-engineering-429904.raw.cycle_hire;

create table data-engineering-429904.raw.cycle_hire as
select *, current_timestamp() as ingested_at from bigquery-public-data.london_bicycles.cycle_hire;

drop table data-engineering-429904.staging.cycle_hire_incremental;
drop table data-engineering-429904.snapshot.snapshot_cycle_hire_check;
drop table data-engineering-429904.snapshot.snapshot_cycle_hire_timestamp;

$ dbt build 