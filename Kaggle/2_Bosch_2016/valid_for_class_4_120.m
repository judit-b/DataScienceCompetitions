%% Imputation of missing data
rng(1234);
tic
load('valid_and_test_set_120.mat', 'valid_clusters_relev_feats');
load('clusters_with_rel_feats_120.mat', 'all_clusters_relev_feats');
valid_clusters_for_class = cell(120, 1);

for i = 1 : 120
    disp(i);
	cluster_data = all_clusters_relev_feats{i, 1};
    valid_data = valid_clusters_relev_feats{i, 1};
    idx = knnsearch(cluster_data(:, 2:end-1), valid_data(:, 2:end-1));
    imputed_cluster = zeros(size(valid_data));
    imputed_cluster(isnan(valid_data) == 0) = cluster_data(isnan(valid_data) == 0);
    imputed_cluster = imputed_cluster + cluster_data(idx, :) .* isnan(valid_data);
    valid_clusters_for_class{i, 1} = imputed_cluster;
end;

save('final_valid_set_for_class_120.mat', 'valid_clusters_for_class');

toc      % Elapsed time is 6064.443563 seconds. (On Eszter's computer.)