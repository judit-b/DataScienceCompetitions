%% WE DO NOT USE THIS SCRIPT
%% Dimension reduction using the result of k-medoid clustering and PCA - PART 5
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
% This file includes step 5.
tic
rng(1234);

load('clusters_with_rel_feats.mat', 'all_clusters_relev_feats');
final_clusters = cell(40, 1);

for i = 1 : 40
    disp(i);
    cluster_data = all_clusters_relev_feats{i, 1};
    idx = knnsearch(cluster_data(:, 2:end-1), cluster_data(:, 2:end-1));
    imputed_cluster = zeros(size(cluster_data));
    imputed_cluster(isnan(cluster_data) == 0) = cluster_data(isnan(cluster_data) == 0);
    imputed_cluster = imputed_cluster + cluster_data(idx, :) .* isnan(cluster_data);
    if sum(sum(isnan(imputed_cluster))) > 0
        cluster_data = imputed_cluster;
        idx = knnsearch(cluster_data(:, 2:end-1), cluster_data(:, 2:end-1));
        imputed_cluster = zeros(size(cluster_data));
        imputed_cluster(isnan(cluster_data) == 0) = cluster_data(isnan(cluster_data) == 0);
        imputed_cluster = imputed_cluster + cluster_data(idx, :) .* isnan(cluster_data);
    end;
    final_clusters{i, 1} = imputed_cluster;
end;

save('clusters_with_rel_feats_knn.mat', 'final_clusters');
    
toc     % Elapsed time is 1168.123385 seconds.