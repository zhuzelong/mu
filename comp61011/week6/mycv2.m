function errV = mycv2(model, data, labels, fold)
% Implement cross-validation on given model and data set, user define the fold.
numRow = size(data, 1);
split = round(numRow/fold); % calculate the num of data in each fold
errV = zeros(1, fold);

m = model;
% shuffle the data and labels before cross validation
[data, labels] = shufflerows(data, labels);    
% split data set
cvdata = data(1: (fold - 1) * split, :); % data for cross validation
testdata = data((fold - 1) * split + 1 : fold*split, :); % data for external test 
cvlabels = labels(1: (fold- 1) * split, :);
testlabels = labels((fold - 1) * split + 1 : fold*split, :); 

% cross validation
for j = 1 : fold-1
    traindata = cvdata;
    trainlabels = cvlabels;
    traindata((j - 1) * split + 1 : j * split, :) = []; % delete the validation rows from train set
    trainlabels((j - 1) * split + 1 : j * split, :)=[]; % delete the test rows from train set
    vdata = cvdata((j - 1) * split + 1 : j * split, :);
    vlabels = cvlabels((j - 1) * split + 1 : j * split, :);

    m = m.traine(traindata, trainlabels);
    m = m.test(vdata, vlabels);
    errV(j) = m.err; % error rate in the j-th iteration
end % j loop

[ans index] = min(errV(1 : fold - 1)); % find the index of smallest error rate
traindata = cvdata;
trainlabels = cvlabels;
traindata((index - 1) * split + 1 : index * split, :) = []; 
trainlabels((index - 1) * split + 1 : index * split, :)=[];

m = m.traine(traindata, trainlabels);
m = m.test(testdata, testlabels); % test on external test data set
errV(fold) = m.err;
end % function
