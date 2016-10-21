function res = log_approximation(X)
    N = size(X, 2);
    if N > 1
        mid = floor(N / 2);
        X1 = log_approximation(X(:,1:mid));
        X2 = log_approximation(X(:,mid+1:N));
        A = max(X1, X2);
        B = min(X1, X2);
        res = A + log(1 + exp(B - A));
    else
        res = X;
    end
end