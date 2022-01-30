import pandas as pd
from sqlalchemy import create_engine

#create engine to connect to database
engine_staging = create_engine('postgresql://username:password@localhost:5432/staging')
engine_ods = create_engine('postgresql://username:password@localhost:5432/postgres')

#upload tip
for chunk in pd.read_sql('select * from staging_tip st', engine_staging, chunksize=25000):
    chunk.to_sql('ods_tip', engine_ods, if_exists = 'append', index = False)

#upload review
for chunk in pd.read_sql('select * from staging_review sr', engine_staging, chunksize=25000):
    chunk.to_sql('ods_review', engine_ods, if_exists = 'append', index = False)

#upload business
for chunk in pd.read_sql('select * from staging_business sb', engine_staging, chunksize=25000):
    chunk.to_sql('ods_business', engine_ods, if_exists = 'append', index = False)

#upload user
for chunk in pd.read_sql('select * from staging_user su', engine_staging, chunksize=25000):
    chunk.to_sql('ods_user', engine_ods, if_exists = 'append', index = False)

#upload checkin
for chunk in pd.read_sql('select * from staging_checkin sc', engine_staging, chunksize=25000):
    chunk.to_sql('ods_checkin', engine_ods, if_exists = 'append', index = False)

#upload weather
for chunk in pd.read_sql(
        """select swp.date, precipitation, precipitation_normal, "min", "max", normal_min, normal_max
        from staging_weather_precipitation swp
        inner join staging_weather_temp swt
        on swp."date" = swt."date"
        where swp."date" in (select distinct sr."date" from staging_review sr)
        """
        ,engine_staging, chunksize=25000):
    chunk.to_sql('ods_weather', engine_ods, if_exists = 'append', index = False)