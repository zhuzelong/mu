function plotEntropy(model, data, labels, index)
% Plot entropy against one of 'w' parameters, with other w fixed.
% Verify if w(index) reaches the global minima.
interval = 5;
w = model.w;
numRow = size(data, 1);

% inbound and outbound define the interval of w to be tested
outbound = w(index) + interval;
inbound = w(index) - interval;

% E is a matrix recording the value of error function
E = [];

stepsize = 0.1;
for testw = inbound : stepsize : outbound;
    w(index) = testw;
    hypo = ones(numRow, 1) ./ (1 + exp([data, -ones(numRow, 1)] * w));
    entropy = - sum(labels .* log(hypo) + (1-labels) .* log(1-hypo));
    %entropy = log(entropy);
    E = [E, entropy];
end % for loop

plot([inbound : stepsize : outbound], E), axis([inbound outbound min(E), max(E)]), xlabel('w1'), ylabel('Entropy'), legend('Dataset: datab')
