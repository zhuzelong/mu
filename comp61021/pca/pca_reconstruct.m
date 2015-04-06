function data = pca_reconstruct(compress_data, centroid, PC)

% Input compressed data, try to restore the original data.
% Centroid is the mean vector of the original data.
% PC is principal components used to compress the original data.

n_sample = size(compress_data, 2);

% Extend the centroid vector to a matrix.
mean_matrix = repmat(centroid, 1, n_sample);

% Reconstruct original data.
data = mean_matrix + PC * compress_data;
