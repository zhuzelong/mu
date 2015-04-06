% Rescale the data and evaluate the error rates of logreg and SVM.

load biggerdata;

% rescale the data.data
average=sum(data)/size(data, 1);
stderr=std(data);
avg1=average(1, 1)*ones(size(data, 1), 1);
avg2=average(1, 2)*ones(size(data, 1), 1);
stderr1=stderr(1, 1)*ones(size(data, 1), 1);
stderr2=stderr(1, 2)*ones(size(data, 1), 1);
normdata=[(data(:, 1)-avg1)./stderr1, (data(:, 2)-avg2)./stderr2]; % normalize data

% run logreg on normalized data
modellog=logreg();
modellog=modellog.train(data, labels);
errlog1=modellog.test(data, labels).err();
modellog=modellog.train(normdata, labels);
errlog2=modellog.test(data, labels).err();

% run svm on normalized data
modelsvm=svm('-t 2 -g 1');
modelsvm=modelsvm.train(data, labels);
errsvm1=modelsvm.test(data,labels).err();
modellog=modellog.train(normdata, labels);
errsvm2=modellog.test(data, labels).err();

[errlog1 errlog2]
[errsvm1 errsvm2]
