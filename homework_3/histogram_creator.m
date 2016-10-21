function [output, output_ind] = histogram_creator(data, bin)
    N = length(data);
    output = zeros(bin, 1);
    bin_max = max(data);
    bin_min = min(data);
    bin_ind = linspace(bin_min, bin_max, bin + 1);
    bin_width = (bin_max - bin_min) / bin;
    for t = 1 : bin
        output(t) = sum((data >= bin_ind(t)) & (data < bin_ind(t+1))) / N / bin_width;
    end
    output_ind = 0.5 * (bin_ind(2:bin+1) + bin_ind(1:bin));