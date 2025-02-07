-- Raw table based on original

create table data-engineering-429904.raw.cycle_hire as
select *, current_timestamp() as ingested_at from bigquery-public-data.london_bicycles.cycle_hire;

-- Vartions: with partition and/or cluster

create table data-engineering-429904.raw.cycle_hire_partition partition by timestamp_trunc(ingested_at, day) as
select *, current_timestamp() as ingested_at from bigquery-public-data.london_bicycles.cycle_hire;

create table data-engineering-429904.raw.cycle_hire_cluster cluster by ingested_at, rental_id as
select *, current_timestamp() as ingested_at from bigquery-public-data.london_bicycles.cycle_hire;

create table data-engineering-429904.raw.cycle_hire_partition_cluster partition by timestamp_trunc(ingested_at, day) cluster by ingested_at, rental_id as
select *, current_timestamp() as ingested_at from bigquery-public-data.london_bicycles.cycle_hire;

-- Partition on target - snapshot

create table data-engineering-429904.snapshot.snapshot_cycle_hire_check_00101 partition by timestamp_trunc(dbt_valid_to, day) as
select * from data-engineering-429904.snapshot.snapshot_cycle_hire_check;

create table data-engineering-429904.snapshot.snapshot_cycle_hire_check_00111 partition by timestamp_trunc(dbt_valid_to, day) as
select * from data-engineering-429904.snapshot.snapshot_cycle_hire_check;

create table data-engineering-429904.snapshot.snapshot_cycle_hire_check_01101 partition by timestamp_trunc(dbt_valid_to, day) as
select * from data-engineering-429904.snapshot.snapshot_cycle_hire_check;

create table data-engineering-429904.snapshot.snapshot_cycle_hire_check_01111 partition by timestamp_trunc(dbt_valid_to, day) as
select * from data-engineering-429904.snapshot.snapshot_cycle_hire_check;

-- Cluster on target - snapshot 

create table data-engineering-429904.snapshot.snapshot_cycle_hire_check_10001 cluster by rental_id, dbt_valid_to, dbt_scd_id as
select * from data-engineering-429904.snapshot.snapshot_cycle_hire_check;

create table data-engineering-429904.snapshot.snapshot_cycle_hire_check_10011 cluster by rental_id, dbt_valid_to, dbt_scd_id as
select * from data-engineering-429904.snapshot.snapshot_cycle_hire_check;

create table data-engineering-429904.snapshot.snapshot_cycle_hire_check_11001 cluster by rental_id, dbt_valid_to, dbt_scd_id as
select * from data-engineering-429904.snapshot.snapshot_cycle_hire_check;

create table data-engineering-429904.snapshot.snapshot_cycle_hire_check_11011 cluster by rental_id, dbt_valid_to, dbt_scd_id as
select * from data-engineering-429904.snapshot.snapshot_cycle_hire_check;

-- Partition and cluster on target - snapshot 

create table data-engineering-429904.snapshot.snapshot_cycle_hire_check_10101 partition by timestamp_trunc(dbt_valid_to, day) cluster by rental_id, dbt_valid_to, dbt_scd_id as
select * from data-engineering-429904.snapshot.snapshot_cycle_hire_check;

create table data-engineering-429904.snapshot.snapshot_cycle_hire_check_10111 partition by timestamp_trunc(dbt_valid_to, day) cluster by rental_id, dbt_valid_to, dbt_scd_id as
select * from data-engineering-429904.snapshot.snapshot_cycle_hire_check;

create table data-engineering-429904.snapshot.snapshot_cycle_hire_check_11101 partition by timestamp_trunc(dbt_valid_to, day) cluster by rental_id, dbt_valid_to, dbt_scd_id as
select * from data-engineering-429904.snapshot.snapshot_cycle_hire_check;

create table data-engineering-429904.snapshot.snapshot_cycle_hire_check_1111 partition by timestamp_trunc(dbt_valid_to, day) cluster by rental_id, dbt_valid_to, dbt_scd_id as
select * from data-engineering-429904.snapshot.snapshot_cycle_hire_check;

-- 