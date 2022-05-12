# Ironhack Project - Classification Case Study: banking industry 💳

by [Roger Serret](https://github.com/rogerserret)

## Prediciting the acceptance of a new credit card

<img width="993" alt="Screenshot 2022-05-12 at 16 49 12" src="https://user-images.githubusercontent.com/101060178/168103495-a5e2fb52-8e73-4c01-8a24-60f53260f673.png">

### Table of contents

1. Project brief
2. Data insights
3. Process & Tools
4. Visualizations
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

The following dashboard visually shows the key insights that came out from that analytic process.

<img width="1200" alt="Screenshot 2022-05-12 at 17 23 00" src="https://user-images.githubusercontent.com/101060178/168110799-103d7ee2-5441-485f-af54-e298a86ef843.png">

For further details, please refer to my [notebook](https://github.com/rogerserret/IronRoger/blob/main/week5_midbootcamp_project/Project/Mid_bootcamp_project.ipynb) or the [Tableau workbook](https://public.tableau.com/app/profile/roger.serret.aracil/viz/Mid-bootcampproject/Dashboard?publish=yes).

#### Analysis

*Which elements are mainly impacting the % of acceptance of the new credit card?*

TARGET:
* **Income level** (The lowest the income level, the highest the acceptance of the offer) 
* **Credit rating** (The lowest the credit rating, the highest the acceptance of the offer) 

OFFER:
* **Reward** (Air Miles is the most effective reward, followed by Points. Cash back is the least effective one)
* **Mailer type** (Postcard converts more than double than Letter)

#### Prediction

CLASSIFICATION TESTED MODELS:
1. Logistic regression
2. KNN
3. Decision Trees
