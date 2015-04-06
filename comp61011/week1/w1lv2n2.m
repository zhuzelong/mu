function [rslt, e]=w1lv2n2(data, labels)
% Train/test 10 times, in each iteration, change the iteration var (plus 10 each time) and
% shuffle the rows. Plot the error rate with error bar.
model=logreg();
for i=1:10
    model.iterations=i*10;
    [randData, randLabels]=shufflerows(data, labels);
    model=model.train(randData, randLabels);
    res=model.test(randData, randLabels);
    rslt(i, 1)=res.err();
end % for loop
e=std(rslt)*ones(10, 1);
end % function

