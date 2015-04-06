function errMatrix = testmomentum(data, labels, lr, interval)
% Test on examples using bootstrap with different momentum.
% Return an error rate matrix.
% Learning rate is fixed.

iter = 1;
numRow = size(data, 1);
for m = 0.01 : interval : 1
    model = mylogreg(lr).mtraine(data, labels, m);
    for j = 1:10
        [bootdata, bootlabels] = mybootstrap(data, labels, numRow);
        errMatrix(iter, j) = model.test(bootdata, bootlabels).err;
    end % j loop
    iter = iter +1;
end % m loop
end % function
