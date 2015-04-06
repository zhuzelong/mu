function res=w2lv1n5(data, labels)
% Vary the gamma parameter fir RBF SVM and compare the error rate.
i=1;
for gamma=0.01: 0.01: 10
    model=svm(['-t 2 -g ', num2str(gamma)]);
    model=model.train(data, labels);
    res(i,1)=gamma;
    res(i,2)=model.test(data, labels).err();
    i=i+1;
end % for loop
end % function
    
