function res=w3lv1n1(data, labels)
% Plot the error rate of k-NN model, k ranges in 1 to 15 (default).
numRow=size(data, 1);
[data, labels]=shufflerows(data, labels);
trainData = data(1: round(numRow/2), :);
trainLabels = labels(1: round(numRow/2), :);
testData = data(round(numRow/2)+1: numRow, :);
testLabels = labels(round(numRow/2)+1: numRow, :);

for k = 1:15
    model=knn('k', k);
    model.train(trainData, trainLabels);
    res(k, 1:2) = [k, model.test(testData, testLabels).err()];
end % for loop
end % function

