------------------------------
--TABLE TRANSFORMATION QUERY--
------------------------------
--FACT_TABLE
--tip fact table (user_id, business_id, date)
select * from staging_tip st

--review fact table (review_id, user_id, business_id, date)
select * from staging_review sr 

--DIMENSION_TABLE
--Business (business_id)
select * from staging_business sb

--user (user_id)
select * from staging_user su

--checkin (business_id)
select * from staging_checkin sc

select * from staging_checkin_flatten scf 

--weather (date)
--combine WEATHER TEMP AND PRECIPITATION
select swp.date, precipitation, precipitation_normal, "min", "max", normal_min, normal_max 
from staging_weather_precipitation swp 
inner join staging_weather_temp swt 
on swp."date" = swt."date"
where swp."date" in (select distinct sr."date" from staging_review sr)
