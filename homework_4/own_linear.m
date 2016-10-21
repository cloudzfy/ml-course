preprocessing;

C = 0.0625;
disp(' ');
disp('When choosing the optimal C = 0.0625, ');
[w, b] = trainsvm(train_data, train_label, C);
accu = testsvm(test_data, test_label, w, b);
disp(['The accuracy of the test set is ', num2str(round(accu * 10000) / 100), '%']);
