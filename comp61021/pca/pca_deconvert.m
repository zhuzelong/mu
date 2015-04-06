function data = pca_deconvert(serial_data)

% Input: serialized images
% Output: a matrix containing cells of images

[dim n_sample] = size(serial_data);
col = sqrt(dim);

data = {};

for i = 1: n_sample
    data{i} = reshape(serial_data(:, i), col, col);
end % for
