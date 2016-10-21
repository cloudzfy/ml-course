function H = entropy(X, Y, bin)
    converted_x = feature_convertor(X, bin);
    converted_y = cell2mat(Y);
    M = length(unique(converted_x(converted_x >= 0)));
    L = length(X);
    H_xy = 0;
    H_y = 0;
    for i = 1 : M
        for j = 0 : 1
            p_xy = sum((i == converted_x) .* (j == converted_y)) / L;
            p_x = sum(i == converted_x) / L;
            if (p_xy == 0)
                continue;
            end
            H_xy = H_xy - p_xy * log(p_xy / p_x);
        end
    end
    for j = 0 : 1
        p_y = sum(j == converted_y) / L;
        if  p_y == 0
            continue
        end
        H_y = H_y - p_y * log(p_y);
    end
    H = H_y - H_xy;