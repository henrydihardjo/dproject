--STAGING TO ODS
--business
select * from staging_business sb;
--review
select * from staging_review sr;
--tip
select * from staging_tip st;
--user
select * from staging_user su;
--checkin
select * from staging_checkin sc;
--weather
select swp.date, precipitation, precipitation_normal, "min", "max", normal_min, normal_max
        from staging_weather_precipitation swp
        inner join staging_weather_temp swt
        on swp."date" = swt."date"
        where swp."date" in (select distinct sr."date" from staging_review sr);

--STAGING TO DWH
--business
select * from ods_business ob
--user
select * from ods_user ou
--weather
select * from ods_weather ow
--
select * from review_agg ra