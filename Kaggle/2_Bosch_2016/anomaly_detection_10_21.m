%% Anomaly detection - PART 10 - Imputation of missing data using PCA for each cluster
%% NOT USED

rng(1234);
tic
load('anomaly_clusters_with_rel_feats_withoutfreq.mat', 'all_clusters_relev_feats_1_50');
all_train_clusters_for_anomaly_1 = cell(50, 1);

for i = 1 : 50
    disp(i);
    dataset = all_clusters_relev_feats_1_50{i, 1};
    [coeff, score, latent, tsquared, explained, mu] = pca(dataset(:, 2:end-1), 'algorithm', 'als');
    dataset(:, 2:end-1) = real(score) * real(coeff)' + repmat(mu, size(dataset, 1), 1);
    all_train_clusters_for_anomaly_1{i, 1} = dataset;
    clearvars dataset coeff score latent tsquared explained mu;
end;

save('anomaly_imputed_clusters_withoutfreq.mat', 'all_train_clusters_for_anomaly_1');
clearvars all_clusters_relev_feats_1_50 all_train_clusters_for_anomaly_1

load('anomaly_clusters_with_rel_feats_withoutfreq.mat', 'all_clusters_relev_feats_51_100');
all_train_clusters_for_anomaly_2 = cell(100, 1);

for i = 51 : 100
    disp(i);
    dataset = all_clusters_relev_feats_51_100{i, 1};
    [coeff, score, latent, tsquared, explained, mu] = pca(dataset(:, 2:end-1), 'algorithm', 'als');
    dataset(:, 2:end-1) = real(score) * real(coeff)' + repmat(mu, size(dataset, 1), 1);
    all_train_clusters_for_anomaly_2{i, 1} = dataset;
    clearvars dataset coeff score latent tsquared explained mu;
end;

save('anomaly_imputed_clusters_withoutfreq.mat', 'all_train_clusters_for_anomaly_2', '-append');

toc      % Elapsed time is 