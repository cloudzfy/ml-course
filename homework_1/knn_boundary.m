function new_label = knn_boundary(train_data, train_label, new_data, K)

N = size(train_data, 1);
M = size(new_data, 1);

train_mu    = 1 ./ N .* sum(train_data, 1);
train_sigma = 1 ./ (N-1) .* sum((train_data - ones(N, 1) * train_mu) .^ 2, 1);

train_data = (train_data - ones(N, 1) * train_mu) ./ (ones(N, 1) * sqrt(train_sigma));
new_data   = (new_data - ones(M, 1) * train_mu) ./ (ones(M, 1) * sqrt(train_sigma));

new_label = zeros(M, 1);

for i = 1 : M
    [~, ind] = sort(sum((ones(N, 1) * new_data(i,:) - train_data) .^ 2, 2));
    new_label(i) = mode(train_label(ind(1:K)));
end