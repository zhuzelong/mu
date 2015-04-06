function [res, stat]=w2lv1n2(data, labels, iter)
% Carry out k-NN model, k ranges in 1 to 15 (default).
% Randomly split the dataset, user define the iteration.
numRow=size(data, 1);
for i = 1:iter
    split=rand; % randomly create a proportion to split data set 
    trainData = data(1: round(numRow*split), :);
    trainLabels = labels(1: round(numRow*split), :);
    testData = data(round(numRow*split)+1: numRow, :);
    testLabels = labels(round(numRow*split)+1: numRow, :);

    for k = 1:15
    model=knn('k', k);
    model.train(trainData, trainLabels);
    res(i, k) = model.test(testData, testLabels).err();
    end % k loop

    res(i, 16) = split;
    stat(i, 1:2) = [sum(res(i, 1:15))/(size(res, 2)-1), std(res(i, 1:15))];
end % i loop
end % function

