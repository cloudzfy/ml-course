function [new_accu, train_accu] = naive_bayes(train_data, train_label, new_data, new_label)
% naive bayes classifier
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  new_data: M*D matrix, each row as a sample and each column as a
%  feature
%  new_label: M*1 vector, each row as a label
%
% Output:
%  new_accu: accuracy of classifying new_data
%  train_accu: accuracy of classifying train_data 
%
% CSCI 567: Machine Learning, Fall 2015, Homework 1

N = size(train_data, 1);
D = size(train_data, 2);
M = size(new_data, 1);
U = size(unique([train_label; new_label]), 1);

new_accu = 0;
train_accu = 0;

for i = 1 : M
    label_mat = zeros(N, U);
    label_mat(sub2ind(size(label_mat), (1 : N)', train_label)) = 1;
    cond = label_mat' * (ones(N, 1) * new_data(i,:) == train_data) ./ (sum(label_mat)' * ones(1, D));
    cond(cond == 0) = 0.01;
    p = prod(cond, 2) .* sum(label_mat)' ./ M;
    [~, ind] = max(p);
    if ind == new_label(i)
        new_accu = new_accu + 1;
    end
end

new_accu = new_accu / M;

for i = 1 : N
    label_mat = zeros(N, U);
    label_mat(sub2ind(size(label_mat), (1 : N)', train_label)) = 1;
    cond = label_mat' * (ones(N, 1) * train_data(i,:) == train_data) ./ (sum(label_mat)' * ones(1, D));
    cond(cond == 0) = 0.01;
    p = prod(cond, 2) .* sum(label_mat)' ./ M;
    [~, ind] = max(p);
    if ind == train_label(i)
        train_accu = train_accu + 1;
    end
end

train_accu = train_accu / N;