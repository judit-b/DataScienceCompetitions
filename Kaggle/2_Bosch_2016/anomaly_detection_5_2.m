%% Anomaly detection - PART 5.2 - Find the best k-medoids for 100 clusters using rare features
% first seed : 1234 (outputs: idx, C, sumd, D, midx, info, Sum) - unsaved
% results, not better than with the second seed
% second seed: 12345 (outputs: idx2, C2, sumd2, D2, midx2, info2, Sum2)

tic
rng(12345);

% Remove the frequent features
load('anomaly_numeric.mat', 'ratio_feats_occur_insample');
frequent_features = ratio_feats_occur_insample > 0.85;
save('anomaly_numeric.mat', 'frequent_features', '-append');

load('anomaly_numeric.mat', 'sample_01features_10000');
% In the following representation of the sample data, there is 1 in those
% columns, which includes data and which are nonfrequent features. (So 0
% means that the feature is either frequent or NaN in the given
% observation.)
dataset = (sample_01features_10000 - frequent_features > 0);
dataset = double(dataset);

% K-medoids with 'hamming' distance which is useful for binaries
% Make 10 repetitions 10 times
num_steps = 10;    
idx = cell(num_steps, 1);
C = cell(num_steps, 1);
sumd = cell(num_steps, 1);
D = cell(num_steps, 1);
midx = cell(num_steps, 1);
info = cell(num_steps, 1);
Sum = zeros(num_steps, 1);

% Use cityblock distance (L1 metric)
for i = 1 : num_steps
    disp(i);
    k = 100;     % number of clusters
    [idx_i,C_i,sumd_i,D_i,midx_i,info_i] = kmedoids(dataset, k, 'Distance', 'hamming', 'Replicates', 10);
    idx{i} = idx_i;
    C{i} = C_i;
    sumd{i} = sumd_i;
    D{i} = D_i;
    midx{i} = midx_i;
    info{i} = info_i;
    Sum(i) = sum(sumd{i});
end;

% save('anomaly_clusters_withoutfreqfeats.mat', 'idx', '-append');
% save('anomaly_clusters_withoutfreqfeats.mat', 'C' , '-append');
% save('anomaly_clusters_withoutfreqfeats.mat', 'sumd', '-append');
% save('anomaly_clusters_withoutfreqfeats.mat', 'D', '-append');
% save('anomaly_clusters_withoutfreqfeats.mat', 'midx' , '-append');
% save('anomaly_clusters_withoutfreqfeats.mat', 'info', '-append');
% save('anomaly_clusters_withoutfreqfeats.mat', 'Sum', '-append');

idx2 = idx;
C2 = C;
sumd2 = sumd;
D2 = D;
midx2 = midx;
info2 = info;
Sum2 = Sum;

save('anomaly_clusters_withoutfreqfeats.mat', 'idx2', '-append');
save('anomaly_clusters_withoutfreqfeats.mat', 'C2' , '-append');
save('anomaly_clusters_withoutfreqfeats.mat', 'sumd2', '-append');
save('anomaly_clusters_withoutfreqfeats.mat', 'D2', '-append');
save('anomaly_clusters_withoutfreqfeats.mat', 'midx2' , '-append');
save('anomaly_clusters_withoutfreqfeats.mat', 'info2', '-append');
save('anomaly_clusters_withoutfreqfeats.mat', 'Sum2', '-append');

toc