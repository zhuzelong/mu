# The package contains Matlab functions involved in the experiment.

1. Implementation of Logistic Regression
    - mylogreg: The core function that implements the algorithm.
    - plotEntropy: Plot entropy against one parameter 'w_j'.

2. Selection of Learning Rate
    - mybootstrap: Implementation of bootstrap algorithm.
    - mycv2: Implementation of cross validation.
    - testlr: Test with incremental learning rates, based on bootstrap.
    - testlr_cv: The same to 'testlr', except based on cross validaiton.
    - selectlr: Plot error rates against learning rates, based on bootstrap, on 'datab', 'datag', 'heart'.
    - selectlr_cv: The same to 'selectlr', except based on cross validation.

3. Selection of Momentum
    - testmomentum: Test with incremental momentum, given a fixed learning rate, based on bootstrap.
    - selectmomentum: Plot error rates against momentum at different learning rates, based on bootstrap, on 'datab', 'datag', 'heart'.

4. Effect of Momentum
    - contrastmomentum: Constrast models with / without momentum.

5. Complement Experiment
    - testlr_datag: The same to 'testlr', except the learning rates are much larger, especially designed for 'datag'.
