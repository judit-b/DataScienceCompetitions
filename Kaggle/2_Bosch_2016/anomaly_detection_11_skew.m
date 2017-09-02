%% Check distribution symmetry
% For each clusters:
% 1. Check the symmetry of the distribution of each features
% 2. In the case of asymmetry try to improve symmetry by applying some 
%    feature transformation.

tic
rng(1234);
% Use the dataset before imputation of missing data
load('anomaly_clusters_with_rel_feats_withoutfreq.mat', 'imputed_clusters_for_anomaly_1');
load('anomaly_clusters_with_rel_feats_withoutfreq.mat', 'imputed_clusters_for_anomaly_2')
num_clusters = 100;
best_feature_transformations = cell(100, 1);
all_sym_clusters_1 = cell(50, 1);
all_sym_clusters_2 = cell(100, 1);

for i = 1 : 100     % for each cluster
    if i < 51
        dataset = imputed_clusters_for_anomaly_1{i, 1};   % training data for the ith cluster
    else
        dataset = imputed_clusters_for_anomaly_2{i, 1};
    end;
    num_feats = size(dataset(:, 2:end-1), 2);     % column ID and column Response don't matter
    skewness_measures = zeros(8, num_feats);    % each row will be the skewess measure of a transformation of the features
    skewness_measures(1, :) = skewness(dataset(:, 2:end-1), 0);     % vector of skewness of the original dataset (0 means symmetry)
    skewness_measures(2, :) = skewness(dataset(:, 2:end-1) .* dataset(:, 2:end-1), 0);    % skewness of the squares
    skewness_measures(3, :) = skewness(dataset(:, 2:end-1) .* dataset(:, 2:end-1) .* dataset(:, 2:end-1), 0);
    skewness_measures(4, :) = skewness(nthroot(dataset(:, 2:end-1), 3), 0);    % skewness of the 3rd roots
    skewness_measures(5, :) = skewness(nthroot(dataset(:, 2:end-1), 5), 0);
    skewness_measures(6, :) = skewness(nthroot(dataset(:, 2:end-1), 7), 0);
    skewness_measures(7, :) = skewness(exp(dataset(:, 2:end-1)), 0);
    skewness_measures(8, :) = skewness(log(dataset(:, 2:end-1) + min(dataset(:, 2:end-1)) + 1), 0);
    [best_skewness_measures, best_transformations] = min(abs(skewness_measures));
    best_feature_transformations{i, 1} = best_transformations;
    
    if i < 51
        all_sym_clusters_1{i, 1} = TransformToSymmetricSample(dataset, best_transformations);
    else
        all_sym_clusters_2{i, 1} = TransformToSymmetricSample(dataset, best_transformations);
    end;
end;

save('anomaly_clusters_with_rel_feats_withoutfreq.mat', 'best_feature_transformations', '-append');
save('anomaly_sym_clusters.mat', 'all_sym_clusters_1');
save('anomaly_sym_clusters.mat', 'all_sym_clusters_2', '-append');

toc          % Elapsed time is 168.505659 seconds.