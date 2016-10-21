function [bias, variance] = linear_regression_w_regularization(X, Y, N_dataset, lambda)
    [N, M] = size(X);
    N_element = N / N_dataset;
    w_pred = zeros(N_dataset, M);
    for t = 1 : N_dataset
        ind_s = (t - 1) * N_element + 1;
        ind_t = t * N_element;
        w_pred(t, :) = (X(ind_s:ind_t,:)' * X(ind_s:ind_t,:)+ lambda .* eye(M)) \ eye(M) * X(ind_s:ind_t,:)' * Y(ind_s:ind_t,:);
    end
    bias = sum((sum(X * w_pred', 2) ./ N_dataset - Y) .^ 2) ./ N;
    variance = sum(sum((X * w_pred' - sum(X * w_pred', 2) * ones(1, N_dataset) ./ N_dataset) .^ 2)) / (N * N_dataset);