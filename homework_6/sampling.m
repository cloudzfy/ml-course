function [mu, sigma] = sampling(data, A, B, PI, trace)
    alpha = cellfun(@(data) forward_probability(data,A, B, PI, trace), data, 'UniformOutput', false);
    alpha_T = cell2mat(cellfun(@(alpha) alpha(:,size(alpha, 2))', alpha, 'UniformOutput', false));
    L_data = log_approximation(alpha_T);
    N = length(L_data);
    mu = sum(L_data) / N;
    sigma = sqrt(sum((L_data - mu) .^ 2) / (N - 1));
end