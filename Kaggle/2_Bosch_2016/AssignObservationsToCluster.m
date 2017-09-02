function obsToCluster = AssignObservationsToCluster(dataset, ids_to_take, centroids)
% ids_to_take is id_resp_train (stored in file 'train_test_sample_sets.mat') 
% which includes the IDs of the observations in the training set

% Take only training set rows from the dataset
dataset = dataset(ismember(dataset(:, 1), ids_to_take(:, 1)), :);
num_centroids = size(centroids, 1);

% For each observation, create 0-1 representation, calculate its distances
% from the centroids, then assign it to the cluster with the nearest
% centroid.

num_obs = size(dataset, 1);
obsToCluster = zeros(num_obs, 2);
obsToCluster(:, 1) = dataset(:, 1);

for obs_idx = 1 : num_obs
    obs_01_repr = 1 - isnan(dataset(obs_idx, 2 : 969));
    closest_centroid_idx = [];
    min_centr_dist = Inf;
    for centr_idx = 1 : num_centroids
        centr_dist = pdist2(obs_01_repr, centroids(centr_idx, :), 'hamming');
        if centr_dist < min_centr_dist
            min_centr_dist = centr_dist;
            closest_centroid_idx = centr_idx;
        end;
    end;
    obsToCluster(obs_idx, 2) = closest_centroid_idx;
end;


end