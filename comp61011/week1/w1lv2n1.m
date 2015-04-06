function rslt=wk1lv1n5(model, data, labels, n)
% record the error rate of different epochs/iterations
rslt=zeros(n, 2);
model.iterations=1; %initial the iteration
for i=1:n
    model.iterations=model.iterations+1;
    model=model.train(data, labels);
    rslt(i,1:2)=[model.iterations, model.test(data, labels).err()];
end
end

