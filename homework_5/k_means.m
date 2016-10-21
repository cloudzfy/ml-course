K = [2,3,5];

figure(1);
X = blob_points;
N = size(X, 1);
for i = 1 : 3
    mu = X(randperm(N, K(i)), :);
    old_r = zeros(N, K(i));
    while true
        [~, k] = min(sum(X .^ 2, 2) * ones(1, K(i)) + ones(N, 1) * sum(mu' .^ 2) - 2 * X * mu', [], 2);
        r = zeros(N, K(i));
        r(sub2ind([N, K(i)], (1 : N)', k)) = 1;
        mu_x = (sum(r .* (X(:, 1) * ones(1, K(i)))) ./ sum(r))';
        mu_y = (sum(r .* (X(:, 2) * ones(1, K(i)))) ./ sum(r))';
        mu = [mu_x mu_y];
        if old_r == r
            break;
        end
        old_r = r;
    end
    subplot(1, 3, i);
    for k = 1 : K(i)
        hold on;
        scatter(X(r(:, k) == 1, 1), X(r(:, k) == 1, 2), 'filled');
    end
end

figure(2);
X = circle_points;
N = size(X, 1);
for i = 1 : 3
    mu = X(randperm(N, K(i)), :);
    old_r = zeros(N, K(i));
    while true
        [~, k] = min(sum(X .^ 2, 2) * ones(1, K(i)) + ones(N, 1) * sum(mu' .^ 2) - 2 * X * mu', [], 2);
        r = zeros(N, K(i));
        r(sub2ind([N, K(i)], (1 : N)', k)) = 1;
        mu_x = (sum(r .* (X(:, 1) * ones(1, K(i)))) ./ sum(r))';
        mu_y = (sum(r .* (X(:, 2) * ones(1, K(i)))) ./ sum(r))';
        mu = [mu_x mu_y];
        if old_r == r
            break;
        end
        old_r = r;
    end
    subplot(1, 3, i);
    for k = 1 : K(i)
        hold on;
        scatter(X(r(:, k) == 1, 1), X(r(:, k) == 1, 2), 'filled');
    end
end