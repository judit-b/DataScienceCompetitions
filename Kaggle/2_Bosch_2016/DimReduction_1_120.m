%% Dimension reduction using the result of k-medoid clustering and PCA - PART 1
% Decrease the number of features in two steps:
% - Take the centroids resulted by k-medoids clustering and assign each 
%   observation to the cluster with the nearest centroid. Then for each 
%   cluster, take only those features which has a value for the most of the 
%   observations in the cluster. This results a reduced feature set for 
%   each cluster.
% - Use PCA for further reduction of the number of features.
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
% 6. For each cluster, determine the principal components that explains at 
%    least 90% of the variance.
% 
% This file includes step 1-3

% Set the seed
rng(1234);

% Load k-medoids centroids
load('kmedoids_clusters_10000.mat', 'C_ham');
% C_ham{1, 1} is a 120*968 matrix including the 120 centroids
idx = 1;
centroids = C_ham{idx, 1};
num_centroids = size(centroids, 1);
num_dataparts = 6;
obsToCluster = cell(num_dataparts, 1);     % stores the id-cluster assignments for the 6 part of the database

load('train_test_sample_sets.mat', 'id_resp_train'); % first col: list of IDs in the training set

load('train_numeric.mat', 'dataset_numeric_1');     % includes training and test observations
obsToCluster{1, 1} = AssignObservationsToCluster(dataset_numeric_1, id_resp_train, centroids);
clearvars dataset_numeric_1;

load('train_numeric.mat', 'dataset_numeric_2');     % includes training and test observations
obsToCluster{2, 1} = AssignObservationsToCluster(dataset_numeric_2, id_resp_train, centroids);
clearvars dataset_numeric_2;

load('train_numeric.mat', 'dataset_numeric_3');     % includes training and test observations
obsToCluster{3, 1} = AssignObservationsToCluster(dataset_numeric_3, id_resp_train, centroids);
clearvars dataset_numeric_3;

load('train_numeric.mat', 'dataset_numeric_4');     % includes training and test observations
obsToCluster{4, 1} = AssignObservationsToCluster(dataset_numeric_4, id_resp_train, centroids);
clearvars dataset_numeric_4;

load('train_numeric.mat', 'dataset_numeric_5');     % includes training and test observations
obsToCluster{5, 1} = AssignObservationsToCluster(dataset_numeric_5, id_resp_train, centroids);
clearvars dataset_numeric_5;

load('train_numeric.mat', 'dataset_numeric_6');     % includes training and test observations
obsToCluster{6, 1} = AssignObservationsToCluster(dataset_numeric_6, id_resp_train, centroids);
clearvars dataset_numeric_6;

save('cluster_assignments_120.mat', 'obsToCluster');
