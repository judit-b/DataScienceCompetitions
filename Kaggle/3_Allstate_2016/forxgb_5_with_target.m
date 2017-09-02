%% Feature engineering for xgb 5
% normalize numeric variables, split into training and submit set

tic
rng(123);

load('forxgb.mat', 'new_merged_matrix');

% add nonused categorical cols
nonused_cats = zeros(1, 116-34);
nonused_cats(1, 1:2) = [8 15];
nonused_cats(1, 3:8) = 17:22;
nonused_cats(1, 9:10) = 25:26;
nonused_cats(1, 11:17) = 29:35;
nonused_cats(1, 18:19) = [37 39];
nonused_cats(1, 20:28) = 41:49;
nonused_cats(1, 29:34) = 51:56;
nonused_cats(1, 35:48) = 58:71;
nonused_cats(1, 49:52) = [74 75 77 78];
nonused_cats(1, 53:56) = 83:86;
nonused_cats(1, 57) = 88;
nonused_cats(1, 58:69) = 91:102;
nonused_cats(1, 70:76) = 104:110;
nonused_cats(1, 77:81) = 112:116;
nonused_cats(1, 82) = 27;
nonused_cols = nonused_cats + 1;

newsize1 = size(new_merged_matrix, 1);
newsize2 = size(new_merged_matrix, 2) + 82;
new_merged_withnonused = zeros(newsize1, newsize2);
new_merged_withnonused(:, 1) = new_merged_matrix(:, 1);
new_merged_withnonused(:, 84:end) = new_merged_matrix(:, 2:end);
clearvars new_merged_matrix;

load('forxgb.mat', 'merged_matrix');
new_merged_withnonused(:, 2:83) = merged_matrix(:, nonused_cols);
clearvars merged_matrix;

boxcox_lambdas = zeros(15, 1);     % for 14 numeric features + 1 target

num_cols = size(new_merged_withnonused, 2);
for i = num_cols - 14 : num_cols - 1     % for 14 numeric features
    i
    col_i = new_merged_withnonused(:, i);
    if sum(col_i <= 0) > 0
        col_i = col_i - min(col_i) + 0.001;
    end;
    [new_col, boxcox_lambdas(i, 1)] = boxcox(col_i);
    new_merged_withnonused(:, i) = new_col;
end;

% split into training and submit set
new_submit_feats = new_merged_withnonused(isnan(new_merged_withnonused(:, end)), 1 : end-1);
new_dataset_feats_target = new_merged_withnonused(~isnan(new_merged_withnonused(:, end)), 1 : end);

%[new_target, boxcox_lambdas(15, 1)] = boxcox(new_merged_withnonused(~isnan(new_merged_withnonused(:, end)), end));

% save('forxgb.mat', 'new_submit_feats', '-append');
% save('forxgb.mat', 'new_dataset_feats_target', '-append');
% save('forxgb.mat', 'new_target', '-append');
% save('forxgb.mat', 'boxcox_lambdas', '-append');
% 
% clearvars new_submit_feats new_dataset_feats new_target boxcox_lambdas;
% 
% new_merged_matrix_normalized = new_merged_matrix;
% clearvars new_merged_matrix;
% 
% save('forxgb.mat', 'new_merged_matrix_normalized', '-append');
% 

clearvars new_merged_withnonused;

forxgb_train_feats_table = array2table(new_dataset_feats_target);
writetable(forxgb_train_feats_table, 'forxgb_train_feats_target_1.csv');

forxgb_submit_feats_table = array2table(new_submit_feats);
writetable(forxgb_submit_feats_table, 'forxgb_submit_feats_1.csv');


toc   % Elapsed time is 148.351548 seconds.