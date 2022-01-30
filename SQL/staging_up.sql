--staging_business
CREATE TABLE IF NOT EXISTS public.staging_business (
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

--staging_checkin
CREATE TABLE IF NOT EXISTS public.staging_checkin (
	business_id varchar NULL,
	"date" date NULL,
	checkin_count numeric NULL
);

--staging_review
CREATE TABLE IF NOT EXISTS public.staging_review (
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

--staging_tip
CREATE TABLE IF NOT EXISTS public.staging_tip (
	user_id varchar NULL,
	business_id varchar NULL,
	"text" varchar NULL,
	"date" date NULL,
	compliment_count numeric NULL
);

--staging_user
CREATE TABLE IF NOT EXISTS public.staging_user (
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

--staging_weather_precipitation
CREATE TABLE IF NOT EXISTS public.staging_weather_precipitation (
	"date" date NULL,
	precipitation numeric NULL,
	precipitation_normal numeric NULL
);

--staging_weather_temp
CREATE TABLE IF NOT EXISTS public.staging_weather_temp (
	"date" date NULL,
	min numeric NULL,
	max numeric NULL,
	normal_min numeric NULL,
	normal_max numeric NULL
);