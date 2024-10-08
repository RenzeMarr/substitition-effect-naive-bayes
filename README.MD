# Correcting Sales for Substitution Effects Using Naive Bayes in SQL

## Overview

In this project, we apply a **Naive Bayes** model in SQL to correct sales data for **substitution effects**. 
The substitution effect occurs when certain products are out of stock, causing customers to purchase 
alternative products (substitutes). By accounting for these substitution patterns, we get a better
estimation of the true demand. 

We implement the entire solution using SQL, breaking down the problem into manageable components 
including the prior probabilities, likelihoods, and posterior probabilities.

## Motivation
Retailers, especially large ones like Albert Heijn, benefit from uncontraining the demand to make accurate forecasts. 
This project offers a practical solution by "unconstraining" the demand, adjusting the observed sales
to reflect what would have happened if all products had been available.

## Structure

- **notebook.ipynb**: A Jupyter notebook that walks through the Naive Bayes calculations step by step, explaining how to compute priors, likelihoods, posteriors, and how to apply the substitution correction to transaction data.
- **input_data/**: Example transaction and product data that serves as input to the model.
- **naive_bayes/**: Scripts implementing the Naive Bayes calculations in SQL.
- **output_data/**: Corrected sales data that reflects true demand, adjusted for substitution effects.

## Example

In this notebook we walk through an example involving lemons and limes. If limes are out of stock, customers may switch to lemons, leading to inflated lemon sales. By applying the model, we correct the lemon sales to reflect what the demand would have been if limes were in stock.

For instance:

- Observed sales: 3 lemons sold when limes are out of stock.
- Corrected sales: Applying a substitution correction ratio of 0.577, the true demand for lemons is estimated at 1.731.