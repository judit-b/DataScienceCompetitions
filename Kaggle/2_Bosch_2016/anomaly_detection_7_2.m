%% Anomaly detection - PART 7 - Dimension reduction using the result of k-medoid clustering - PART 2
%% Frequent features do not matter
% Decrease the number of features:
% - Take the centroids resulted by k-medoids clustering and assign each 
%   observation to the cluster with the nearest centroid. Then for each 
%   cluster, take only those features which has a value for the most of the 
%   observations in the cluster. This results a reduced feature set for 
%   each cluster.
%
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
% This file is between step 3 and 4: it stores the training data in
% variables according to their cluster assignment.

tic
rng(1234);

% Create a common file to store the cluster assignments
load('anomaly_clusters_withoutfreqfeats.mat', 'obsToCluster');
num_obs = 0;
for i = 1 : 6
    num_obs = num_obs + size(obsToCluster{i, 1}, 1);
end;
allObsToCluster = zeros(num_obs, 2);
nextrow = 1;
for i = 1 : 6
    num_obs_i = size(obsToCluster{i, 1}, 1);
    allObsToCluster(nextrow : nextrow + num_obs_i - 1, :) = obsToCluster{i, 1};
    nextrow = nextrow + num_obs_i;
end;
save('anomaly_clusters_withoutfreqfeats.mat', 'allObsToCluster', '-append');
clearvars obsToCluster i nextrow;

% Initialize vars to store cluster data
cluster_1_5 = cell(5, 1);
cluster_6_10 = cell(5, 1);
cluster_11_15 = cell(5, 1);
cluster_16_20 = cell(5, 1);
cluster_21_25 = cell(5, 1);
cluster_26_30 = cell(5, 1);
cluster_31_35 = cell(5, 1);
cluster_36_40 = cell(5, 1);
cluster_41_45 = cell(5, 1);
cluster_46_50 = cell(5, 1);
cluster_51_55 = cell(5, 1);
cluster_56_60 = cell(5, 1);
cluster_61_65 = cell(5, 1);
cluster_66_70 = cell(5, 1);
cluster_71_75 = cell(5, 1);
cluster_76_80 = cell(5, 1);
cluster_81_85 = cell(5, 1);
cluster_86_90 = cell(5, 1);
cluster_91_95 = cell(5, 1);
cluster_96_100 = cell(5, 1);

save('anomaly_clusters_train_withoutfreq.mat', 'cluster_1_5');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_6_10', '-append');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_11_15', '-append');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_16_20', '-append');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_21_25', '-append');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_26_30', '-append');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_31_35', '-append');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_36_40', '-append');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_41_45', '-append');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_46_50', '-append');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_51_55', '-append');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_56_60', '-append');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_61_65', '-append');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_66_70', '-append');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_71_75', '-append');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_76_80', '-append');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_81_85', '-append');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_86_90', '-append');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_91_95', '-append');
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_96_100', '-append');

