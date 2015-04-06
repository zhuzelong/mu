function [PC,V] = pca2(data)

% PCA2: Perform PCA using SVD.
% data - MxN matrix of input data
% (M dimensions, N trials)
% PC - each column is a PC
% V - Mx1 matrix of variances

[M,N] = size(data);

% subtract off the mean for each dimension
% mn is the mean of features
mn = mean(data,2);
% extend the vector mn to a matrix
data = data - repmat(mn,1,N);

% construct the matrix Y
Y = data' ./ sqrt(N-1);

% SVD does it all
% Y = u * S * PC'
[u,S,PC] = svd(Y);

% calculate the variances
% S is converted to a vector containing the singular values
S = diag(S);
V = S .* S;
