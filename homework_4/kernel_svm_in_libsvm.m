C = [4^(-3) 4^(-2) 4^(-1) 4^(0) 4^(1) 4^(2) 4^(3) 4^(4) 4^(5) 4^(6) 4^(7)];
C_state = ['4^{-3}'; '4^{-2}'; '4^{-1}'; '4^{+0}'; '4^{+1}'; '4^{+2}'; '4^{+3}'; '4^{+4}'; '4^{+5}'; '4^{+6}'; '4^{+7}'];
degree = [1 2 3];
degree_state = ['1'; '2'; '3'];
gamma = [4^(-7) 4^(-6) 4^(-5) 4^(-4) 4^(-3) 4^(-2) 4^(-1)];
gamma_state = ['4^{-7}'; '4^{-6}'; '4^{-5}'; '4^{-4}'; '4^{-3}'; '4^{-2}'; '4^{-1}'];

best_accu = 0;

disp(' ');
disp('**Use kernel SVM in LIBSVM');

% Polynomial kernel

%file = fopen('kernel_svm_polynomial.txt', 'w');
disp(' ');
disp('Polynomial kernel');
for i = 1 : 11
    disp(' ');
    disp(['When C = ', C_state(i, :)]);
    %fprintf(file, '\\multirow{3}{*}{$%s$} ', C_state(i, :));
    for j = 1 : 3
        disp(' ');
        disp(['When degree = ', degree_state(j, :)]);
        disp(' ');
        tic;
        valid_accu = svmtrain(train_label, train_data, ['-t 1 -c ', num2str(C(i)), ' -d ', num2str(degree(j)), ' -v 3 -q']);
        if valid_accu >= best_accu
            best_state = ['Polynomial kernel with C = ', num2str(C(i)), ' and degree = ', num2str(degree(j))];
            best_accu = valid_accu;
        end
        train_time = toc;
        disp(['Average Training Time     = ', num2str(round(train_time * 1000 / 3)), 'ms']);
        %fprintf(file, '& %s & %.2f\\%% & %.0f ms \\\\\n', degree_state(j, :), valid_accu, train_time * 1000 / 3);
    end
end
%fclose(file);

% RBF kernel

%file = fopen('kernel_svm_rbf.txt', 'w');
disp(' ');
disp('RBF kernel');
for i = 1 : 11
    disp(' ');
    disp(['When C = ', C_state(i, :)]);
    %fprintf(file, '\\multirow{7}{*}{$%s$} ', C_state(i, :));
    for j = 1 : 7
        disp(' ');
        disp(['When gamma = ', gamma_state(j, :)]);
        disp(' ');
        tic;
        valid_accu = svmtrain(train_label, train_data, ['-t 2 -c ', num2str(C(i)), ' -g ', num2str(gamma(j)), ' -v 3 -q']);
        if valid_accu >= best_accu
            best_state = ['RBF kernel with C = ', num2str(C(i)), ' and gamma = ', num2str(gamma(j))];
            best_accu = valid_accu;
        end
        train_time = toc;
        disp(['Average Training Time     = ', num2str(round(train_time * 1000 / 3)), 'ms']);
        %fprintf(file, '& $%s$ & %.2f\\%% & %.0f ms \\\\\n', gamma_state(j, :), valid_accu, train_time * 1000 / 3);
    end
end
%fclose(file);
disp(' ');
disp('The best approach is: ');
disp(best_state);
disp(['With best cross-validation accuracy = ', num2str(best_accu), '%']);