%% Feature engineering for xgb 5
% normalize numeric variables, split into training and submit set

tic
rng(123);

%load('forxgb_2.mat', 'new_merged_matrix');

boxcox_lambdas = zeros(15, 1);     % for 14 numeric features + 1 target

num_cols = size(new_merged_matrix, 2);
for i = num_cols - 14 : num_cols - 1     % for 14 numeric features
    i
    col_i = new_merged_matrix(:, i);
    if sum(col_i <= 0) > 0
        col_i = col_i - min(col_i) + 0.001;
    end;
    [new_col, boxcox_lambdas(i, 1)] = boxcox(col_i);
    new_merged_matrix(:, i) = new_col;
end;

% split into training and submit set
new_submit_feats = new_merged_matrix(isnan(new_merged_matrix(:, end)), 1 : end-1);
new_dataset_feats = new_merged_matrix(~isnan(new_merged_matrix(:, end)), 1 : end-1);

[new_target, boxcox_lambdas(15, 1)] = boxcox(new_merged_matrix(~isnan(new_merged_matrix(:, end)), end));

save('forxgb_21_1.mat', 'new_submit_feats', '-v7.3');
save('forxgb_21_2.mat', 'new_dataset_feats', '-v7.3');
save('forxgb_21.mat', 'new_target');
save('forxgb_21.mat', 'boxcox_lambdas', '-append');

clearvars boxcox_lambdas;

new_merged_matrix_normalized = new_merged_matrix;
%clearvars new_merged_matrix;

%save('forxgb_22.mat', 'new_merged_matrix_normalized', '-append');

toc           % Elapsed time is 94.417418 seconds.