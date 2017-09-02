load('anomaly_imputed_test_clusters.mat', 'anomaly_test_clusters');
load('anomaly_clusters_with_rel_feats_withoutfreq.mat', 'best_feature_transformations');

anomaly_final_test_clusters = cell(100, 1);

for i = 1 : 100
    dataset = anomaly_test_clusters{i, 1};
    best_transformations = best_feature_transformations{i, 1};
    anomaly_final_test_clusters{i, 1} = TransformToSymmetricSample(dataset, best_transformations);
end;

save('anomaly_final_test_set.mat', 'anomaly_final_test_clusters');