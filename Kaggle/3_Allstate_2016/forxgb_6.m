%% Save datasets for xgb in a csv file 6

tic

load('forxgb.mat', 'new_dataset_feats');
forxgb_train_feats_table = array2table(new_dataset_feats);
writetable(forxgb_train_feats_table, 'forxgb_train_feats.csv');

load('forxgb.mat', 'new_target');
forxgb_target_table = array2table(new_target);
writetable(forxgb_target_table, 'forxgb_target.csv');

load('forxgb.mat', 'new_submit_feats');
forxgb_submit_feats_table = array2table(new_submit_feats);
writetable(forxgb_submit_feats_table, 'forxgb_submit_feats.csv');

toc    % Elapsed time is 89.397549 seconds.