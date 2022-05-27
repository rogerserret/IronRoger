#!/usr/bin/env python
# coding: utf-8

# # Creating a MVP for the song recommender

# - Import data and create df
# - Collect user input
# - Deal with possible user input errors / behaviours
# - Look for what the user has input, against the 100 hot song collection
# - Feedback to user if their song is hot or not
# - Provide a recommendation from the collection - potentially randomly

# ## Import data and create df

# In[1]:


import pandas as pd
import random


# In[2]:


top100= pd.read_excel('top100songs.xlsx') # import df
top100.head()


# In[3]:


top100['song'] = top100['song'].str.rstrip().str.lstrip().str.lower() #lower case all song and singer names
top100['singer'] = top100['singer'].str.lower()


# In[4]:


top100


# ## Collect user input

# In[5]:


top100songs=top100['song'].tolist() # a column is a series, we should convert it to list


# In[6]:


top100songs


# In[7]:


song_name = input("Write your favourite song to check if it's in the TOP100: ").lower()
if len(song_name) < 3:
    print("Write a song with more than 3 characters, don't be lazy!")
elif song_name in top100songs:
    print('Your song is in the TOP100 list! I also recommend you to listen to: ', random.choice(top100songs))
else:
    print('You like weird music dude, your song is not in the TOP100 list!')


# In[8]:


def top100_check():
    from billboard_scraping import billboard_scrape
    top100 = billboard_scrape()
    
    # lower case all song and singer names and convert to list
    top100['song'] = top100['song'].str.rstrip().str.lstrip().str.lower() #lower case all song and singer names
    top100['singer'] = top100['singer'].str.lower()
    top100songs=top100['song'].tolist()
    
    # check song
    song_name = input("Write your favourite song to check if it's in the TOP100: ").lower()
    if len(song_name) < 3:
        print("Write a song with more than 3 characters, don't be lazy!")
    elif song_name in top100songs:
        print('Your song is in the TOP100 list! I also recommend you to listen to: ', random.choice(top100songs))
    else:
        print('You like weird music dude, your song is not in the TOP100 list!')  
    


# In[11]:


top100_check();

