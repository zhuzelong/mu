% Script
% Increase the LR in datag, to see if the error rate will increase.

load datag;

err=[];
for lr = 2:10
    model = mylogreg(lr);
    model = model.traine(data, labels); % Train without momentum
    model = model.test(data, labels);
    err = [err, model.err];
end % for loop
err
