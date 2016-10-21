disp(' ');
disp('Bias/Variance Tradeoff with Regularization');
disp(' ');

% h(x) = w_0 + w_1 * x + w_2 * x^2 + lambda * (w_0^2 + w_1^2 + w_2^2)

X_train = [ones(N, 1) X X.^2];
disp('Function h(x) = w_0 + w_1 * x + w_2 * x^2 + lambda * (w_0^2 + w_1^2 + w_2^2)');
disp(' ');
for lambda = [0.01 0.1 1 10]
    disp(['lambda = ', num2str(lambda)]);
    [bias, variance] = linear_regression_w_regularization(X_train, Y, N_dataset, lambda);
    disp(['Bias: ', num2str(bias)]);
    disp(['Variance: ', num2str(variance)]);
    disp(' ');
end