#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

import warnings
warnings.filterwarnings("ignore")

from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.linear_model import LinearRegression
from sklearn.svm import SVR
from sklearn.metrics import classification_report
from sklearn.metrics import mean_absolute_error,mean_squared_error,r2_score
import pickle


# In[2]:


df=pd.read_csv("Tax Forecast Dataset.xlsx.csv")


# In[3]:


df.head()


# In[4]:


df.info()


# In[6]:


df.describe()


# In[5]:


x=df.iloc[:,:-1]
y=df.iloc[:,-1]


# In[6]:


xtrain,xtest,ytrain,ytest=train_test_split(x,y,test_size=0.20,random_state=0)


# In[7]:


LR=LinearRegression()


# In[8]:


LR.fit(xtrain,ytrain)
ypred=LR.predict(xtest)
train=LR.score(xtrain,ytrain)
test=LR.score(xtest,ytest)


# In[9]:


print(f"Training Accuracy:{train}\nTesting Accuracy:{test}")


# In[10]:


mae=mean_absolute_error(ytest,ypred)
mse=mean_squared_error(ytest,ypred)
rmse=np.sqrt(mse)
r2=r2_score(ytest,ypred)
print(f"MAE:{mae}\nMSE:{mse}\nRMSE:{rmse}\nAccuracy:{r2}")

pickle.dump(LR, open('model.pkl','wb'))

# In[20]:


'''def Tax():
    name=input("Your Name:")
    inc=float(input("Enter your annual income:"))
    oth=float(input("Enter income from other soure:"))
    NPS=float(input("Contribution to NPS:"))
    Lea=float(input("Leave Encashment:"))
    Tran=float(input("Transport allowance to specially abled:"))
    Int=float(input("Enter interest paid towards home loan:"))
    othe=float(input("Enter other investments:"))
    pred=LR.predict([[inc,oth,NPS,Lea,Tran,Int,othe]])
    print("Tax on Income is:",pred)


# In[23]:


Tax()'''


