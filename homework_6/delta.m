function count = delta(S, i, j, varargin)
    N = length(S);
    if nargin == 2
        count = sum(S(1 : N - 1) == i);
    elseif nargin == 3
        count = sum((S(1 : N - 1) == i) .* (S(2 : N) == j));
    end
end