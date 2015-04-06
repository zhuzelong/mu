function res=w2lv2n1(data, labels)
% Try different parameters C and gamma for RBF kernel, plot the error rate for each.
iter=1;
for c=1:10:100
    for gamma=0.01:0.01:1
        model=svm(['-t 2 -g ', num2str(gamma), ' -c ', num2str(c)]);
        res(iter, 1:2)=[c, gamma];
        model=model.train(data, labels);
        res(iter, 3)=model.test(data, labels).err();
        iter=iter+1;
    end % gamma loop
end % c loop
end % function

