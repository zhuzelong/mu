% Script
% Apply pca1 (eigen) and pca2 (svd) to iris dataset.
% Visualize two principal components.

load iris;

[pc_eigen variance_eigen] = pca1(X);
[pc_svd variance_svd] = pca2(X);

n_sample = size(X, 2);

% Normalization: x - avg(x)
mean_x = mean(X, 2);
data = X - repmat(mean_x, 1, n_sample);

% Project data to PCs of eigen
z1_eigen = pc_eigen(:, 1)' * data;
z2_eigen = pc_eigen(:, 2)' * data;
z3_eigen = pc_eigen(:, 3)' * data;

% Project data to PCs of svd
z1_svd= pc_svd(:, 1)' * data;
z2_svd= pc_svd(:, 2)' * data;
z3_svd= pc_svd(:, 3)' * data;

subplot(2, 2, 1)
scatter(z1_svd, z2_svd), xlabel('PC1'), ylabel('PC2')
subplot(2, 2, 2)
scatter(z1_svd, z3_svd), xlabel('PC1'), ylabel('PC3')
subplot(2, 2, 3)
scatter(z2_svd, z3_svd), xlabel('PC2'), ylabel('PC3')
