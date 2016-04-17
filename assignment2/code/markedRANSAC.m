close all;
clear;
im1 = rgb2gray(imread('../images/im1.jpg'));
im1 = imresize(im1, [480 640]);
im2 = imresize(imrotate(im1,-20), 1.2);
n = 10;
% Read saved points
x = dlmread('marked_original.txt');
x_i = dlmread('marked_skewed.txt');

N = 10;
min_outliers = N;
best_H = [];
    for iterations = 1:10
        % Randomly picking 5 indices
        n = 15;
        r = randi([1 N],1,n);
        while length(unique(r)) ~= length(r)
            r = randi([1 N],1,n);
        end

        % Implement DLT on the chosen points
        x = all_x(r, :);
        x_i = all_x_i(r, :);

        A = zeros(2 * n, 9);
        for i = 1:n
            A(2 * i - 1, :) = [zeros(1,3) -x_i(i, :) x(i,2) * x_i(i, :)];
            A(2 * i, :) = [x_i(i, :) zeros(1, 3) -x(i,1) * x_i(i, :)];
        end
        [U, D, V] = svd(A);
        H = V(:, 9);
        H = reshape(H, [3, 3]);

        x_predicted = (H * all_x_i')';
        for i = 1:N
            x_predicted(i, 1) = x_predicted(i, 1) ./ x_predicted(i, 3);
            x_predicted(i, 2) = x_predicted(i, 2) ./ x_predicted(i, 3);
        end

        error = abs(x_predicted(:, [1, 2]) - all_x(:, [1, 2]));
        norms = sqrt(sum(error.^2,2));

        % Taking the threshold as the mean of the errors for the seleted points
        thresh = mean(norms(r));
        difference = norms - thresh;
        outliers = sum(difference > 0);

        if outliers < min_outliers
            min_outliers = outliers;
            best_H = H;
        end
    end
    
T = maketform('projective', best_H);
t_img = imtransform(im2, T, 'Size', size(im2));
imshow(t_img);