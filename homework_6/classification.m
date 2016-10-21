K = [1, 5, 10, 20, 80];

N_train = size(X.train, 1);
N_test = size(X.test, 1);
mu = sum(X.train) / N;
eigenvecs = get_sorted_eigenvecs(X.train);

for i = 1 : 5
    disp(['When K = ', num2str(K(i))]);
    tic;
    X_compressed = (X.train - ones(N_train, 1) * mu) * eigenvecs(:,1:K(i));
    train_data = X_compressed * pinv(eigenvecs(:,1:K(i))) + ones(N_train, 1) * mu;
    train_label = y.train;
    X_compressed = (X.test - ones(N_test, 1) * mu) * eigenvecs(:,1:K(i));
    test_data = X_compressed * pinv(eigenvecs(:,1:K(i))) + ones(N_test, 1) * mu;
    test_label = y.test;
    tree = ClassificationTree.fit(train_data, train_label, 'SplitCriterion', 'deviance');
    train_label_inferred = predict(tree, train_data);
    test_label_inferred = predict(tree, test_data);
    train_accu = sum(train_label_inferred == train_label) / N_train;
    test_accu = sum(test_label_inferred == test_label) / N_test;
    t = toc;
    disp(['The accuracy of the training prediction is ', num2str(train_accu)]);
    disp(['The accuracy of the testing prediction is ', num2str(test_accu)]);
    disp(['Computation time is ', num2str(t), ' s']);
    disp(' ');
end