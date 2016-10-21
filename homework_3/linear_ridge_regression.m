lambda = [0, 0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000]';
N_lambda = length(lambda);
test_error = size(10, 1);

disp(' ');
disp('Linear Ridge Regression');
disp(' ');

for t = 1 : 10
    disp(['Random Split No. ', num2str(t)]);
    [train_data, train_label, test_data, test_label] = preprocessing(imported_data);
    [N_train, D] = size(train_data);
    error_min = zeros(5, 1);
    opt_ind = zeros(5, 1);
    for i = 1 : 5
        [train_data_current, train_label_current, valid_data_current, valid_label_current] = five_folder(train_data, train_label, i);
        N_valid = size(valid_data_current, 1);
        error = zeros(N_lambda, 1);
        for j = 1 : N_lambda
            w = (train_data_current' * train_data_current + lambda(j) * eye(D)) \ train_data_current' * train_label_current;
            error(j) = sum((valid_data_current * w - valid_label_current) .^ 2) ./ N_valid;
        end
        [error_min(i), opt_ind(i)] = min(error);
    end
    [~, error_min_ind] = min(error_min);
    opt_lambda = lambda(opt_ind(error_min_ind));
    disp(['Optimal lambda: ', num2str(opt_lambda)]);
    disp(' ');
    N_test = size(test_data, 1);
    w = (train_data' * train_data + opt_lambda * eye(D)) \ train_data' * train_label;
    test_error(t) = sum((test_data * w - test_label) .^ 2) ./ N_test;
end
test_mean_error = sum(test_error) / 10;
disp(['Average test error: ', num2str(test_mean_error)]);
disp(' ');

clear -regexp [^imported_data];