%% Anomaly_detection - For submission
tic

% Load k-medoid centroids
load('anomaly_clusters_withoutfreqfeats.mat', 'C2');
% C2{4, 1} is a 40*968 matrix including the best 100 centroids
centroids = C2{4, 1};
num_centroids = size(centroids, 1);
load('anomaly_numeric.mat', 'frequent_features');

submitObsToCluster = cell(6, 1);

load('submit_numeric.mat', 'dataset_numeric_1');
submitObsToCluster{1,1} = AssignObservationsToCluster2(dataset_numeric_1, dataset_numeric_1(:,1), centroids, frequent_features);
clearvars dataset_numeric_1;

load('submit_numeric.mat', 'dataset_numeric_2');
submitObsToCluster{2,1} = AssignObservationsToCluster2(dataset_numeric_2, dataset_numeric_2(:,1), centroids, frequent_features);
clearvars dataset_numeric_2;

load('submit_numeric.mat', 'dataset_numeric_3');
submitObsToCluster{3,1} = AssignObservationsToCluster2(dataset_numeric_3, dataset_numeric_3(:,1), centroids, frequent_features);
clearvars dataset_numeric_3;

load('submit_numeric.mat', 'dataset_numeric_4');
submitObsToCluster{4,1} = AssignObservationsToCluster2(dataset_numeric_4, dataset_numeric_4(:,1), centroids, frequent_features);
clearvars dataset_numeric_4;

load('submit_numeric.mat', 'dataset_numeric_5');
submitObsToCluster{5,1} = AssignObservationsToCluster2(dataset_numeric_5, dataset_numeric_5(:,1), centroids, frequent_features);
clearvars dataset_numeric_5;

load('submit_numeric.mat', 'dataset_numeric_6');
submitObsToCluster{6,1} = AssignObservationsToCluster2(dataset_numeric_6, dataset_numeric_6(:,1), centroids, frequent_features);
clearvars dataset_numeric_6;

save('anomaly_submit.mat', 'submitObsToCluster');

toc         % Elapsed time is 39293.566582 seconds. (On Eszter's computer.)