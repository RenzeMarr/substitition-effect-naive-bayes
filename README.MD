# Correcting Sales for Substitution Effects Using Naive Bayes in SQL

## Overview

In this notebook, we will use **Naive Bayes**—a probabilistic model based on Bayes' theorem—to adjust 
transaction quantities by considering how stock-outs influence purchasing behavior. 
Specifically, we will focus on how the probability of purchasing Product A (e.g., lemons) 
changes when Product B (e.g., limes) is out of stock. This model allows us to calculate a 
correction ratio that adjusts the observed sales data, enabling us to more closely estimate the true demand of a product.

The correction ratio is the ratio between two posterior probabilities:

- The probability of purchasing Product A when all products are available.
- The probability of purchasing Product A when Product B is out of stock.

For example, if the probability of purchasing lemons is 0.5 when limes are available but increases to 0.8 when limes are out of stock, we can adjust the lemon transactions by applying a correction factor of 0.5 / 0.8 = 0.625.

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