%% For anomaly detection - PART 3 - CREATE A SAMPLE OF 100000 OBSERVATIONS IN THE TRAINING SET

tic
rng(1234);

load('anomaly_numeric.mat', 'train_id_resp');

sampleIDs_resp_10000 = datasample(train_id_resp, 10000, 'Replace', false);
sampleIDs_10000 = sampleIDs_resp_10000(:, 1);
sample_10000 = zeros(10000, 970);

load('train_numeric.mat','dataset_numeric_1');
data_for_sample = dataset_numeric_1(ismember(dataset_numeric_1(:, 1), sampleIDs_10000), :);
len = size(data_for_sample, 1);
sample_10000(1 : len, :) = data_for_sample;
clearvars dataset_numeric_1
disp(1);
load('train_numeric.mat','dataset_numeric_2');
firstRow = len + 1;
data_for_sample = dataset_numeric_2(ismember(dataset_numeric_2(:, 1), sampleIDs_10000), :);
len = size(data_for_sample, 1);
sample_10000(firstRow : firstRow + len - 1, :) = data_for_sample;
clearvars dataset_numeric_2
disp(2);
load('train_numeric.mat','dataset_numeric_3');
firstRow = firstRow + len;
data_for_sample = dataset_numeric_3(ismember(dataset_numeric_3(:, 1), sampleIDs_10000), :);
len = size(data_for_sample, 1);
sample_10000(firstRow : firstRow + len - 1, :) = data_for_sample;
clearvars dataset_numeric_3
disp(3);
load('train_numeric.mat','dataset_numeric_4');
firstRow = firstRow + len;
data_for_sample = dataset_numeric_4(ismember(dataset_numeric_4(:, 1), sampleIDs_10000), :);
len = size(data_for_sample, 1);
sample_10000(firstRow : firstRow + len - 1, :) = data_for_sample;
clearvars dataset_numeric_4
disp(4);
load('train_numeric.mat','dataset_numeric_5');
firstRow = firstRow + len;
data_for_sample = dataset_numeric_5(ismember(dataset_numeric_5(:, 1), sampleIDs_10000), :);
len = size(data_for_sample, 1);
sample_10000(firstRow : firstRow + len - 1, :) = data_for_sample;
clearvars dataset_numeric_5
disp(5);
load('train_numeric.mat','dataset_numeric_6');
firstRow = firstRow + len;
data_for_sample = dataset_numeric_6(ismember(dataset_numeric_6(:, 1), sampleIDs_10000), :);
len = size(data_for_sample, 1);
sample_10000(firstRow : firstRow + len - 1, :) = data_for_sample;
clearvars dataset_numeric_6
disp(6);
% Save variables
save('anomaly_numeric.mat', 'sampleIDs_10000', '-append');
save('anomaly_numeric.mat', 'sample_10000', '-append');

toc           % Unmeasured, only 2-3 minutes on Eszter's computer.