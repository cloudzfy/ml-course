function alpha = forward_probability(O, A, B, PI, trace)
    N_pid = size(A, 1);
    T = length(O);
    alpha = zeros(N_pid, T);
    alpha(:,1) = log(B(:, trace == O(1))) + log(PI);
    for t = 2 : T
        alpha(:,t) = log(B(:, trace == O(t))) + log_approximation((log(A) + (alpha(:,t-1) * ones(1, N_pid)))');
    end
end