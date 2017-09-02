function remaining_features = FindFeaturesWithEnoughValues(cluster_data, num_all_features, threshold)

% cluster_data is a cell array that includes the dataset for 5 clusters.
% cluster_data{i, 1} is the data set for cluster i

% remaining_features is a 5 by num_all_features, its ith row includes the
% 0-1 vector showing the remaining features for cluster i
remaining_features = zeros(5, num_all_features);

for i = 1 : 5
    cluster = cluster_data{i, 1};
    num_obs = size(cluster, 1);
    existence_ratio = ones(1, num_all_features);
    nan_values = isnan(cluster(:, 1 : num_all_features));
    existence_ratio = existence_ratio - sum(nan_values, 1) / num_obs;
    enough_values = (existence_ratio > threshold);  % changed in 11/09
    remaining_features(i, : ) = enough_values;
end;

end