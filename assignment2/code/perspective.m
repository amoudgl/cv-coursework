n = 4;
x = dlmread('orig.txt');
im = imread('../images/planer_im1.jpg');
im = imresize(im, 0.25);

figure; imshow(im);
x_i = ginput(n);
x_i = [x_i ones(n, 1)];

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
t_img = imtransform(im, T, 'Size', size(im));
imshow(t_img);

    