function cost = somcost(data, som)
% Given data points and SOM of neurons
% Calculate cost function to measure the effect of approximation

n_sample = size(data, 1);
total_dist = 0;

for i = 1: n_sample
    distances = eudistance(som, data(i, :));
    total_dist = total_dist + min(distances);
end % for

cost = total_dist / n_sample;

end % function


function distances = eudistance(X, y)
% Given a matrix X and a row vector y.
% Calculate the euclidean distance between each row of X and y.
% Distances is a column vector (m*1).

if size(y, 1) ~= 1
    error('Please type in a row vector for the second parameter.');
end % if

if size(X, 2) ~= size(y, 2)
    error('Dimension does not match.');
end % if

% n is the number of som 
n = size(X, 1);
diff = bsxfun(@minus, X, y);
distances = sum(abs(diff) .^2, 2);
   
end % function
