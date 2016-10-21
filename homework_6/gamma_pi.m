function count = gamma_pi(S, t, i, varargin)
    if nargin == 2
        count = length(S(t));
    elseif nargin == 3
        count = sum(S(t) == i);
    end
end