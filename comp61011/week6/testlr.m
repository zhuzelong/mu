function errMatrix = testlr(data, labels, interval)
% Test on examples using bootstrap with different LR.
% Return an error rate matrix.
% No momentum is involved.

iter = 1;
numRow = size(data, 1);
for lr = 0.01 : interval : 1
    model = mylogreg(lr).traine(data, labels);
    for j = 1:10
        [bootdata, bootlabels] = mybootstrap(data, labels, numRow);
        errMatrix(iter, j) = model.test(bootdata, bootlabels).err;
    end % j loop
    iter = iter +1;
end % lr loop
end % function
