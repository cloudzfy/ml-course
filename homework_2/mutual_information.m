pclass_data = train_data(:, 1);
pclass_mi = entropy(pclass_data, train_label, false);
disp(['Passenger Class                   ', num2str(pclass_mi)]);
clearvars pclass_data pclass_mi;

name_data = train_data(:, 2);
name_mi = entropy(name_data, train_label, false);
disp(['Name                              ', num2str(name_mi)]);
clearvars name_data name_mi;

sex_data = train_data(:, 3);
sex_mi = entropy(sex_data, train_label, false);
disp(['Sex                               ', num2str(sex_mi)]);
clearvars sex_data sex_mi;

age_data = train_data(:, 4);
age_mi = entropy(age_data, train_label, true);
disp(['Age                               ', num2str(age_mi)]);
clearvars age_data age_mi;

sibsp_data = train_data(:, 5);
sibsp_mi = entropy(sibsp_data, train_label, false);
disp(['Number of Siblings/Spouses Aboard ', num2str(sibsp_mi)]);
clearvars sibsp_data sibsp_mi;

parch_data = train_data(:, 6);
parch_mi = entropy(parch_data, train_label, false);
disp(['Number of Parents/Children Aboard ', num2str(parch_mi)]);
clearvars parch_data parch_mi;

ticket_data = train_data(:, 7);
ticket_mi = entropy(ticket_data, train_label, false);
disp(['Ticket Number                     ', num2str(ticket_mi)]);
clearvars ticket_data ticket_mi;

fare_data = train_data(:, 8);
fare_mi = entropy(fare_data, train_label, true);
disp(['Passenger Fare                    ', num2str(fare_mi)]);
clearvars fare_data fare_mi;

cabin_data = train_data(:, 9);
cabin_mi = entropy(cabin_data, train_label, false);
disp(['Cabin                             ', num2str(cabin_mi)]);
clearvars cabin_data cabin_mi;

embarked_data = train_data(:, 10);
embarked_mi = entropy(embarked_data, train_label, false);
disp(['Port of Embarkation               ', num2str(embarked_mi)]);
clearvars embarked_data embarked_mi;

boat_data = train_data(:, 11);
boat_mi = entropy(boat_data, train_label, false);
disp(['Lifeboat                          ', num2str(boat_mi)]);
clearvars boat_data boat_mi;

body_data = train_data(:, 12);
body_mi = entropy(body_data, train_label, false);
disp(['Body Identification Number        ', num2str(body_mi)]);
clearvars body_data body_mi;

home_dest_data = train_data(:, 13);
home_dest_mi = entropy(home_dest_data, train_label, false);
disp(['Home/Destination                  ', num2str(home_dest_mi)]);
clearvars home_dest_data home_dest_mi;