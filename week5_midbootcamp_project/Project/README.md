# Ironhack Project - Classification Case Study: banking industry 💳

by [Roger Serret](https://github.com/rogerserret)

## Predicting the acceptance of a new credit card

<img width="993" alt="Screenshot 2022-05-12 at 16 49 12" src="https://user-images.githubusercontent.com/101060178/168103495-a5e2fb52-8e73-4c01-8a24-60f53260f673.png">

### Table of contents

1. Project brief
2. Data insights
3. Process & Tools
4. Deliverables
5. Final recommendations

---

### Project brief

#### WHY (Overall goal)

The bank wants to understand the demographics and other characteristics of its customers that accept a credit card offer and that do not accept a credit card.

#### WHAT (Problem)

The observational data for these kinds of problems is somewhat limited in that often the company sees only those who respond to an offer.

#### HOW (Solution)

The bank designs a focused marketing study, with 18,000 current bank customers. This focused approach allows the bank to know who does and does not respond to the offer, and to use existing demographic data that is already available on each customer.

#### Project goals

1. Build a model that will provide insight into why some bank customers accept credit card offers. 
2. Help the bank find out potential areas of opportunities

---

### Data insights

Leveraging on the [data](https://github.com/rogerserret/IronRoger/blob/main/week5_midbootcamp_project/data_mid_bootcamp_project_classification-master/creditcardmarketing.csv) we were provided with, we used [SQL](https://github.com/rogerserret/IronRoger/blob/main/week5_midbootcamp_project/Project/SQL_questions.sql) to query the data base and Tableau's and Python's data visualisation tools to explore the relationships between features.

The following dashboard visually shows the key insights that came out from that analytic process:

<img width="1200" alt="Screenshot 2022-05-12 at 17 23 00" src="https://user-images.githubusercontent.com/101060178/168110799-103d7ee2-5441-485f-af54-e298a86ef843.png">

For further details, please refer to my [notebook](https://github.com/rogerserret/IronRoger/blob/main/week5_midbootcamp_project/Project/Mid_bootcamp_project.ipynb) or the [Tableau workbook](https://public.tableau.com/app/profile/roger.serret.aracil/viz/Mid-bootcampproject/Dashboard?publish=yes).

#### - ANALYSIS -

*Which elements are mainly impacting the % of acceptance of the new credit card?*

CUSTOMER:
* **Income level** (The lowest the income level, the highest the acceptance of the offer) 
* **Credit rating** (The lowest the credit rating, the highest the acceptance of the offer) 

OFFER:
* **Reward** (Air Miles is the most effective reward, followed by Points. Cash back is the least effective one)
* **Mailer type** (Postcard converts more than double than Letter)

*Other relevant findings*:
* There is no correlation between the features “average balance”, the “quarter balances”, “overdraft protection” or “own your home” and the % of "offer acceptance".
* There is no correlation between "income level" and "average balance".
* The higher the "average balance", the bigger the amount of "homes owned".

#### - PREDICTION -

CLASSIFICATION TESTED MODELS:
1. Logistic regression
2. KNN
3. Decision Trees

After many iterations, my selected model for that business case would be the KNN. However, as Decision Trees is also giving really good results, it would be interesting to analyze the business impact of both and see which one provides the highest profit for the company.

<img width="838" alt="Screenshot 2022-05-12 at 18 40 04" src="https://user-images.githubusercontent.com/101060178/168126144-ad873463-aa33-4205-8097-d47678e9e8d6.png">

The confusion matrix also helps to observe the difference between both models:

<img width="840" alt="Screenshot 2022-05-12 at 18 50 30" src="https://user-images.githubusercontent.com/101060178/168127967-ad0ca020-19aa-4208-84ce-b47eb04cc967.png">

As you can see, we would be **losing 2,6X** more customers with the Decision Trees model than with the KNN model.

IMBALANCED DATA

I found a clear problem of imbalanced data in our target:

<img width="847" alt="Screenshot 2022-05-12 at 18 58 12" src="https://user-images.githubusercontent.com/101060178/168129236-c7eeb92b-9b44-49f9-a101-58aa290dc76b.png">

To fix it, I tried three different techniques:
* SMOTE
* Tomek Links
* A combination of both

SMOTE gave me the best results and it was applied prior to all the classification models mentioned above.

FEATURE ENGINEERING

* Feature engineering was not improving results so I applied the models considering all the features.
* I also checked collinearity between "average balance" and the "quarter balance" features, but it had no impact on the final outcome.

---

### Process & Tools

* *Github*: set up of my Github repo to store all my project files
* *Trello*: set up a Kanban board in Trello to keep track of the tasks and be able to prioritize 
* *SQL*: started with the independent task of completing the SQL queries
* *Tableau and EDA*: followed with the Tableau activity and proceeded with the assessment of the dataframe to get ready for cleaning
* *Data cleaning & wrangling in Python*: column names cleaning, drop 'customer_number' column, drop null values, checked duplicates
* *EDA*: More EDA in Python to check correlation between features and others
* *Pre-processing*: Log Transformation, encoding with Dummies 
* *Machine Learning Model*: using scikit learn
  * iteration 1 (X): applied a Logistic Regression model having only used preprocessing and used it as a benchmark for the following iterations 
  * iteration 2 (X_i2): using SMOTE to improve the imbalance of the target
  * iteration 3 (X_i3): using Tomek Links to improve the imbalance of the target
  * iteration 4 (X_i4): using SMOTE and Tomek Links combined to improve the imbalance of the target
  * iteration 5 (X_i5): applied some feature engineering (dropping q balance columns) based on X_i2
  * iteration 6 (X_i6): applied some feature engineering (droping non-correlated features) based on X_i2
  * iteration 7 (X_i7): applied a KNN classification model combined with SMOTE
  * iteration 8 (X_i8): applied a Decision Trees classification model combined with SMOTE

<img width="704" alt="Screenshot 2022-05-12 at 19 19 17" src="https://user-images.githubusercontent.com/101060178/168132622-a376ce4b-6153-4abb-b1df-b3c2d72ff935.png">

---

### Deliverables

* SQL: [Link to SQL activity](https://github.com/rogerserret/IronRoger/blob/main/week5_midbootcamp_project/Project/SQL_questions.sql)
* Tableau: [Link to Tableau Workbook](https://public.tableau.com/app/profile/roger.serret.aracil/viz/Mid-bootcampproject/Dashboard?publish=yes)
* Python: [Link to Jupyter Notebook](https://github.com/rogerserret/IronRoger/blob/main/week5_midbootcamp_project/Project/Mid_bootcamp_project.ipynb)
* Project deck: [Link to the presentation](https://docs.google.com/presentation/d/1gBfdD4QKXUhK0XqAICLK4Ar6m8wnxAgE-9M0m8tPA5c/edit?usp=sharing)

---

### Final business recommendations

* Deeply assess the risk of each customer and try to find the right balance between conversion and risk.
* Create a business case and assess which reward is better to focus on regarding its costs and it’s probability of acceptance of the offer.
* Definitely use postcards as the mailer type. Cost of postcards and letters are quite similar, the advantage is clear.
* In order to predict which customers are going to accept or not a credit card offer I would recommend using a KNN classification model combined with SMOTE.

___

If you have any questions, please don't hesitate to reach out to me.

🚀 Roger Serret 
