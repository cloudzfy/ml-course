function [test_accu] = testsvm(test_data, test_label, w, b)
    N = size(test_data, 1);
    test_accu = sum(test_label .* (test_data * w + b) > 0) / N;
end