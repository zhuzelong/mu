function m = pca_convert_cell(data)

% Input data is a matrix containing cells.
% Each cell is a grey-level image, namely d*d matrix.
% Convert each cell to a column vector.
% Output matrix is a (d^2, n_images) matrix.

n_images = size(data, 2);
d = size(data{1}, 2);

m = zeros(d^2, n_images);

for i = 1: n_images
    m(:, i) = data{i}(:);
end % for
