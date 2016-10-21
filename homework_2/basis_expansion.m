% pclass1, pclass2, pclass3, sex1, sex2, age, sibsp, parch, fare,
% embarked1, embarked2, embarked3

numerical_val = [0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0];
for i = 1 : 12
    if numerical_val(i)
        converted_train_data = [converted_train_data sqrt(converted_train_data(:, i))];
        converted_test_data = [converted_test_data sqrt(converted_test_data(:, i))];
    end
end

k = 13;
for i = 1 : 12
    if numerical_val(i)
        if length(unique(converted_train_data(:,i))) >= 10
            tmp = sort(converted_train_data(:,i));
            tmp = tmp(~isnan(tmp));
            bin = 1 : (length(tmp)-1) / 10 : length(tmp);
            bin = tmp(round(bin));
            bin(11) = bin(11) + 1;
            converted_train_data = [converted_train_data zeros(size(converted_train_data, 1), 10)];
            converted_test_data = [converted_test_data zeros(size(converted_test_data, 1), 10)];
            for j = 1 : 10
                converted_train_data((converted_train_data(:,i)>=bin(j) & converted_train_data(:,i)<bin(j+1)), k) = 1;
                converted_test_data((converted_test_data(:,i)>=bin(j) & converted_test_data(:,i)<bin(j+1)), k) = 1;
                k = k + 1;
            end
            clearvars bin_ind tmp
        else
            tmp = converted_train_data(:,i);
            tmp = tmp(~isnan(tmp));
            feature_new = unique(tmp);
            converted_train_data = [converted_train_data zeros(size(converted_train_data, 1), length(feature_new))];
            converted_test_data = [converted_test_data zeros(size(converted_test_data, 1), length(feature_new))];
            for j = 1 : length(feature_new)
                converted_train_data(converted_train_data(:,i)==feature_new(j), k) = 1;
                converted_test_data(converted_test_data(:,i)==feature_new(j), k) = 1;
                k = k + 1;
            end
        end
    end
end

N = size(converted_train_data, 2);
for i = 2 : N
    for j = 1 : i - 1
        converted_train_data = [converted_train_data converted_train_data(:,i) .* converted_train_data(:,j)];
        converted_test_data = [converted_test_data converted_test_data(:,i) .* converted_test_data(:,j)];
    end
end

for i = fliplr(1 : size(converted_train_data, 2))
    tmp = converted_train_data(:,i);
    tmp = tmp(~isnan(tmp));
    if length(unique(tmp)) < 2
        converted_train_data(:,i) = [];
        converted_test_data(:,i) = [];
    end
end

N_train = size(converted_train_data, 1);
N_test = size(converted_test_data, 1);
tmp = converted_train_data;
tmp(isnan(tmp)) = 0;
N = sum(~isnan(converted_train_data));
mu = 1 ./ N .* sum(tmp);
sigma = 1 ./ (N - 1) .* sum(((tmp - ones(N_train, 1) * mu) .* ~isnan(converted_train_data)) .^ 2);
normalized_train_data = (converted_train_data - ones(N_train, 1) * mu) ./ (ones(N_train, 1) * sqrt(sigma));
normalized_test_data = (converted_test_data - ones(N_test, 1) * mu) ./ (ones(N_test, 1) * sqrt(sigma));

clearvars N N_train N_test N tmp mu sigma i j k bin feature_new numerical_val;