%% Imputation of missing data
rng(1234);
tic

load('anomaly_test_095.mat', 'test_clusters_relev_feats');
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'all_train_cluster_modes_for_anomaly');
anomaly_test_clusters = cell(100, 1);

for i = 1 : 100
    disp(i);
    dataset = test_clusters_relev_feats{i, 1};
    nan_values = isnan(dataset);
    impute_values = nan_values .* all_train_cluster_modes_for_anomaly{i, 1};
    dataset(nan_values) = impute_values(nan_values);
    anomaly_test_clusters{i, 1} = dataset;
end;

save('anomaly_imputed_test_clusters_095.mat', 'anomaly_test_clusters');

toc      % Elapsed time is 9.119110 seconds. (On Eszter's computer.)
