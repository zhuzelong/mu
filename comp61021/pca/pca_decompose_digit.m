% Script
% Decompose train set in 'digit.mat' using pca1 and pca2.

load digit;

converted_image = pca_convert_cell(train);

[pc_eigen variance_eigen] = pca1(converted_image);
[pc_svd variance_svd] = pca2(converted_image);

decomposed_image_eigen = pca_decomposition(converted_image, pc_eigen, variance_eigen);
decomposed_image_svd = pca_decomposition(converted_image, pc_svd, variance_svd);

