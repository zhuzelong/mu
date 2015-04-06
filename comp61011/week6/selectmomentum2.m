% Script
% Plot the error rate against momentum based on the outcome of 'testmomentum.m'.

% set the interval of momentum to 0.05
interval = 0.05;

% ==== DATAB ====
load datab;

lr = 0.2;
errM = testmomentum(data, labels, lr, interval); 
% calculate the mean value of each row of errM
meanV = mean(errM')';
% calculate the standart deviation of each row of errM
stdV = std(errM')';

m = [0.01 : interval : 1];
subplot(2, 2, 1)
errorbar(m, meanV, stdV), xlabel('Momentum'), ylabel('Mean Error rate'), legend('DATAB, LR=0.2'), grid on

% ==== DATAG ====
load datag;

lr = 0.1;
errM = testmomentum(data, labels, lr, interval); 
% calculate the mean value of each row of errM
meanV = mean(errM')';
% calculate the standart deviation of each row of errM
stdV = std(errM')';

m = [0.01 : interval : 1];
subplot(2, 2, 2)
errorbar(m, meanV, stdV), xlabel('Momentum'), ylabel('Mean Error rate'), legend('DATAG, LR=0.1'), grid on

% ==== HEART ====
load heart;

lr = 0.25;
errM = testmomentum(data, labels, lr, interval); 
% calculate the mean value of each row of errM
meanV = mean(errM')';
% calculate the standart deviation of each row of errM
stdV = std(errM')';

m = [0.01 : interval : 1];
subplot(2, 2, 3)
errorbar(m, meanV, stdV), xlabel('Momentum'), ylabel('Mean Error rate'), legend('HEART, LR=0.25'), grid on


