# Description
"""
Generate data for the 201 cats database
"""
################################################################# Functions ################################################################# 

# import libraries
import random
from datetime import datetime, timedelta
import numpy as np
import string


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

def randomString(stringLength = 5):
    letters = string.ascii_letters
    return ''.join(random.choice(letters) for i in range(stringLength)).lower().capitalize()

################################################################# Generate SQL #################################################################

# define options
n_users = 50
n_videos = 150
n_likes = 2000
n_suggestions = 500
n_sessions = 2500
n_friendships = 1000
n_watched = 700


# create file with each table
f = open("/Users/gio/Documents/DSE/2019-rgm001/DSE201/Homeworks/Milestone2/Data_Generated/201_cats_data.txt","w")

# users table
users = dict()
while len(users) != n_users:
    users[len(users)] = (randomString(random.randint(5,10)), "facebook.com/"+randomString(random.randint(10,20)))

for idx, user in enumerate(users):
     f.write('INSERT INTO users (user_id, first_name, last_name, username, fb_login) VALUES (' + str(idx+1) + ', \'' + users[user][0] + '\'' + ', \'' + users[user][0] + '\''+ ', \'' + users[user][0] + '\''+', \'' + users[user][1] + '\''+');\n')

f.write('\n\n')

# videos table
videos = dict()
while len(videos) != n_videos:
    videos[len(videos)] = randomString()

for idx, video in enumerate(videos.keys()):
     f.write('INSERT INTO videos (video_id, name, description) VALUES (' + str(idx+1) + ', \'' + videos[video] + '\'' + ', \'' + videos[video] + '\'' +');\n')
    
f.write('\n\n')

# likes table
like_id = np.arange(1,n_likes+1)
createdon = rand_timestamp_list(2010,2020,n_likes)
user_id, video_id = unique_user_video_pair(n_users, n_videos, n_likes)
for i in range(n_likes):
     f.write("INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES ({}, {}, {}, {});\n".format(like_id[i], createdon[i], video_id[i], user_id[i]))

f.write('\n\n')

# friends table
user_id, friend_id = unique_user_friend_pair(n_users, n_friendships)
for i in range(n_friendships):
     f.write("INSERT INTO friends (user_id, friend_id) VALUES ({}, {});\n".format(user_id[i], friend_id[i]))

f.write('\n\n')  

# sessions table
session_id = np.arange(1,n_sessions+1)
createdon = rand_timestamp_list(2010,2020,n_sessions)
user_id = [random.randint(1, n_users) for iter in range(n_sessions)]
for i in range(n_sessions):
     f.write("INSERT INTO sessions (session_id, created_on, user_id) VALUES ({}, {}, {});\n".format(session_id[i], createdon[i], user_id[i]))

f.write('\n\n')

# suggestions table
suggestion_id = np.arange(1,n_suggestions+1)
for i in range(n_suggestions):
     f.write("INSERT INTO suggestions (suggestion_id, session_id, video_id) VALUES ({}, {}, {});\n".format(suggestion_id[i], random.choice(list(session_id)), random.choice(list(np.arange(1,n_videos+1)))))

f.write('\n\n')

# watched table
watched_id = np.arange(1,n_watched+1)
createdon = rand_timestamp_list(2010,2020,n_watched)
end_time = rand_timestamp_list(2010,2020,n_watched)
for i in range(n_watched):
     f.write("INSERT INTO watched (watch_id, created_on, end_time, video_id, session_id) VALUES ({}, {}, {},{},{});\n".format(watched_id[i], createdon[i], end_time[i], random.choice(list(np.arange(1,n_videos+1))), random.choice(session_id)))
  
f.close()    
    
    
    
    
    
    
    
    
    
    
    
    