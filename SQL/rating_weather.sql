with t as (
	select "date", ("min"+"max")/2 as avg_temp, "min", "max",
		case when precipitation_normal <= 0.5 then 'light'
		 	when precipitation_normal > 0.5 and precipitation_normal <= 2  then 'moderate'
		 	when precipitation_normal > 2 and precipitation_normal <= 3  then 'heavy'
		 	when precipitation_normal > 3 then 'very heavy'
		 end as precipitation
	from dwh_weather dw
	group by dw."date"
)
select count(review_id) as number_of_reviews, stars, sum(checkin_count) as checkin_count , sum(tip_count) as tip_count ,
sum(compliment_count) as compliment_count, precipitation, max("min"), min("max"),round(avg("min"+"max")/2) as avg_temp
from dwh_review dr
left outer join t
on dr."date" = t."date"
group by stars,precipitation

select avg(stars), "date"
from dwh_review dr
group by "date";