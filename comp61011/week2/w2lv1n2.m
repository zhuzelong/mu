function res=w2lv1n2(data, labels)
% Calculate the leave-one-out cross validation error of logreg.
row=size(data, 1);
model=logreg();
for i=2:row
    model=model.train(data([1:i-1 i+1:row], :), labels([1:i-1 i+1:row], :));
    res(i-1, 1)=model.test(data(i, :), labels(i, :)).err();
end % for loop
end % function

