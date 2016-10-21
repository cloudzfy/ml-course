warning('off');

% pclass, sex, age, sibsp, parch, fare, embarked
ind = [1, 3, 4, 5, 6, 8, 10];

train_data_new = train_data(:, ind);
test_data_new = test_data(:, ind);

% embarked
train_data_new(cellfun(@isnan, train_data_new(:, 7)), 7) = {'S'};
test_data_new(cellfun(@isnan, test_data_new(:, 7)), 7) = {'S'};

% fare
train_data_new(cellfun(@isnan, train_data_new(:, 6)), 6) = {33.2955};
test_data_new(cellfun(@isnan, test_data_new(:, 6)), 6) = {33.2955};

converted_train_data = zeros(0, 0);
converted_test_data = zeros(0, 0);

categorical_val = [1, 1, 0, 0, 0, 0, 1];

for i = 1 : 7
    if categorical_val(i)
        train_data_new_num2str = cellfun(@num2str, train_data_new(:, i), 'UniformOutput', false);
        feature_new = unique(train_data_new_num2str);
        map = containers.Map(feature_new, (1 : length(feature_new))');
        converted_train_data = [converted_train_data feature_mapping(train_data_new_num2str, map)];
    
        test_data_new_num2str = cellfun(@num2str, test_data_new(:, i), 'UniformOutput', false);
        feature_new = unique(test_data_new_num2str);
        map = containers.Map(feature_new, (1 : length(feature_new))');
        converted_test_data = [converted_test_data feature_mapping(test_data_new_num2str, map)];
    else
        converted_train_data = [converted_train_data cell2mat(train_data_new(:, i))];
        converted_test_data = [converted_test_data cell2mat(test_data_new(:, i))];
    end
end

% Multiple Models
converted_train_label = cell2mat(train_label);
converted_test_label = cell2mat(test_label);
N_train = size(converted_train_data, 1);
N_test = size(converted_test_data, 1);
tmp = converted_train_data;
tmp(isnan(tmp)) = 0;
N = sum(~isnan(converted_train_data));
mu = 1 ./ N .* sum(tmp);
sigma = 1 ./ (N - 1) .* sum(((tmp - ones(N_train, 1) * mu) .* ~isnan(converted_train_data)) .^ 2);
normalized_train_data = (converted_train_data - ones(N_train, 1) * mu) ./ (ones(N_train, 1) * sqrt(sigma));
normalized_test_data = (converted_test_data - ones(N_test, 1) * mu) ./ (ones(N_test, 1) * sqrt(sigma));

w1 = glmfit(normalized_train_data, converted_train_label, 'binomial', 'logit');
normalized_train_data_w = normalized_train_data;
normalized_train_data_w(:,6) = [];
w2 = glmfit(normalized_train_data_w, converted_train_label, 'binomial', 'logit');

y1 = (sigmoid([ones(N_train, 1) normalized_train_data] * w1) > 0.5) .* (sum(isnan(normalized_train_data), 2) == 0);
y2 = (sigmoid([ones(N_train, 1) normalized_train_data_w] * w2) > 0.5) .* (sum(isnan(normalized_train_data_w), 2) > 0);
pos = sum((y1 + y2) .* converted_train_label);

y1 = (sigmoid([ones(N_train, 1) normalized_train_data] * w1) < 0.5) .* (sum(isnan(normalized_train_data), 2) == 0);
y2 = (sigmoid([ones(N_train, 1) normalized_train_data_w] * w2) < 0.5) .* (sum(isnan(normalized_train_data_w), 2) > 0);
neg = sum((y1 + y2) .* ~converted_train_label);

train_accu = (pos + neg) / length(converted_train_label);

normalized_test_data_w = normalized_test_data;
normalized_test_data_w(:,6) = [];

y1 = (sigmoid([ones(N_test, 1) normalized_test_data] * w1) > 0.5) .* (sum(isnan(normalized_test_data), 2) == 0);
y2 = (sigmoid([ones(N_test, 1) normalized_test_data_w] * w2) > 0.5) .* (sum(isnan(normalized_test_data_w), 2) > 0);
pos = sum((y1 + y2) .* converted_test_label);

y1 = (sigmoid([ones(N_test, 1) normalized_test_data] * w1) < 0.5) .* (sum(isnan(normalized_test_data), 2) == 0);
y2 = (sigmoid([ones(N_test, 1) normalized_test_data_w] * w2) < 0.5) .* (sum(isnan(normalized_test_data_w), 2) > 0);
neg = sum((y1 + y2) .* ~converted_test_label);
test_accu = (pos + neg) / length(converted_test_label);

disp('Multiple Models:');
disp(['Training Accuracy: ', num2str(train_accu)]);
disp(['Testing Accuracy: ', num2str(test_accu)]);

% Substituting Values
tmp = converted_train_data;
tmp(isnan(tmp(:, 6)), 6) = mu(6);
converted_test_data(isnan(converted_test_data(:, 6)), 6) = mu(6);
normalized_train_data = (tmp - ones(N_train, 1) * mu) ./ (ones(N_train, 1) * sqrt(sigma));
normalized_test_data = (converted_test_data - ones(N_test, 1) * mu) ./ (ones(N_test, 1) * sqrt(sigma));

w = glmfit(normalized_train_data, converted_train_label, 'binomial', 'logit');

pos = sum((sigmoid([ones(N_train, 1) normalized_train_data] * w) > 0.5) .* converted_train_label);
neg = sum((sigmoid([ones(N_train, 1) normalized_train_data] * w) < 0.5) .* ~converted_train_label);
train_accu = (pos + neg) / length(converted_train_label);

pos = sum((sigmoid([ones(N_test, 1) normalized_test_data] * w) > 0.5) .* converted_test_label);
neg = sum((sigmoid([ones(N_test, 1) normalized_test_data] * w) < 0.5) .* ~converted_test_label);
test_accu = (pos + neg) / length(converted_test_label);

disp('Substituting Values:');
disp(['Training Accuracy: ', num2str(train_accu)]);
disp(['Testing Accuracy: ', num2str(test_accu)]);

clearvars N N_train N_test pos neg train_accu test_accu mu sigma
clearvars normalized_train_data normalized_train_data_w
clearvars normalized_test_data normalized_test_data_w
clearvars w w1 w2 y1 y2 map i ind feature_new tmp categorical_val
clearvars train_data_new train_data_new_num2str
clearvars test_data_new test_data_new_num2str