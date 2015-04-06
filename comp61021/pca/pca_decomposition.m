function devector = pca_decomposition(data, PC, variance)

% Implement decomposition using two PCs.
% User defines which two PCs to implement PCA.
% data: input data, a d*N matrix, d is dimension, N is sample.
% PC: principal component, a matrix containing the pc.
% variance: variance vector.
% devector: the decomposited vector.

n_pc = pca_select_n_pc(variance);
n_sample = size(data, 2);

% Normalization: x - avg(x)
mean_x = mean(data, 2);
data = bsxfun(@minus, data, mean_x);

% Project data to the eigenvector.
% Decompose data.
devector = PC(:, 1:n_pc)' * data;
