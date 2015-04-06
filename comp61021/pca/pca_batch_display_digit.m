% Script
% Given a set of grey-level images, show them all in one graph.
% Each image is represented by a 28*28 pixel matrix.
% Show images in a 20*15 array, given 300 images in total.

load digit;

row = 5;
col = 5;
n_image = size(train, 2);

for i = 1:25
    subplot(row, col, i);
    display_digit(train{i})
end % for loop

