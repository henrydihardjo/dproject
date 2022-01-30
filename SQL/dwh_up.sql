--dwh_business
CREATE TABLE  IF NOT EXISTS public.dwh_business (
	business_id varchar NOT NULL,
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
	hours text NULL,
	CONSTRAINT dwh_business_pkey PRIMARY KEY (business_id)
);
CREATE INDEX business_idx ON public.dwh_business USING btree (business_id);

--dwh_weather
CREATE TABLE  IF NOT EXISTS public.dwh_weather (
	"date" date NOT NULL,
	precipitation numeric NULL,
	precipitation_normal numeric NULL,
	min numeric NULL,
	max numeric NULL,
	normal_min numeric NULL,
	normal_max numeric NULL,
	CONSTRAINT dwh_weather_pkey PRIMARY KEY (date)
);
CREATE INDEX weather_idx ON public.dwh_weather USING btree ("date");

--dwh_user
CREATE TABLE  IF NOT EXISTS public.dwh_user (
	user_id varchar NOT NULL,
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
	compliment_photos numeric NULL,
	CONSTRAINT dwh_user_pkey PRIMARY KEY (user_id)
);
CREATE INDEX user_idx ON public.dwh_user USING btree (user_id);

--dwh_review
CREATE TABLE IF NOT EXISTS public.dwh_review (
	review_id varchar NOT NULL,
	user_id varchar NOT NULL,
	business_id varchar NOT NULL,
	stars numeric NULL,
	useful numeric NULL,
	funny numeric NULL,
	cool numeric NULL,
	"text" text NULL,
	"date" date NOT NULL,
	checkin_count numeric NULL,
	compliment_count numeric NULL,
	tip_count numeric NULL,
	CONSTRAINT pk_review PRIMARY KEY (review_id, user_id, business_id, date),
	CONSTRAINT dwh_review_business_id_fkey FOREIGN KEY (business_id) REFERENCES public.dwh_business(business_id),
	CONSTRAINT dwh_review_date_fkey FOREIGN KEY ("date") REFERENCES public.dwh_weather("date"),
	CONSTRAINT dwh_review_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.dwh_user(user_id)
);
CREATE INDEX review_idx1 ON public.dwh_review USING btree (review_id);
CREATE INDEX review_idx2 ON public.dwh_review USING btree ("date");
CREATE INDEX review_idx3 ON public.dwh_review USING btree (user_id);