function res=w2lv3n1(data, labels)
% Find good parameters via cross validation.
iter=1;
for c=1:1:10
    for gamma=0.01:0.01:1
        res(iter, 1:2)=[c, gamma];
        model=svm(['-g ', num2str(gamma), ' -c ', num2str(c)]);
        errlist=crossvalidation(model, data, labels, 10, 5); % implement cross validation on model
        res(iter, 3)=sum(errlist)/size(errlist, 1); % average error rate
        res(iter, 4)=std(errlist); % std deviation error rate
        iter=iter+1;
    end % gamma loop
end % c loop
end % function 
