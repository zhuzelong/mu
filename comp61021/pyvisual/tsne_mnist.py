import numpy as np
import scipy.io as sio
from sklearn.manifold import TSNE

# Load data from Matlab dataset.
# Dataset has labels.
infile = '/Users/Zack/Documents/code/Matlab/comp61021/data/mnist/train_digits.mat'
outfile = '/Users/Zack/Documents/code/Matlab/comp61021/data/mnist/map_digits.mat'

data = sio.loadmat(infile)
digits = data['train_digits']
max_sample = 5000 

# Apply tSNE to MNIST dataset
# Use default paramters: n_dims=2, perplexity=30, early_exaggeration=4, 
# learning_rate=1000, n_iteration=1000
# Decrease the learning rate to 500
model = TSNE(learning_rate=500)
mapdata = model.fit_transform(digits[0:max_sample])

# Save mapped data to Matlab dataset.
sio.savemat(outfile, {'map_digits': mapdata})
