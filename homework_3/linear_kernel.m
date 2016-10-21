disp('Linear Kernel');
disp(' ');

lambda = [0, 0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000]';
N_lambda = length(lambda);
test_error = size(10, 1);
for t = 1 : 10
    error_min = zeros(5, 1);
    opt_ind = zeros(5, 1);
    disp(['Random Split No. ', num2str(t)]);
    [train_data, train_label, test_data, test_label] = preprocessing(imported_data);
    N_train = size(train_data, 1);
    for i = 1 : 5
        [train_data_current, train_label_current, valid_data_current, valid_label_current] = five_folder(train_data, train_label, i);
        N_valid = size(valid_data_current, 1);
        N_train_current = size(train_data_current, 1);
        error = zeros(N_lambda, 1);
        kernel_1 = train_data_current * train_data_current';
        kernel_2 = train_data_current * valid_data_current';
        for j = 1 : N_lambda
            y_pred = train_label_current' * ((kernel_1 + lambda(j) * eye (N_train_current)) \ eye(N_train_current)) * kernel_2;
            error(j) = sum((y_pred' - valid_label_current) .^ 2) ./ N_valid;
        end
        [error_min(i), opt_ind(i)] = min(error);
    end
    [~, error_min_ind] = min(error_min);
    opt_lambda = lambda(opt_ind(error_min_ind));
    disp(['Optimal lambda: ', num2str(opt_lambda)]);
    disp(' ');
    N_test = size(test_data, 1);
    kernel_1 = train_data * train_data';
    kernel_2 = train_data * test_data';
    y_pred = train_label' * ((kernel_1 + opt_lambda * eye (N_train)) \ eye(N_train)) * kernel_2;
    test_error(t) = sum((y_pred' - test_label) .^ 2) ./ N_test;
end
test_mean_error = sum(test_error) / 10;
disp(['Average test error: ', num2str(test_mean_error)]);
disp(' ');

clear -regexp [^imported_data];