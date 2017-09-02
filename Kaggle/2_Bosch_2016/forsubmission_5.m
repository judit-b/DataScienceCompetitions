%% Imputation of missing data
rng(1234);
tic

load('submit_numeric.mat', 'new_cluster_1_5');
submit_clusters_for_class_1_5 = cell(5, 1);
for i = 1 : 5
    dataset = new_cluster_1_5{i, 1};
    [coeff, score, latent, tsquared, explained, mu] = pca(dataset(:, 2:end-1), 'algorithm', 'als');
    dataset(:, 2:end-1) = real(score) * real(coeff)' + repmat(mu, size(dataset, 1), 1);
    submit_clusters_for_class_1_5{i, 1} = dataset;
    clearvars dataset coeff score latent tsquared explained mu;
end;     
save('submit_final_data_for_class.mat', 'submit_clusters_for_class_1_5');
clearvars submit_clusters_for_class_1_5;

load('submit_numeric.mat', 'new_cluster_6_10');
submit_clusters_for_class_6_10 = cell(5, 1);
for i = 1 : 5
    dataset = new_cluster_6_10{i, 1};
    [coeff, score, latent, tsquared, explained, mu] = pca(dataset(:, 2:end-1), 'algorithm', 'als');
    dataset(:, 2:end-1) = real(score) * real(coeff)' + repmat(mu, size(dataset, 1), 1);
    submit_clusters_for_class_6_10{i, 1} = dataset;
    clearvars dataset coeff score latent tsquared explained mu;
end;     
save('submit_final_data_for_class.mat', 'submit_clusters_for_class_6_10', '-append');
clearvars submit_clusters_for_class_6_10;

load('submit_numeric.mat', 'new_cluster_11_15');
submit_clusters_for_class_11_15 = cell(5, 1);
for i = 1 : 5
    dataset = new_cluster_11_15{i, 1};
    [coeff, score, latent, tsquared, explained, mu] = pca(dataset(:, 2:end-1), 'algorithm', 'als');
    dataset(:, 2:end-1) = real(score) * real(coeff)' + repmat(mu, size(dataset, 1), 1);
    submit_clusters_for_class_11_15{i, 1} = dataset;
    clearvars dataset coeff score latent tsquared explained mu;
end;     
save('submit_final_data_for_class.mat', 'submit_clusters_for_class_11_15', '-append');
clearvars submit_clusters_for_class_11_15;

load('submit_numeric.mat', 'new_cluster_16_20');
submit_clusters_for_class_16_20 = cell(5, 1);
for i = 1 : 5
    dataset = new_cluster_16_20{i, 1};
    [coeff, score, latent, tsquared, explained, mu] = pca(dataset(:, 2:end-1), 'algorithm', 'als');
    dataset(:, 2:end-1) = real(score) * real(coeff)' + repmat(mu, size(dataset, 1), 1);
    submit_clusters_for_class_16_20{i, 1} = dataset;
    clearvars dataset coeff score latent tsquared explained mu;
end;     
save('submit_final_data_for_class.mat', 'submit_clusters_for_class_16_20', '-append');
clearvars submit_clusters_for_class_16_20;

load('submit_numeric.mat', 'new_cluster_21_25');
submit_clusters_for_class_21_25 = cell(5, 1);
for i = 1 : 5
    dataset = new_cluster_21_25{i, 1};
    [coeff, score, latent, tsquared, explained, mu] = pca(dataset(:, 2:end-1), 'algorithm', 'als');
    dataset(:, 2:end-1) = real(score) * real(coeff)' + repmat(mu, size(dataset, 1), 1);
    submit_clusters_for_class_21_25{i, 1} = dataset;
    clearvars dataset coeff score latent tsquared explained mu;
end;     
save('submit_final_data_for_class.mat', 'submit_clusters_for_class_21_25', '-append');
clearvars submit_clusters_for_class_21_25;

load('submit_numeric.mat', 'new_cluster_26_30');
submit_clusters_for_class_26_30 = cell(5, 1);
for i = 1 : 5
    dataset = new_cluster_26_30{i, 1};
    [coeff, score, latent, tsquared, explained, mu] = pca(dataset(:, 2:end-1), 'algorithm', 'als');
    dataset(:, 2:end-1) = real(score) * real(coeff)' + repmat(mu, size(dataset, 1), 1);
    submit_clusters_for_class_26_30{i, 1} = dataset;
    clearvars dataset coeff score latent tsquared explained mu;
end;     
save('submit_final_data_for_class.mat', 'submit_clusters_for_class_26_30', '-append');
clearvars submit_clusters_for_class_26_30;

load('submit_numeric.mat', 'new_cluster_31_35');
submit_clusters_for_class_31_35 = cell(5, 1);
for i = 1 : 5
    dataset = new_cluster_31_35{i, 1};
    [coeff, score, latent, tsquared, explained, mu] = pca(dataset(:, 2:end-1), 'algorithm', 'als');
    dataset(:, 2:end-1) = real(score) * real(coeff)' + repmat(mu, size(dataset, 1), 1);
    submit_clusters_for_class_31_35{i, 1} = dataset;
    clearvars dataset coeff score latent tsquared explained mu;
end;     
save('submit_final_data_for_class.mat', 'submit_clusters_for_class_31_35', '-append');
clearvars submit_clusters_for_class_31_35;

load('submit_numeric.mat', 'new_cluster_36_40');
submit_clusters_for_class_36_40 = cell(5, 1);
for i = 1 : 5
    dataset = new_cluster_36_40{i, 1};
    [coeff, score, latent, tsquared, explained, mu] = pca(dataset(:, 2:end-1), 'algorithm', 'als');
    dataset(:, 2:end-1) = real(score) * real(coeff)' + repmat(mu, size(dataset, 1), 1);
    submit_clusters_for_class_36_40{i, 1} = dataset;
    clearvars dataset coeff score latent tsquared explained mu;
end;     
save('submit_final_data_for_class.mat', 'submit_clusters_for_class_36_40', '-append');
clearvars submit_clusters_for_class_36_40;

toc 