%% My third method for this project
tic
% Create (-1)-(+1) representation of the training data ((-1) means NaN)

disp(1);
load('train_numeric.mat', 'dataset_numeric_1');
dataset_nanrepr_1 = int32(zeros(size(dataset_numeric_1)));
dataset_nanrepr_1 = 1 - 2 * int32(isnan(dataset_numeric_1));
dataset_nanrepr_1(:, 1) = int32(dataset_numeric_1(:, 1));
save('third_dataset_nanrepr.mat', 'dataset_nanrepr_1');
clearvars dataset_numeric_1 dataset_nanrepr_1;

disp(2);
load('train_numeric.mat', 'dataset_numeric_2');
dataset_nanrepr_2 = int32(zeros(size(dataset_numeric_2)));
dataset_nanrepr_2 = 1 - 2 * int32(isnan(dataset_numeric_2));
dataset_nanrepr_2(:, 1) = int32(dataset_numeric_2(:, 1));
save('third_dataset_nanrepr.mat', 'dataset_nanrepr_2', '-append');
clearvars dataset_numeric_2 dataset_nanrepr_2;

disp(3);
load('train_numeric.mat', 'dataset_numeric_3');
dataset_nanrepr_3 = int32(zeros(size(dataset_numeric_3)));
dataset_nanrepr_3 = 1 - 2 * int32(isnan(dataset_numeric_3));
dataset_nanrepr_3(:, 1) = int32(dataset_numeric_3(:, 1));
save('third_dataset_nanrepr.mat', 'dataset_nanrepr_3', '-append');
clearvars dataset_numeric_3 dataset_nanrepr_3;

disp(4);
load('train_numeric.mat', 'dataset_numeric_4');
dataset_nanrepr_4 = int32(zeros(size(dataset_numeric_4)));
dataset_nanrepr_4 = 1 - 2 * int32(isnan(dataset_numeric_4));
dataset_nanrepr_4(:, 1) = int32(dataset_numeric_4(:, 1));
save('third_dataset_nanrepr.mat', 'dataset_nanrepr_4', '-append');
clearvars dataset_numeric_4 dataset_nanrepr_4;

disp(5);
load('train_numeric.mat', 'dataset_numeric_5');
dataset_nanrepr_5 = int32(zeros(size(dataset_numeric_5)));
dataset_nanrepr_5 = 1 - 2 * int32(isnan(dataset_numeric_5));
dataset_nanrepr_5(:, 1) = int32(dataset_numeric_5(:, 1));
save('third_dataset_nanrepr.mat', 'dataset_nanrepr_5', '-append');
clearvars dataset_numeric_5 dataset_nanrepr_5;

disp(6);
load('train_numeric.mat', 'dataset_numeric_6');
dataset_nanrepr_6 = int32(zeros(size(dataset_numeric_6)));
dataset_nanrepr_6 = 1 - 2 * int32(isnan(dataset_numeric_6));
dataset_nanrepr_6(:, 1) = int32(dataset_numeric_6(:, 1));
save('third_dataset_nanrepr.mat', 'dataset_nanrepr_6', '-append');
clearvars dataset_numeric_6 dataset_nanrepr_6;

toc      % Elapsed time is 70.810978 seconds.