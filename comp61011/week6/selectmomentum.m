% Script
% Plot the error rate against momentum based on the outcome of 'testmomentum.m'.

% set the interval of momentum to 0.05
interval = 0.05;

% ==== DATAB ====
load datab;
M = [];
S = [];

for lr = 0.01 : 0.025 : 0.11
errM = testmomentum(data, labels, lr, interval); 
% calculate the mean value of each row of errM
meanV = mean(errM')';
M = [M meanV];
% calculate the standart deviation of each row of errM
stdV = std(errM')';
S = [S stdV];
end % for loop

m = [0.01 : interval : 1];
subplot(2, 2, 1)
plot(m, M(:, 1), m, M(:, 2), '--', m, M(:, 3), '-.',m, M(:, 4), ':', m, M(:, 5)), xlabel('Momentum'), ylabel('Mean Error Rate'), legend('LR=0.01', 'LR=0.035', 'LR=0.06', 'LR=0.085', 'LR=0.11'), grid on 

% ==== DATAG ====
load datag;
M = [];
S = [];

for lr = 0.1 : 0.1 : 0.5 
errM = testmomentum(data, labels, lr, interval); 
% calculate the mean value of each row of errM
meanV = mean(errM')';
M = [M meanV];
% calculate the standart deviation of each row of errM
stdV = std(errM')';
S = [S stdV];
end % for loop

m = [0.01 : interval : 1];
subplot(2, 2, 2)
plot(m, M(:, 1), m, M(:, 2), '--', m, M(:, 3), '-.',m, M(:, 4), ':', m, M(:, 5)), xlabel('Momentum'), ylabel('Mean Error Rate'), legend('LR=0.1', 'LR=0.2', 'LR=0.3', 'LR=0.4', 'LR=0.5'), grid on 

% ==== HEART ====
load heart;
M = [];
S = [];

for lr = [0.01: 0.05 : 0.11 0.3 : 0.05: 0.4] 
errM = testmomentum(data, labels, lr, interval); 
% calculate the mean value of each row of errM
meanV = mean(errM')';
M = [M meanV];
% calculate the standart deviation of each row of errM
stdV = std(errM')';
S = [S stdV];
end % for loop

m = [0.01 : interval : 1];
subplot(2, 2, 3)
plot(m, M(:, 1), m, M(:, 2), '--', m, M(:, 3), '-.',m, M(:, 4), ':', m, M(:, 5), m, M(:, 6), '--'), xlabel('Momentum'), ylabel('Mean Error Rate'), legend('LR=0.01', 'LR=0.06', 'LR=0.11', 'LR=0.3', 'LR=0.35', 'LR=0.4'), grid on 


