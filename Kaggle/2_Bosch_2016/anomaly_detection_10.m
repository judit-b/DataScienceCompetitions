%% Anomaly detection - PART 10 - Imputation of missing data using PCA for each cluster

rng(1234);
tic
load('anomaly_clusters_with_rel_feats_withoutfreq.mat', 'all_clusters_relev_feats');
all_train_clusters_for_anomaly = cell(40, 1);

for i = 1 : 100
    disp(i);
    dataset = all_clusters_relev_feats{i, 1};
    [coeff, score, latent, tsquared, explained, mu] = pca(dataset(:, 2:end-1), 'algorithm', 'als');
    dataset(:, 2:end-1) = real(score) * real(coeff)' + repmat(mu, size(dataset, 1), 1);
    all_train_clusters_for_anomaly{i, 1} = dataset;
    clearvars dataset coeff score latent tsquared explained mu;
end;

save('anomaly_balanced_clusters_withoutfreq.mat', 'all_train_clusters_for_anomaly');

toc      % Elapsed time is 