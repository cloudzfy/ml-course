X = blob_points;
K = 3;
N = size(X, 1);
color = ['r', 'g', 'b', 'm', 'k'];

opt_L = -10000;
opt_mu = zeros(3, 2);
opt_sigma = zeros(3, 4);
opt_gamma = zeros(N, 1);
figure(4)
for T = 1 : 5
    mu = [-1, 1.5; -0.5, 1; 0.5 0.5];
    sigma_x = rand(K, 1);
    sigma_y = rand(K, 1);
    rho = rand(K, 1) * 0.5;
    L = [];
    old_L = -10000;
    while true
        nd = zeros(N, K);
        for k = 1 : K
            sigma_1 = (X(:, 1) - ones(N, 1) * mu(k, 1)) .^ 2 / (sigma_x(k) ^ 2);
            sigma_2 = (X(:, 2) - ones(N, 1) * mu(k, 2)) .^ 2 / (sigma_y(k) ^ 2);
            sigma_3 = 2 * rho(k) * (X(:, 1) - ones(N, 1) * mu(k, 1)) .* (X(:, 2) - ones(N, 1) * mu(k, 2)) / (sigma_x(k) * sigma_y(k));
            nd(:, k) = exp(- 1 / (2 * (1 - rho(k) ^ 2)) * (sigma_1 + sigma_2 - sigma_3)) / (2 * pi * sigma_x(k) * sigma_y(k) * sqrt(1 - rho(k) ^ 2));
        end
        [~, ind] = max(nd, [], 2);
        p_cond = zeros(K, 1);
        for k = 1 : K
            p_cond(k) = sum(ind == k) / N;
        end
        p_joint = nd .* (ones(N, 1) * p_cond');
        L_current = sum(log(p_joint(sub2ind([N, K], (1:N)', ind))));
        L = [L L_current];
        if abs(old_L - L_current) < 0.01
            break;
        end
        old_L = L_current;
        for k = 1 : K
            n = sum(ind == k);
            ind_k = ind == k;
            mu(k, 1) = sum(X(ind_k, 1)) / n;
            mu(k, 2) = sum(X(ind_k, 2)) / n;
            sigma_x(k) = sqrt((X(ind_k, 1) - mu(k, 1))' * (X(ind_k, 1) - mu(k, 1)) / (n - 1));
            sigma_y(k) = sqrt((X(ind_k, 2) - mu(k, 2))' * (X(ind_k, 2) - mu(k, 2)) / (n - 1));
            rho(k) = (X(ind_k, 1) - mu(k, 1))' * (X(ind_k, 2) - mu(k, 2)) / ((n - 1) * sigma_x(k) * sigma_y(k));
        end
    end
    if opt_L < L_current
        opt_L = L_current;
        opt_gamma = ind;
        opt_mu = mu;
        for k = 1 : K
            opt_sigma(k, :) = [sigma_x(k) ^ 2, rho(k) * sigma_x(k) * sigma_y(k), rho(k) * sigma_y(k) * sigma_x(k), sigma_y(k) ^ 2];
        end
    end
    hold on
    t = 0 : length(L) - 1;
    plot(t, L, color(T));
end
disp('For the best run of the log likelihood function: ');
disp(' ');
figure(5)
for k = 1 : K
    hold on
    scatter(X(ind == k, 1), X(ind == k, 2), 'filled');
    disp(['In Gaussian ', num2str(k)]);
    disp(['The mean is ', num2str(opt_mu(k, :))]);
    disp(['The covariance matrix is ', num2str(opt_sigma(k, :))]);
end