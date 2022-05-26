#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import requests
from bs4 import BeautifulSoup


# # Scrap a list of 100 top songs from Billboard website

# - get website url
# - run request on url
# - check status code
# - parse the html as soup
# - pretty print to read the soup
# - find the right html or css
# - get song title, singer and rank
# - clean and turn the data into a data frame

# ## Get website url

# In[2]:


url = 'https://www.billboard.com/charts/hot-100/'


# ## Run request on url

# In[3]:


response = requests.get(url)


# ## Check status code

# In[4]:


response.status_code


# ## Parse the html as soup

# In[5]:


soup = BeautifulSoup (response.content,'html.parser')


# ## Pretty print to read the soup

# In[6]:


print(soup.prettify())


# ## Find the right HTML / CSS for one element

# In[7]:


soup.select('h3.c-title.a-no-trucate')


# In[8]:


# check the length (number of elements to see if we are where we should be)
len(soup.select('h3.c-title.a-no-trucate'))


# In[9]:


# sample one song and get the information back
# iterate for all songs
# for song title:
soup.select('h3.c-title.a-no-trucate')[1].get_text(strip=True)
# strip = true removes all the \n\n\t\
# If there is a space in the name of the class we put a "."


# In[10]:


# for singer:
soup.select('span.c-label.a-no-trucate')[1].get_text(strip=True)


# In[11]:


# the rank we will create it with the for loop


# ## Expand to all elements

# In[12]:


rank_position = []
song_title = []
singer_name = []

len_song_titles=len(soup.select('h3.c-title.a-no-trucate'))
len_singer_names=len(soup.select('span.c-label.a-no-trucate'))


# In[13]:


print(len_song_titles,len_singer_names)


# In[14]:


from tqdm.notebook import tqdm 


# In[15]:


for i in tqdm(range(len_song_titles)):
    rank_position.append(i+1)
    song_title.append(soup.select('h3.c-title.a-no-trucate')[i].get_text(strip=True))
    singer_name.append(soup.select('span.c-label.a-no-trucate')[i].get_text(strip=True))


# ## Create a clean df

# In[16]:


clean_song_title=[i.strip('(').strip(')') for i in song_title]
clean_singer_name=[i.strip('(').strip(')') for i in singer_name]
# remove comas


# In[17]:


songs_100=pd.DataFrame({'rank': rank_position, 'song' : song_title, 'singer' : singer_name})


# In[18]:


songs_100


# In[19]:


songs_100.to_excel(r'/Users/rogerserret/Documents/GitHub/IronRoger/week7_classexs/top100songs.xlsx', index = False)


# In[20]:


def billboard_scrape():
    # obtain information
    url = 'https://www.billboard.com/charts/hot-100/'  # get the url
    response = requests.get(url)   # run request
    soup = BeautifulSoup (response.content,'html.parser')   # convert to soup file
    
    # create empty lists
    rank_position = []
    song_title = []
    singer_name = []   
    
    #fill the lists
    for i in range(len_song_titles):
        rank_position.append(i+1)
        song_title.append(soup.select('h3.c-title.a-no-trucate')[i].get_text(strip=True))
        singer_name.append(soup.select('span.c-label.a-no-trucate')[i].get_text(strip=True))
    
    # create a dataframe
    clean_song_title=[i.strip('(').strip(')') for i in song_title]
    clean_singer_name=[i.strip('(').strip(')') for i in singer_name]
    songs_100=pd.DataFrame({'rank': rank_position, 'song' : song_title, 'singer' : singer_name})
    
    return songs_100
    


# In[21]:


billboard_scrape()

