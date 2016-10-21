function [w, b] = trainsvm(train_data, train_label, C)
    [N, M] = size(train_data);
    H = diag([0; ones(M, 1); zeros(N, 1)]);
    f = C .* [0; zeros(M, 1); ones(N, 1)];
    a11 = diag(train_label) * [ones(N, 1), train_data];
    a12 = eye(N);
    a21 = zeros(N, 1 + M);
    a22 = eye(N);
    A = -[a11, a12; a21, a22];
    b = -[ones(N, 1); zeros(N, 1)];
    options = optimset('Algorithm', 'interior-point-convex', 'Display', 'off');
    X = quadprog(H, f, A, b, [], [], [], [], [] ,options);
    w = X(2 : M + 1);
    b = X(1);
end