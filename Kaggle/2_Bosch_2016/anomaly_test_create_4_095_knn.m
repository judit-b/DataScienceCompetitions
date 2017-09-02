%% Imputation of missing data
rng(1234);
tic

load('anomaly_test_095.mat', 'test_clusters_relev_feats');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'all_clusters_relev_feats_1_50');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'all_clusters_relev_feats_51_100');
anomaly_test_clusters = cell(100, 1);

for i = 1 : 100
    disp(i);
    if i < 51
        cluster_data = all_clusters_relev_feats_1_50{i, 1}(:, 2:end-1);
        anomaly_test_clusters{i, 1} = zeros(size(test_clusters_relev_feats{i, 1}));
        anomaly_test_clusters{i, 1}(:, 1) = test_clusters_relev_feats{i, 1}(:, 1);
        anomaly_test_clusters{i, 1}(:, end) = test_clusters_relev_feats{i, 1}(:, end);
    else
        cluster_data = all_clusters_relev_feats_51_100{i, 1}(:, 2:end-1);
        anomaly_test_clusters{i, 1} = zeros(size(test_clusters_relev_feats{i, 1}));
        anomaly_test_clusters{i, 1}(:, 1) = test_clusters_relev_feats{i, 1}(:, 1);
        anomaly_test_clusters{i, 1}(:, end) = test_clusters_relev_feats{i, 1}(:, end);
    end;
    test_data = test_clusters_relev_feats{i, 1}(:, 2:end-1);
    idx = knnsearch(cluster_data, test_data);
    imputed_test_cluster = zeros(size(test_data));
    imputed_test_cluster(isnan(test_data) == 0) = test_data(isnan(test_data) == 0);
    imputed_test_cluster = imputed_test_cluster + cluster_data(idx, :) .* isnan(test_data);
    anomaly_test_clusters{i, 1}(:, 2 : end-1) = imputed_test_cluster;
end;

save('anomaly_imputed_test_clusters_095_knn.mat', 'anomaly_test_clusters');

toc      % Elapsed time is 163.340649 seconds. (On Eszter's computer.)
