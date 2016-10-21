function [error, bias, variance] = linear_regression(X, Y, N_dataset, const)
    [N, M] = size(X);
    N_element = N / N_dataset;
    error = zeros(N_dataset, 1);
    w_pred = zeros(N_dataset, M);
    for t = 1 : N_dataset
        ind_s = (t - 1) * N_element + 1;
        ind_t = t * N_element;
        if const
            w_pred(t, :) = ones(M, 1);
            error(t) = sum((X(ind_s:ind_t,:) - Y(ind_s:ind_t,:)) .^2) / N_element;
        else
            w_pred(t, :) = (X(ind_s:ind_t,:)' * X(ind_s:ind_t,:)) \ eye(M) * X(ind_s:ind_t,:)' * Y(ind_s:ind_t,:);
            error(t) = sum((X(ind_s:ind_t,:) * w_pred(t,:)' - Y(ind_s:ind_t,:)) .^2) / N_element;
        end
    end
    bias = sum((sum(X * w_pred', 2) ./ N_dataset - Y) .^ 2) ./ N;
    variance = sum(sum((X * w_pred' - sum(X * w_pred', 2) * ones(1, N_dataset) ./ N_dataset) .^ 2)) / (N * N_dataset);