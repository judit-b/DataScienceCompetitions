%% Anomaly_detection - Create validation set 
tic

% Create a common file for the validation set
load('anomaly_numeric.mat', 'validation_1');
load('anomaly_numeric.mat', 'validation_2');
load('anomaly_numeric.mat', 'validation_3');
load('anomaly_numeric.mat', 'validation_4');
load('anomaly_numeric.mat', 'validation_5');
load('anomaly_numeric.mat', 'validation_6');

num_validation = size(validation_1, 1) + size(validation_2, 1) + size(validation_3, 1);
num_validation = num_validation + size(validation_4, 1) + size(validation_5, 1);
num_validation = num_validation + size(validation_6, 1);

validation = zeros(num_validation, 970);

next_row = 1;
last_row = next_row - 1 + size(validation_1, 1);
validation(next_row : last_row, :) = validation_1;

next_row = last_row + 1;
last_row = next_row - 1 + size(validation_2, 1);
validation(next_row : last_row, :) = validation_2;

next_row = last_row + 1;
last_row = next_row - 1 + size(validation_3, 1);
validation(next_row : last_row, :) = validation_3;

next_row = last_row + 1;
last_row = next_row - 1 + size(validation_4, 1);
validation(next_row : last_row, :) = validation_4;

next_row = last_row + 1;
last_row = next_row - 1 + size(validation_5, 1);
validation(next_row : last_row, :) = validation_5;

next_row = last_row + 1;
last_row = next_row - 1 + size(validation_6, 1);
validation(next_row : last_row, :) = validation_6;

save('anomaly_validation.mat', 'validation');

clearvars validation_1 validation_2 validation_3 validation_4 validation_5 validation_6;
disp('common validation set created');

% Load k-medoid centroids
load('anomaly_clusters_withoutfreqfeats.mat', 'C2');
% C2{4, 1} is a 40*968 matrix including the best 100 centroids
centroids = C2{4, 1};
num_centroids = size(centroids, 1);

load('anomaly_numeric.mat', 'frequent_features');
validObsToCluster = AssignObservationsToCluster2(validation, validation(:,1), centroids, frequent_features);

save('anomaly_validation.mat', 'validObsToCluster', '-append');
disp('validObsToCluster created');

toc