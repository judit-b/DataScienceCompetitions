%% Transform test set for classification - PART 2
% Store cluster test data
tic
load('anomaly_test.mat', 'testObsToCluster');

% Initialize variable to store cluster data
test_clusters = cell(100, 1);

% Store cluster data
load('anomaly_test.mat', 'test');
test_set = test;

for i = 1 : 100
    ids_clust_i = testObsToCluster(testObsToCluster(:,2) == i, 1);
    test_clusters{i, 1} = test_set(ismember(test_set(:, 1), ids_clust_i(:, 1)), :);
end;
save('anomaly_test.mat', 'test_clusters', '-append');
toc     % Elapsed time is 22.940583 seconds. (On Eszter's computer.)