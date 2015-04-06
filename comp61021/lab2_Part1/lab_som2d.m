function [som,grid] = lab_som2d (trainingData, neuronCountW, neuronCountH, trainingSteps, startLearningRate, startRadius)
% som = lab_som2d (trainingData, neuronCountW, neuronCountH, trainingSteps, startLearningRate, startRadius)
% -- Purpose: Trains a 2D SOM, which consists of a grid of
%             (neuronCountH * neuronCountW) neurons.
%             
% -- <trainingData> data to train the SOM with
% -- <som> returns the neuron weights after training
% -- <grid> returns the location of the neurons in the grid
% -- <neuronCountW> number of neurons along width
% -- <neuronCountH> number of neurons along height
% -- <trainingSteps> number of training steps 
% -- <startLearningRate> initial learning rate
% -- <startRadius> initial radius used to specify the initial neighbourhood size
%

% TODO:
% The student will need to copy their code from lab_som() and
% update it so that it uses a 2D grid of neurons, rather than a 
% 1D line of neurons.
% 
% Your function will still return the a weight matrix 'som' with
% the same format as described in lab_som().
%
% However, it will additionally return a vector 'grid' that will
% state where each neuron is located in the 2D SOM grid. 
% 
% grid(n, :) contains the grid location of neuron 'n'
%
% For example, if grid = [[1,1];[1,2];[2,1];[2,2]] then:
% 
%   - som(1,:) are the weights for the neuron at position x=1,y=1 in the grid
%   - som(2,:) are the weights for the neuron at position x=2,y=1 in the grid
%   - som(3,:) are the weights for the neuron at position x=1,y=2 in the grid 
%   - som(4,:) are the weights for the neuron at position x=2,y=2 in the grid
%
% x first
% It is important to return the grid in the correct format so that
% lab_vis2d() can render the SOM correctly

% =======================================================
% My code
% =======================================================

% Assume the data is a N*d matrix where d is the number of dimension.
dim = size(trainingData, 2);
n_sample = size(trainingData, 1);

% Initialize som
neuronCount = neuronCountW * neuronCountH;
som = rand(neuronCount, dim);

t = 1;
T1 = trainingSteps;
T2 = trainingSteps / log(startRadius);

grid = zeros(neuronCount, 2);
for k = 1: neuronCount
    if mod(k, neuronCountW) == 0
        grid(k, :) = [neuronCountW, k / neuronCountW];
    else
        grid(k, :) = [mod(k, neuronCountW), (k - mod(k, neuronCountW)) / neuronCountW + 1];
    end % if
end % for

% D is the cityblock distance matrix of neurons.
D = squareform(pdist(grid, 'cityblock'));

while t <= trainingSteps
    i = mod(t, n_sample);
    if i == 0
        i = n_sample;
    end % if

    learning_rate = startLearningRate * exp(-t / T1);
    radius = round(startRadius * exp(-t / T2));

    % Find the best match unit (BMU) for the given data point.
    input_data = trainingData(i, :);
    eudistances = eudistance(som, input_data);
    [junk win_index] = min(eudistances);
     
    neighbors = find_neighbor(D, win_index, radius);

    % Update weight vectors of the neighbors of the win neuron.
    for j = neighbors
        neuro_distance = D(win_index, j); 
        % neighborhood kernel function h_ij(t)
        kernel = exp(-(neuro_distance)^2 / (2 * radius^2));
        som(j, :) = som(j, :) + learning_rate * kernel * (input_data - som(j, :)); 
    end % for

    t = t + 1;

end % while

end % function

function distances = eudistance(X, y)
% Given a matrix X and a colum vector y.
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

function indices = find_neighbor(D, win_index, radius)
% Given a win index and a radius.
% Find all neighbors of the win index based on city distance.
% Indices is a row vector indicating corresponding elements in som.

indices = [];
i = 1;

for dist = D(win_index, :)
    if dist <= radius 
        indices = [indices i];
    end % if
    i = i + 1;
end % for

end % function
