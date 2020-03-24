import pandas as pd


# Parse .data file for training set
f1_train = open('C:/Users/rmartinez4/Desktop/Raul/DSE 210 - HW4/20news-bydate/matlab/train.data', 'r')

d_train = {'docIdx':[], 'wordIdx':[], 'count':[]}
cols = list(d_train.keys())

for line in f1_train:
    d_train[cols[0]].append(line.split(' ')[0])
    d_train[cols[1]].append(line.split(' ')[1])
    d_train[cols[2]].append(line.split(' ')[2][:-1])
   
f1_train.close()

train_data = pd.DataFrame(d_train)

# Parse .label file for training set
f2_train = open('C:/Users/rmartinez4/Desktop/Raul/DSE 210 - HW4/20news-bydate/matlab/train.label', 'r')

l_train = {'Id':[]}
cols = list(l_train.keys())

for line in f2_train:
    l_train[cols[0]].append(line.split(' ')[0][:-1])

f2_train.close()

train_label = pd.DataFrame(l_train)



# Parse .data file for test set
f1_test = open('C:/Users/rmartinez4/Desktop/Raul/DSE 210 - HW4/20news-bydate/matlab/test.data', 'r')

d_test = {'docIdx':[], 'wordIdx':[], 'count':[]}
cols = list(d_test.keys())

for line in f1_test:
    d_test[cols[0]].append(line.split(' ')[0])
    d_test[cols[1]].append(line.split(' ')[1])
    d_test[cols[2]].append(line.split(' ')[2][:-1])
   
f1_test.close()

test_data = pd.DataFrame(d_test)

# Parse .label file for test set
f2_test = open('C:/Users/rmartinez4/Desktop/Raul/DSE 210 - HW4/20news-bydate/matlab/test.label', 'r')

l_test = {'Id':[]}
cols = list(l_test.keys())

for line in f2_test:
    l_test[cols[0]].append(line.split(' ')[0][:-1])

f2_test.close()

test_label = pd.DataFrame(l_test)