%% Data transformation for xgboost 3

forsubmit_table.loss = cell(height(forsubmit_table), 1);

merged_table = vertcat(dataset_table, forsubmit_table);

%% Create a numeric matrix to represent data

tic

merged_matrix = zeros(size(merged_table));
merged_matrix(:, 1) = merged_table.(1);
catToNumber_xgb = cell(117, 1);

% Categorical features: column 2 - column 117
for i = 2 : 117
    merged_table.(i) = categorical(merged_table.(i));
    categories = unique(merged_table.(i));
    numValues = (1 : size(categories, 1))';
    catToNumber_xgb{i, 1} = table(categories, numValues);
    
    merged_matrix(:, i) = ConvertCategoricalToNumeric(merged_table.(i), catToNumber_xgb{i, 1});
end;

% Numeric features + target value (loss): column 118 - column 132
for i = 118 : 132
    merged_table.(i) = str2double(merged_table.(i));
end;
merged_matrix(:, 118:132) = table2array(merged_table(:, 118 : 132));

save('forxgb.mat', 'merged_matrix');
save('forxgb.mat', 'catToNumber_xgb', '-append');

toc        % Elapsed time is  seconds. (Eszter)