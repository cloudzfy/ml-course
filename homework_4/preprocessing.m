clear;

diff = [2, 7, 8, 14, 15, 16, 26, 29];

load('phishing-train.mat');
m = size(features, 2);
train_data = [];
for i = 1 : m
    if find(diff == i)
        train_data = [train_data, (features(:, i) == -1), (features(:, i) == 0), (features(:, i) == 1)];
    else
        train_data = [train_data, features(:, i)];
    end
end
train_label = label';

load('phishing-test.mat');
m = size(features, 2);
test_data = [];
for i = 1 : m
    if find(diff == i)
        test_data = [test_data, (features(:, i) == -1), (features(:, i) == 0), (features(:, i) == 1)];
    else
        test_data = [test_data, features(:, i)];
    end
end
test_label = label';

train_data = double(train_data);
train_label = double(train_label);
test_data = double(test_data);
test_label = double(test_label);

clearvars diff features label i m;