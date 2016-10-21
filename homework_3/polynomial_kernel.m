disp(' ');
disp('Polynomial Kernel');
disp(' ');

lambda = [0, 0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000]';
N_lambda = length(lambda);
a = [-1 -0.5 0 0.5 1];
b = [1 2 3 4];
N_a = length(a);
N_b = length(b);
param = zeros(N_lambda * N_a * N_b, 3);
param_ind = 1;
for j_lambda = 1 : N_lambda
    for j_a = 1 : N_a
        for j_b = 1 : N_b
            param(param_ind, 1) = lambda(j_lambda);
            param(param_ind, 2) = a(j_a);
            param(param_ind, 3) = b(j_b);
            param_ind = param_ind + 1;
        end
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
        error = zeros(N_lambda * N_a * N_b, 1);
        error_ind = 1;
        kernel_tmp_1 = train_data_current * train_data_current';
        kernel_tmp_2 = train_data_current * valid_data_current';
        for j_lambda = 1 : N_lambda
            for j_a = 1 : N_a
                for j_b = 1 : N_b
                    kernel_1 = (kernel_tmp_1 + a(j_a)) .^ b(j_b);
                    kernel_2 = (kernel_tmp_2 + a(j_a)) .^ b(j_b);
                    y_pred = train_label_current' * ((kernel_1 + lambda(j_lambda) * eye (N_train_current)) \ eye(N_train_current)) * kernel_2;
                    error(error_ind) = sum((y_pred' - valid_label_current) .^ 2) ./ N_valid;
                    error_ind = error_ind + 1;
                end
            end
        end
        [error_min(i), opt_ind(i)] = min(error);
    end
    [~, error_min_ind] = min(error_min);
    opt_lambda = param(opt_ind(error_min_ind), 1);
    opt_a = param(opt_ind(error_min_ind), 2);
    opt_b = param(opt_ind(error_min_ind), 3);
    disp(['Optimal lambda: ', num2str(opt_lambda)]);
    disp(['Optimal a: ', num2str(opt_a)]);
    disp(['Optimal b: ', num2str(opt_b)]);
    disp(' ');
    N_test = size(test_data, 1);
    kernel_1 = (train_data * train_data' + opt_a) .^ opt_b;
    kernel_2 = (train_data * test_data' + opt_a) .^ opt_b;
    y_pred = train_label' * ((kernel_1 + opt_lambda * eye (N_train)) \ eye(N_train)) * kernel_2;
    test_error(t) = sum((y_pred' - test_label) .^ 2) ./ N_test;
end
test_mean_error = sum(test_error) / 10;
disp(['Average test error: ', num2str(test_mean_error)]);
disp(' ');

clear -regexp [^imported_data];