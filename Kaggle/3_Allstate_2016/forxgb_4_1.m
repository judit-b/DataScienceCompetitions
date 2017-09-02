%% Feature engineering for xgb 4
% Use all binary and 10 further categorical and all numeric variable. Also generate the
% combinations of the categorical variables

tic

load('forxgb.mat', 'merged_matrix');
load('forxgb.mat', 'catToNumber_xgb');

% selected_cats is the list of the selected categorical variables for
% further usage
selected_cats_1 = 1 : 72;        % all binary variables
selected_cats_2 = [76 79 80 81 82 87 89 90 103 111];    % categorical vars with more than 2 levels
selected_cats = zeros(1, 72 + size(selected_cats_2, 2));
selected_cats(1, 1:72) = selected_cats_1;
selected_cats(1, 73:end) = selected_cats_2;
selected_cols = zeros(size(selected_cats, 2) + 16, 1); % ID + selected_cats + 14 numeric features + target
selected_cols(1, 1) = 1;
selected_cols(2 : size(selected_cats, 2)+1, 1) = selected_cats + 1; % cat1 is in column 2
selected_cols(size(selected_cats, 2) + 2 : end, 1) = 118 : 132;   % numeric variables and target

merged_matrix_selection = merged_matrix(:, selected_cols);

num_cats = size(selected_cats, 2);   % number of selected categorical vars
num_total_cats = num_cats * (num_cats - 1) / 2 + num_cats;    % number of all cat vars with combinations
num_all_cols = 1 + num_total_cats + 15;
new_merged_matrix = zeros(size(merged_matrix_selection, 1), num_all_cols);

new_merged_matrix(:, 1 : num_cats + 1) = merged_matrix_selection(:, 1 : num_cats + 1);
new_merged_matrix(:, end - 14 : end) = merged_matrix_selection(:, end - 14 : end);

catToNumber_selected = catToNumber_xgb(selected_cols(1 : 1 + num_cats));
next_col = num_cats + 2;
for i = 2 : num_cats      % cat vars are in col 2 - col (num_cats + 1)
    cat_i = merged_matrix_selection(:, i);
    for j = i + 1 : num_cats + 1
        cat_j = merged_matrix_selection(:, j);
        num_categories_j = height(catToNumber_selected{j, 1});
        new_merged_matrix(:, next_col) = cat_i * num_categories_j + cat_j;
    end;
end;

save('forxgb_2.mat', 'new_merged_matrix', '-v7.3');
save('forxgb_2a.mat', 'selected_cols');

toc       % Elapsed time is 83.801135 seconds.