#!/usr/bin/env python
# coding: utf-8

# In[28]:


import warnings
warnings.filterwarnings("ignore")

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split

import pickle

# In[3]:


df = pd.read_csv("Investmentguru.csv")


# In[4]:


df.info()


# In[7]:


from sklearn.preprocessing import StandardScaler
sc = StandardScaler()
x = sc.fit_transform(df)


# In[ ]:





# In[8]:


from sklearn.cluster import KMeans
#wcss = []

'''for i in range(1, 11):
    kmeans = KMeans(n_clusters=i, random_state=1)
    kmeans.fit(x)
    wcss.append(kmeans.inertia_)


# In[9]:


plt.plot(range(1,11), wcss, "o--")
plt.grid()
plt.show()'''


# In[12]:


kmeans = KMeans(n_clusters=3, random_state=1)
ylabel = kmeans.fit_predict(x)


# In[13]:


df["Class"]=ylabel


# In[17]:


df.tail(30)


# In[18]:


kmeans.cluster_centers_


# In[16]:





# In[26]:


x=df.iloc[:,:-1]
y=df.iloc[:,-1]


# In[29]:


xtrain,xtest,ytrain,ytest=train_test_split(x,y,test_size=0.20,random_state=0)


# In[33]:


def mymod(model):
    model.fit(xtrain,ytrain)
    ypred=model.predict(xtest)
    train=model.score(xtrain,ytrain)
    test=model.score(xtest,ytest)
    print(f"Training Accuracy:{train}\nTesting Accuracy:{test}\n\n")
    print(classification_report(ytest,ypred))
    return model


# In[34]:


from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import classification_report


# In[35]:


DT=mymod(DecisionTreeClassifier())


# In[55]:
pickle.dump(DT, open('model.pkl','wb'))

'''def Investment_plans():
    list0=["Tata AIA Fortune Pro","LIC SIIP","PNB Metlife Mera Wealth Plan"]
    list1=["HDFC Standard Sampoorn Nivesh (11X)","ICICI Prudential Signature","SBI eWealth Insurance"]
    list2=["Max Life Online Savings Plan","Bajaj Allianz Smart Wealth Goal","Birla Sun Life Wealth Aspire Plan"]
    name=input("Your Name:")
    inc=float(input("Give your annual income:"))
    pred=DT.predict([[inc]])
    if pred==0:
        for i in list0:
            print("Please invest on",i)
    elif pred==1:
        for i in list1:
            print("Please invest on",i)
    elif pred==2:
        for i in list2:
            print("Please invest on",i)
    else:
        print("Stock Marketing")


# In[57]:


Investment_plans()'''

