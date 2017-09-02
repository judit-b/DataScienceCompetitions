%% Check distribution symmetry
% For each clusters:
% 1. Check the symmetry of the distribution of each features
% 2. In the case of asymmetry try to improve symmetry by applying some 
%    feature transformation.

% Use the dataset before imputation of missing data
load('anomaly_clusters_with_rel_feats_withoutfreq.mat', 'all_clusters_relev_feats_1_50');
num_clusters = 100;
best_feature_transformations = cell(50, 1);

for i = 1 : 1     % for each cluster
    dataset = all_clusters_relev_feats_1_50{i, 1}(:, 2:end-1);   % training data for the ith cluster
    num_feats = size(dataset, 2);     % column ID and column Response don't matter
    skewness_measures = zeros(8, num_feats);    % each row will be the skewess measure of a transformation of the features
    skewness_measures(1, :) = skewness(dataset, 0);     % vector of skewness of the original dataset (0 means symmetry)
    skewness_measures(2, :) = skewness(dataset .* dataset, 0);    % skewness of the squares
    skewness_measures(3, :) = skewness(dataset .* dataset .* dataset, 0);
    skewness_measures(4, :) = skewness(nthroot(dataset, 3), 0);    % skewness of the 3rd roots
    skewness_measures(5, :) = skewness(nthroot(dataset, 5), 0);
    skewness_measures(6, :) = skewness(nthroot(dataset, 7), 0);
    skewness_measures(7, :) = skewness(exp(dataset), 0);
    skewness_measures(8, :) = skewness(log(dataset + min(dataset) + 1), 0);
    [best_skewness_measures, best_transformations] = min(abs(skewness_measures));
    best_feature_transformations{i, 1} = best_transformations;
end;


        