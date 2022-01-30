import pandas as pd
import os
from sqlalchemy import create_engine

#create engine to connect to database
engine = create_engine('postgresql://username:password@localhost:5432/staging')

#filename
weather_temp = 'USW00023169-temperature-degreeF.csv'
weather_pre = 'USW00023169-LAS_VEGAS_MCCARRAN_INTL_AP-precipitation-inch.csv'
dataset_checkin = 'yelp_academic_dataset_checkin.csv'
dataset_user = 'yelp_academic_dataset_user.csv'
dataset_tip = 'yelp_academic_dataset_tip.csv'
dataset_review = 'yelp_academic_dataset_review.csv'
dataset_business = 'yelp_academic_dataset_business.csv'

chunksize = 25000

#get current file directory
__location__ = os.path.realpath(
    os.path.join(os.getcwd(), os.path.dirname(__file__)))

#upload checkin
for chunk in pd.read_csv(os.path.join(__location__, dataset_checkin), chunksize=chunksize):
    # split date to array
    chunk.date = chunk.date.str.split(', ')
    # explode the column
    chunk = chunk.explode('date').reset_index(drop=True)
    # get the yyyy-mm-dd
    chunk['date'] = pd.to_datetime(chunk['date'].astype(str)).dt.date
    # count occurrence by year and put to new column
    chunk = chunk.groupby(chunk.columns.tolist()).size().reset_index(). \
        rename(columns={0: 'checkin_count'})
    chunk.to_sql('staging_checkin', engine, if_exists = 'append', index = False)
    column_temp  = chunk.dtypes

#upload user
for chunk in pd.read_csv(os.path.join(__location__, dataset_user), chunksize=chunksize):
    chunk.to_sql('staging_user', engine, if_exists = 'append', index = False)
    column_temp  = chunk.dtypes

#upload weather temp
for chunk in pd.read_csv(os.path.join(__location__, weather_temp), chunksize=chunksize):
    #rename(switch) min and max column
    chunk = chunk.rename(columns={'min': 'max', 'max': 'min', 'normal_min': 'normal_max', 'normal_max': 'normal_min'})
    chunk['date'] = pd.to_datetime(chunk['date'].astype(str), format='%Y%m%d')
    chunk.to_sql('staging_weather_temp', engine, if_exists = 'append', index = False)

#upload weather precipitation
for chunk in pd.read_csv(os.path.join(__location__, weather_pre), chunksize=chunksize):
    # make all non int to null
    chunk['precipitation'] = chunk['precipitation'].apply(lambda x: pd.to_numeric(x, errors='coerce'))
    # get yyyy-mm-dd from date
    chunk['date'] = pd.to_datetime(chunk['date'].astype(str), format='%Y%m%d')
    chunk.to_sql('staging_weather_precipitation', engine, if_exists = 'append', index = False)

#upload tip
for chunk in pd.read_csv(os.path.join(__location__, dataset_tip), chunksize=chunksize):
    chunk.to_sql('staging_tip', engine, if_exists = 'append', index = False)
    column_temp  = chunk.dtypes

#upload review
for chunk in pd.read_csv(os.path.join(__location__, dataset_review), chunksize=chunksize):
    chunk.to_sql('staging_review', engine, if_exists = 'append', index = False)
    column_temp  = chunk.dtypes

#upload business
for chunk in pd.read_csv(os.path.join(__location__, dataset_business), chunksize=chunksize):
    chunk.to_sql('staging_business', engine, if_exists = 'append', index = False)
    column_temp  = chunk.dtypes
