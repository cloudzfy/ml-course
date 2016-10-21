function est = histogram(train_data, test_data, h)
    n = size(test_data, 1);
    m = size(train_data, 1);
    u = test_data * ones(1, m) - ones(n,1) * train_data';
    est = sum((u > 0) .* (u <= h), 2) ./ (m * h);