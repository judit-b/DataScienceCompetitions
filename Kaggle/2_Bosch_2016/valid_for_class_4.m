%% Imputation of missing data  ---- ELRONTOTTAM A KÓDOT!!!!!!
rng(1234);
tic
load('anomaly_validation.mat', 'valid_clusters_relev_feats');
load('anomaly_clusters_with_rel_feats_withoutfreq.mat', 'all_train_cluster_modes_for_anomaly');
anomaly_valid_clusters = cell(100, 1);


for i = 1 : 100
    disp(i);
    dataset = valid_clusters_relev_feats{i, 1};
    all_train_cluster_modes_for_anomaly{i, 1} = mode(dataset);
    nan_values = isnan(dataset);
    impute_values = nan_values .* all_train_cluster_modes_for_anomaly{i, 1};
    dataset(nan_values) = impute_values(nan_values);
    all_train_clusters_for_anomaly_1{i, 1} = dataset;
end;

save('anomaly_imputed_clusters_withoutfreq.mat', 'all_train_clusters_for_anomaly_1');

for i = 1 : 50
    disp(i);
    dataset = all_clusters_relev_feats_1_50{i, 1};
    all_train_cluster_modes_for_anomaly{i, 1} = mode(dataset);
    nan_values = isnan(dataset);
    impute_values = nan_values .* all_train_cluster_modes_for_anomaly{i, 1};
    dataset(nan_values) = impute_values(nan_values);
    all_train_clusters_for_anomaly_1{i, 1} = dataset;
end;

save('anomaly_imputed_clusters_withoutfreq.mat', 'all_train_clusters_for_anomaly_1');


toc      % Elapsed time is 6064.443563 seconds.

save('anomaly_validation.mat', 'anomaly_valid_clusters', '-append');