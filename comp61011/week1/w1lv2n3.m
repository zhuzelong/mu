function rslt=wk1lv2n3(data, labels, N)
% implement cross-validation to identify a good learning_rate for logreg
row=size(data, 1);
split=row/N; % number of instance in one fold

testData=data(1: split, :); % for external final test
testLabels=labels(1: split, :)

cvData=data(split: row, :); % for cross-validation
cvLabels=labels(split: row, :);

stepsize=0.05
model=logreg();
iter=1;

for learningrate=0.1: stepsize: 1
    rslt(iter, 1)=learningrate;
    for i=1: N-1
        valData=cvData((i-1)*split+1: i*split, :);
        valLabels=cvLabels((i-1)*split+1: i*split, :);
        
        % delete the validation rows from cvData
        trainData=cvData;
        trainData((i-1)*split+1: i*split, :)=[];
        trainLabels=cvLabels;
        trainLabels((i-1)*split+1: i*split, :)=[];
        
        model=model.train(trainData, trainLabels);
        res=model.test(valData, valLabels);
        rslt(iter, i+1)=res.err();
    end
    model=model.train(cvData, cvLabels);
    res=model.test(testData, testLabels);
    rslt(iter, N+1)=res.err();
    iter=iter+1;
end
end

