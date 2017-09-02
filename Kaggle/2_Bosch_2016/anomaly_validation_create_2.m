%% Transform validation set for classification - PART 2
% Store cluster validation data
tic
load('anomaly_validation.mat', 'testObsToCluster');

% Initialize variable to store cluster data
valid_clusters = cell(100, 1);

% Store cluster data
load('anomaly_validation.mat', 'validation');
validation_set = validation;

for i = 1 : 100
    ids_clust_i = testObsToCluster(testObsToCluster(:,2) == i, 1);
    valid_clusters{i, 1} = validation_set(ismember(validation_set(:, 1), ids_clust_i(:, 1)), :);
end;
save('anomaly_validation.mat', 'valid_clusters', '-append');
toc     % Elapsed time is 22.940583 seconds. (On Eszter's computer.)