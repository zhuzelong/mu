function [PC,V] = pca1(data)
% PCA1: Perform PCA using covariance.
% data - MxN matrix of input data
% (M dimensions, N trials)
% PC - each column is a PC
% V - Mx1 matrix of variances, contains eigenvalues

[M,N] = size(data);

% subtract off the mean for each dimension
mn = mean(data,2);
data = data - repmat(mn,1,N);

% calculate the covariance matrix
covariance = 1 / (N-1) .* data * data';

% find the eigenvectors and eigenvalues
[PC, V] = eig(covariance);

% extract diagonal of matrix as vector
V = diag(V);

% sort the variances in decreasing order
% junk is the sorted vector, which is not used
% rindices are the indices of the corresponding index in the original vector
%[junk, rindices] = sort(-1*V);
[junk, rindices] = sort(V, 'descend');
% V = V(rindices) is equal to 'junk', the sorted vector
%V = V(rindices);
V = junk;
PC = PC(:,rindices);
