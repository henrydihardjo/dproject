with t as (
	select "date", ("min"+"max")/2 as avg_temp, "min", "max",
		case when precipitation_normal <= 0.5 then '1'
		 	when precipitation_normal > 0.5 and precipitation_normal <= 2  then '2'
		 	when precipitation_normal > 2 and precipitation_normal <= 3  then '3'
		 	when precipitation_normal > 3 then '4'end as rain
	from dwh_weather dw
	group by dw."date"
)
select count(stars), stars,
		--min(stars), max(stars),
		avg("min"+"max")/2 as avg_temp, rain
from dwh_review dr
inner join t
on dr."date" = t."date"
group by stars,rain;