% Script
% Plot the decomposited data in 2-D space.
% PCA is implemented by 'pca2.m', svd method.

load iris;

[pc_svd v_svd] = pca2(X);

devector_one_two = pca_decomposition_test(X, pc_svd, 1, 2);
devector_one_three = pca_decomposition_test(X, pc_svd, 1, 3);
devector_two_three = pca_decomposition_test(X, pc_svd, 2, 3);

subplot(2, 2, 1);
scatter(devector_one_two(1, :), devector_one_two(2, :)), xlabel('PC1'), ylabel('PC2')

subplot(2, 2, 2);
scatter(devector_one_three(1, :), devector_one_three(2, :)), xlabel('PC1'), ylabel('PC3')

subplot(2, 2, 3);
scatter(devector_two_three(1, :), devector_two_three(2, :)), xlabel('PC2'), ylabel('PC3')
