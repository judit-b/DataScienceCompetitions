load('anomaly_imputed_test_clusters_095_knn.mat', 'anomaly_test_clusters');
load('anomaly_clusters_with_rel_feats_withoutfreq_095_knn.mat', 'best_feature_transformations');
tic
anomaly_final_test_clusters = cell(100, 1);

for i = 1 : 100
    dataset = anomaly_test_clusters{i, 1};
    best_transformations = best_feature_transformations{i, 1};
    anomaly_final_test_clusters{i, 1} = TransformToSymmetricSample(dataset, best_transformations);
end;

save('anomaly_final_test_set_095_knn.mat', 'anomaly_final_test_clusters');

toc       % Elapsed time is 8.779991 seconds.