%% Anomaly detection - PART 8 - Dimension reduction using the result of k-medoid clustering- PART 3
% Decrease the number of features:
% - Take the centroids resulted by k-medoids clustering and assign each 
%   observation to the cluster with the nearest centroid. Then for each 
%   cluster, take only those features which has a value for the most of the 
%   observations in the cluster. This results a reduced feature set for 
%   each cluster.
%
% Use 'hamming' distance for the 0-1 representations of the observations.
%
% Steps:
% 1. Load k-medoids centroids.
% 2. For each observation, generate its 0-1 representation. (1 denotes an 
%    existing data, 0 denotes missing data.)
% 2. For each observation, calculate the distance between the 0-1 
%    representation of the observation and each cluster centroids.
% 3. Assign each observation to the cluster with the nearest centroid to 
%    its 0-1 representation.
% 4. For each cluster, take features with more than 80% assignments. Other 
%    features are not taken into account in the later steps.
% 5. For each cluster, run a PCA. Use ALS to estimate the missing values.
% 
% This file includes step 4.

tic

rng(1234);
num_all_features = 969;     % ID + 968 features
num_clusters = 40;
threshold = 0.8;     % take values with more than 80% of existing values in the cluster

% We will store the remaining features (those which includes more than 80%
% values within a given cluster) for each cluster in the following matrix.
% Row i includes the features for cluster i. (1 = the feature is used for
% cluster i; 0 = the feature isn't used for cluster i)
features_after_clustering = zeros(num_clusters, num_all_features);

load('anomaly_clusters_train.mat', 'cluster_1_5');
features_after_clustering(1:5, :) = FindFeaturesWithEnoughValues(cluster_1_5, num_all_features, threshold);
clearvars cluster_1_5;

load('anomaly_clusters_train.mat', 'cluster_6_10');
features_after_clustering(6:10, :) = FindFeaturesWithEnoughValues(cluster_6_10, num_all_features, threshold);
clearvars cluster_6_10;
disp(10);
load('anomaly_clusters_train.mat', 'cluster_11_15');
features_after_clustering(11:15, :) = FindFeaturesWithEnoughValues(cluster_11_15, num_all_features, threshold);
clearvars cluster_11_15;

load('anomaly_clusters_train.mat', 'cluster_16_20');
features_after_clustering(16:20, :) = FindFeaturesWithEnoughValues(cluster_16_20, num_all_features, threshold);
clearvars cluster_16_20;
disp(20);
load('anomaly_clusters_train.mat', 'cluster_21_25');
features_after_clustering(21:25, :) = FindFeaturesWithEnoughValues(cluster_21_25, num_all_features, threshold);
clearvars cluster_21_25;

load('anomaly_clusters_train.mat', 'cluster_26_30');
features_after_clustering(26:30, :) = FindFeaturesWithEnoughValues(cluster_26_30, num_all_features, threshold);
clearvars cluster_26_30;
disp(30);
load('anomaly_clusters_train.mat', 'cluster_31_35');
features_after_clustering(31:35, :) = FindFeaturesWithEnoughValues(cluster_31_35, num_all_features, threshold);
clearvars cluster_31_35;

load('anomaly_clusters_train.mat', 'cluster_36_40');
features_after_clustering(36:40, :) = FindFeaturesWithEnoughValues(cluster_36_40, num_all_features, threshold);
clearvars cluster_36:40;
disp(40);
% load('anomaly_clusters_train.mat', 'cluster_41_45');
% features_after_clustering(41:45, :) = FindFeaturesWithEnoughValues(cluster_41_45, num_all_features, threshold);
% clearvars cluster_41_45;
% 
% load('anomaly_clusters_train.mat', 'cluster_46_50');
% features_after_clustering(46:50, :) = FindFeaturesWithEnoughValues(cluster_46_50, num_all_features, threshold);
% clearvars cluster_46_50;
% disp(50);

% load('anomaly_clusters_train.mat', 'cluster_51_55');
% features_after_clustering(51:55, :) = FindFeaturesWithEnoughValues(cluster_51_55, num_all_features, threshold);
% clearvars cluster_51_55;
% 
% load('anomaly_clusters_train.mat', 'cluster_56_60');
% features_after_clustering(56:60, :) = FindFeaturesWithEnoughValues(cluster_56_60, num_all_features, threshold);
% clearvars cluster_56_60;
% disp(60);

% load('anomaly_clusters_train.mat', 'cluster_61_65');
% features_after_clustering(61:65, :) = FindFeaturesWithEnoughValues(cluster_61_65, num_all_features, threshold);
% clearvars cluster_61_65;
% 
% load('anomaly_clusters_train.mat', 'cluster_66_70');
% features_after_clustering(66:70, :) = FindFeaturesWithEnoughValues(cluster_66_70, num_all_features, threshold);
% clearvars cluster_66_70;
% disp(70);

% load('anomaly_clusters_train.mat', 'cluster_71_75');
% features_after_clustering(71:75, :) = FindFeaturesWithEnoughValues(cluster_71_75, num_all_features, threshold);
% clearvars cluster_71_75;
% 
% load('anomaly_clusters_train.mat', 'cluster_76_80');
% features_after_clustering(76:80, :) = FindFeaturesWithEnoughValues(cluster_76_80, num_all_features, threshold);
% clearvars cluster_76_80;
% disp(80);

% load('anomaly_clusters_train.mat', 'cluster_81_85');
% features_after_clustering(81:85, :) = FindFeaturesWithEnoughValues(cluster_81_85, num_all_features, threshold);
% clearvars cluster_81_85;
% 
% load('anomaly_clusters_train.mat', 'cluster_86_90');
% features_after_clustering(86:90, :) = FindFeaturesWithEnoughValues(cluster_86_90, num_all_features, threshold);
% clearvars cluster_86_90;
% disp(90);

% load('anomaly_clusters_train.mat', 'cluster_91_95');
% features_after_clustering(91:95, :) = FindFeaturesWithEnoughValues(cluster_91_95, num_all_features, threshold);
% clearvars cluster_91_95;
% 
% load('anomaly_clusters_train.mat', 'cluster_96_100');
% features_after_clustering(96:100, :) = FindFeaturesWithEnoughValues(cluster_96_100, num_all_features, threshold);
% clearvars cluster_96_100;
% disp(100);

save('anomaly_clusters_train.mat', 'features_after_clustering', '-append');

% Save cluster data including only the relevant features (as defined by
% features_after_clustering)

load('anomaly_clusters_train.mat', 'cluster_1_5');
new_cluster_1_5 = ClustersWithOnlyRelevantFeatures(cluster_1_5, features_after_clustering, 1);
save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_1_5');
clearvars cluster_1_5 new_cluster_1_5;

load('anomaly_clusters_train.mat', 'cluster_6_10');
new_cluster_6_10 = ClustersWithOnlyRelevantFeatures(cluster_6_10, features_after_clustering, 6);
save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_6_10', '-append');
clearvars cluster_6_10 new_cluster_6_10;
disp(10);
load('anomaly_clusters_train.mat', 'cluster_11_15');
new_cluster_11_15 = ClustersWithOnlyRelevantFeatures(cluster_11_15, features_after_clustering, 11);
save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_11_15', '-append');
clearvars cluster_11_15 new_cluster_11_15;

load('anomaly_clusters_train.mat', 'cluster_16_20');
new_cluster_16_20 = ClustersWithOnlyRelevantFeatures(cluster_16_20, features_after_clustering, 16);
save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_16_20', '-append');
clearvars cluster_16_20 new_cluster_16_20;
disp(20);
load('anomaly_clusters_train.mat', 'cluster_21_25');
new_cluster_21_25 = ClustersWithOnlyRelevantFeatures(cluster_21_25, features_after_clustering, 21);
save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_21_25', '-append');
clearvars cluster_21_25 new_cluster_21_25;

load('anomaly_clusters_train.mat', 'cluster_26_30');
new_cluster_26_30 = ClustersWithOnlyRelevantFeatures(cluster_26_30, features_after_clustering, 26);
save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_26_30', '-append');
clearvars cluster_26_30 new_cluster_26_30;
disp(30);
load('anomaly_clusters_train.mat', 'cluster_31_35');
new_cluster_31_35 = ClustersWithOnlyRelevantFeatures(cluster_31_35, features_after_clustering, 31);
save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_31_35', '-append');
clearvars cluster_31_35 new_cluster_31_35;

load('anomaly_clusters_train.mat', 'cluster_36_40');
new_cluster_36_40 = ClustersWithOnlyRelevantFeatures(cluster_36_40, features_after_clustering, 36);
save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_36_40', '-append');
clearvars cluster_36_40 new_cluster_36_40;
disp(40);
% load('anomaly_clusters_train.mat', 'cluster_41_45');
% new_cluster_41_45 = ClustersWithOnlyRelevantFeatures(cluster_41_45, features_after_clustering, 41);
% save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_41_45', '-append');
% clearvars cluster_41_45 new_cluster_41_45;
% 
% load('anomaly_clusters_train.mat', 'cluster_46_50');
% new_cluster_46_50 = ClustersWithOnlyRelevantFeatures(cluster_46_50, features_after_clustering, 46);
% save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_46_50', '-append');
% clearvars cluster_46_50 new_cluster_46_50;
% disp(50);

% load('anomaly_clusters_train.mat', 'cluster_51_55');
% new_cluster_51_55 = ClustersWithOnlyRelevantFeatures(cluster_51_55, features_after_clustering, 51);
% save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_51_55', '-append');
% clearvars cluster_1_5 new_cluster_51_55;
% 
% load('anomaly_clusters_train.mat', 'cluster_56_60');
% new_cluster_56_60 = ClustersWithOnlyRelevantFeatures(cluster_56_60, features_after_clustering, 56);
% save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_56_60', '-append');
% clearvars cluster_56_60 new_cluster_56_60;
% disp(60);

% load('anomaly_clusters_train.mat', 'cluster_61_65');
% new_cluster_61_65 = ClustersWithOnlyRelevantFeatures(cluster_61_65, features_after_clustering, 61);
% save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_61_65', '-append');
% clearvars cluster_61_65 new_cluster_61_65;
% 
% load('anomaly_clusters_train.mat', 'cluster_66_70');
% new_cluster_66_70 = ClustersWithOnlyRelevantFeatures(cluster_66_70, features_after_clustering, 66);
% save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_66_70', '-append');
% clearvars cluster_66_70 new_cluster_66_70;
% disp(70);

% load('anomaly_clusters_train.mat', 'cluster_71_75');
% new_cluster_71_75 = ClustersWithOnlyRelevantFeatures(cluster_71_75, features_after_clustering, 71);
% save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_71_75', '-append');
% clearvars cluster_71_75 new_cluster_71_75;
% 
% load('anomaly_clusters_train.mat', 'cluster_76_80');
% new_cluster_76_80 = ClustersWithOnlyRelevantFeatures(cluster_76_80, features_after_clustering, 76);
% save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_76_80', '-append');
% clearvars cluster_76_80 new_cluster_76_80;
% disp(80);

% load('anomaly_clusters_train.mat', 'cluster_81_85');
% new_cluster_81_85 = ClustersWithOnlyRelevantFeatures(cluster_81_85, features_after_clustering, 81);
% save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_81_85', '-append');
% clearvars cluster_81_85 new_cluster_81_85;
% 
% load('anomaly_clusters_train.mat', 'cluster_86_90');
% new_cluster_86_90 = ClustersWithOnlyRelevantFeatures(cluster_86_90, features_after_clustering, 86);
% save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_86_90', '-append');
% clearvars cluster_86_90 new_cluster_86_90;
% disp(90);

% load('anomaly_clusters_train.mat', 'cluster_91_95');
% new_cluster_91_95 = ClustersWithOnlyRelevantFeatures(cluster_91_95, features_after_clustering, 91);
% save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_91_95', '-append');
% clearvars cluster_91_95 new_cluster_91_95;
% 
% load('anomaly_clusters_train.mat', 'cluster_96_100');
% new_cluster_96_100 = ClustersWithOnlyRelevantFeatures(cluster_96_100, features_after_clustering, 96);
% save('anomaly_clusters_with_rel_feats.mat', 'new_cluster_96_100', '-append');
% clearvars cluster_96_100 new_cluster_96_100;
% disp(100);

toc              % Elapsed time is 24.300309 seconds.