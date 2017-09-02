function new_cluster_data = ClustersWithOnlyRelevantFeatures(cluster_data, features_after_clustering, first_cluster)

% cluster_data is a cell array that includes the dataset for 5 clusters
% (the first_cluster, and the next 4 clusters)
% cluster_data{i, 1} is the matrix of the ith cluster
% features_after_clustering includes the remaining features for all
% clusters (not only for the clusters in cluster_data), this function uses
% only its rows from first_cluster to first_cluster+4

relevant_features = features_after_clustering(first_cluster : first_cluster + 4, :);
num_remaining_features = sum(relevant_features, 2);

new_cluster_data = cell(5, 1);
for i = 1 : 5
    num_obs = size(cluster_data{i, 1}, 1);
    new_cluster_data{i, 1} = zeros(num_obs, num_remaining_features(i) + 1);   % ID + features + response variable
    new_cluster_data{i, 1}(:, 1:num_remaining_features(i)) = cluster_data{i, 1}(:, relevant_features(i, :) == 1);
    new_cluster_data{i, 1}(:, end) = cluster_data{i, 1}(:, end);
end;

end
