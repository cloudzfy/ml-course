function beta =  backward_algorithm(O, A, B, trace)
    N_pid = size(A, 1);
    T = length(O);
    beta = zeros(N_pid, T);
    beta(:, T) = 0;
    for t = T : -1 : 2
        beta(:, t-1) = log_approximation(ones(N_pid, 1) * beta(:, t)' + log(A) + ones(N_pid, 1) * log(B(:, trace == O(t)))');
    end
end