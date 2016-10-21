make;

preprocessing;

C = 4;
gamma = 0.0625;
disp(' ');
disp('When choosing the optimal C = 4 and gamma = 4^(-2), ');
model = svmtrain(train_label, train_data, ['-t 1 -c ', num2str(C), ' -g ', num2str(gamma), ' -q']);
[~, accu, ~] = svmpredict(test_label, test_data, model, '-q');
disp(['The accuracy of the test set is ', num2str(round(accu(1) * 100) / 100), '%']);