N = 1000;
N_dataset = 100;
N_bin = 10;
X = 2 * rand(N, 1) - 1;
Y = 2 * X .* X + normrnd(0, sqrt(0.1),N,1);

disp(' ');
disp('Bias/Variance Tradeoff with 10 Samples:');
disp(' ');

% g_1(x) = 1
X_train = ones(N, 1);
[error, bias, variance] = linear_regression(X_train, Y, N_dataset, true);
disp('Function g_1(x) = 1');
disp(['Bias: ', num2str(bias)]);
disp(['Variance: ', num2str(variance)]);
disp(' ');
[error_hist, hist_ind] = histogram_creator(error, N_bin);
subplot(3,2,1);
bar(hist_ind, error_hist);
title('g_1(x)');

% g_2(x) = w_0
X_train = ones(N, 1);
[error, bias, variance] = linear_regression(X_train, Y, N_dataset, false);
disp('Function g_2(x) = w_0');
disp(['Bias: ', num2str(bias)]);
disp(['Variance: ', num2str(variance)]);
disp(' ');
[error_hist, hist_ind] = histogram_creator(error, N_bin);
subplot(3,2,2);
bar(hist_ind, error_hist);
title('g_2(x)');

% g_3(x) = w_0 + w_1*x
X_train = [ones(N, 1) X];
[error, bias, variance] = linear_regression(X_train, Y, N_dataset, false);
disp('Function g_3(x) = w_0 + w_1*x');
disp(['Bias: ', num2str(bias)]);
disp(['Variance: ', num2str(variance)]);
disp(' ');
[error_hist, hist_ind] = histogram_creator(error, N_bin);
subplot(3,2,3);
bar(hist_ind, error_hist);
title('g_3(x)');

% g_4(x) = w_0 + w_1*x + w_2*x^2
X_train = [ones(N, 1) X X.^2];
[error, bias, variance] = linear_regression(X_train, Y, N_dataset, false);
disp('Function g_4(x) = w_0 + w_1*x + w_2*x^2');
disp(['Bias: ', num2str(bias)]);
disp(['Variance: ', num2str(variance)]);
disp(' ');
[error_hist, hist_ind] = histogram_creator(error, N_bin);
subplot(3,2,4);
bar(hist_ind, error_hist);
title('g_4(x)');

% g_5(x) = w_0 + w_1*x + w_2*x^2 + w_3*x^3
X_train = [ones(N, 1) X X.^2 X.^3];
[error, bias, variance] = linear_regression(X_train, Y, N_dataset, false);
disp('Function g_5(x) = w_0 + w_1*x + w_2*x^2 + w_3*x^3');
disp(['Bias: ', num2str(bias)]);
disp(['Variance: ', num2str(variance)]);
disp(' ');
[error_hist, hist_ind] = histogram_creator(error, N_bin);
subplot(3,2,5);
bar(hist_ind, error_hist);
title('g_5(x)');

% g_6(x) = w_0 + w_1*x + w_2*x^2 + w_3*x^3 + w_4*x^4
X_train = [ones(N, 1) X X.^2 X.^3 X.^4];
[error, bias, variance] = linear_regression(X_train, Y, N_dataset, false);
disp('Function g_6(x) = w_0 + w_1*x + w_2*x^2 + w_3*x^3 + w_4*x^4');
disp(['Bias: ', num2str(bias)]);
disp(['Variance: ', num2str(variance)]);
disp(' ');
[error_hist, hist_ind] = histogram_creator(error, N_bin);
subplot(3,2,6);
bar(hist_ind, error_hist);
title('g_6(x)');

clearvars N N_bin N_dataset X Y
clearvars X_train bias variance error error_hist hist_ind