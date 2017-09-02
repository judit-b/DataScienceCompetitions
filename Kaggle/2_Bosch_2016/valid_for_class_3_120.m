%% Transform validation set for classification - PART 3
% For each cluster, take features with more than 80% assignments. Other 
% features are not taken into account in the later steps.
tic
rng(1234);

load('clusters_train_120.mat', 'features_after_clustering');
load('valid_and_test_set_120.mat', 'valid_clusters');

num_all_features = 969;     % ID + 968 features
num_clusters = 120;

% Save cluster data including only the relevant features (as defined by
% features_after_clustering)

num_remaining_features = sum(features_after_clustering, 2);

valid_clusters_relev_feats = cell(120, 1);
for i = 1 : 120
    num_obs = size(valid_clusters{i, 1}, 1);
    valid_clusters_relev_feats{i, 1} = zeros(num_obs, num_remaining_features(i) + 1);   % ID + features + response variable
    valid_clusters_relev_feats{i, 1}(:, 1:num_remaining_features(i)) = valid_clusters{i, 1}(:, features_after_clustering(i, :) == 1);
    valid_clusters_relev_feats{i, 1}(:, end) = valid_clusters{i, 1}(:, end);
end;

save('valid_and_test_set_120.mat', 'valid_clusters_relev_feats', '-append');
toc    % Elapsed time is 20.670695 seconds.