C = [4^(-6) 4^(-5) 4^(-4) 4^(-3) 4^(-2) 4^(-1) 4^(0) 4^(1) 4^(2)];
C_state = ['4^{-6}'; '4^{-5}'; '4^{-4}'; '4^{-3}'; '4^{-2}'; '4^{-1}'; '4^{+0}'; '4^{+1}'; '4^{+2}'];

%file = fopen('linear_svm_primal.txt', 'w');
N = size(train_data, 1);
best_C = 0;
best_accu = 0;
disp(' ');
disp('**Cross-validation for linear SVM');
for i = 1 : 9
    disp(' ');
    disp(['When C = ', C_state(i, :)]);
    train_time = 0;
    valid_accu = 0;
    for j = 1 : 3
        [train_data_current, train_label_current, valid_data_current, valid_label_current] = three_folder(train_data, train_label, j);
        tic;
        [w, b] = trainsvm(train_data_current, train_label_current, C(i));
        train_time = train_time + toc;
        valid_accu = valid_accu + testsvm(valid_data_current, valid_label_current, w, b);
    end
    valid_accu = round(valid_accu * 10000 / 3) / 100;
    disp(' ');
    disp(['Cross Validation Accuracy = ', num2str(valid_accu), '%']);
    disp(['Average Training Time     = ', num2str(round(train_time * 1000 / 3)), 'ms']);
    %fprintf(file, '$%s$ & %.2f\\%% & %.0f ms \\\\\n', C_state(i, :), valid_accu, train_time * 1000 / 3);
    if best_accu < valid_accu
        best_accu = valid_accu;
        best_C = C(i);
    end
end

disp(' ');
disp(['The best case is C = ', num2str(best_C), ' with accuracy ', num2str(best_accu), '%']);

%fclose(file);