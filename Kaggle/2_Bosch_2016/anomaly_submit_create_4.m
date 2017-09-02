%% Imputation of missing data
rng(1234);
tic
load('anomaly_submit.mat', 'submit_clusters_relev_feats');
load('anomaly_imputed_clusters_withoutfreq.mat', 'all_train_cluster_modes_for_anomaly');
anomaly_submit_clusters = cell(100, 1);

for i = 1 : 100
    disp(i);
    dataset = submit_clusters_relev_feats{i, 1};
    nan_values = isnan(dataset);
    impute_values = nan_values .* all_train_cluster_modes_for_anomaly{i, 1};
    dataset(nan_values) = impute_values(nan_values);
    anomaly_submit_clusters{i, 1} = dataset;
end;

save('anomaly_imputed_submit_clusters.mat', 'anomaly_submit_clusters');

toc      % Elapsed time is 4.384432 seconds. (On Eszter's computer.)
