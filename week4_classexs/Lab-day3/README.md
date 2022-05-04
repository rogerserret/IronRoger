# EDA: STEP BY STEP

by [Roger Serret](https://github.com/rogerserret), May 2022

## Defining all the steps of an EDA process

![alt text](https://forum.huawei.com/enterprise/en/data/attachment/forum/202110/15/122724accn70sunn0di0g7.png "data cleaning")

### 🔖 Table of contents

1. Process brief
2. Step by step
3. Key take aways


#### 🚀 Process brief
---
This project contains the definition of the main steps for a cleaning data process. Most of them should be applied in the EDA process of every data analytics project. So read carefully and see how to use them!

All the details are in the [Jupyter Notebook EDA_process.ipynb](https://github.com/rogerserret/IronRoger/blob/main/week4_classexs/Lab-day3/EDA_process.ipynb). To show the impact of each of the steps we have used a dataset called [dataset.csv](https://github.com/rogerserret/IronRoger/blob/main/week4_classexs/Lab-day3/dataset.csv).


#### 👉 Step by step
---
1. Import data
2. Create a data frame
3. Check duplicates 
4. Deal with other drops
5. Reset index
6. Split the data into numericals and categoricals
7. Numerical columns handling: deal with nulls
8. Categorical columns handling: deal with nulls

<img width="606" alt="Screenshot 2022-05-04 at 18 21 18" src="https://user-images.githubusercontent.com/101060178/166726256-a2682887-09c1-4abb-b3ce-8318b3d90461.png">


#### 💡 Key take aways
---
Here are some highlights that you may need in your next projects:
- How to create a nulls summary table?
    * Create a nulls summary table:
    * nulls=pd.DataFrame(d_num.isna().sum()/len(d_num))  (calculate the % of nulls)
    * nulls.reset_index(inplace=True)    (create an index for the nulls df)
    * nulls.columns=['column_name','percentage_nulls’]   (create the table)  
    * nulls.sort_values(by='percentage_nulls', ascending=False)    (order the values)
- Different ways to deal with nulls for numerical columns:
    * One option may be to replace them with the median, mode or mean or by other value we may think it's appropiate.
    * But the most smart way would be to apply machine learning to predict the null values as we have the information of the rest of the columns.
    * A worse option would be to remove rows and the worst to remove a whole column.
    * The most important thing is to understand data: for example if a column of income has nulls it may be logic to substitute them by 0 (depending on the process to obtain the data)
- Different ways to deal with outliers:
    * Removing outliers then scatter plot again
    * IQR (interquile ranges)
    * Upper limit
    * Exclude anything over upper limit OR filter by a fixed limit
            

**GOOD LUCK ON YOUR NEXT PROJECTS!** 

If you have any doubts just reach me out 😉

