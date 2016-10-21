function converted_data = feature_mapping(raw_data, map)
    n = size(raw_data, 1);
    m = size(map, 1);
    index = cell2mat(values(map, raw_data));
    converted_data = zeros(n, m);
    converted_data(sub2ind(size(converted_data),(1:n)',index)) = 1;