import pandas as pd
import os

json_dir = '/yelp_dataset_json/'
csv_dir = '/yelp_dataset_csv/'

#make dir if not exist for output
if not os.path.exists(csv_dir): os.makedirs(csv_dir)

#get all files with input dir
for file in os.listdir(json_dir):
    csv_filename = csv_dir + os.path.splitext(file)[0] + '.csv'
    with open(json_dir + file, 'r', encoding = 'utf-8') as f, open(csv_filename, 'w', encoding = 'utf-8', newline = '') as csv:
        header = True
        for line in f:
            df = pd.read_json(''.join(('[', line.rstrip(), ']')))
            df.to_csv(csv, header = header, index = 0, quoting = 1)
            header = False