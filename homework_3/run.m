clc;

% Programming - Bias/Variance Tradeoff

clear;

figure(1);
bias_var_10_samples;

figure(2);
bias_var_100_samples;

bias_var_w_regularization;

clear;

% Programming - Regression

imported_data = load('space_ga.txt');

linear_ridge_regression;

kernel_ridge_regression;

clear;