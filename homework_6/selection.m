function gamma = selection(alpha, beta)
    [~, gamma] = max(alpha + beta, [], 1);
end