function P = fdlt(xw, xi)

    x = xi(1,:);
    y = xi(2,:);
    z = xi(3,:);
    n = size(xw,2); 
    A = zeros(2*n,12);
    for i = 1 : n 
        A(2*i-1:2*i, :) = [-z(i)*xw(:,i)' zeros(1,4) x(i)*xw(:,i)';
                            zeros(1,4) -z(i)*xw(:,i)' y(i)*xw(:,i)'];
    end

 for i = 1 : 3
     A(i, :) = A(i, :)/norm(A(i, :));
 
    [u,s,v] = svd(A);
    P = reshape(v(:, 12), [4, 3])';
end
