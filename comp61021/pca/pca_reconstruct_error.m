function err = pca_reconstruct_error(origin_data, restored_data)

% Input the original data and the restored data that is reconstructed
% from the compressed data.
% Calculate the reconstruction error.

n_sample = size(origin_data, 2);
err = zeros(1, n_sample);
diff = origin_data - restored_data;

for i = 1: n_sample
    err(i) = norm(diff(:, i)) ^ 2;
end % for

err = mean(err);


