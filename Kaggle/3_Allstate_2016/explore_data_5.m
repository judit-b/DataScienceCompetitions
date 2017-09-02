%% Calculate correlation coefficients for categorical features

tic

load('dataset.mat', 'dataset_matrix');

cat_correlation_coeffs = corrcoef(dataset_matrix(:, 2 : 117));

save('explore_cat_corr.mat', 'cat_correlation_coeffs');

toc