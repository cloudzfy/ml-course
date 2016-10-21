sample = [5500, 6500, 7500, 8000, 8500];
K = [1, 5, 10, 20, 80];

N = size(X.train, 1);
mu = sum(X.train) / N;
eigenvecs = get_sorted_eigenvecs(X.train);
figure(2);
for i = 1 : 5
    current_img = X.train(sample(i), :);
    hold on;
    subplot(6, 5, i);
    imshow(double(reshape(current_img, 16, 16)), []);
    hold off;
    for j = 1 : 5
        X_compressed = (current_img - mu) * eigenvecs(:,1:K(j));
        X_reconstruction = X_compressed * pinv(eigenvecs(:,1:K(j))) + mu;
        hold on;
        subplot(6, 5, i + 5 * j);
        imshow(double(reshape(X_reconstruction, 16, 16)), []);
        hold off;
    end
end