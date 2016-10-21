[~, ~, raw_data] = xlsread('titanic3.xls');

n = size(raw_data, 1) - 1;
m = size(raw_data, 2);

r = randperm(n) + 1;
train_data = [raw_data(r(1 : round(n / 2)), 1) raw_data(r(1 : round(n / 2)), 3 : m)];
train_label = raw_data(r(1 : round(n / 2)),2);
test_data = [raw_data(r(round(n / 2) + 1 : n), 1) raw_data(r(round(n / 2) + 1 : n), 3 : m)];
test_label = raw_data(r(round(n / 2) + 1 : n), 2);

clearvars m n r raw_data;