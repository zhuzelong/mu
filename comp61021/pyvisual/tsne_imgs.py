import numpy as np
import scipy.io as sio
from sklearn.manifold import TSNE

# Load data from Matlab dataset.
# Dataset has labels.
data = sio.loadmat('/Users/Zack/Documents/code/Matlab/comp61021/data/Image/dimgs.mat')
imgs = data['dimgs']

# Apply tSNE to images. 
# Use default paramters: n_dims=2, perplexity=30, early_exaggeration=4, 
# learning_rate=1000, n_iteration=1000
model = TSNE()
mapdata = model.fit_transform(imgs)

# Save mapped data to Matlab dataset.
sio.savemat('/Users/Zack/Documents/code/Matlab/comp61021/data/result/mapimgs.mat', {'mapimgs': mapdata})
