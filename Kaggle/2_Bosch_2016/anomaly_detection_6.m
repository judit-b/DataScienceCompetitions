%% Anomaly detection - PART 6 - Dimension reduction using the result of k-medoid clustering - PART 1
% Decrease the number of features:
% - Take the centroids resulted by k-medoids clustering and assign each 
%   observation to the cluster with the nearest centroid. Then for each 
%   cluster, take only those features which has a value for the most of the 
%   observations in the cluster. This results a reduced feature set for 
%   each cluster.
%
% Use 'hamming' distance for the 0-1 representations of the observations.
%
% Steps:
% 1. Load k-medoids centroids.
% 2. For each observation, generate its 0-1 representation. (1 denotes an 
%    existing data, 0 denotes missing data.)
% 2. For each observation, calculate the distance between the 0-1 
%    representation of the observation and each cluster centroids.
% 3. Assign each observation to the cluster with the nearest centroid to 
%    its 0-1 representation.
% 4. For each cluster, take features with at least 80% assignments. Other 
%    features are not taken into account in the later steps.
% 5. For each cluster, run a PCA. Use ALS to estimate the missing values.
% 
% This file includes step 1-3
tic
% Set the seed
rng(1234);

% Load k-medoids centroids
load('anomaly_kmedoids_clusters.mat', 'C_ham');
% C_ham{idx, 1} is a 40*968 matrix including the 40 centroids
% (idx = num_centroids / 5)
idx = 8;  
centroids = C_ham{idx, 1};
num_centroids = size(centroids, 1);
num_dataparts = 6;
obsToCluster = cell(num_dataparts, 1);     % stores the id-cluster assignments for the 6 part of the database

load('anomaly_numeric.mat', 'train_id_resp');

load('train_numeric.mat', 'dataset_numeric_1');     % includes training and test observations
obsToCluster{1, 1} = AssignObservationsToCluster(dataset_numeric_1, train_id_resp, centroids);
clearvars dataset_numeric_1;
disp(1);
load('train_numeric.mat', 'dataset_numeric_2');     % includes training and test observations
obsToCluster{2, 1} = AssignObservationsToCluster(dataset_numeric_2, train_id_resp, centroids);
clearvars dataset_numeric_2;
disp(2);
load('train_numeric.mat', 'dataset_numeric_3');     % includes training and test observations
obsToCluster{3, 1} = AssignObservationsToCluster(dataset_numeric_3, train_id_resp, centroids);
clearvars dataset_numeric_3;
disp(3);
load('train_numeric.mat', 'dataset_numeric_4');     % includes training and test observations
obsToCluster{4, 1} = AssignObservationsToCluster(dataset_numeric_4, train_id_resp, centroids);
clearvars dataset_numeric_4;
disp(4);
load('train_numeric.mat', 'dataset_numeric_5');     % includes training and test observations
obsToCluster{5, 1} = AssignObservationsToCluster(dataset_numeric_5, train_id_resp, centroids);
clearvars dataset_numeric_5;
disp(5);
load('train_numeric.mat', 'dataset_numeric_6');     % includes training and test observations
obsToCluster{6, 1} = AssignObservationsToCluster(dataset_numeric_6, train_id_resp, centroids);
clearvars dataset_numeric_6;
disp(6);
save('anomaly_cluster_assignments.mat', 'obsToCluster');
toc        % Elapsed time is 3576.847668 seconds. (On Eszter's computer.)