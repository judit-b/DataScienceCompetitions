%% Anomaly_detection - Create test set 
tic

% Create a common file for the test set
load('anomaly_numeric.mat', 'test_1');
load('anomaly_numeric.mat', 'test_2');
load('anomaly_numeric.mat', 'test_3');
load('anomaly_numeric.mat', 'test_4');
load('anomaly_numeric.mat', 'test_5');
load('anomaly_numeric.mat', 'test_6');

num_test = size(test_1, 1) + size(test_2, 1) + size(test_3, 1);
num_test = num_test + size(test_4, 1) + size(test_5, 1);
num_test = num_test + size(test_6, 1);

test = zeros(num_test, 970);

next_row = 1;
last_row = next_row - 1 + size(test_1, 1);
test(next_row : last_row, :) = test_1;

next_row = last_row + 1;
last_row = next_row - 1 + size(test_2, 1);
test(next_row : last_row, :) = test_2;

next_row = last_row + 1;
last_row = next_row - 1 + size(test_3, 1);
test(next_row : last_row, :) = test_3;

next_row = last_row + 1;
last_row = next_row - 1 + size(test_4, 1);
test(next_row : last_row, :) = test_4;

next_row = last_row + 1;
last_row = next_row - 1 + size(test_5, 1);
test(next_row : last_row, :) = test_5;

next_row = last_row + 1;
last_row = next_row - 1 + size(test_6, 1);
test(next_row : last_row, :) = test_6;

save('anomaly_test.mat', 'test');

clearvars test_1 test_2 test_3 test_4 test_5 test_6;
disp('common test set created');

% Load k-medoid centroids
load('anomaly_clusters_withoutfreqfeats.mat', 'C2');
% C2{4, 1} is a 40*968 matrix including the best 100 centroids
centroids = C2{4, 1};
num_centroids = size(centroids, 1);

load('anomaly_numeric.mat', 'frequent_features');
testObsToCluster = AssignObservationsToCluster2(test, test(:,1), centroids, frequent_features);

save('anomaly_test.mat', 'testObsToCluster', '-append');
disp('validObsToCluster created');

toc         % Elapsed time is 1380.843800 seconds. (On Eszter's computer.)