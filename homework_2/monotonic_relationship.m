label = cell2mat(train_label);

pclass = zeros(3, 1);
pclass_data = cell2mat(train_data(:, 1));
for i = 1 : 3
    pclass(i) = label' * (pclass_data == i) / sum(pclass_data == i);
end
subplot(2, 3, 1);
bar(pclass)
title('Passenger Class')
clearvars pclass pclass_data;

age = zeros(10, 1);
age_data = cell2mat(train_data(:, 4));
age_max = max(age_data) + 1;
age_min = min(age_data);
age_x = age_min : (age_max - age_min) / 10 : age_max;
for i = 1 : 10
    age(i) = label' * ((age_data >= age_x(i)) & (age_data < age_x(i+1))) / sum((age_data >= age_x(i)) & (age_data < age_x(i+1)));
end
subplot(2, 3, 2);
bar(age)
title('Age')
clearvars age age_data age_max age_min age_x;

sibsp = zeros(8, 1);
sibsp_data = cell2mat(train_data(:,5));
for i = 1 : 8
    sibsp(i) = label' * (sibsp_data == i) / sum(sibsp_data == i);
end
subplot(2, 3, 3);
bar(sibsp)
title('Number of Siblings/Spouses Aboard')
clearvars sibsp sibsp_data;

parch = zeros(9, 1);
parch_data = cell2mat(train_data(:, 6));
for i = 1 : 9
    parch(i) = label' * (parch_data == i) / sum(parch_data == i);
end
subplot(2, 3, 4);
bar(parch)
title('Number of Parents/Children Aboard')
clearvars parch parch_data;

fare = zeros(10, 1);
fare_data = cell2mat(train_data(:, 8));
fare_max = max(fare_data) + 1;
fare_min = min(fare_data);
fare_x = fare_min : (fare_max - fare_min) / 10 : fare_max;
for i = 1 : 10
    fare(i) = label' * ((fare_data >= fare_x(i)) & (fare_data < fare_x(i+1))) / sum((fare_data >= fare_x(i)) & (fare_data < fare_x(i+1)));
end
subplot(2, 3, 5);
bar(1 : 10, fare)
title('Passenger Fare')
clearvars fare fare_data fare_max fare_min fare_x;
clearvars i label;
