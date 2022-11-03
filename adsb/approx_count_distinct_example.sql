-- approxiate count distinct walkthrough requires "dump1090new" table and data
-- turn on timing
\timing

-- EXACT COUNT DISTINCT... slow?
select min(date_generated), max(date_generated), COUNT(DISTINCT hex_ident), COUNT(DISTINCT callsign) from dump1090new where date_generated between '2022-10-01' and '2022-10-10';
select date_generated, COUNT(DISTINCT hex_ident), COUNT(DISTINCT callsign) FROM dump1090new where date_generated between '2022-10-01' and '2022-10-10' group by date_generated;

-- build a table to store approximates
create table dump1090_approximate (day date, hex_ident long varbinary(262144), callsign long varbinary(262144));

-- store approximate synopses for 10 days
insert into dump1090_approximate select date_generated, APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (hex_ident), APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (callsign) from dump1090new where date_generated = '2022-10-01' group by date_generated;
insert into dump1090_approximate select date_generated, APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (hex_ident), APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (callsign) from dump1090new where date_generated = '2022-10-02' group by date_generated;
insert into dump1090_approximate select date_generated, APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (hex_ident), APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (callsign) from dump1090new where date_generated = '2022-10-03' group by date_generated;
insert into dump1090_approximate select date_generated, APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (hex_ident), APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (callsign) from dump1090new where date_generated = '2022-10-04' group by date_generated;
insert into dump1090_approximate select date_generated, APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (hex_ident), APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (callsign) from dump1090new where date_generated = '2022-10-05' group by date_generated;
insert into dump1090_approximate select date_generated, APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (hex_ident), APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (callsign) from dump1090new where date_generated = '2022-10-06' group by date_generated;
insert into dump1090_approximate select date_generated, APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (hex_ident), APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (callsign) from dump1090new where date_generated = '2022-10-07' group by date_generated;
insert into dump1090_approximate select date_generated, APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (hex_ident), APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (callsign) from dump1090new where date_generated = '2022-10-08' group by date_generated;
insert into dump1090_approximate select date_generated, APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (hex_ident), APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (callsign) from dump1090new where date_generated = '2022-10-09' group by date_generated;
insert into dump1090_approximate select date_generated, APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (hex_ident), APPROXIMATE_COUNT_DISTINCT_SYNOPSIS (callsign) from dump1090new where date_generated = '2022-10-10' group by date_generated;

-- now do daily and 10-day summary.  Fast!  compare results to the above exact counts: should be within 1.25%
select day, APPROXIMATE_COUNT_DISTINCT_OF_SYNOPSIS(hex_ident), APPROXIMATE_COUNT_DISTINCT_OF_SYNOPSIS(callsign) from dump1090_approximate group by day;
select min, max, APPROXIMATE_COUNT_DISTINCT_OF_SYNOPSIS(hexmerge), APPROXIMATE_COUNT_DISTINCT_OF_SYNOPSIS(csmerge) from (select min(day) as min, max(day) as max, APPROXIMATE_COUNT_DISTINCT_SYNOPSIS_MERGE(hex_ident) as hexmerge, APPROXIMATE_COUNT_DISTINCT_SYNOPSIS_MERGE(callsign) as csmerge from dump1090_approximate) a1 group by min, max;
