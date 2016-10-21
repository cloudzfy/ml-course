formatSpec = '%s%s%s%s%s%s%s%s%s';
fileID = fopen('hw1nursery_train.data','r');
nursery_train_raw = textscan(fileID, formatSpec, 'Delimiter', ',',  'ReturnOnError', false);
fclose(fileID);

formatSpec = '%s%s%s%s%s%s%s%s%s';
fileID = fopen('hw1nursery_valid.data','r');
nursery_valid_raw = textscan(fileID, formatSpec, 'Delimiter', ',',  'ReturnOnError', false);
fclose(fileID);

formatSpec = '%s%s%s%s%s%s%s%s%s';
fileID = fopen('hw1nursery_test.data','r');
nursery_test_raw = textscan(fileID, formatSpec, 'Delimiter', ',',  'ReturnOnError', false);
fclose(fileID);

formatSpec = '%s%s%s%s%s%s%s%s%s%s';
fileID = fopen('hw1ttt_train.data','r');
ttt_train_raw = textscan(fileID, formatSpec, 'Delimiter', ',',  'ReturnOnError', false);
fclose(fileID);

formatSpec = '%s%s%s%s%s%s%s%s%s%s';
fileID = fopen('hw1ttt_valid.data','r');
ttt_valid_raw = textscan(fileID, formatSpec, 'Delimiter', ',',  'ReturnOnError', false);
fclose(fileID);

formatSpec = '%s%s%s%s%s%s%s%s%s%s';
fileID = fopen('hw1ttt_test.data','r');
ttt_test_raw = textscan(fileID, formatSpec, 'Delimiter', ',',  'ReturnOnError', false);
fclose(fileID);

nursery_train_data = zeros(size(nursery_train_raw{1}, 1), 0);
nursery_valid_data = zeros(size(nursery_valid_raw{1}, 1), 0);
nursery_test_data  = zeros(size(nursery_test_raw{1}, 1), 0);

for i = 1 : 8
    feature = unique([nursery_train_raw{i}; nursery_valid_raw{i}; nursery_test_raw{i}]);
    map = containers.Map(feature, (1 : size(feature, 1))');
    nursery_train_data = [nursery_train_data feature_converter(nursery_train_raw{i}, map)];
    nursery_valid_data = [nursery_valid_data feature_converter(nursery_valid_raw{i}, map)];
    nursery_test_data  = [nursery_test_data feature_converter(nursery_test_raw{i}, map)];
end

label = unique([nursery_train_raw{9}; nursery_valid_raw{9}; nursery_test_raw{9}]);
map = containers.Map(label, (1 : size(label, 1))');
nursery_train_label = cell2mat(values(map, nursery_train_raw{9}));
nursery_valid_label = cell2mat(values(map, nursery_valid_raw{9}));
nursery_test_label  = cell2mat(values(map, nursery_test_raw{9}));

ttt_train_data = zeros(size(ttt_train_raw{1}, 1), 0);
ttt_valid_data = zeros(size(ttt_valid_raw{1}, 1), 0);
ttt_test_data  = zeros(size(ttt_test_raw{1}, 1), 0);

for i = 1 : 9
    feature = unique([ttt_train_raw{i}; ttt_valid_raw{i}; ttt_test_raw{i}]);
    map = containers.Map(feature, (1 : size(feature, 1))');
    ttt_train_data = [ttt_train_data feature_converter(ttt_train_raw{i}, map)];
    ttt_valid_data = [ttt_valid_data feature_converter(ttt_valid_raw{i}, map)];
    ttt_test_data  = [ttt_test_data feature_converter(ttt_test_raw{i}, map)];
end

label = unique([ttt_train_raw{10}; ttt_valid_raw{10}; ttt_test_raw{10}]);
map = containers.Map(label, (1 : size(label, 1))');
ttt_train_label = cell2mat(values(map, ttt_train_raw{10}));
ttt_valid_label = cell2mat(values(map, ttt_valid_raw{10}));
ttt_test_label  = cell2mat(values(map, ttt_test_raw{10}));

clearvars ans fileID formatSpec map i feature label
clearvars nursery_train_raw nursery_valid_raw nursery_test_raw
clearvars ttt_train_raw ttt_valid_raw ttt_test_raw