%% Anomaly detection - PART 10 - Imputation of missing data using modes
% Impute the mode (most frequent value) of the feature for NaNs

rng(1234);
tic
load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'all_clusters_relev_feats_1_50');
all_train_cluster_modes_for_anomaly = cell(100, 1);
imputed_clusters_for_anomaly_1 = cell(50, 1);

for i = 1 : 50
    disp(i);
    dataset = all_clusters_relev_feats_1_50{i, 1};
    all_train_cluster_modes_for_anomaly{i, 1} = mode(dataset);
    nan_values = isnan(dataset);
    impute_values = nan_values .* all_train_cluster_modes_for_anomaly{i, 1};
    dataset(nan_values) = impute_values(nan_values);
    imputed_clusters_for_anomaly_1{i, 1} = dataset;
end;

save('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'imputed_clusters_for_anomaly_1', '-append');
clearvars all_clusters_relev_feats_1_50 imputed_clusters_for_anomaly_1;

load('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'all_clusters_relev_feats_51_100');
imputed_clusters_for_anomaly_2 = cell(100, 1);

for i = 51 : 100
    disp(i);
    dataset = all_clusters_relev_feats_51_100{i, 1};
    all_train_cluster_modes_for_anomaly{i, 1} = mode(dataset);
    nan_values = isnan(dataset);
    impute_values = nan_values .* all_train_cluster_modes_for_anomaly{i, 1};
    dataset(nan_values) = impute_values(nan_values);
    imputed_clusters_for_anomaly_2{i, 1} = dataset;
end;

save('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'imputed_clusters_for_anomaly_2', '-append');
save('anomaly_clusters_with_rel_feats_withoutfreq_095.mat', 'all_train_cluster_modes_for_anomaly', '-append');

toc      % Elapsed time is 51.601363 seconds. (On Eszter's computer.)