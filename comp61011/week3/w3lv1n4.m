function tmodel = w3lv1n4(data, labels)
% Build a dtree model on randomly split data set.
split=rand;
numRow=size(data, 1);
trainData=data(1: round(numRow*split), :);
trainLabels=labels(1: round(numRow*split), :);

tmodel=dtree().train(trainData, trainLabels);
end % function

