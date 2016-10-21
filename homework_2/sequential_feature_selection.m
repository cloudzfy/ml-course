%normalized_train_data(isnan(normalized_train_data)) = 0;
%normalized_test_data(isnan(normalized_test_data)) = 0;
N_train = size(normalized_train_data, 1);
N_test = size(normalized_test_data, 1);
train_accu = zeros(10, 1);
test_accu = zeros(10, 1);
optimal_train_data = [];
optimal_test_data = [];
for t = 1 : 10
    current_train_accu = zeros(1, size(normalized_train_data, 2));
    for i = 1 : size(normalized_train_data, 2)
        current_train_data = [optimal_train_data normalized_train_data(:,i)];
        w = glmfit(current_train_data, converted_train_label, 'normal', 'identity');
        pos = sum((([ones(N_train, 1) current_train_data] * w) > 0.5) .* converted_train_label);
        neg = sum((([ones(N_train, 1) current_train_data] * w) < 0.5) .* ~converted_train_label);
        current_train_accu(i) = (pos + neg) / length(converted_train_label);
    end
    [train_accu(t),ind] = max(current_train_accu);
    optimal_train_data = [optimal_train_data normalized_train_data(:,ind)];
    optimal_test_data = [optimal_test_data normalized_test_data(:,ind)];
    
    w = glmfit(optimal_train_data, converted_train_label, 'normal', 'identity');
    pos = sum((([ones(N_test, 1) optimal_test_data] * w) > 0.5) .* converted_test_label);
    neg = sum((([ones(N_test, 1) optimal_test_data] * w) < 0.5) .* ~converted_test_label);
    test_accu(t) = (pos + neg) / length(converted_test_label);
end

t = 1 : 10;
plot(t, train_accu, t, test_accu),legend('Training Accuracy', 'Testing Accuracy');

clearvars current_train_data current_train_accu
clearvars i ind pos neg t w N_train N_test