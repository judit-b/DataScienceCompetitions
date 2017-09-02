%% Calculate summary statistics

tic

load('dataset.mat', 'dataset_matrix');
load('dataset.mat', 'catToNumber');

% Calculate and store mean, standard deviation, and the three quartiles of 
% the features and store them in a matrix
num_features = size(dataset_matrix, 2) - 2;
statistics_all = zeros(6, num_features + 1);     % target + all features
% First row: id of feature (132 is the target value)
statistics_all(1, 1) = 132;
statistics_all(1, 2:end) = 2 : num_features;
% Row 2: mean, row 3: std, row 4: 1st quartile, row 5: median,
% row 6: 3rd quartile
statistics_all(2, 1) = mean(dataset_matrix(:, 132));
statistics_all(3, 1) = std(dataset_matrix(:, 132));
statistics_all(4 : 6, 1) = quantile(dataset_matrix(:, 132) , [0.25, 0.5, 0.75], 1);
statistics_all(2, 2 : end) = mean(dataset_matrix(:, 2 : end - 1));
statistics_all(3, 2 : end) = std(dataset_matrix(:, 2 : end - 1));
statistics_all(4 : 6, 2 : end) = quantile(dataset_matrix(:, 2 : end - 1), [0.25, 0.5, 0.75], 1);

save('explore_statistics.mat', 'statistics_all');
clearvars statistics_all;

% Calculate the correlation coefficients for the features + target
correlation_coeffs = corrcoef(dataset_matrix(:, 2 : end));

save('explore_statistics.mat', 'correlation_coeffs', '-append');

toc    %