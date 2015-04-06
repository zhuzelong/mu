function dimgs = img2mat(imgs)
% Convert images to a matrix.

n_sample = size(imgs, 1);
down_width = 50;
down_height = 50;

for i = 1: n_sample
    img = imgs{i};
    dimg = lab_downsample(img, down_width, down_height);
    dimgs(i) = dimg;
end
