%% Dimension reduction using the result of k-medoid clustering and PCA - PART 4
% Decrease the number of features in two steps:
% - Take the centroids resulted by k-medoids clustering and assign each 
%   observation to the cluster with the nearest centroid. Then for each 
%   cluster, take only those features which has a value for the most of the 
%   observations in the cluster. This results a reduced feature set for 
%   each cluster.
% - Use PCA for further reduction of the number of features.
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
% 6. For each cluster, determine the principal components that explains at 
%    least 90% of the variance.
% 
% This file is between step 4 and 5: it stores the outcome of step 4 in a
% common variable called all_clusters_relev_feats.

tic
rng(1234);

% Load cluster data and save them in a common variable

load('clusters_with_rel_feats_120.mat', 'new_cluster_1_5');
load('clusters_with_rel_feats_120.mat', 'new_cluster_6_10');
load('clusters_with_rel_feats_120.mat', 'new_cluster_11_15');
load('clusters_with_rel_feats_120.mat', 'new_cluster_16_20');
load('clusters_with_rel_feats_120.mat', 'new_cluster_21_25');
load('clusters_with_rel_feats_120.mat', 'new_cluster_26_30');
load('clusters_with_rel_feats_120.mat', 'new_cluster_31_35');
load('clusters_with_rel_feats_120.mat', 'new_cluster_36_40');
load('clusters_with_rel_feats_120.mat', 'new_cluster_41_45');
load('clusters_with_rel_feats_120.mat', 'new_cluster_46_50');
load('clusters_with_rel_feats_120.mat', 'new_cluster_51_55');
load('clusters_with_rel_feats_120.mat', 'new_cluster_56_60');
load('clusters_with_rel_feats_120.mat', 'new_cluster_61_65');
load('clusters_with_rel_feats_120.mat', 'new_cluster_66_70');
load('clusters_with_rel_feats_120.mat', 'new_cluster_71_75');
load('clusters_with_rel_feats_120.mat', 'new_cluster_76_80');
load('clusters_with_rel_feats_120.mat', 'new_cluster_81_85');
load('clusters_with_rel_feats_120.mat', 'new_cluster_86_90');
load('clusters_with_rel_feats_120.mat', 'new_cluster_91_95');
load('clusters_with_rel_feats_120.mat', 'new_cluster_96_100');
load('clusters_with_rel_feats_120.mat', 'new_cluster_101_105');
load('clusters_with_rel_feats_120.mat', 'new_cluster_106_110');
load('clusters_with_rel_feats_120.mat', 'new_cluster_111_115');
load('clusters_with_rel_feats_120.mat', 'new_cluster_116_120');

all_clusters_relev_feats = cell(120, 1);

for i = 1 : 5
    all_clusters_relev_feats{i, 1} = new_cluster_1_5{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 5, 1} = new_cluster_6_10{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 10, 1} = new_cluster_11_15{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 15, 1} = new_cluster_16_20{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 20, 1} = new_cluster_21_25{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 25, 1} = new_cluster_26_30{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 30, 1} = new_cluster_31_35{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 35, 1} = new_cluster_36_40{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 40, 1} = new_cluster_41_45{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 45, 1} = new_cluster_46_50{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 50, 1} = new_cluster_51_55{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 55, 1} = new_cluster_56_60{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 60, 1} = new_cluster_61_65{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 65, 1} = new_cluster_66_70{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 70, 1} = new_cluster_71_75{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 75, 1} = new_cluster_76_80{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 80, 1} = new_cluster_81_85{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 85, 1} = new_cluster_86_90{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 90, 1} = new_cluster_91_95{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 95, 1} = new_cluster_96_100{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 100, 1} = new_cluster_101_105{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 105, 1} = new_cluster_106_110{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 110, 1} = new_cluster_111_115{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats{i + 115, 1} = new_cluster_116_120{i, 1};
end;

save('clusters_with_rel_feats_120.mat', 'all_clusters_relev_feats', '-append');
toc                % Elapsed time is 26.186516 seconds.