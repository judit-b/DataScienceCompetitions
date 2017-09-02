%% Transform test set for classification - PART 1
% Assign each observations in the test set to the cluster with the
% nearest centroid (40 clusters)
tic
load('valid_and_test_set.mat', 'test_set');

% Load k-medoids centroids
load('kmedoids_clusters_10000.mat', 'C_ham');
% C_ham{idx, 1} is a 40*968 matrix including the 120 centroids
% (idx = num_centroids / 5)
idx = 1;
centroids = C_ham{idx, 1};
num_centroids = size(centroids, 1);

testObsToCluster = AssignObservationsToCluster(test_set, test_set(:, 1), centroids);

save('valid_and_test_set_120.mat', 'testObsToCluster', '-append');
toc       % Elapsed time is 2432.068126 seconds.