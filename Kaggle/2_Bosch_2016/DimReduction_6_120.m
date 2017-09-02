%% Balance dataset
rng(1234);
tic
load('clusters_with_rel_feats_120.mat', 'final_clusters');
all_balanced_clusters = cell(120, 1);

for i = 1 : 120
    dataset = final_clusters{i, 1};
    num_positives = sum(dataset(:, end));
    new_dataset = zeros(10 * num_positives, size(dataset, 2));
    num_medoids = 5 * num_positives;
    all_negatives = dataset(dataset(:, end) == 0, :);
    [idx,C,sumd,D,midx,info] = kmedoids(all_negatives(:, 2 : end - 1), num_medoids,...
        'Replicates', 15);
    new_dataset(1:num_positives, :) = dataset(dataset(:, end) == 1, :);
    new_dataset(num_positives+1 : 2*num_positives, :)) = dataset(dataset(:, end) == 1, :);
    new_dataset(2*num_positives+1 : 3*num_positives, :)) = dataset(dataset(:, end) == 1, :);
    new_dataset(3*num_positives+1 : 4*num_positives, :)) = dataset(dataset(:, end) == 1, :);
    new_dataset(4*num_positives+1 : 5*num_positives, :)) = dataset(dataset(:, end) == 1, :);
    new_dataset(5*num_positives + 1 : end, 1) = all_negatives(midx, 1);
    new_dataset(5*num_positives + 1 : end, 2 : end - 1) = C;
    all_balanced_clusters{i, 1} = new_dataset;
end;
toc      % Elapsed time is 27210.894260 seconds.

save('anomaly_balanced_clusters_120.mat', 'all_balanced_clusters');