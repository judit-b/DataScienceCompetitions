%% Anomaly detection - PART 10 - Imputation of missing data using modes
% Impute the mode (most frequent value) of the feature for NaNs

rng(1234);
tic
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'all_clusters_relev_feats_1_50');
imputed_clusters_for_anomaly_1 = cell(50, 1);

for i = 1 : 50
    disp(i);
    cluster_data = all_clusters_relev_feats_1_50{i, 1};
    idx = knnsearch(cluster_data(:, 2:end-1), cluster_data(:, 2:end-1));
    imputed_cluster = zeros(size(cluster_data));
    imputed_cluster(isnan(cluster_data) == 0) = cluster_data(isnan(cluster_data) == 0);
    imputed_cluster = imputed_cluster + cluster_data(idx, :) .* isnan(cluster_data);
    imputed_clusters_for_anomaly_1{i, 1} = imputed_cluster;
end;

save('anomaly_clusters_with_rel_feats_withoutfreq_095_knn.mat', 'imputed_clusters_for_anomaly_1');
clearvars all_clusters_relev_feats_1_50 imputed_clusters_for_anomaly_1;

load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'all_clusters_relev_feats_51_100');
imputed_clusters_for_anomaly_2 = cell(100, 1);

for i = 51 : 100
    disp(i);
    cluster_data = all_clusters_relev_feats_51_100{i, 1};
    idx = knnsearch(cluster_data(:, 2:end-1), cluster_data(:, 2:end-1));
    imputed_cluster = zeros(size(cluster_data));
    imputed_cluster(isnan(cluster_data) == 0) = cluster_data(isnan(cluster_data) == 0);
    imputed_cluster = imputed_cluster + cluster_data(idx, :) .* isnan(cluster_data);
    imputed_clusters_for_anomaly_2{i, 1} = imputed_cluster;
end;

save('anomaly_clusters_with_rel_feats_withoutfreq_095_knn.mat', 'imputed_clusters_for_anomaly_2', '-append');

toc      % Elapsed time is 477.077724 seconds. (On Eszter's computer.)