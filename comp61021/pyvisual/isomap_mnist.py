import numpy as np
import scipy.io as sio
from sklearn.manifold import Isomap 

# Load data from Matlab dataset.
# Data has no labels.
infile = '/Users/Zack/Documents/code/Matlab/comp61021/data/mnist/train_digits.mat'
outfile = '/Users/Zack/Documents/code/Matlab/comp61021/data/result/isomap_mnist_n30.mat'

data = sio.loadmat(infile)
digits = data['train_digits']
max_sample = 5000

# Apply Isomap to MNIST dataset
# Use default paramters: n_dims=2, neighbor=12, neighbor_algorithm='auto'
model = Isomap(n_neighbors=30, n_components=2)
mapdata = model.fit_transform(digits[0:max_sample])

print mapdata.shape

# Save mapped data to Matlab dataset.
sio.savemat(outfile, {'map_digits_isomap': mapdata})

