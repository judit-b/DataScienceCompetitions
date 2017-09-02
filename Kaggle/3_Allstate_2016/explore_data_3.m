%% Exploratory data analysis

tic 

load('dataset.mat', 'dataset_matrix');

%% Create boxplots for the target (alone and vs. each features)

% Boxplot of the target
bp(1) = figure;
boxplot(dataset_matrix(:, 132));

% Boxplots for categorical features
for i = 2 : 117
    bp(i) = figure;
    boxplot(dataset_matrix(:, 132), dataset_matrix(:, i));
end;

% Boxplots for numeric features
for i = 118 : 131
    groups = dataset_matrix(:, i) > 0.2;
    groups = groups + (dataset_matrix(:, i) > 0.4);
    groups = groups + (dataset_matrix(:, i) > 0.6);
    groups = groups + (dataset_matrix(:, i) > 0.8);
    bp(i) = figure;
    boxplot(dataset_matrix(:, 132), groups);
end;
savefig(bp, 'explore_boxplots.fig');

toc        % Elapsed time is 756.004276 seconds. (Judit)