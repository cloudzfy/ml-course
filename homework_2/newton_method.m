function train_accu = newton_method(train_data, train_label, it)
    [N, M] = size(train_data);
    w = zeros(M, 1);
    eta = 0.001;
    for t = 1 : it
        w_old = w;
        D_sigma = train_data' * (sigmoid(train_data * w) - train_label);
        H = sigmoid(train_data * w)' * (ones(N, 1) - sigmoid(train_data * w)) * (train_data' * train_data);
        w = w - (H \ D_sigma);
        if abs(w - w_old) < eta
            disp(t)
            break;
        end
    end
    pos = sum((sigmoid(train_data * w) > 0.5) .* train_label);
    neg = sum((sigmoid(train_data * w) < 0.5) .* ~train_label);
    train_accu = (pos + neg) / N;