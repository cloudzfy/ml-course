function sample = sample_generator(N, A, B, PI, trace)
    sample = cell(100, 1);
    for t = 1 : 100
        sample{t} = zeros(N, 1);
        flag = 1;
        while flag
            flag = 0;
            s = PI > exp(-100);
            b = find(B(s, :) > exp(-100));
            o = b(randi(length(b), 1));
            sample{t}(1) = trace(o);
            for i = 2 : N
                a = find(A(s, :) > exp(-100));
                if length(a) <= 0
                    flag = 1;
                    break;
                end
                s = a(randi(length(a), 1));
                b = find(B(s, :) > exp(-100));
                o = b(randi(length(b), 1));
                sample{t}(i) = trace(o);
            end
        end
    end
end