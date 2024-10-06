# Correcting Sales for Substitution Effects Using Naive Bayes in SQL

## Overview

In this project, we apply a Naive Bayes model in SQL to capture substitution effects. 
The substitution effect occurs when products go out of stock, and customers switch to alternative products (substitutes).

We implement the entire solution in SQL, breaking down the problem into manageable components.

## Structure / How it works

**Input**: Transaction data, product availability data, ...

**Naive Bayes**:

- Priors: We calculate the prior probabilities of buying each product.
- Likelihoods: We compute the likelihoods of a product being chosen given that other products are available or unavailable (to model substitution behavior).
- Posterior: Using these priors and likelihoods, we calculate the posterior probabilities of buying substitute products when the preferred product is unavailable.

**Output**: The final probabilities are used to correct sales for the substitution effects found.