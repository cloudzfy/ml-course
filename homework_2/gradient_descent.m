train_data = optimal_train_data(:, 1:4);
train_data(sum(isnan(train_data),2) > 0) = [];
train_label = cell2mat(train_label);

accu_glmfit = train_accu(4);
disp(['Glmfit training accuracy is: ', num2str(accu_glmfit)]);

it = 100;
accu_batch = zeros(it, 1);
for t = 1:it
    accu_batch(t) = batch_gradient_descent(train_data, train_label, t);
end
subplot(1, 2, 1)
plot(1:it, accu_batch),title('Batch Gradient Descent')
disp(['Batch Gradient Descent training accuracy is: ', num2str(accu_batch(it))]);

accu_newton = zeros(it, 1);
for t = 1:it
    accu_newton(t) = newton_method(train_data, train_label, t);
end
subplot(1, 2, 2)
plot(1:it, accu_newton), title('Newton''s Method')
disp(['Newton''s Method training accuracy is: ', num2str(accu_newton(it))]);