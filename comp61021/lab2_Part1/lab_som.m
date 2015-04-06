function som = lab_som (trainingData, neuronCount, trainingSteps, startLearningRate, startRadius)
% som = lab_som (trainingData, neuronCount, trainingSteps, startLearningRate, startRadius)
% -- Purpose: Trains a 1D SOM i.e. A SOM where the neurons are arranged
%             in a single line. 
%             
% -- <trainingData> data to train the SOM with
% -- <som> returns the neuron weights after training
% -- <neuronCount> number of neurons 
% -- <trainingSteps> number of training steps 
% -- <startLearningRate> initial learning rate
% -- <startRadius> initial radius used to specify the initial neighbourhood size

% TODO:
% The student will need to complete this function so that it returns
% a matrix 'som' containing the weights of the trained SOM.
% The weight matrix should be arranged as follows, where
% N is the number of features and M is the number of neurons:
%
% Neuron1_Weight1 Neuron1_Weight2 ... Neuron1_WeightN
% Neuron2_Weight1 Neuron2_Weight2 ... Neuron2_WeightN
% ...
% NeuronM_Weight1 NeuronM_Weight2 ... NeuronM_WeightN
%
% It is important that this format is maintained as it is what
% lab_vis(...) expects.
%
% Some points that you need to consider are:
%   - How should you randomise the weight matrix at the start?
%   - How do you decay both the learning rate and radius over time?
%   - How does updating the weights of a neuron effect those nearby?
%   - How do you calculate the distance of two neurons when they are
%     arranged on a single line?

% =======================================================
% My code
% =======================================================

% Assume the data is a N*d matrix where d is the number of dimension.
dim = size(trainingData, 2);
n_sample = size(trainingData, 1);

% Initialize som
som = 0.001 * rand(neuronCount, dim);

t = 1;
T1 = trainingSteps / 2;
T2 = trainingSteps;

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
     
    % Find neighbors of the win neuron.
    up_index = win_index + radius;
    low_index = win_index - radius;
    if up_index > neuronCount
        up_index = neuronCount;
    end % if
    if low_index < 1
        low_index = 1;
    end % if

    % Update weight vectors of the neighbors of the win neuron.
    for j = low_index: up_index
        neuro_distance = j - win_index;
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
