close all;
clear;
im1 = rgb2gray(imread('../images/im1.jpg'));
im1 = imresize(im1, [480 640]);
im2 = imresize(imrotate(im1,-20), 1.2);
n = 10;
% Read saved points
x = dlmread('marked_original.txt');
x_i = dlmread('marked_skewed.txt');

% Select the first 6 points and compute DLT
n = 6;
A = zeros(2 * n, 9);
for i = 1:n
    A(2 * i - 1, :) = [zeros(1,3) -x_i(i, :) x(i,2) * x_i(i, :)];
    A(2 * i, :) = [x_i(i, :) zeros(1, 3) -x(i,1) * x_i(i, :)];
end
[U, D, V] = svd(A);
H = V(:, 9);
H = reshape(H, [3, 3]);

% Transform the image according to the obtained H matrix
T = maketform('projective', H);
t_img = imtransform(im2, T, 'Size', size(im2));
imshow(t_img);