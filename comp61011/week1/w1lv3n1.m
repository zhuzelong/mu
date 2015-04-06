function rslt=wk1lv3n1(data, labels)
% Test the sensitivity of the logreg to the amount of training data
stepsize=10;
model=logreg();
iter=1;
for amount=2: stepsize: size(data, 1)
    rslt(iter, 1)=amount;
    traindata=data(1:amount, :);
    trainlabels=labels(1:amount, :);
    model=model.train(traindata, trainlabels);
    rslt(iter, 2)=model.test(data(1:amount, :), labels(1:amount, :)).err();
    iter=iter+1;
end 
end

