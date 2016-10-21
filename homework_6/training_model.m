pid = unique(hmm_train(:, 1));
trace = unique(hmm_train(:, 2));
train_data = cell(size(pid));

N_pid = length(pid);
N_trace = size(trace, 1);
S = cell(size(pid));
T_trace = hist(hmm_train(:,1), unique(hmm_train(:,1)));
for i = 1 : length(pid)
    S{i} = randi([1, N_trace], 1, T_trace(i));
end

for i = 1 : length(pid)
    train_data{i} = hmm_train(hmm_train(:,1) == pid(i), 2);
end

PI = zeros(N_trace, 1);
A = zeros(N_trace, N_trace);
B = zeros(N_trace, N_trace);

while true
    old_S = S;
    for i = 1 : N_trace
        PI(i) = sum(cellfun(@(S) gamma_pi(S, 1, i), S)) / sum(cellfun(@(S) gamma_pi(S, 1), S));
        if isnan(PI(i))
            PI(i) = 0;
        end
    end
    for i = 1 : N_trace
        for j = 1 : N_trace
            A(i, j) = sum(cellfun(@(S) delta(S, i, j), S)) / sum(cellfun(@(S) delta(S, i), S));
            if isnan(A(i, j))
                A(i, j) = 0;
            end
        end
    end
    for i = 1 : N_trace
        for k = 1 : N_trace
            B(i, k) = sum(cellfun(@(S, train_data) gamma_b(S, train_data, i, trace(k)), S, train_data))...
                / sum(cellfun(@(S, train_data) gamma_b(S, train_data, i), S, train_data));
            if isnan(B(i, k))
                B(i, k) = 0;
            end
        end
    end
    PI(PI == 0) = exp(-500);
    A(A == 0) = exp(-500);
    B(B == 0) = exp(-500);
    alpha = cellfun(@(train_data) forward_probability(train_data,A, B, PI, trace), train_data, 'UniformOutput', false);
    beta = cellfun(@(train_data) backward_algorithm(train_data, A, B, trace), train_data, 'UniformOutput', false);
    S = cellfun(@(alpha, beta) selection(alpha, beta), alpha, beta, 'UniformOutput', false);
    if sum(cellfun(@isequal, old_S, S)) == N_pid
        break;
    end
end