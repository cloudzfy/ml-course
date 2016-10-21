disp(' ');
disp('Gaussian RBF Kernel');
disp(' ');

lambda = [0, 0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000]';
N_lambda = length(lambda);
sigma_sqr = [0.125 0.25 0.5 1 2 4 8];
N_sigma = length(sigma_sqr);
param = zeros(N_lambda * N_sigma, 2);
param_ind = 1;
for j_lambda = 1 : N_lambda
    for j_sigma = 1 : N_sigma
        param(param_ind, 1) = lambda(j_lambda);
        param(param_ind, 2) = sigma_sqr(j_sigma);
        param_ind = param_ind + 1;
    end
end

test_error = size(10, 1);
for t = 1 : 10
    disp(['Random Split No. ', num2str(t)]);
    [train_data, train_label, test_data, test_label] = preprocessing(imported_data);
    N_train = size(train_data, 1);
    error_min = zeros(5, 1);
    opt_ind = zeros(5, 1);
    for i = 1 : 5
        [train_data_current, train_label_current, valid_data_current, valid_label_current] = five_folder(train_data, train_label, i);
        N_valid = size(valid_data_current, 1);
        N_train_current = size(train_data_current, 1);
        error = zeros(N_lambda * N_sigma, 1);
        error_ind = 1;
        tmp1 = sum(train_data_current .^ 2, 2) * ones(1, N_train_current);
        tmp2 = ones(N_train_current, 1) * sum(train_data_current' .^ 2, 1);
        tmp3 = 2 .* train_data_current * train_data_current';
        kernel_tmp_1 = -(tmp1 + tmp2 - tmp3);
        tmp1 = sum(train_data_current .^ 2, 2) * ones(1, N_valid);
        tmp2 = ones(N_train_current, 1) * sum(valid_data_current' .^ 2, 1);
        tmp3 = 2 .* train_data_current * valid_data_current';
        kernel_tmp_2 = -(tmp1 + tmp2 - tmp3);        
        for j_lambda = 1 : N_lambda
            for j_sigma = 1 : N_sigma
                kernel_1 = exp(kernel_tmp_1 ./ sigma_sqr(j_sigma));
                kernel_2 = exp(kernel_tmp_2 ./ sigma_sqr(j_sigma));
                y_pred = train_label_current' * ((kernel_1 + lambda(j_lambda) * eye (N_train_current)) \ eye(N_train_current)) * kernel_2;
                error(error_ind) = sum((y_pred' - valid_label_current) .^ 2) ./ N_valid;
                error_ind = error_ind + 1;
            end
        end
        [error_min(i), opt_ind(i)] = min(error);
    end
    [~, error_min_ind] = min(error_min);
    opt_lambda = param(opt_ind(error_min_ind), 1);
    opt_sigma = param(opt_ind(error_min_ind), 2);
    disp(['Optimal lambda: ', num2str(opt_lambda)]);
    disp(['Optimal sigma^2: ', num2str(opt_sigma)]);
    disp(' ');
    N_test = size(test_data, 1);
    tmp1 = sum(train_data .^ 2, 2) * ones(1, N_train);
    tmp2 = ones(N_train, 1) * sum(train_data' .^ 2, 1);
    tmp3 = 2 .* train_data * train_data';
    kernel_1 = exp(-(tmp1 + tmp2 - tmp3) ./ sigma_sqr(j_sigma));
    tmp1 = sum(train_data .^ 2, 2) * ones(1, N_test);
    tmp2 = ones(N_train, 1) * sum(test_data' .^ 2, 1);
    tmp3 = 2 .* train_data * test_data';
    kernel_2 = exp(-(tmp1 + tmp2 - tmp3) ./ sigma_sqr(j_sigma));
    y_pred = train_label' * ((kernel_1 + opt_lambda * eye (N_train)) \ eye(N_train)) * kernel_2;
    test_error(t) = sum((y_pred' - test_label) .^ 2) ./ N_test;
end
test_mean_error = sum(test_error) / 10;
disp(['Average test error: ', num2str(test_mean_error)]);
disp(' ');

clear -regexp [^imported_data];