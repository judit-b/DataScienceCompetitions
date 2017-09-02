%% Third method 2

tic

load('train_test_sample_sets.mat', 'id_resp_train');

load('third_dataset_nanrepr.mat', 'dataset_nanrepr_1');
train_nanrepr_1 = dataset_nanrepr_1(ismember(dataset_nanrepr_1(:, 1), id_resp_train(:, 1)) == 1, :);
save('third_dataset_nanrepr.mat', 'train_nanrepr_1', '-append');
clearvars train_nanrepr_1;

load('third_dataset_nanrepr.mat', 'dataset_nanrepr_2');
train_nanrepr_2 = dataset_nanrepr_2(ismember(dataset_nanrepr_2(:, 1), id_resp_train(:, 1)) == 1, :);
save('third_dataset_nanrepr.mat', 'train_nanrepr_2', '-append');
clearvars train_nanrepr_2;

load('third_dataset_nanrepr.mat', 'dataset_nanrepr_3');
train_nanrepr_3 = dataset_nanrepr_3(ismember(dataset_nanrepr_3(:, 1), id_resp_train(:, 1)) == 1, :);
save('third_dataset_nanrepr.mat', 'train_nanrepr_3', '-append');
clearvars train_nanrepr_3;

load('third_dataset_nanrepr.mat', 'dataset_nanrepr_4');
train_nanrepr_4 = dataset_nanrepr_4(ismember(dataset_nanrepr_4(:, 1), id_resp_train(:, 1)) == 1, :);
save('third_dataset_nanrepr.mat', 'train_nanrepr_4', '-append');
clearvars train_nanrepr_4;

load('third_dataset_nanrepr.mat', 'dataset_nanrepr_5');
train_nanrepr_5 = dataset_nanrepr_5(ismember(dataset_nanrepr_5(:, 1), id_resp_train(:, 1)) == 1, :);
save('third_dataset_nanrepr.mat', 'train_nanrepr_5', '-append');
clearvars train_nanrepr_5;

load('third_dataset_nanrepr.mat', 'dataset_nanrepr_6');
train_nanrepr_6 = dataset_nanrepr_6(ismember(dataset_nanrepr_6(:, 1), id_resp_train(:, 1)) == 1, :);
save('third_dataset_nanrepr.mat', 'train_nanrepr_6', '-append');
clearvars train_nanrepr_6;

load('valid_and_test_set.mat', 'id_resp_validset');

load('third_dataset_nanrepr.mat', 'dataset_nanrepr_1');
valid_nanrepr_1 = dataset_nanrepr_1(ismember(dataset_nanrepr_1(:, 1), id_resp_validset(:, 1)) == 1, :);
save('third_dataset_nanrepr.mat', 'valid_nanrepr_1', '-append');
clearvars valid_nanrepr_1;

load('third_dataset_nanrepr.mat', 'dataset_nanrepr_2');
valid_nanrepr_2 = dataset_nanrepr_2(ismember(dataset_nanrepr_2(:, 1), id_resp_validset(:, 1)) == 1, :);
save('third_dataset_nanrepr.mat', 'valid_nanrepr_2', '-append');
clearvars valid_nanrepr_2;

load('third_dataset_nanrepr.mat', 'dataset_nanrepr_3');
valid_nanrepr_3 = dataset_nanrepr_3(ismember(dataset_nanrepr_3(:, 1), id_resp_validset(:, 1)) == 1, :);
save('third_dataset_nanrepr.mat', 'valid_nanrepr_3', '-append');
clearvars valid_nanrepr_3;

load('third_dataset_nanrepr.mat', 'dataset_nanrepr_4');
valid_nanrepr_4 = dataset_nanrepr_4(ismember(dataset_nanrepr_4(:, 1), id_resp_validset(:, 1)) == 1, :);
save('third_dataset_nanrepr.mat', 'valid_nanrepr_4', '-append');
clearvars valid_nanrepr_4;

load('third_dataset_nanrepr.mat', 'dataset_nanrepr_5');
valid_nanrepr_5 = dataset_nanrepr_5(ismember(dataset_nanrepr_5(:, 1), id_resp_validset(:, 1)) == 1, :);
save('third_dataset_nanrepr.mat', 'valid_nanrepr_5', '-append');
clearvars valid_nanrepr_5;

load('third_dataset_nanrepr.mat', 'dataset_nanrepr_6');
valid_nanrepr_6 = dataset_nanrepr_6(ismember(dataset_nanrepr_6(:, 1), id_resp_validset(:, 1)) == 1, :);
save('third_dataset_nanrepr.mat', 'valid_nanrepr_6', '-append');
clearvars valid_nanrepr_6;

load('valid_and_test_set.mat', 'id_resp_testset');

load('third_dataset_nanrepr.mat', 'dataset_nanrepr_1');
test_nanrepr_1 = dataset_nanrepr_1(ismember(dataset_nanrepr_1(:, 1), id_resp_testset(:, 1)) == 1, :);
save('third_dataset_nanrepr.mat', 'test_nanrepr_1', '-append');
clearvars test_nanrepr_1;

load('third_dataset_nanrepr.mat', 'dataset_nanrepr_2');
test_nanrepr_2 = dataset_nanrepr_2(ismember(dataset_nanrepr_2(:, 1), id_resp_testset(:, 1)) == 1, :);
save('third_dataset_nanrepr.mat', 'test_nanrepr_2', '-append');
clearvars test_nanrepr_2;

load('third_dataset_nanrepr.mat', 'dataset_nanrepr_3');
test_nanrepr_3 = dataset_nanrepr_3(ismember(dataset_nanrepr_3(:, 1), id_resp_testset(:, 1)) == 1, :);
save('third_dataset_nanrepr.mat', 'test_nanrepr_3', '-append');
clearvars test_nanrepr_3;

load('third_dataset_nanrepr.mat', 'dataset_nanrepr_4');
test_nanrepr_4 = dataset_nanrepr_4(ismember(dataset_nanrepr_4(:, 1), id_resp_testset(:, 1)) == 1, :);
save('third_dataset_nanrepr.mat', 'test_nanrepr_4', '-append');
clearvars test_nanrepr_4;

load('third_dataset_nanrepr.mat', 'dataset_nanrepr_5');
test_nanrepr_5 = dataset_nanrepr_5(ismember(dataset_nanrepr_5(:, 1), id_resp_testset(:, 1)) == 1, :);
save('third_dataset_nanrepr.mat', 'test_nanrepr_5', '-append');
clearvars test_nanrepr_5;

load('third_dataset_nanrepr.mat', 'dataset_nanrepr_6');
test_nanrepr_6 = dataset_nanrepr_6(ismember(dataset_nanrepr_6(:, 1), id_resp_testset(:, 1)) == 1, :);
save('third_dataset_nanrepr.mat', 'test_nanrepr_6', '-append');
clearvars test_nanrepr_6;

toc      % Elapsed time is 70.906698 seconds.