dt = 0.0001;
t = (0:dt:1)';
h = [0.01 0.02 0.05 0.1 0.3];

N = 19;
r = randperm(size(x_te, 1));

var_g = zeros(5, 1);
var_e = zeros(5, 1);
var_h = zeros(5, 1);

for i = 1 : 5
    disp(['When h = ', num2str(h(i)), ',']);
    f_g = zeros(size(t,1),N);
    f_e = zeros(size(t,1),N);
    f_h = zeros(size(t,1),N);
    for n = 1 : N
        f_g(:,n) = gaussian_kernel(x_te(r(n * 500 - 499 : n * 500)),t,h(i));
        f_e(:,n) = epanechnikov_kernel(x_te(r(n * 500 - 499 :n * 500)),t,h(i));
        f_h(:,n) = histogram(x_te(r(n * 500 - 499 : n * 500)),t,h(i));
    end

    var_g(i) = sum(1 / N .* sum((f_g - sum(f_g, 2) * ones(1, N) ./ N) .^ 2, 2) .* dt);
    disp(['The integrated variance of Gaussian kernel is ', num2str(var_g(i))]);
    var_e(i) = sum(1 / N .* sum((f_e - sum(f_e, 2) * ones(1, N) ./ N) .^ 2, 2) .* dt);
    disp(['The integrated variance of Epanechnikov kernel is ', num2str(var_e(i))]);
    var_h(i) = sum(1 / N .* sum((f_h - sum(f_h, 2) * ones(1, N) ./ N) .^ 2, 2) .* dt);
    disp(['The integrated variance of Histogram is ', num2str(var_h(i))]);
end

plot(h, var_g, h, var_e, h, var_h);
legend('Gaussian kernel', 'Epanechnikov kernel', 'Histogram')