pid = unique(hmm_test_normal(:, 1));
test_data_normal = cell(size(pid));
for i = 1 : length(pid)
    test_data_normal{i} = hmm_test_normal(hmm_test_normal(:,1) == pid(i), 2);
end
alpha = cellfun(@(test_data_normal) forward_probability(test_data_normal,A, B, PI, trace), test_data_normal, 'UniformOutput', false);
alpha_T = cell2mat(cellfun(@(alpha) alpha(:,size(alpha, 2))', alpha, 'UniformOutput', false));
L_test_normal = log_approximation(alpha_T);

disp('For normal testing set: ');
disp('The log likelihood is ');
disp(num2str(L_test_normal'));

%beta = cellfun(@(test_data_normal) backward_algorithm(test_data_normal, A, B, trace), test_data_normal, 'UniformOutput', false);
%beta_T = cell2mat(cellfun(@(beta) (beta(:, 1) + log(PI) + log(B(:, 15)))', beta, 'UniformOutput', false));
%L_test_normal_2 = log_approximation(beta_T);

%test_sample_normal = cellfun(@(test_data_normal) sample_generator(length(test_data_normal), A, B, PI, trace), test_data_normal, 'UniformOutput', false);
load('test_normal_sample_100.mat');
[mu_normal, sigma_normal] = cellfun(@(test_sample_normal) sampling(test_sample_normal, A, B, PI, trace), test_sample_normal);
disp('The mean of generated sample is ');
disp(num2str(mu_normal'));
disp('The standard deviation of generated sample is ');
disp(num2str(sigma_normal'));
disp(' ');

pid = unique(hmm_test_trojan(:, 1));
test_data_trojan = cell(size(pid));
for i = 1 : length(pid)
    test_data_trojan{i} = hmm_test_trojan(hmm_test_trojan(:,1) == pid(i), 2);
end
alpha = cellfun(@(test_data_trojan) forward_probability(test_data_trojan,A, B, PI, trace), test_data_trojan, 'UniformOutput', false);
alpha_T = cell2mat(cellfun(@(alpha) alpha(:,size(alpha, 2))', alpha, 'UniformOutput', false));
L_test_trojan = log_approximation(alpha_T);

disp('For trojan testing set: ');
disp('The log likelihood is ');
disp(num2str(L_test_trojan'));

%test_sample_trojan = cellfun(@(test_data_trojan) sample_generator(length(test_data_trojan), A, B, PI, trace), test_data_trojan, 'UniformOutput', false);
load('test_trojan_sample_100.mat');
[mu_trojan, sigma_trojan] = cellfun(@(test_sample_trojan) sampling(test_sample_trojan, A, B, PI, trace), test_sample_trojan);

disp('The mean of generated sample is ');
disp(num2str(mu_trojan'));
disp('The standard deviation of generated sample is ');
disp(num2str(sigma_trojan'));
disp(' ');
