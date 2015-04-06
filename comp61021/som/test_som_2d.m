% Experiment with parameters and plot SOM
% Parameters: LR_0, radius_0, num_neurons, training_steps, T_1 and T_2

data = nicering;

[som1 grid1] = lab_som2d(data, 2, 2, 2000, 1, 2);
[som2 grid2] = lab_som2d(data, 3, 3, 4500, 1, 5);
[som3 grid3] = lab_som2d(data, 4, 4, 8000, 1, 8);
[som4 grid4] = lab_som2d(data, 5, 5, 12500, 1, 12);
[som5 grid5] = lab_som2d(data, 6, 6, 18000, 1, 18);
[som6 grid6] = lab_som2d(data, 7, 7, 24500, 1, 25);
[som7 grid7] = lab_som2d(data, 8, 8, 32000, 1, 32);
[som8 grid8] = lab_som2d(data, 9, 9, 40500, 1, 40);
[som9 grid9] = lab_som2d(data, 10, 10, 50000, 1, 50);

SOM = {som1, som2, som3, som4, som5, som6, som7, som8, som9};
Cost = [];
for i = 1: size(SOM, 1)
    Cost = [Cost somcost(data, SOM{i})];
end % for


% Suboptimal parameters
%[som grid] = lab_som2d(data, 10, 10, 50000, 0.1, 10);
%lab_vis2d(som, grid, data);
