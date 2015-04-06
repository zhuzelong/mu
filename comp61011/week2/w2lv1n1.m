function res=w2lv1n1(data, labels)
% Calculate the error rate of 5-fold Cross-Validation of logreg.
row=size(data, 1);
fold=row/5;
model=logreg();
for i=1:5
    testset=data((i-1)*fold+1: i*fold, :);
    trainset=data;
    trainset((i-1)*fold+1: i*fold, :)=[]; % delete the test rows from trainset
    testlabels=labels((i-1)*fold+1: i*fold, :);
    trainlabels=labels;
    trainlabels((i-1)*fold+1: i*fold, :)=[]; % delete the test rows from trainlabels
    model=model.train(trainset, trainlabels);
    res(i, 1)=model.test(testset, testlabels).err();
end % for loop
end

