%% Imputation of missing data
rng(1234);
tic
load('anomaly_validation_095.mat', 'valid_clusters_relev_feats');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'all_clusters_relev_feats_1_50');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'all_clusters_relev_feats_51_100');
anomaly_valid_clusters = cell(100, 1);

for i = 1 : 100
    disp(i);
    if i < 51
        cluster_data = all_clusters_relev_feats_1_50{i, 1}(:, 2:end-1);
        anomaly_valid_clusters{i, 1} = zeros(size(valid_clusters_relev_feats{i, 1}));
        anomaly_valid_clusters{i, 1}(:, 1) = valid_clusters_relev_feats{i, 1}(:, 1);
        anomaly_valid_clusters{i, 1}(:, end) = valid_clusters_relev_feats{i, 1}(:, end);
    else
        cluster_data = all_clusters_relev_feats_51_100{i, 1}(:, 2:end-1);
        anomaly_valid_clusters{i, 1} = zeros(size(valid_clusters_relev_feats{i, 1}));
        anomaly_valid_clusters{i, 1}(:, 1) = valid_clusters_relev_feats{i, 1}(:, 1);
        anomaly_valid_clusters{i, 1}(:, end) = valid_clusters_relev_feats{i, 1}(:, end);
    end;
    valid_data = valid_clusters_relev_feats{i, 1}(:, 2:end-1);
    idx = knnsearch(cluster_data, valid_data);
    imputed_valid_cluster = zeros(size(valid_data));
    imputed_valid_cluster(isnan(valid_data) == 0) = valid_data(isnan(valid_data) == 0);
    imputed_valid_cluster = imputed_valid_cluster + cluster_data(idx, :) .* isnan(valid_data);
    anomaly_valid_clusters{i, 1}(:, 2 : end-1) = imputed_valid_cluster;
end;

save('anomaly_imputed_valid_clusters_095_knn.mat', 'anomaly_valid_clusters');

toc      % Elapsed time is 167.487566 seconds.
