load('hw1boundary.mat');

x = reshape((0.01:0.01:1)' * ones(1, 100), 10000, 1);
y = reshape(ones(100, 1) * (0.01:0.01:1), 10000, 1);
points = [x, y];

i = 1;
for K = [1, 5, 15, 25]
    label = knn_boundary(features, labels, points, K);
    subplot(2, 2, i);
    i = i + 1;
    scatter(points(label == 1, 1), points(label == 1, 2), 'r');
    hold on;
    scatter(points(label == -1, 1), points(label == -1, 2), 'b');
    title(['K = ', num2str(K)]);
end