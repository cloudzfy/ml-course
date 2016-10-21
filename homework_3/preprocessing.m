function [train_data, train_label, test_data, test_label] = preprocessing(data)
% features: POP, EDUCATION, HOUSES, INCOME, XCOORD, YCOORD
% label: VOTES

[N, M] = size(data);
N_train = round(0.8*N);
N_test = N - N_train;
r = randperm(N);
data_new = data(r, :);

train_data = data_new(1:N_train, 2:M);
train_label = data_new(1:N_train, 1);
test_data = data_new(N_train+1:N, 2:M);
test_label = data_new(N_train+1:N, 1);

mu = 1 / N_train .* sum(train_data);
sigma = 1 / (N_train - 1) .* sum((train_data - ones(N_train, 1) * mu).^2);

train_data = (train_data - ones(N_train, 1) * mu) ./ (ones(N_train, 1) * sqrt(sigma));
test_data = (test_data - ones(N_test, 1) * mu) ./ (ones(N_test, 1) * sqrt(sigma));

train_data = [ones(N_train, 1) train_data];
test_data = [ones(N_test, 1) test_data];