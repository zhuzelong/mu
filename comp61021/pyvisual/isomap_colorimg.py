import numpy as np
import scipy.io as sio
from sklearn.manifold import Isomap 

# Load data from Matlab dataset.
# Data has no labels.
infile = '/Users/Zack/Documents/code/Matlab/comp61021/data/colorimg/colorimg.mat'
outfile = '/Users/Zack/Documents/code/Matlab/comp61021/data/result/isomap_colorimg.mat'

data = sio.loadmat(infile)
imgs = data['training']
max_sample = 144

# Apply Isomap to color images dataset
# Use default paramters: n_dims=2, neighbor=12, neighbor_algorithm='auto'
model = Isomap(n_neighbors=12, n_components=2)
mapdata = model.fit_transform(imgs[0:max_sample])

print mapdata.shape

# Save mapped data to Matlab dataset.
sio.savemat(outfile, {'isomap_colorimg': mapdata})


