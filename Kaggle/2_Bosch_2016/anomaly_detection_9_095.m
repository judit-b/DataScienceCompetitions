%% Anomaly detection - PART 9 - Dimension reduction using the result of k-medoid clustering and PCA - PART 4
% Decrease the number of features in two steps:
% - Take the centroids resulted by k-medoids clustering and assign each 
%   observation to the cluster with the nearest centroid. Then for each 
%   cluster, take only those features which has a value for the most of the 
%   observations in the cluster. This results a reduced feature set for 
%   each cluster.
% - Use PCA for imputation of missing values.
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
% 4. For each cluster, take features with more than 70% assignments. Other 
%    features are not taken into account in the later steps.
% 5. For each cluster, run a PCA. Use ALS to estimate the missing values.

% 
% This file is between step 4 and 5: it stores the outcome of step 4 in a
% common variable called all_clusters_relev_feats.
tic
rng(1234);

% Load cluster data and save them in a common variable

load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_1_5');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_6_10');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_11_15');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_16_20');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_21_25');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_26_30');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_31_35');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_36_40');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_41_45');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_46_50');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_51_55');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_56_60');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_61_65');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_66_70');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_71_75');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_76_80');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_81_85');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_86_90');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_91_95');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'new_cluster_96_100');

all_clusters_relev_feats_1_50 = cell(50, 1);
all_clusters_relev_feats_51_100 = cell(50, 1);

for i = 1 : 5
    all_clusters_relev_feats_1_50{i, 1} = new_cluster_1_5{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats_1_50{i + 5, 1} = new_cluster_6_10{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats_1_50{i + 10, 1} = new_cluster_11_15{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats_1_50{i + 15, 1} = new_cluster_16_20{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats_1_50{i + 20, 1} = new_cluster_21_25{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats_1_50{i + 25, 1} = new_cluster_26_30{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats_1_50{i + 30, 1} = new_cluster_31_35{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats_1_50{i + 35, 1} = new_cluster_36_40{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats_1_50{i + 40, 1} = new_cluster_41_45{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats_1_50{i + 45, 1} = new_cluster_46_50{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats_51_100{i + 50, 1} = new_cluster_51_55{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats_51_100{i + 55, 1} = new_cluster_56_60{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats_51_100{i + 60, 1} = new_cluster_61_65{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats_51_100{i + 65, 1} = new_cluster_66_70{i, 1};
end;


for i = 1 : 5
    all_clusters_relev_feats_51_100{i + 70, 1} = new_cluster_71_75{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats_51_100{i + 75, 1} = new_cluster_76_80{i, 1};
end;


for i = 1 : 5
    all_clusters_relev_feats_51_100{i + 80, 1} = new_cluster_81_85{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats_51_100{i + 85, 1} = new_cluster_86_90{i, 1};
end;


for i = 1 : 5
    all_clusters_relev_feats_51_100{i + 90, 1} = new_cluster_91_95{i, 1};
end;

for i = 1 : 5
    all_clusters_relev_feats_51_100{i + 95, 1} = new_cluster_96_100{i, 1};
end;

save('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'all_clusters_relev_feats_1_50', '-append');
save('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'all_clusters_relev_feats_51_100', '-append');
toc              % Elapsed time is 23.181578 seconds. (On Eszter's computer.)