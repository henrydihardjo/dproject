import pandas as pd
from sqlalchemy import create_engine

#create engine to connect to database
engine_dwh = create_engine('postgresql://username:password@localhost:5432/DWH')
engine_ods = create_engine('postgresql://username:password@localhost:5432/postgres')

#upload business
for chunk in pd.read_sql('select * from ods_business ob', engine_ods, chunksize=25000):
    chunk.to_sql('dwh_business', engine_dwh, if_exists = 'append', index = False)

#upload user
for chunk in pd.read_sql('select * from ods_user ou', engine_ods, chunksize=25000):
    chunk.to_sql('dwh_user', engine_dwh, if_exists = 'append', index = False)

#upload weather
for chunk in pd.read_sql('select * from ods_weather ow', engine_ods, chunksize=25000):
    chunk.to_sql('dwh_weather', engine_dwh, if_exists = 'append', index = False)

#upload review
for chunk in pd.read_sql('select * from review_agg ra',engine_ods, chunksize=25000):
    chunk.to_sql('dwh_review', engine_dwh, if_exists = 'append', index = False)