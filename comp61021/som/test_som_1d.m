% Experiment with parameters and plot SOM
% Parameters: LR_0, radius_0, num_neurons, training_steps, T_1 and T_2

data = nicering;

som1 = lab_som(data, 4, 2000, 1, 2);
som2 = lab_som(data, 8, 4000, 1, 4);
som3 = lab_som(data, 16, 8000, 1, 8);
som4 = lab_som(data, 32, 16000, 1, 16);
som5 = lab_som(data, 64, 32000, 0.2, 8);
som6 = lab_som(data, 128, 64000, 0.2, 8);
som7 = lab_som(data, 256, 128000, 0.2, 8);
som8 = lab_som(data, 512, 256000, 1, 256);

SOM = {som1, som2, som3, som4, som5, som6, som7, som8};
Cost = [];
for i = 1: 8
    Cost = [Cost somcost(data, SOM{i})];
end % for



%scatter(data(:, 1), data(:, 2));
%hold on
%scatter(som1(:, 1), som1(:, 2), 'k');
%scatter(som2(:, 1), som2(:, 2), 'k');
%scatter(som4(:, 1), som3(:, 2), 'k');
%scatter(som1(:, 1), som1(:, 2), 'k');
%scatter(som1(:, 1), som1(:, 2), 'k');
%scatter(som1(:, 1), som1(:, 2), 'k');

%lab_vis(som1, data);
%hold on
%
%lab_vis(som2, data);
%hold on
%
%lab_vis(som3, data);
%hold on

%lab_vis(som4, data);
%hold on

%lab_vis(som5, data);
%hold on
%
%lab_vis(som6, data);
%hold on
%
%lab_vis(som7, data);
%hold on
%
%lab_vis(som8, data);

% show suboptimal graph
% n_neuron = 64, radius = 8, LR = 0.2
% lab_vis(lab_som(data, 64, 32000, 0.2, 8))