clearvars cluster_1_5 cluster_6_10 cluster_11_15 cluster_16_20 cluster_21_25;
clearvars cluster_26_30 cluster_31_35 cluster_36_40 cluster_41_45 cluster_46_50;
clearvars cluster_51_55 cluster_56_60 cluster_61_65 cluster_66_70 cluster_71_75;
clearvars cluster_76_80 cluster_81_85 cluster_86_90 cluster_91_95 cluster_96_100;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_1_5');
for i = 1 : 5
    cluster_1_5{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_1_5', '-append');
clearvars cluster_1_5;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_6_10');
for i = 1 : 5
    cluster_6_10{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+5, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_6_10', '-append');
clearvars cluster_6_10;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_11_15');
for i = 1 : 5
    cluster_11_15{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+10, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_11_15', '-append');
clearvars cluster_11_15;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_16_20');
for i = 1 : 5
    cluster_16_20{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+15, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_16_20', '-append');
clearvars cluster_16_20;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_21_25');
for i = 1 : 5
    cluster_21_25{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+20, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_21_25', '-append');
clearvars cluster_21_25;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_26_30');
for i = 1 : 5
    cluster_26_30{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+25, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_26_30', '-append');
clearvars cluster_26_30;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_31_35');
for i = 1 : 5
    cluster_31_35{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+30, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_31_35', '-append');
clearvars cluster_31_35;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_36_40');
for i = 1 : 5
    cluster_36_40{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+35, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_36_40', '-append');
clearvars cluster_36_40;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_41_45');
for i = 1 : 5
    cluster_41_45{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+40, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_41_45', '-append');
clearvars cluster_41_45;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_46_50');
for i = 1 : 5
    cluster_46_50{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+45, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_46_50', '-append');
clearvars cluster_46_50;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_51_55');
for i = 1 : 5
    cluster_51_55{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+50, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_51_55', '-append');
clearvars cluster_51_55;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_56_60');
for i = 1 : 5
    cluster_56_60{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+55, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_56_60', '-append');
clearvars cluster_56_60;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_61_65');
for i = 1 : 5
    cluster_61_65{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+60, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_61_65', '-append');
clearvars cluster_61_65;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_66_70');
for i = 1 : 5
    cluster_66_70{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+65, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_66_70', '-append');
clearvars cluster_66_70;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_71_75');
for i = 1 : 5
    cluster_71_75{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+70, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_71_75', '-append');
clearvars cluster_71_75;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_76_80');
for i = 1 : 5
    cluster_76_80{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+75, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_76_80', '-append');
clearvars cluster_76_80;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_81_85');
for i = 1 : 5
    cluster_81_85{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+80, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_81_85', '-append');
clearvars cluster_81_85;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_86_90');
for i = 1 : 5
    cluster_86_90{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+85, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_86_90', '-append');
clearvars cluster_86_90;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_91_95');
for i = 1 : 5
    cluster_91_95{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+90, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_91_95', '-append');
clearvars cluster_91_95;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_96_100');
for i = 1 : 5
    cluster_96_100{i, 1} = zeros(size(allObsToCluster(allObsToCluster(:,2)==i+95, :), 1), 970);
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_96_100', '-append');
clearvars cluster_96_100;

% Store cluster data
load('train_numeric.mat', 'dataset_numeric_1');
disp(1);
load('anomaly_clusters_train_withoutfreq.mat', 'cluster_1_5');
for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == i, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_1_5{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_1_5', '-append');
clearvars cluster_1_5 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_6_10');
for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == i + 5, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_6_10{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_6_10', '-append');
clearvars cluster_6_10 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_11_15');
for i = 1 : 5
    ids_clust_i0 = allObsToCluster(allObsToCluster(:,2) == i + 10, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i0(:, 1)), :);
    cluster_11_15{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_11_15', '-append');
clearvars cluster_11_15 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_16_20');
for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == i + 15, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_16_20{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_16_20', '-append');
clearvars cluster_16_20 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_21_25');
for i = 1 : 5
    ids_clust_i= allObsToCluster(allObsToCluster(:,2) == i + 20, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_21_25{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_21_25', '-append');
clearvars cluster_21_25 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_26_30');
for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == i + 25, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_26_30{i, 1}(1 : size(clust_data, 1), :) = clust_data;
 end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_26_30', '-append');
clearvars cluster_26_30 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_31_35');
for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == i + 30, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_31_35{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_31_35', '-append');
clearvars cluster_31_35 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_36_40');
for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == i + 35, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_36_40{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_36_40', '-append');
clearvars cluster_36_40 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_41_45');
for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == i + 40, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_41_45{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_41_45', '-append');
clearvars cluster_41_45 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_46_50');
for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == i + 45, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_46_50{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_46_50', '-append');
clearvars cluster_46_50 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_51_55');
for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == i + 50, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_51_55{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_51_55', '-append');
clearvars cluster_51_55 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_56_60');
for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == i + 55, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_56_60{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_56_60', '-append');
clearvars cluster_56_60 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_61_65');
for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == i + 60, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_61_65{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_61_65', '-append');
clearvars cluster_61_65 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_66_70');
for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == i + 65, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_66_70{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_66_70', '-append');
clearvars cluster_66_70 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_71_75');
for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == i + 70, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_71_75{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_71_75', '-append');
clearvars cluster_71_75 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_76_80');
for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == i + 75, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_76_80{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_76_80', '-append');
clearvars cluster_76_80 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_81_85');
for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == i + 80, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_81_85{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_81_85', '-append');
clearvars cluster_81_85 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_86_90');
for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == i + 85, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_86_90{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_86_90', '-append');
clearvars cluster_86_90 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_91_95');
for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == i + 90, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_91_95{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_91_95', '-append');
clearvars cluster_91_95 ids_clust_i;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_96_100');
for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == i + 95, 1);
    clust_data = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), ids_clust_i(:, 1)), :);
    cluster_96_100{i, 1}(1 : size(clust_data, 1), :) = clust_data;
end;
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_96_100', '-append');
clearvars cluster_96_100 ids_clust_i;

clearvars dataset_numeric_1;

% Continue with dataset_numeric_2
load('train_numeric.mat', 'dataset_numeric_2');
disp(2);
load('anomaly_clusters_train_withoutfreq.mat', 'cluster_1_5');
cluster_1_5 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_1_5, 1, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_1_5', '-append');
clearvars cluster_1_5;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_6_10');
cluster_6_10 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_6_10, 6, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_6_10', '-append');
clearvars cluster_6_10;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_11_15');
cluster_11_15 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_11_15, 11, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_11_15', '-append');
clearvars cluster_11_15;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_16_20');
cluster_16_20 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_16_20, 16, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_16_20', '-append');
clearvars cluster_16_20;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_21_25');
cluster_21_25 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_21_25, 21, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_21_25', '-append');
clearvars cluster_21_25;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_26_30');
cluster_26_30 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_26_30, 26, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_26_30', '-append');
clearvars cluster_26_30;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_31_35');
cluster_31_35 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_31_35, 31, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_31_35', '-append');
clearvars cluster_31_35;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_36_40');
cluster_36_40 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_36_40, 36, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_36_40', '-append');
clearvars cluster_36_40;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_41_45');
cluster_41_45 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_41_45, 41, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_41_45', '-append');
clearvars cluster_41_45;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_46_50');
cluster_46_50 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_46_50, 46, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_46_50', '-append');
clearvars cluster_46_50;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_51_55');
cluster_51_55 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_51_55, 51, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_51_55', '-append');
clearvars cluster_51_55;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_56_60');
cluster_56_60 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_56_60, 56, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_56_60', '-append');
clearvars cluster_56_60;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_61_65');
cluster_61_65 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_61_65, 61, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_61_65', '-append');
clearvars cluster_61_65;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_66_70');
cluster_66_70 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_66_70, 66, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_66_70', '-append');
clearvars cluster_66_70;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_71_75');
cluster_71_75 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_71_75, 71, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_71_75', '-append');
clearvars cluster_71_75;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_76_80');
cluster_76_80 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_76_80, 76, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_76_80', '-append');
clearvars cluster_76_80;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_81_85');
cluster_81_85 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_81_85, 81, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_81_85', '-append');
clearvars cluster_81_85;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_86_90');
cluster_86_90 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_86_90, 86, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_86_90', '-append');
clearvars cluster_86_90;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_91_95');
cluster_91_95 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_91_95, 91, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_91_95', '-append');
clearvars cluster_91_95;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_96_100');
cluster_96_100 = FindAndStoreFiveClusterData(dataset_numeric_2, cluster_96_100, 96, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_96_100', '-append');
clearvars cluster_96_100;

clearvars dataset_numeric_2;

% Continue with dataset_numeric_3
load('train_numeric.mat', 'dataset_numeric_3');
disp(3);
load('anomaly_clusters_train_withoutfreq.mat', 'cluster_1_5');
cluster_1_5 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_1_5, 1, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_1_5', '-append');
clearvars cluster_1_5;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_6_10');
cluster_6_10 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_6_10, 6, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_6_10', '-append');
clearvars cluster_6_10;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_11_15');
cluster_11_15 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_11_15, 11, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_11_15', '-append');
clearvars cluster_11_15;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_16_20');
cluster_16_20 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_16_20, 16, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_16_20', '-append');
clearvars cluster_16_20;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_21_25');
cluster_21_25 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_21_25, 21, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_21_25', '-append');
clearvars cluster_21_25;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_26_30');
cluster_26_30 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_26_30, 26, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_26_30', '-append');
clearvars cluster_26_30;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_31_35');
cluster_31_35 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_31_35, 31, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_31_35', '-append');
clearvars cluster_31_35;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_36_40');
cluster_36_40 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_36_40, 36, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_36_40', '-append');
clearvars cluster_36_40;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_41_45');
cluster_41_45 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_41_45, 41, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_41_45', '-append');
clearvars cluster_41_45;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_46_50');
cluster_46_50 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_46_50, 46, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_46_50', '-append');
clearvars cluster_46_50;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_51_55');
cluster_51_55 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_51_55, 51, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_51_55', '-append');
clearvars cluster_51_55;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_56_60');
cluster_56_60 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_56_60, 56, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_56_60', '-append');
clearvars cluster_56_60;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_61_65');
cluster_61_65 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_61_65, 61, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_61_65', '-append');
clearvars cluster_61_65;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_66_70');
cluster_66_70 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_66_70, 66, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_66_70', '-append');
clearvars cluster_66_70;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_71_75');
cluster_71_75 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_71_75, 71, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_71_75', '-append');
clearvars cluster_71_75;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_76_80');
cluster_76_80 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_76_80, 76, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_76_80', '-append');
clearvars cluster_76_80;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_81_85');
cluster_81_85 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_81_85, 81, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_81_85', '-append');
clearvars cluster_81_85;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_86_90');
cluster_86_90 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_86_90, 86, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_86_90', '-append');
clearvars cluster_86_90;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_91_95');
cluster_91_95 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_91_95, 91, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_91_95', '-append');
clearvars cluster_91_95;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_96_100');
cluster_96_100 = FindAndStoreFiveClusterData(dataset_numeric_3, cluster_96_100, 96, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_96_100', '-append');
clearvars cluster_96_100;

clearvars dataset_numeric_3;

% Continue with dataset_numeric_4
load('train_numeric.mat', 'dataset_numeric_4');
disp(4);
load('anomaly_clusters_train_withoutfreq.mat', 'cluster_1_5');
cluster_1_5 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_1_5, 1, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_1_5', '-append');
clearvars cluster_1_5;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_6_10');
cluster_6_10 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_6_10, 6, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_6_10', '-append');
clearvars cluster_6_10;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_11_15');
cluster_11_15 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_11_15, 11, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_11_15', '-append');
clearvars cluster_11_15;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_16_20');
cluster_16_20 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_16_20, 16, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_16_20', '-append');
clearvars cluster_16_20;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_21_25');
cluster_21_25 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_21_25, 21, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_21_25', '-append');
clearvars cluster_21_25;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_26_30');
cluster_26_30 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_26_30, 26, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_26_30', '-append');
clearvars cluster_26_30;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_31_35');
cluster_31_35 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_31_35, 31, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_31_35', '-append');
clearvars cluster_31_35;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_36_40');
cluster_36_40 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_36_40, 36, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_36_40', '-append');
clearvars cluster_36_40;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_41_45');
cluster_41_45 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_41_45, 41, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_41_45', '-append');
clearvars cluster_41_45;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_46_50');
cluster_46_50 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_46_50, 46, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_46_50', '-append');
clearvars cluster_46_50;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_51_55');
cluster_51_55 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_51_55, 51, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_51_55', '-append');
clearvars cluster_51_55;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_56_60');
cluster_56_60 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_56_60, 56, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_56_60', '-append');
clearvars cluster_56_60;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_61_65');
cluster_61_65 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_61_65, 61, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_61_65', '-append');
clearvars cluster_61_65;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_66_70');
cluster_66_70 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_66_70, 66, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_66_70', '-append');
clearvars cluster_66_70;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_71_75');
cluster_71_75 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_71_75, 71, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_71_75', '-append');
clearvars cluster_71_75;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_76_80');
cluster_76_80 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_76_80, 76, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_76_80', '-append');
clearvars cluster_76_80;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_81_85');
cluster_81_85 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_81_85, 81, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_81_85', '-append');
clearvars cluster_81_85;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_86_90');
cluster_86_90 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_86_90, 86, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_86_90', '-append');
clearvars cluster_86_90;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_91_95');
cluster_91_95 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_91_95, 91, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_91_95', '-append');
clearvars cluster_91_95;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_96_100');
cluster_96_100 = FindAndStoreFiveClusterData(dataset_numeric_4, cluster_96_100, 96, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_96_100', '-append');
clearvars cluster_96_100;

clearvars dataset_numeric_4;

% Continue with dataset_numeric_5
load('train_numeric.mat', 'dataset_numeric_5');
disp(5);
load('anomaly_clusters_train_withoutfreq.mat', 'cluster_1_5');
cluster_1_5 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_1_5, 1, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_1_5', '-append');
clearvars cluster_1_5;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_6_10');
cluster_6_10 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_6_10, 6, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_6_10', '-append');
clearvars cluster_6_10;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_11_15');
cluster_11_15 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_11_15, 11, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_11_15', '-append');
clearvars cluster_11_15;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_16_20');
cluster_16_20 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_16_20, 16, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_16_20', '-append');
clearvars cluster_16_20;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_21_25');
cluster_21_25 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_21_25, 21, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_21_25', '-append');
clearvars cluster_21_25;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_26_30');
cluster_26_30 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_26_30, 26, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_26_30', '-append');
clearvars cluster_26_30;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_31_35');
cluster_31_35 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_31_35, 31, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_31_35', '-append');
clearvars cluster_31_35;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_36_40');
cluster_36_40 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_36_40, 36, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_36_40', '-append');
clearvars cluster_36_40;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_41_45');
cluster_41_45 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_41_45, 41, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_41_45', '-append');
clearvars cluster_41_45;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_46_50');
cluster_46_50 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_46_50, 46, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_46_50', '-append');
clearvars cluster_46_50;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_51_55');
cluster_51_55 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_51_55, 51, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_51_55', '-append');
clearvars cluster_51_55;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_56_60');
cluster_56_60 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_56_60, 56, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_56_60', '-append');
clearvars cluster_56_60;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_61_65');
cluster_61_65 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_61_65, 61, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_61_65', '-append');
clearvars cluster_61_65;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_66_70');
cluster_66_70 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_66_70, 66, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_66_70', '-append');
clearvars cluster_66_70;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_71_75');
cluster_71_75 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_71_75, 71, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_71_75', '-append');
clearvars cluster_71_75;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_76_80');
cluster_76_80 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_76_80, 76, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_76_80', '-append');
clearvars cluster_76_80;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_81_85');
cluster_81_85 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_81_85, 81, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_81_85', '-append');
clearvars cluster_81_85;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_86_90');
cluster_86_90 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_86_90, 86, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_86_90', '-append');
clearvars cluster_86_90;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_91_95');
cluster_91_95 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_91_95, 91, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_91_95', '-append');
clearvars cluster_91_95;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_96_100');
cluster_96_100 = FindAndStoreFiveClusterData(dataset_numeric_5, cluster_96_100, 96, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_96_100', '-append');
clearvars cluster_96_100;

clearvars dataset_numeric_5;

% Continue with dataset_numeric_6
load('train_numeric.mat', 'dataset_numeric_6');
disp(6);
load('anomaly_clusters_train_withoutfreq.mat', 'cluster_1_5');
cluster_1_5 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_1_5, 1, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_1_5', '-append');
clearvars cluster_1_5;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_6_10');
cluster_6_10 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_6_10, 6, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_6_10', '-append');
clearvars cluster_6_10;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_11_15');
cluster_11_15 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_11_15, 11, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_11_15', '-append');
clearvars cluster_11_15;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_16_20');
cluster_16_20 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_16_20, 16, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_16_20', '-append');
clearvars cluster_16_20;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_21_25');
cluster_21_25 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_21_25, 21, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_21_25', '-append');
clearvars cluster_21_25;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_26_30');
cluster_26_30 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_26_30, 26, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_26_30', '-append');
clearvars cluster_26_30;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_31_35');
cluster_31_35 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_31_35, 31, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_31_35', '-append');
clearvars cluster_31_35;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_36_40');
cluster_36_40 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_36_40, 36, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_36_40', '-append');
clearvars cluster_36_40;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_41_45');
cluster_41_45 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_41_45, 41, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_41_45', '-append');
clearvars cluster_41_45;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_46_50');
cluster_46_50 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_46_50, 46, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_46_50', '-append');
clearvars cluster_46_50;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_51_55');
cluster_51_55 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_51_55, 51, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_51_55', '-append');
clearvars cluster_51_55;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_56_60');
cluster_56_60 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_56_60, 56, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_56_60', '-append');
clearvars cluster_56_60;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_61_65');
cluster_61_65 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_61_65, 61, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_61_65', '-append');
clearvars cluster_61_65;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_66_70');
cluster_66_70 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_66_70, 66, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_66_70', '-append');
clearvars cluster_66_70;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_71_75');
cluster_71_75 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_71_75, 71, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_71_75', '-append');
clearvars cluster_71_75;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_76_80');
cluster_76_80 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_76_80, 76, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_76_80', '-append');
clearvars cluster_76_80;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_81_85');
cluster_81_85 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_81_85, 81, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_81_85', '-append');
clearvars cluster_81_85;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_86_90');
cluster_86_90 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_86_90, 86, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_86_90', '-append');
clearvars cluster_86_90;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_91_95');
cluster_91_95 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_91_95, 91, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_91_95', '-append');
clearvars cluster_91_95;

load('anomaly_clusters_train_withoutfreq.mat', 'cluster_96_100');
cluster_96_100 = FindAndStoreFiveClusterData(dataset_numeric_6, cluster_96_100, 96, allObsToCluster);
save('anomaly_clusters_train_withoutfreq.mat', 'cluster_96_100', '-append');
clearvars cluster_96_100;

clearvars dataset_numeric_6;

toc            % Elapsed time is 365.477350 seconds. (On Eszter's computer.)