function count = gamma_b(S, O, i, k, varargin)
    if nargin == 3
        count = sum(S == i);
    elseif nargin == 4
        count = sum(S(O == k) == i);
    end
end