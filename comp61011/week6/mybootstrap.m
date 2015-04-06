function [bootdata bootlabels] = mybootstrap(data, labels, n)
% Bootstrap data and labels, n is the capacity of bootstrap.
numRow = size(data, 1);
Index = randi(numRow, n, 1);
bootdata = data(Index, :);
bootlabels = labels(Index);
