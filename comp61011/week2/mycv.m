function res=mycv(model, data, labels, fold, epoch)
% Implement cross-validation on given model and data set, user define the fold and epoch.
row=size(data, 1);
split=row/fold; % calculate the num of data in each fold
%iter=1;
for i=1: epoch
    newmodel=model;
    [data, labels]=shufflerows(data, labels); % shuffle the data and labels before cross validation
    cvdata=data(1: (fold-1)*split, :); % data for cross validation
    testdata=data((fold-1)*split+1: fold*split, :); % data for external test 
    cvlabels=labels(1: (fold-1)*split, :);
    testlabels=labels((fold-1)*split+1: fold*split, :); 

    for j=1: fold-1
        traindata=cvdata;
        trainlabels=cvlabels;
        traindata((j-1)*split+1: j*split, :)=[]; % delete the test rows from train set.
        trainlabels((j-1)*split+1: j*split, :)=[]; % delete the test rows from train set.
        newmodel=newmodel.traine(traindata, trainlabels); % train on train data and labels.
        res(i, j)=newmodel.test(cvdata((j-1)*split+1: j*split, :), cvlabels((j-1)*split+1: j*split, :)).err();
        %iter=iter+1;
    end % j loop
end % i loop
end % function
