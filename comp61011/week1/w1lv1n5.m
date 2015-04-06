function rslt=wk1lv1n5(model, data, labels, n)
% record the accuracy of different learning rates in logistic regression
% modle
rslt=zeros(n, 1);
model.learningrate=0.1 %initial the learningrate
for i=1:n
    model.learningrate=model.learningrate+0.1;
    model=model.train(data, labels);
    rslt(i,1:2)=[model.learningrate, model.test(data, labels).acc()];
end
end

