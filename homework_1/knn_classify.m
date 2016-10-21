function [new_accu, train_accu] = knn_classify(train_data, train_label, new_data, new_label, K)
% k-nearest neighbor classifier
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  new_data: M*D matrix, each row as a sample and each column as a
%  feature
%  new_label: M*1 vector, each row as a label
%  K: number of nearest neighbors
%
% Output:
%  new_accu: accuracy of classifying new_data
%  train_accu: accuracy of classifying train_data (using leave-one-out
%  strategy)
%
% CSCI 567: Machine Learning, Fall 2015, Homework 1

N = size(train_data, 1);
M = size(new_data, 1);

new_accu   = 0;
train_accu = 0;

train_mu    = 1 ./ N .* sum(train_data, 1);
train_sigma = 1 ./ (N-1) .* sum((train_data - ones(N, 1) * train_mu) .^ 2, 1);

train_data = (train_data - ones(N, 1) * train_mu) ./ (ones(N, 1) * sqrt(train_sigma));
new_data   = (new_data - ones(M, 1) * train_mu) ./ (ones(M, 1) * sqrt(train_sigma));

for i = 1 : M
    [~, ind] = sort(sum((ones(N, 1) * new_data(i,:) - train_data) .^ 2, 2));
    if mode(train_label(ind(1:K))) == new_label(i)
        new_accu = new_accu + 1;
    end
end

new_accu = new_accu / M;

for i = 1 : N
    [~, ind] = sort(sum((ones(N, 1) * train_data(i,:) - train_data) .^ 2, 2));
    if mode(train_label(ind(2:K+1))) == train_label(i)
        train_accu = train_accu + 1;
    end
end

train_accu = train_accu / N;