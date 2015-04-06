% Script
% Plot the decomposited data in 2-D space.
% PCA is implemented by 'pca1.m', eigenvalue method.

load iris;

[pc_eigen v_eigen] = pca1(X);

devector_one_two = pca_decomposition_test(X, pc_eigen, 1, 2);
devector_one_three = pca_decomposition_test(X, pc_eigen, 1, 3);
devector_two_three = pca_decomposition_test(X, pc_eigen, 2, 3);

subplot(2, 2, 1);
scatter(devector_one_two(1, :), devector_one_two(2, :)), xlabel('PC1'), ylabel('PC2')

subplot(2, 2, 2);
scatter(devector_one_three(1, :), devector_one_three(2, :)), xlabel('PC1'), ylabel('PC3')

subplot(2, 2, 3);
scatter(devector_two_three(1, :), devector_two_three(2, :)), xlabel('PC2'), ylabel('PC3')
