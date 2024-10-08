# Correcting Sales for Substitution Effects Using Naive Bayes in SQL

## Overview

In this notebook, we use **Naive Bayes**—a probabilistic model based on Bayes' theorem—to adjust 
sales for stock-out substitution. 
Specifically, we focus on how the probability of purchasing Product A (e.g., lemons) 
changes when Product B (e.g., limes) is out of stock. With this model we calculate a 
correction ratio that adjusts the observed sales data to obtain a better estimate of the true demand of a product.

The correction ratio is the ratio between two posterior probabilities:

- The probability of purchasing Product A when all products are available.
- The probability of purchasing Product A when Product B is out of stock.

Consider the example of limes and lemons again. Suppose the probability with which a customer purchases a lemon equals 0.5 when both limes and lemons are available, but increases to 0.8 when limes are out of stock. Now, if we sell 1000 lemons while limes were out of stock, we adjust the (inflated) sales of lemons by applying a correction factor of 0.5 / 0.8 = 0.625, to obtain an estimate for the demand of lemons of 625 units.

## Motivation
Retailers benefit from uncontraining the demand to make accurate forecasts. 
This project offers a practical solution by "unconstraining" the demand, adjusting the observed sales
to reflect what would have happened if all products had been available.

## Structure

- **explanation_of_queries.ipynb**: A Jupyter notebook that walks through the Naive Bayes calculations step by step, explaining how to compute priors, likelihoods, posteriors, and how to apply the substitution correction to transaction data.
- **input_data/**: Example transaction and product data that serves as input to the model.
- **naive_bayes/**: Scripts implementing the Naive Bayes calculations in SQL.
- **output_data/**: Corrected sales data that reflects true demand, adjusted for substitution effects.

## Example

In the notebook, we walk through an example involving lemons and limes. If limes are out of stock, customers may switch to lemons, leading to inflated lemon sales. By applying the model, we correct the lemon sales to reflect what the demand would have been if limes were in stock.

For instance:

- Observed sales: 3 lemons sold when limes are out of stock.
- Corrected sales: Applying a substitution correction ratio of 0.577, the true demand for lemons is estimated at 1.731.