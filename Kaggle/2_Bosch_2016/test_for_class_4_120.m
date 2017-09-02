%% Imputation of missing data
rng(1234);
tic
load('valid_and_test_set_120.mat', 'test_clusters_relev_feats');
load('clusters_with_rel_feats_120.mat', 'all_clusters_relev_feats');
test_clusters_for_class = cell(120, 1);

for i = 1 : 120
    disp(i);
	cluster_data = all_clusters_relev_feats{i, 1};
    test_data = test_clusters_relev_feats{i, 1};
    idx = knnsearch(cluster_data(:, 2:end-1), test_data(:, 2:end-1));
    imputed_cluster = zeros(size(test_data));
    imputed_cluster(isnan(test_data) == 0) = cluster_data(isnan(test_data) == 0);
    imputed_cluster = imputed_cluster + cluster_data(idx, :) .* isnan(test_data);
    test_clusters_for_class{i, 1} = imputed_cluster;
end;

save('final_test_set_for_class_120.mat', 'test_clusters_for_class');

toc      % Elapsed time is 6064.443563 seconds. (On Eszter's computer.)