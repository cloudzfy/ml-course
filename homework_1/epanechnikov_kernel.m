function est = epanechnikov_kernel(train_data, test_data, h)
    n = size(test_data, 1);
    m = size(train_data, 1);
    u = (test_data * ones(1, m) - ones(n, 1) * train_data') ./ h;
    est = 1 ./ (m * h) .* sum(0.75 .* (1 - u .^ 2) .* (abs(u) <= 1), 2);