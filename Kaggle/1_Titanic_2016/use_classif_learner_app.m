%% Classification
% 1. Train different classifiction algorithms (created by the
% classification learning app).
% 2. Find the best weighted average of the classification methods.
% 3. Make predictions and submission file.

tic
rng(1);

load('train_valid_set.mat', 'train_set');
load('train_valid_set.mat', 'target_train');
trainingData = zeros(size(train_set, 1), size(train_set, 2) + 1);
trainingData(:, 1:10) = train_set;
trainingData(:, 11) = target_train;

% Train
num_classifiers = 23;
trainedClassifier = cell(num_classifiers, 1);   % cell array of classifiers
validationAccuracy = zeros(num_classifiers, 1);   % vector of accuracies using 5-fold CV
[trainedClassifier{1, 1}, validationAccuracy(1, 1)] = trainClassifier_1_1(trainingData);
[trainedClassifier{2, 1}, validationAccuracy(2, 1)] = trainClassifier_1_2(trainingData);
[trainedClassifier{3, 1}, validationAccuracy(3, 1)] = trainClassifier_1_3(trainingData);
[trainedClassifier{4, 1}, validationAccuracy(4, 1)] = trainClassifier_1_4(trainingData);
[trainedClassifier{5, 1}, validationAccuracy(5, 1)] = trainClassifier_1_5(trainingData);
[trainedClassifier{6, 1}, validationAccuracy(6, 1)] = trainClassifier_1_6(trainingData);
[trainedClassifier{7, 1}, validationAccuracy(7, 1)] = trainClassifier_1_7(trainingData);
[trainedClassifier{8, 1}, validationAccuracy(8, 1)] = trainClassifier_1_8(trainingData);
[trainedClassifier{9, 1}, validationAccuracy(9, 1)] = trainClassifier_1_9(trainingData);
[trainedClassifier{10, 1}, validationAccuracy(10, 1)] = trainClassifier_1_10(trainingData);
[trainedClassifier{11, 1}, validationAccuracy(11, 1)] = trainClassifier_1_11(trainingData);
[trainedClassifier{12, 1}, validationAccuracy(12, 1)] = trainClassifier_1_12(trainingData);
[trainedClassifier{13, 1}, validationAccuracy(13, 1)] = trainClassifier_1_13(trainingData);
[trainedClassifier{14, 1}, validationAccuracy(14, 1)] = trainClassifier_1_14(trainingData);
[trainedClassifier{15, 1}, validationAccuracy(15, 1)] = trainClassifier_1_15(trainingData);
[trainedClassifier{16, 1}, validationAccuracy(16, 1)] = trainClassifier_1_16(trainingData);
[trainedClassifier{17, 1}, validationAccuracy(17, 1)] = trainClassifier_1_17(trainingData);
[trainedClassifier{18, 1}, validationAccuracy(18, 1)] = trainClassifier_1_18(trainingData);
[trainedClassifier{19, 1}, validationAccuracy(19, 1)] = trainClassifier_1_19(trainingData);
[trainedClassifier{20, 1}, validationAccuracy(20, 1)] = trainClassifier_1_20(trainingData);
[trainedClassifier{21, 1}, validationAccuracy(21, 1)] = trainClassifier_1_21(trainingData);
[trainedClassifier{22, 1}, validationAccuracy(22, 1)] = trainClassifier_1_22(trainingData);
[trainedClassifier{23, 1}, validationAccuracy(23, 1)] = trainClassifier_1_23(trainingData);

% Make predictions
load('train_valid_set.mat', 'valid_set');
load('train_valid_set.mat', 'target_valid');
num_valid = size(valid_set, 1);
valid_preds = zeros(num_valid, num_classifiers);
for i = 1 : num_classifiers
    valid_preds(:, i) = trainedClassifier{i, 1}.predictFcn(valid_set(:, 2:10));
end;

% Find the best weighted average of predictions
best_weights = ones(num_classifiers, 1) / num_classifiers;
best_threshold = 0.5;
aver_preds = valid_preds * best_weights;
new_preds = aver_preds > best_threshold;
best_accuracy = sum(new_preds == target_valid) / num_valid;

thresholds = [0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 .7 0.75 0.8 0.85 0.9];
for i = 1 : 1000000
    disp(i);
    weights = rand(num_classifiers, 1);
    weights = weights / sum(weights);
    aver_preds = valid_preds * weights;
    for threshold = thresholds
        new_preds = aver_preds > threshold;
        new_accuracy = sum(new_preds == target_valid) / num_valid;
        if new_accuracy > best_accuracy
            best_accuracy = new_accuracy;
            best_weights = weights;
            best_threshold = threshold;
        end;
    end;
end;

% Make predictions for submission and calculate their best weighted average
load('dataset_matrices.mat', 'test_matrix');
submit_preds = zeros(size(test_matrix, 1), num_classifiers);
for i = 1 : num_classifiers
    submit_preds(:, i) = trainedClassifier{i, 1}.predictFcn(test_matrix(:, 2 : 10));
end;
submit_aver_preds = submit_preds * best_weights;
submit_prediction = submit_aver_preds > best_threshold;

% Create submission file
PassengerId = test_matrix(:, 1);
Survived = submit_prediction;
submit_table = table(PassengerId, Survived);
writetable(submit_table, 'submit_matlabclasslearnerapp.csv');

toc

# Public score: 0.78468