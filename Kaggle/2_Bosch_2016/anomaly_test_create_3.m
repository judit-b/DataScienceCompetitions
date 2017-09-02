%% Transform test set for classification - PART 3
% For each cluster, take features with more than 70% assignments. Other 
% features are not taken into account in the later steps.
tic
rng(1234);

load('anomaly_clusters_train_withoutfreq.mat', 'features_after_clustering');
load('anomaly_test.mat', 'test_clusters');

num_all_features = 969;     % ID + 968 features

% Save cluster data including only the relevant features (as defined by
% features_after_clustering)

num_remaining_features = sum(features_after_clustering, 2);

test_clusters_relev_feats = cell(100, 1);
for i = 1 : 100
    num_obs = size(test_clusters{i, 1}, 1);
    test_clusters_relev_feats{i, 1} = zeros(num_obs, num_remaining_features(i) + 1);   % ID + features + response variable
    test_clusters_relev_feats{i, 1}(:, 1:num_remaining_features(i)) = test_clusters{i, 1}(:, features_after_clustering(i, :) == 1);
    test_clusters_relev_feats{i, 1}(:, end) = test_clusters{i, 1}(:, end);
end;

save('anomaly_test.mat', 'test_clusters_relev_feats', '-append');
toc    % Elapsed time is 11.464033 seconds. (On Eszter's computer.)