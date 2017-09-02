%% For anomaly detection - PART 1 - CREATE TRAINING, VALIDATION AND TEST SET
% Create a new training, validation and test set for anomaly detection.
% The training set contains 60% of negative examples (Response == 0),
% the validation set contains 20% of negative examples and 50% of positive
% ones,
% the test set contains 20% of negative examples and 50% of positive ones.
tic

rng(1234);
% Load matrix of all IDs and Response values
load('train_test_sample_sets.mat', 'train_numeric_id_resp');
all_id_resp = train_numeric_id_resp;

negative_id_resp = all_id_resp(all_id_resp(:, 2) == 0, :);
positive_id_resp = all_id_resp(all_id_resp(:, 2) == 1, :);

num_negatives = size(negative_id_resp, 1);
[trainInd,valInd,testInd] = dividerand(num_negatives, 0.6, 0.2, 0.2);
train_id_resp = negative_id_resp(trainInd, :);
val_neg_id_resp = negative_id_resp(valInd, :);
test_neg_id_resp = negative_id_resp(testInd, :);

num_positives = size(positive_id_resp, 1);
part = cvpartition(num_positives,'holdout',0.5);
istrain = training(part);
istest = test(part);
val_pos_id_resp = positive_id_resp(istrain, :);
test_pos_id_resp = positive_id_resp(istest, :);

num_validation = size(val_neg_id_resp, 1) + size(val_pos_id_resp, 1);
validation_id_resp = zeros(num_validation, 2);
validation_id_resp(1 : size(val_neg_id_resp, 1), :) = val_neg_id_resp(:, :);
nextrow = size(val_neg_id_resp, 1) + 1;
validation_id_resp(nextrow : end, :) = val_pos_id_resp(:, :);

num_test = size(test_neg_id_resp, 1) + size(test_pos_id_resp, 1);
test_id_resp = zeros(num_test, 2);
test_id_resp(1 : size(test_neg_id_resp, 1), :) = test_neg_id_resp(:, :);
nextrow = size(test_neg_id_resp, 1) + 1;
test_id_resp(nextrow : end, :) = test_pos_id_resp(:, :);

save('anomaly_numeric.mat', 'train_id_resp');
save('anomaly_numeric.mat', 'validation_id_resp', '-append');
save('anomaly_numeric.mat', 'test_id_resp', '-append');

toc           % Elapsed time is 0.639329 seconds. (On Eszter's computer.)