% K-Nearest Neighbour
disp('=== K-Nearest Neighbour Report ===');
for K = 1:2:15
    disp(['When K = ', num2str(K)]);
    [valid_accu, ~] = knn_classify(ttt_train_data,ttt_train_label,ttt_valid_data,ttt_valid_label,K);
    [test_accu, train_accu]  = knn_classify(ttt_train_data,ttt_train_label,ttt_test_data,ttt_test_label,K);
    disp(['    The accuracy of training data is ', num2str(train_accu)]);
    disp(['    The accuracy of validation data is ', num2str(valid_accu)]);
    disp(['    The accuracy of testing data is ', num2str(test_accu)]);
end
disp(' ');

%Decision Tree
disp('=== Decision Tree Report ===');
for L = 1:10
    disp(['When MinLeaf = ', num2str(L)]);
    gdi_tree = ClassificationTree.fit(ttt_train_data,ttt_train_label,'SplitCriterion','gdi','MinLeaf',L,'Prune','off');
    dev_tree = ClassificationTree.fit(ttt_train_data,ttt_train_label,'SplitCriterion','deviance','MinLeaf',L,'Prune','off');
    gdi_train_accu = sum(predict(gdi_tree, ttt_train_data) == ttt_train_label) / length(ttt_train_label);
    gdi_valid_accu = sum(predict(gdi_tree, ttt_valid_data) == ttt_valid_label) / length(ttt_valid_label);
    gdi_test_accu  = sum(predict(gdi_tree, ttt_test_data) == ttt_test_label) / length(ttt_test_label);
    dev_train_accu = sum(predict(dev_tree, ttt_train_data) == ttt_train_label) / length(ttt_train_label);
    dev_valid_accu = sum(predict(dev_tree, ttt_valid_data) == ttt_valid_label) / length(ttt_valid_label);
    dev_test_accu  = sum(predict(dev_tree, ttt_test_data) == ttt_test_label) / length(ttt_test_label);
    disp('When Split Criterion is Gini index:');
    disp(['    The accuracy of training data is ', num2str(gdi_train_accu)]);
    disp(['    The accuracy of validation data is ', num2str(gdi_valid_accu)]);
    disp(['    The accuracy of testing data is ', num2str(gdi_test_accu)]);
    disp('When Split Criterion is Cross-entropy:');
    disp(['    The accuracy of training data is ', num2str(dev_train_accu)]);
    disp(['    The accuracy of validation data is ', num2str(dev_valid_accu)]);
    disp(['    The accuracy of testing data is ', num2str(dev_test_accu)]);
end
disp(' ');

% Naive Bayes
disp('=== Naive Bayes Report ===');
disp('On the Tic-Tac-Toe Endgame Dataset,');
[valid_accu, ~] = naive_bayes(ttt_train_data,ttt_train_label,ttt_valid_data,ttt_valid_label);
[test_accu, train_accu]  = naive_bayes(ttt_train_data,ttt_train_label,ttt_test_data,ttt_test_label);
disp(['    The accuracy of training data is ', num2str(train_accu)]);
disp(['    The accuracy of validation data is ', num2str(valid_accu)]);
disp(['    The accuracy of testing data is ', num2str(test_accu)]);
disp('On the Nursery Dataset,');
[valid_accu, ~] = naive_bayes(nursery_train_data,nursery_train_label,nursery_valid_data,nursery_valid_label);
[test_accu, train_accu]  = naive_bayes(nursery_train_data,nursery_train_label,nursery_test_data,nursery_test_label);
disp(['    The accuracy of training data is ', num2str(train_accu)]);
disp(['    The accuracy of validation data is ', num2str(valid_accu)]);
disp(['The accuracy of testing data is ', num2str(test_accu)]);
disp(' ');