load('dataset.mat', 'dataset_matrix')
target = dataset_matrix(:, end);
clearvars dataset_matrix;
load('forxgb_21_2.mat', 'new_dataset_feats')

new_dataset_with_target = zeros(size(new_dataset_feats, 1), size(new_dataset_feats, 2)+1);
new_dataset_with_target(:, 1:end-1) = new_dataset_feats;
new_dataset_with_target(:, end) = target;
forxgb_train_table = array2table(new_dataset_with_target);
writetable(forxgb_train_table, 'forxgb_train_new.csv');

%load('forxgb.mat', 'new_submit_feats');
% new_submit_with_target = zeros(size(new_submit_feats, 1), size(new_submit_feats, 2)+1);
% new_submit_with_target(:, 1:end-1) = new_submit_feats;
% new_submit_with_target(:, end) = NaN;
% forxgb_submit_table = array2table(new_submit_with_target);
% writetable(forxgb_submit_table, 'forxgb_submit_new.csv');