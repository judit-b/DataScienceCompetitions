%% Train boosted tree using the dataset for xgb
%% !!!!!!!!!take out column ID!!!!!!!!!!!!!

tic
rng(123);

load('forxgb.mat', 'new_dataset_feats');
load('forxgb.mat', 'new_target');

tFinal = templateTree('MaxNumSplits', 12, 'MinLeafSize', 100);
MdlFinal_xgb = fitrensemble(new_dataset_feats, new_target, 'NumLearningCycles', 10000,...
    'Learners', tFinal, 'LearnRate', 0.03);

save('forxgb_model.mat', 'MdlFinal_xgb', '-v7.3');

toc    % Elapsed time is 87752.028337 seconds.