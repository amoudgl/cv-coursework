[Q, W] = qr(inv(P(1:3, 1:3)));

% P = [KR -KRC] 

% Rotation Matrix
R = inv(Q);

% Intrinsic Camera Matrix
K = inv(W);
K = K/K(3,3);

% Camera Center
C = - (inv(R) * inv(K) * P(:, 4));
