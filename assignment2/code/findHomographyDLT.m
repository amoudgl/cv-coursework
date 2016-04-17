function H = findHomographyDLT(im1, im2) 

    % Number of matching points
    n = 15;
    [matched_points1, matched_points2] = siftMatch(im1, im2, n);
    x = [matched_points1 ones(n, 1)]
    xi = [matched_points2 ones(n, 1)]
    A = zeros(2*n, 9);
    for i = 1:n
        A(2*i-1:2*i, :) = [zeros(1, 3) -xi(i, :) x(i, 2)*xi(i,:);
                            xi(i, :) zeros(1, 3) -x(i, 1)*xi(i, :)];
    end
    [u,s,v] = svd(A);
    H = reshape(v(:, 9), [3, 3]);
end
