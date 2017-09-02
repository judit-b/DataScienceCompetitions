%% Transform validation set for classification - PART 2
% Store cluster validation data
tic
load('valid_and_test_set_120.mat', 'testObsToCluster');

% Initialize variable to store cluster data
test_clusters = cell(120, 1);

% Store cluster data
load('valid_and_test_set.mat', 'test_set');

for i = 1 : 120
    ids_clust_i = testObsToCluster(testObsToCluster(:,2) == i, 1);
    test_clusters{i, 1} = test_set(ismember(test_set(:, 1), ids_clust_i(:, 1)), :);
end;
save('valid_and_test_set_120.mat', 'test_clusters', '-append');
toc     % Elapsed time is 19.174782 seconds.