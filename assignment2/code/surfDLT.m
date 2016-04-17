close all;
clear;
im1 = rgb2gray(imread('../images/im1.jpg'));
im1 = imresize(im1, [480 640]);
figure, imshow(im1);
im2 = imresize(imrotate(im1,-20), 1.2);
figure, imshow(im2);
n = 15;
[matched_points1, matched_points2] = surfFeatures(im1, im2, n);
x = [matched_points1.Location ones(n,1)];
x_i = [matched_points2.Location ones(n, 1)];
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
figure, imshow(t_img);