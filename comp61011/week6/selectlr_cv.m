% Script
% Plot the error bar based on the outcome of 'testlr.m'.

interval = 0.05;

% ==== DATAB ====
load datab;
numRow = size(data, 1);
errMb = testlr_cv(data, labels, interval); 
% calculate the mean value of each row of errM
meanVb = mean(errMb')';
% calculate the standart deviation of each row of errM
stdVb = std(errMb')';

% ==== DATAG ====
load datag;
numRow = size(data, 1);
errMg = testlr_cv(data, labels, interval); 
meanVg = mean(errMg')';
stdVg = std(errMg')';

% ==== HEART ====
load heart;
numRow = size(data, 1);
errMh = testlr_cv(data, labels, interval); 
meanVh = mean(errMh')';
stdVh = std(errMh')';

% plot the error bar
lr = [0.01 : interval : 1]; 
subplot(2, 2, 1)
errorbar(lr, meanVb, stdVb), xlabel('Learning Rate'), ylabel('Mean Error Rate'), legend('Dataset: datab')

subplot(2, 2, 2)
errorbar(lr, meanVg, stdVg), xlabel('Learning Rate'), ylabel('Mean Error Rate'), legend('Dataset: datag')

subplot(2, 2, 3)
errorbar(lr, meanVh, stdVh), xlabel('Learning Rate'), ylabel('Mean Error Rate'), legend('Dataset: heart')

