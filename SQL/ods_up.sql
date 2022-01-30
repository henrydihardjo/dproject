--ods_business
CREATE TABLE  IF NOT EXISTS public.ods_business (
	business_id varchar NULL,
	"name" varchar NULL,
	address varchar NULL,
	city varchar NULL,
	state varchar NULL,
	postal_code varchar NULL,
	latitude numeric NULL,
	longitude numeric NULL,
	stars numeric NULL,
	review_count numeric NULL,
	is_open numeric NULL,
	"attributes" text NULL,
	categories text NULL,
	hours text NULL
);
CREATE INDEX business_idx ON public.ods_business USING btree (business_id);

--ods_checkin
CREATE TABLE  IF NOT EXISTS public.ods_checkin (
	business_id varchar NULL,
	"date" date NULL,
	checkin_count numeric NULL
);
CREATE INDEX checkin_idx ON public.ods_checkin USING btree (business_id, date);

--ods_review
CREATE TABLE  IF NOT EXISTS public.ods_review (
	review_id varchar NULL,
	user_id varchar NULL,
	business_id varchar NULL,
	stars numeric NULL,
	useful numeric NULL,
	funny numeric NULL,
	cool numeric NULL,
	"text" text NULL,
	"date" date NULL
);
CREATE INDEX review_idx ON public.ods_review USING btree (business_id, date);

--ods_tip
CREATE TABLE  IF NOT EXISTS public.ods_tip (
	user_id varchar NULL,
	business_id varchar NULL,
	"text" varchar NULL,
	"date" date NULL,
	compliment_count numeric NULL
);
CREATE INDEX tip_idx ON public.ods_tip USING btree (business_id, date);

--ods_user
CREATE TABLE  IF NOT EXISTS public.ods_user (
	user_id varchar NULL,
	"name" varchar NULL,
	review_count numeric NULL,
	yelping_since date NULL,
	useful numeric NULL,
	funny numeric NULL,
	cool numeric NULL,
	elite text NULL,
	friends text NULL,
	fans numeric NULL,
	average_stars numeric NULL,
	compliment_hot numeric NULL,
	compliment_more numeric NULL,
	compliment_profile numeric NULL,
	compliment_cute numeric NULL,
	compliment_list numeric NULL,
	compliment_note numeric NULL,
	compliment_plain numeric NULL,
	compliment_cool numeric NULL,
	compliment_funny numeric NULL,
	compliment_writer numeric NULL,
	compliment_photos numeric NULL
);
CREATE INDEX user_idx ON public.ods_user USING btree (user_id);

--ods_weather
CREATE TABLE  IF NOT EXISTS public.ods_weather (
	"date" date NULL,
	precipitation numeric NULL,
	precipitation_normal numeric NULL,
	min numeric NULL,
	max numeric NULL,
	normal_min numeric NULL,
	normal_max numeric NULL
);
CREATE INDEX weather_idx ON public.ods_weather USING btree (date);

--materialized_view
CREATE MATERIALIZED VIEW  IF NOT EXISTS public.review_agg
TABLESPACE pg_default
AS WITH checkin AS (
         SELECT odc.business_id,
            odc.date,
            odc.checkin_count
           FROM ods_checkin odc
             JOIN ods_review or2 ON or2.business_id::text = odc.business_id::text AND or2.date = odc.date
        ), tip AS (
         SELECT ot.business_id,
            ot.date,
            ot.compliment_count
           FROM ods_tip ot
             JOIN ods_review or3 ON or3.business_id::text = ot.business_id::text AND or3.date = ot.date
        )
 SELECT sr.review_id,
    sr.user_id,
    sr.business_id,
    sr.stars,
    sr.useful,
    sr.funny,
    sr.cool,
    sr.text,
    sr.date,
    checkin.checkin_count,
    sum(tip.compliment_count) AS compliment_count,
    count(tip.date) AS tip_count
   FROM ods_review sr
     LEFT JOIN checkin ON sr.business_id::text = checkin.business_id::text AND sr.date = checkin.date
     LEFT JOIN tip ON sr.business_id::text = tip.business_id::text AND sr.date = tip.date
  GROUP BY sr.review_id, sr.user_id, sr.business_id, sr.stars, sr.useful, sr.funny, sr.cool, sr.text, sr.date, checkin.checkin_count
WITH DATA;
--refresh materialized view
REFRESH MATERIALIZED VIEW review_agg;

-- View indexes:
CREATE INDEX review_agg_idx ON public.review_agg USING btree (business_id, date);
