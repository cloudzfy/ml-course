K = 2;
a = 0;
b = 2;

figure(3);
X = circle_points;
N = size(X, 1);
mu = X(randperm(N, K), :);
old_r = zeros(N, K);
kernel_1 = ones(N, K);
r = repmat([1 0],N,1);
s = sum(X.^2,2);
pos = find(s==min(s));
r(pos,:) = [0 1];
while true
    kernel_tmp_1 = (X * X' + a) .^ b;
    kernel_3 = (kernel_tmp_1 * r ./ (ones(N, 1) * sum(r)));
    kernel_tmp_2 = zeros(1, K);
    for k = 1 : K
        kernel_tmp_2(k) = sum(sum(kernel_tmp_1 .* (r(:, k) * r(:, k)'), 1), 2) / sum(sum(r(:, k) * r(:, k)', 1), 2);
    end
    kernel_2 = ones(N, 1) * kernel_tmp_2;
    [~, k] = min(kernel_1 + kernel_2 - 2 * kernel_3, [], 2);
    r = zeros(N, K);
    r(sub2ind([N, K], (1 : N)', k)) = 1;
    if old_r == r
        break;
    end
    old_r = r;
end
for k = 1 : K
    hold on;
    scatter(X(r(:, k) == 1, 1), X(r(:, k) == 1, 2), 'filled');
end