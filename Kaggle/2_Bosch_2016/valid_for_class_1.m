%% Transform validation set for classification - PART 1
% Assign each observations in the validation set to the cluster with the
% nearest centroid (40 clusters)
tic
load('valid_and_test_set.mat', 'valid_set');

% Load k-medoids centroids
load('kmedoids_clusters.mat', 'C_ham');
% C_ham{idx, 1} is a 40*968 matrix including the 40 centroids
% (idx = num_centroids / 5)
idx = 8;
centroids = C_ham{idx, 1};
num_centroids = size(centroids, 1);

validObsToCluster = AssignObservationsToCluster(valid_set, valid_set(:, 1), centroids);

save('valid_and_test_set.mat', 'validObsToCluster', '-append');
toc       % Elapsed time is 2432.068126 seconds.