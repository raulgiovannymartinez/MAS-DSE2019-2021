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
import psycopg2


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

# define Postgress options'

# connect to the db
con = psycopg2.connect("host = localhost dbname=Cats_Milestone3 user=postgres password = bitch")

# Cursor
cur =  con.cursor()

# test dataset took 4 minutes to run
# n_users = 10000
# n_videos = 25000
# n_likes = 100000
# n_suggestions = 35000
# n_sessions = 30000
# n_friendships = 150000
# n_watched = 70000

n_users = 10000
n_videos = 25000
n_likes = 100000
n_suggestions = 35000
n_sessions = 30000
n_friendships = 150000
n_watched = 70000


# create file with each table
# f = open("/Users/gio/Documents/DSE/2019-rgm001/DSE201/Homeworks/Milestone3/201_cats_data.sql","w")

print('Generating for users')

# users table
users = dict()
while len(users) != n_users:
    users[len(users)] = (randomString(random.randint(5,10)), "facebook.com/"+randomString(random.randint(10,20)))

for idx, user in enumerate(users):
     cur.execute('INSERT INTO users (user_id, first_name, last_name, username, fb_login) VALUES (' + str(idx+1) + ', \'' + users[user][0] + '\'' + ', \'' + users[user][0] + '\''+ ', \'' + users[user][0] + '\''+', \'' + users[user][1] + '\''+');\n')

# f.write('\n\n')

print('Generating for videos')


# videos table
videos = dict()
while len(videos) != n_videos:
    videos[len(videos)] = randomString()

for idx, video in enumerate(videos.keys()):
     cur.execute('INSERT INTO videos (video_id, name, description) VALUES (' + str(idx+1) + ', \'' + videos[video] + '\'' + ', \'' + videos[video] + '\'' +');\n')
    
# f.write('\n\n')

print('Generating for likes')


# likes table
like_id = np.arange(1,n_likes+1)
createdon = rand_timestamp_list(2010,2020,n_likes)
user_id, video_id = unique_user_video_pair(n_users, n_videos, n_likes)
for i in range(n_likes):
     cur.execute("INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES ({}, {}, {}, {});\n".format(like_id[i], createdon[i], video_id[i], user_id[i]))

# f.write('\n\n')

print('Generating for friends')


# friends table
user_id, friend_id = unique_user_friend_pair(n_users, n_friendships)
for i in range(n_friendships):
     cur.execute("INSERT INTO friends (user_id, friend_id) VALUES ({}, {});\n".format(user_id[i], friend_id[i]))

# f.write('\n\n')  

print('Generating for sessions')


# sessions table
session_id = np.arange(1,n_sessions+1)
createdon = rand_timestamp_list(2010,2020,n_sessions)
user_id = [random.randint(1, n_users) for iter in range(n_sessions)]
for i in range(n_sessions):
     cur.execute("INSERT INTO sessions (session_id, created_on, user_id) VALUES ({}, {}, {});\n".format(session_id[i], createdon[i], user_id[i]))

# f.write('\n\n')

print('Generating for suggestions')


# suggestions table
suggestion_id = np.arange(1,n_suggestions+1)
for i in range(n_suggestions):
     cur.execute("INSERT INTO suggestions (suggestion_id, session_id, video_id) VALUES ({}, {}, {});\n".format(suggestion_id[i], random.choice(list(session_id)), random.choice(list(np.arange(1,n_videos+1)))))

# f.write('\n\n')

print('Generating for watched')


# watched table
watched_id = np.arange(1,n_watched+1)
createdon = rand_timestamp_list(2010,2020,n_watched)
end_time = rand_timestamp_list(2010,2020,n_watched)
for i in range(n_watched):
     cur.execute("INSERT INTO watched (watch_id, created_on, end_time, video_id, session_id) VALUES ({}, {}, {},{},{});\n".format(watched_id[i], createdon[i], end_time[i], random.choice(list(np.arange(1,n_videos+1))), random.choice(session_id)))
  
con.commit()

# Close the connection
con.close()
    
    
    
    
    
    
    
    
    
    