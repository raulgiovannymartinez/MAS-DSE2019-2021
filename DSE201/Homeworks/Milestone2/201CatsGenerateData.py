# Description
"""
Generate data for 10 videos and 10 users for the 201 cats database
"""

# import libraries
import random
from datetime import datetime, timedelta
import numpy as np


# Define functions
def rand_timestamp_list(min_yr, max_yr, n):
    min_year=min_yr
    max_year=max_yr
    
    start = datetime(min_year, 1, 1, 00, 00, 00)
    years = max_year - min_year+1
    end = start + timedelta(days=365 * years)
    
    data = []
    for i in range(n):
        random_date = start + (end - start) * random.random()
        data.append("\'" + str(random_date)[:19] + "\'")
        
    return data

def unique_user_video_pair(n_users, n_videos, n):
    
    data = set()
    while len(data) < n:
        data.add((random.randint(1,n_users),(random.randint(1,n_videos))))
    
    users_id = [i[0] for i in list(data)]
    videos_id = [i[1] for i in list(data)]
    
    return users_id, videos_id

def unique_user_friend_pair(n_users, n):
    
    data = set()
    while len(data) < n:
        curr_tuple = (random.randint(1,n_users),random.randint(1,n_users))
        if curr_tuple[0] != curr_tuple[1]:
            data.add(curr_tuple)    
    
    users_id = [i[0] for i in list(data)]
    friends_id = [i[1] for i in list(data)]
    
    return users_id, friends_id

# likes table
n_users, n_videos = 15, 15
n_tuples = 50
like_id = np.arange(1,n_tuples+1)
createdon = rand_timestamp_list(2010,2020,n_tuples)
user_id, video_id = unique_user_video_pair(n_users, n_videos, n_tuples)

for i in range(n_tuples):
    print("INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES ({}, {}, {}, {});".format(like_id[i], createdon[i], video_id[i], user_id[i]))

# friends table
n_tuples = 50    
n_users = 15
user_id, friend_id = unique_user_friend_pair(n_users, n_tuples)
for i in range(n_tuples):
    print("INSERT INTO friends (user_id, friend_id) VALUES ({}, {});".format(user_id[i], friend_id[i]))
 
    
    
    
    
    
    
    
    
    
