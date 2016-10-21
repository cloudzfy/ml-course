function est = gaussian_kernel(train_data, test_data, h)
    n = size(test_data, 1);
    m = size(train_data, 1);
    u = (test_data * ones(1, m) - ones(n, 1) * train_data') ./ h;
    est = 1 ./ (m * h) .* sum(1 / sqrt(2 * pi) .* exp(- u .^ 2 ./ 2), 2);