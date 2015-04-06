% Script
% Decompose test set in 'digit' using parameters from train set.
% Restore test set and compare them with the original images.

% Apply PCA to train set.
pca_decompose_digit;

% Serialize test images.
serial_img_test = pca_convert_cell(test);
n_sample_test = size(serial_img_test, 2);
n_pc = 76;

% Apply PCA1 to test set.
avg_img_train = mean(converted_image, 2);
norm_img_test= serial_img_test - repmat(avg_img_train, 1, n_sample_test);
decomposed_img_test_eigen = pc_eigen(:, 1: n_pc)' * norm_img_test; 

% Apply PCA2 to test set.
decomposed_img_test_svd = pc_svd(:, 1: n_pc)' * norm_img_test;

% Reconstruct the test images.
new_img_test_eigen = repmat(avg_img_train, 1, n_sample_test) + pc_eigen(:, 1: n_pc) * decomposed_img_test_eigen;
new_img_test_svd= repmat(avg_img_train, 1, n_sample_test) + pc_svd(:, 1: n_pc) * decomposed_img_test_svd;

% Find the reconstruction error.
err_eigen = pca_reconstruct_error(serial_img_test, new_img_test_eigen)
err_svd= pca_reconstruct_error(serial_img_test, new_img_test_svd)

% Display reconstructed images.
img_test_eigen = pca_deconvert(new_img_test_eigen);
img_test_svd= pca_deconvert(new_img_test_svd);

for i = 1: n_sample_test
    subplot(3, 10, i);
    display_digit(test{i}, 'actual');
end % for

for i = 1: n_sample_test
    subplot(3, 10, 10 + i);
    display_digit(img_test_eigen{i}, 'actual');
end % for

for i = 1: n_sample_test
    subplot(3, 10, 20 + i);
    display_digit(img_test_svd{i}, 'actual');
end % for

