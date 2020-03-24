import random
import string
import itertools

No_teams = 50
No_coaches = 50

def randomString_team(stringLength = 5):
    letters = string.ascii_letters
    return ''.join(random.choice(letters) for i in range(stringLength)).lower().capitalize()

def randomString_coach(stringLength = 10):
    letters = string.ascii_letters
    return ''.join(random.choice(letters) for i in range(stringLength)).lower().capitalize()

f = open("/Users/gio/Documents/DSE/2019-rgm001/DSE201/Homeworks/Final/problem2_data.txt","w")

f.write('\n\n')

teams = dict()
while len(teams) != No_teams:
    teams[len(teams)] = randomString_team()    

coaches = dict()
while len(coaches) != No_coaches:
    coaches[len(coaches)] = randomString_coach()    

for team, coach in zip(teams.keys(), coaches.keys()):
    f.write('INSERT INTO Teams (name, coach) VALUES(' '\'' + teams[team] + '\''+',''\'' + coaches[coach] + '\'' + ');\n')
    
f.write('\n\n')


teams_list = []
for i in teams.keys():
    teams_list.append(teams[i])
    
# create tuples for teams
teams_tuples_home = list(itertools.combinations(teams_list, 2))
teams_tuples_visitor = [(i[1],i[0]) for i in teams_tuples_home]
teams_tuple_total = teams_tuples_home + teams_tuples_visitor
home = [i[0] for i in teams_tuple_total]
visitor = [i[1] for i in teams_tuple_total]

for h, v in zip(home,visitor):
    

    f.write('INSERT INTO Matches (hTeam, vteam, hScore, vScore) VALUES (' +'\''+ h + '\''+', \'' + v + '\'' + ',' + str(random.randint(0,10)) +',' + str(random.randint(0,10)) + ');\n')

f.write('\n\n')



f.close()
















