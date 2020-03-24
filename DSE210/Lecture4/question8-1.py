# import libraries
import pandas as pd
import numpy as np

# calculate pi_j, the fraction of documents that belong to each class

# read labels for train data
train_label = open('/Users/gio/Documents/DSE/2019-rgm001/DSE210/Lecture4/20news-bydate/matlab/train.label', 'r')

# define dictionary for pi_j where j is each class 1,2,..., 20
pi = {}
for i in range(1,21):
    pi[i] = 0

# count the occurrence of each class j
lines = train_label.readlines()
for line in lines:
    j_val = int(line.split()[0])
    pi[j_val] += 1

# divide each class count for the total number of documents
for j in pi.keys():
    pi[j] /= len(lines)


# calculate Pj, the probability distrution over V that models the documents of that class

# read train data and labels
train_data = pd.read_csv('/Users/gio/Documents/DSE/2019-rgm001/DSE210/Lecture4/20news-bydate/matlab/train.data', delimiter=' ', names=['docIdx', 'wordIdx', 'count'])
train_labels = pd.read_csv('/Users/gio/Documents/DSE/2019-rgm001/DSE210/Lecture4/20news-bydate/matlab/train.label', names=['classIdx'])

# get array for documents and class indexes
docIdx = train_data['docIdx']
classIdx = train_labels['classIdx']

# match data and label size by increasing label length
new_train_labels = []
i = 0
for index in range(len(docIdx)-1):
    new_train_labels.append(classIdx[i])
    if docIdx[index] != docIdx[index+1]:
        i += 1
new_train_labels.append(classIdx[i])

# create dataframe with both train and label
df = train_data
df['classIdx'] = new_train_labels




#Alpha value for smoothing
a = 0.001

#Calculate probability of each word based on class
pb_ij = df.groupby(['classIdx','wordIdx'])
pb_j = df.groupby(['classIdx'])
Pr =  (pb_ij['count'].sum() + a) / (pb_j['count'].sum() + 61188 + 1)    

#Unstack series
Pr = Pr.unstack()

#Replace NaN or columns with 0 as word count with a/(count+|V|+1)
for c in range(1,21):
    Pr.loc[c,:] = Pr.loc[c,:].fillna(a/(pb_j['count'].sum()[c] + 61188 + 1))

#Convert to dictionary for greater speed
Pr_dict = Pr.to_dict()




def MNB(df, smooth = False, IDF = False):
    '''
    Multinomial Naive Bayes classifier
    :param df [Pandas Dataframe]: Dataframe of data
    :param smooth [bool]: Apply Smoothing if True
    :return predict [list]: Predicted class ID
    '''
    #Using dictionaries for greater speed
    df_dict = df.to_dict()
    new_dict = {}
    prediction = []
    
    #new_dict = {docIdx : {wordIdx: count},....}
    for idx in range(len(df_dict['docIdx'])):
        docIdx = df_dict['docIdx'][idx]
        wordIdx = df_dict['wordIdx'][idx]
        count = df_dict['count'][idx]
        try: 
            new_dict[docIdx][wordIdx] = count 
        except:
            new_dict[df_dict['docIdx'][idx]] = {}
            new_dict[docIdx][wordIdx] = count

    #Calculating the scores for each doc
    for docIdx in range(1, len(new_dict)+1):
        score_dict = {}
        #Creating a probability row for each class
        for classIdx in range(1,21):
            score_dict[classIdx] = 1
            #For each word:
            for wordIdx in new_dict[docIdx]:
                #Check for frequency smoothing
                #log(1+f)*log(Pr(i|j))
                if smooth: 
                    try:
                        probability=Pr_dict[wordIdx][classIdx]         
                        power = np.log(1+ new_dict[docIdx][wordIdx])     
                
                        score_dict[classIdx]+=power*np.log(probability)
                    except:
                        #Missing V will have log(1+0)*log(a/16689)=0 
                        score_dict[classIdx] += 0                          
            #Multiply final with pi         
            score_dict[classIdx] +=  np.log(pi[classIdx])                          

        #Get class with max probabilty for the given docIdx 
        max_score = max(score_dict, key=score_dict.get)
        prediction.append(max_score)
        
    return prediction








