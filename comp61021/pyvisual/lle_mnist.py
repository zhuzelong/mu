import numpy as np
import scipy.io as sio
from sklearn.manifold import LocallyLinearEmbedding as lle 

# Load data from Matlab dataset.
# Data has no labels.
infile = '/Users/Zack/Documents/code/Matlab/comp61021/data/mnist/train_digits.mat'
outfile = '/Users/Zack/Documents/code/Matlab/comp61021/data/result/lle_mnist_n30.mat'

data = sio.loadmat(infile)
digits = data['train_digits']
max_sample = 5000

# Apply LLE to MNIST dataset
# Use default paramters: neighbor=12, n_dims=2, max_iter=100
model = lle(n_neighbors=30, n_components=2)
mapdata = model.fit_transform(digits[0:max_sample])

print mapdata.shape

# Save mapped data to Matlab dataset.
sio.savemat(outfile, {'map_digits_lle': mapdata})
