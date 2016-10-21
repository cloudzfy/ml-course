function train_accu = batch_gradient_descent(train_data, train_label, it)
    [N, M] = size(train_data);
    w = zeros(M, 1);
    eta = 0.001;
    for t = 1 : it
        w_old = w;
        w = w - eta * (train_data' * (sigmoid(train_data * w) - train_label));
        if abs(w - w_old) < eta
            break;
        end
    end
    pos = sum((sigmoid(train_data * w) > 0.5) .* train_label);
    neg = sum((sigmoid(train_data * w) < 0.5) .* ~train_label);
    train_accu = (pos + neg) / N;