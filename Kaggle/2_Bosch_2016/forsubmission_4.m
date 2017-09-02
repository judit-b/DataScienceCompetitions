%% For each cluster, take features with more than 80% assignments (in the training data)
tic
rng(1234);
num_all_features = 969;     % ID + 968 features
num_clusters = 40;
threshold = 0.8;     % take values with more than 80% of existing values in the cluster

load('clusters_train.mat', 'features_after_clustering');

% Save cluster data including only the relevant features (as defined by
% features_after_clustering)

load('submit_numeric.mat', 'cluster_1_5');
new_cluster_1_5 = ClustersWithOnlyRelevantFeatures(cluster_1_5, features_after_clustering, 1);
save('submit_numeric.mat', 'new_cluster_1_5', '-append');
clearvars cluster_1_5 new_cluster_1_5;

load('submit_numeric.mat', 'cluster_6_10');
new_cluster_6_10 = ClustersWithOnlyRelevantFeatures(cluster_6_10, features_after_clustering, 6);
save('submit_numeric.mat', 'new_cluster_6_10', '-append');
clearvars cluster_6_10 new_cluster_6_10;

load('submit_numeric.mat', 'cluster_11_15');
new_cluster_11_15 = ClustersWithOnlyRelevantFeatures(cluster_11_15, features_after_clustering, 11);
save('submit_numeric.mat', 'new_cluster_11_15', '-append');
clearvars cluster_11_15 new_cluster_11_15;

load('submit_numeric.mat', 'cluster_16_20');
new_cluster_16_20 = ClustersWithOnlyRelevantFeatures(cluster_16_20, features_after_clustering, 16);
save('submit_numeric.mat', 'new_cluster_16_20', '-append');
clearvars cluster_16_20 new_cluster_16_20;

load('submit_numeric.mat', 'cluster_21_25');
new_cluster_21_25 = ClustersWithOnlyRelevantFeatures(cluster_21_25, features_after_clustering, 21);
save('submit_numeric.mat', 'new_cluster_21_25', '-append');
clearvars cluster_21_25 new_cluster_21_25;

load('submit_numeric.mat', 'cluster_26_30');
new_cluster_26_30 = ClustersWithOnlyRelevantFeatures(cluster_26_30, features_after_clustering, 26);
save('submit_numeric.mat', 'new_cluster_26_30', '-append');
clearvars cluster_26_30 new_cluster_26_30;

load('submit_numeric.mat', 'cluster_31_35');
new_cluster_31_35 = ClustersWithOnlyRelevantFeatures(cluster_31_35, features_after_clustering, 31);
save('submit_numeric.mat', 'new_cluster_31_35', '-append');
clearvars cluster_31_35 new_cluster_31_35;

load('submit_numeric.mat', 'cluster_36_40');
new_cluster_36_40 = ClustersWithOnlyRelevantFeatures(cluster_36_40, features_after_clustering, 36);
save('submit_numeric.mat', 'new_cluster_36_40', '-append');
clearvars cluster_36_40 new_cluster_36_40;

toc