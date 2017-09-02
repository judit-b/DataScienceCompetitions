%% Transform validation set for classification - PART 2
% Store cluster validation data
tic
load('valid_and_test_set_120.mat', 'validObsToCluster');

% Initialize variable to store cluster data
valid_clusters = cell(120, 1);

% Store cluster data
load('valid_and_test_set.mat', 'valid_set');

for i = 1 : 120
    ids_clust_i = validObsToCluster(validObsToCluster(:,2) == i, 1);
    valid_clusters{i, 1} = valid_set(ismember(valid_set(:, 1), ids_clust_i(:, 1)), :);
end;
save('valid_and_test_set_120.mat', 'valid_clusters', '-append');
toc     % 
Elapsed time is 17.879188 seconds.