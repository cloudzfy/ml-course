C = [4^(-6) 4^(-5) 4^(-4) 4^(-3) 4^(-2) 4^(-1) 4^(0) 4^(1) 4^(2)];
C_state = ['4^{-6}'; '4^{-5}'; '4^{-4}'; '4^{-3}'; '4^{-2}'; '4^{-1}'; '4^{+0}'; '4^{+1}'; '4^{+2}'];

%file = fopen('linear_svm_dual.txt', 'w');
disp(' ');
disp('**Use linear SVM in LIBSVM');
for i = 1 : 9
    disp(' ');
    disp(['When C = ', C_state(i, :)]);
    disp(' ');
    tic;
    valid_accu = svmtrain(train_label, train_data, ['-t 0 -c ', num2str(C(i)), ' -v 3 -q']);
    train_time = toc;
    disp(['Average Training Time     = ', num2str(round(train_time * 1000 / 3)), 'ms']);
    %fprintf(file, '$%s$ & %.2f\\%% & %.0f ms \\\\\n', C_state(i, :), valid_accu, train_time * 1000 / 3);
end
disp(' ');

%fclose(file);