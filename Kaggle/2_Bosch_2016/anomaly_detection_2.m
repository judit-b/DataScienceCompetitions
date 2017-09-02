%% For anomaly detection - PART 2 - SAVE TRAINING, VALIDATION AND TEST DATASETS
% Save training, validation and test datasets into separate variables.
tic
rng(1234);
% Save training data
load('anomaly_numeric.mat', 'train_id_resp');

load('train_numeric.mat', 'dataset_numeric_1');
train_1 = dataset_numeric_1(ismember(dataset_numeric_1(:,1), train_id_resp(:,1)) == 1, :);
save('anomaly_numeric.mat', 'train_1', '-append');
clearvars train_1 dataset_numeric_1;

load('train_numeric.mat', 'dataset_numeric_2');
train_2 = dataset_numeric_2(ismember(dataset_numeric_2(:,1), train_id_resp(:,1)) == 1, :);
save('anomaly_numeric.mat', 'train_2', '-append');
clearvars train_2 dataset_numeric_2;
disp('train');
load('train_numeric.mat', 'dataset_numeric_3');
train_3 = dataset_numeric_3(ismember(dataset_numeric_3(:,1), train_id_resp(:,1)) == 1, :);
save('anomaly_numeric.mat', 'train_3', '-append');
clearvars train_3 dataset_numeric_3;

load('train_numeric.mat', 'dataset_numeric_4');
train_4 = dataset_numeric_4(ismember(dataset_numeric_4(:,1), train_id_resp(:,1)) == 1, :);
save('anomaly_numeric.mat', 'train_4', '-append');
clearvars train_4 dataset_numeric_4;
disp('train');
load('train_numeric.mat', 'dataset_numeric_5');
train_5 = dataset_numeric_5(ismember(dataset_numeric_5(:,1), train_id_resp(:,1)) == 1, :);
save('anomaly_numeric.mat', 'train_5', '-append');
clearvars train_5 dataset_numeric_5;

load('train_numeric.mat', 'dataset_numeric_6');
train_6 = dataset_numeric_6(ismember(dataset_numeric_6(:,1), train_id_resp(:,1)) == 1, :);
save('anomaly_numeric.mat', 'train_6', '-append');
clearvars train_6 dataset_numeric_6;
disp('train');
% Save validation data
load('anomaly_numeric.mat', 'validation_id_resp');

load('train_numeric.mat', 'dataset_numeric_1');
validation_1 = dataset_numeric_1(ismember(dataset_numeric_1(:,1), validation_id_resp(:,1)) == 1, :);
save('anomaly_numeric.mat', 'validation_1', '-append');
clearvars validation_1 dataset_numeric_1;

load('train_numeric.mat', 'dataset_numeric_2');
validation_2 = dataset_numeric_2(ismember(dataset_numeric_2(:,1), validation_id_resp(:,1)) == 1, :);
save('anomaly_numeric.mat', 'validation_2', '-append');
clearvars validation_2 dataset_numeric_2;
disp('validation');
load('train_numeric.mat', 'dataset_numeric_3');
validation_3 = dataset_numeric_3(ismember(dataset_numeric_3(:,1), validation_id_resp(:,1)) == 1, :);
save('anomaly_numeric.mat', 'validation_3', '-append');
clearvars validation_3 dataset_numeric_3;

load('train_numeric.mat', 'dataset_numeric_4');
validation_4 = dataset_numeric_4(ismember(dataset_numeric_4(:,1), validation_id_resp(:,1)) == 1, :);
save('anomaly_numeric.mat', 'validation_4', '-append');
clearvars validation_4 dataset_numeric_4;
disp('validation');
load('train_numeric.mat', 'dataset_numeric_5');
validation_5 = dataset_numeric_5(ismember(dataset_numeric_5(:,1), validation_id_resp(:,1)) == 1, :);
save('anomaly_numeric.mat', 'validation_5', '-append');
clearvars validation_5 dataset_numeric_5;

load('train_numeric.mat', 'dataset_numeric_6');
validation_6 = dataset_numeric_6(ismember(dataset_numeric_6(:,1), validation_id_resp(:,1)) == 1, :);
save('anomaly_numeric.mat', 'validation_6', '-append');
clearvars validation_6 dataset_numeric_6;
disp('validation');
% Save test data
load('anomaly_numeric.mat', 'test_id_resp');

load('train_numeric.mat', 'dataset_numeric_1');
test_1 = dataset_numeric_1(ismember(dataset_numeric_1(:,1), test_id_resp(:,1)) == 1, :);
save('anomaly_numeric.mat', 'test_1', '-append');
clearvars test_1 dataset_numeric_1;

load('train_numeric.mat', 'dataset_numeric_2');
test_2 = dataset_numeric_2(ismember(dataset_numeric_2(:,1), test_id_resp(:,1)) == 1, :);
save('anomaly_numeric.mat', 'test_2', '-append');
clearvars test_2 dataset_numeric_2;
disp('test');
load('train_numeric.mat', 'dataset_numeric_3');
test_3 = dataset_numeric_3(ismember(dataset_numeric_3(:,1), test_id_resp(:,1)) == 1, :);
save('anomaly_numeric.mat', 'test_3', '-append');
clearvars test_3 dataset_numeric_3;

load('train_numeric.mat', 'dataset_numeric_4');
test_4 = dataset_numeric_4(ismember(dataset_numeric_4(:,1), test_id_resp(:,1)) == 1, :);
save('anomaly_numeric.mat', 'test_4', '-append');
clearvars test_4 dataset_numeric_4;
disp('test');
load('train_numeric.mat', 'dataset_numeric_5');
test_5 = dataset_numeric_5(ismember(dataset_numeric_5(:,1), test_id_resp(:,1)) == 1, :);
save('anomaly_numeric.mat', 'test_5', '-append');
clearvars test_5 dataset_numeric_5;

load('train_numeric.mat', 'dataset_numeric_6');
test_6 = dataset_numeric_6(ismember(dataset_numeric_6(:,1), test_id_resp(:,1)) == 1, :);
save('anomaly_numeric.mat', 'test_6', '-append');
clearvars test_6 dataset_numeric_6;
disp('test');

toc          % Elapsed time is 157.517186 seconds. (On Eszter's computer.)
