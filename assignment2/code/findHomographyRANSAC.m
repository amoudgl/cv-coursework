function [best_H] = findHomographyRANSAC(im1, im2)
    N = 50;
    [matched_points1, matched_points2] = siftMatch(im1, im2, N);
    all_x = [matched_points1 ones(N, 1)];
    all_x_i = [matched_points2 ones(N, 1)];

    min_outliers = N;
    best_H = [];
    for iterations = 1:50
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
end