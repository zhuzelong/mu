function res=w2lv2n3(data, labels)
% Build a polynomial kernel with d in {1 to 7}, evaluate the training time.
res=[];
for d=1:7
    model=svm(['-t 1 -d ', num2str(d)]);
    tic; % begin the timer
    model=model.train(data, labels);
    elapse=toc; % shut the timer and record the elapse
    res=[res; elapse];
end % for loop
end

