%% Anomaly detection - PART 5 - Cluster analysis of sample_01features_10000

tic

rng(1234);
load('anomaly_numeric.mat', 'sample_01features_10000');
dataset = sample_01features_10000;
num_steps = 12;
step_size = 10;

% K-medoids with 'hamming' distance which is useful for binaries
[idx_ham, C_ham, sumd_ham, D_ham, midx_ham, info_ham, Sum_ham] = CalculateKMedoidClusters(dataset, num_steps, step_size, 'hamming', 10);

% K-medoids with 'cityblock' distance (L1 norm)
% [idx_L1, C_L1, sumd_L1, D_L1, midx_L1, info_L1, Sum_L1] = CalculateKMedoidClusters(dataset, num_steps, step_size, 'cityblock', 10);

% K-medoids with 'cosine' distance (L1 norm)
% [idx_cos, C_cos, sumd_cos, D_cos, Sum_cos] = CalculateKMedoidClusters(dataset, num_steps, step_size, 'cosine', 10);

x = 1 : num_steps;
x = x * step_size;
% plot(x, Sum_ham, x, Sum_L1 / 1000);
plot(x, Sum_ham);
title('Anomaly - Heterogeneity vs. Number of Clusters using k-medoid Clustering');
xlabel('Number of Clusters');
ylabel('Heterogeneity');
%legend('hamming', 'L1 norm (divided by 1000');

save('anomaly_kmedoids_clusters.mat', 'idx_ham');
save('anomaly_kmedoids_clusters.mat', 'C_ham' , '-append');
save('anomaly_kmedoids_clusters.mat', 'sumd_ham', '-append');
save('anomaly_kmedoids_clusters.mat', 'D_ham', '-append');
save('anomaly_kmedoids_clusters.mat', 'midx_ham' , '-append');
save('anomaly_kmedoids_clusters.mat', 'info_ham', '-append');
save('anomaly_kmedoids_clusters.mat', 'Sum_ham', '-append');

% save('anomaly_kmedoids_clusters.mat', 'idx_L1', '-append');
% save('anomaly_kmedoids_clusters.mat', 'C_L1' , '-append');
% save('anomaly_kmedoids_clusters.mat', 'sumd_L1', '-append');
% save('anomaly_kmedoids_clusters.mat', 'D_L1', '-append');
% save('anomaly_kmedoids_clusters.mat', 'midx_L1' , '-append');
% save('anomaly_kmedoids_clusters.mat', 'info_L1', '-append');
% save('anomaly_kmedoids_clusters.mat', 'Sum_L1', '-append');

save('anomaly_kmedoids_clusters.mat', 'num_steps', '-append');
save('anomaly_kmedoids_clusters.mat', 'step_size', '-append');
toc