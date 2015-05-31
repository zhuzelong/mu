import numpy as np
import scipy
from sklearn.manifold import TSNE

# Load data from Matlab dataset.
# Dataset has labels.
cnncodes = scipy.io.loadmat('/Users/Zack/Documents/code/Matlab/comp61021/data/cnncodes/cnncodes.mat')

# Apply tSNE to cnncodes dataset
# Use default paramters: n_dims=2, perplexity=30, early_exaggeration=4, 
# learning_rate=1000, n_iteration=1000
model = TSNE()
mapdata = model.fit_transform(cnncodes)

# Save mapped data to Matlab dataset.
scipy.io.savemat('/Users/Zack/Documents/code/Matlab/comp61021/data/cnncodes/mapcnncodes.mat', mapdata)
