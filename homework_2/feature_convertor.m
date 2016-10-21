function converted_data = feature_convertor(data, bin)
    if ~bin
        ind = ~cellfun(@sum,cellfun(@isnan, data, 'UniformOutput', false));
        feature = unique(cellfun(@num2str, data(ind), 'UniformOutput', false));
        map = containers.Map(feature, (1 : length(feature))');
        data = cellfun(@num2str, data, 'UniformOutput', false);
        map('NaN') = -1;
        converted_data = cell2mat(values(map, data));
    else
        data = cell2mat(data);
        ind = 1 : (length(data)-1) / 10 : length(data);
        tmp = sort(data);
        ind = tmp(round(ind));
        ind(11) = ind(11) + 1;
        converted_data = zeros(size(data));
        for i = 1 : 10
            converted_data((data >= ind(i)) & (data < ind(i+1))) = i;
        end
    end