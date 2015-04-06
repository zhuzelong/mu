function errMatrix = testlr_cv(data, labels, interval)
% Test on examples using bootstrap with different LR.
% Return an error rate matrix.
% No momentum is involved.

fold = 10;
errMatrix = [];
numRow = size(data, 1);
for lr = 0.01 : interval : 1
    model = mylogreg(lr);
    errV = mycv2(model, data, labels, fold);
    errMatrix = [errMatrix; errV]; 
end % lr loop
end % function
