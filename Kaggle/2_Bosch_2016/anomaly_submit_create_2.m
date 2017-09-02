%% Transform submit set for classification - PART 2
% Store cluster submit data
tic
load('anomaly_submit.mat', 'submitObsToCluster');
num_submit = 0;
for j = 1 : 6
    num_submit = num_submit + size(submitObsToCluster{j, 1}, 1);
end;
allSubmitObsToCluster = zeros(num_submit, 2);
nextrow = 1;
for j = 1 : 6
    lastrow = nextrow - 1 + size(submitObsToCluster{j, 1}, 1);
    allSubmitObsToCluster(nextrow : lastrow, :) = submitObsToCluster{j, 1};
end;

% Initialize variable to store cluster data
clusters = cell(100, 6);

% Store cluster data
load('submit_numeric.mat', 'dataset_numeric_1');
j = 1;
submit_set = dataset_numeric_1;
for i = 1 : 100
    ids_clust_i = allSubmitObsToCluster(allSubmitObsToCluster(:,2) == i, 1);
    clusters{i, j} = submit_set(ismember(submit_set(:, 1), ids_clust_i(:, 1)), :);
end;
clearvars dataset_numeric_1 submit_set;

load('submit_numeric.mat', 'dataset_numeric_2');
j = 2;
submit_set = dataset_numeric_2;
for i = 1 : 100
    ids_clust_i = allSubmitObsToCluster(allSubmitObsToCluster(:,2) == i, 1);
    clusters{i, j} = submit_set(ismember(submit_set(:, 1), ids_clust_i(:, 1)), :);
end;
clearvars dataset_numeric_2 submit_set;

load('submit_numeric.mat', 'dataset_numeric_3');
j = 3;
submit_set = dataset_numeric_3;
for i = 1 : 100
    ids_clust_i = allSubmitObsToCluster(allSubmitObsToCluster(:,2) == i, 1);
    clusters{i, j} = submit_set(ismember(submit_set(:, 1), ids_clust_i(:, 1)), :);
end;
clearvars dataset_numeric_3 submit_set;

load('submit_numeric.mat', 'dataset_numeric_4');
j = 4;
submit_set = dataset_numeric_4;
for i = 1 : 100
    ids_clust_i = allSubmitObsToCluster(allSubmitObsToCluster(:,2) == i, 1);
    clusters{i, j} = submit_set(ismember(submit_set(:, 1), ids_clust_i(:, 1)), :);
end;
clearvars dataset_numeric_4 submit_set;

load('submit_numeric.mat', 'dataset_numeric_5');
j = 5;
submit_set = dataset_numeric_5;
for i = 1 : 100
    ids_clust_i = allSubmitObsToCluster(allSubmitObsToCluster(:,2) == i, 1);
    clusters{i, j} = submit_set(ismember(submit_set(:, 1), ids_clust_i(:, 1)), :);
end;
clearvars dataset_numeric_5 submit_set;

load('submit_numeric.mat', 'dataset_numeric_6');
j = 6;
submit_set = dataset_numeric_6;
for i = 1 : 100
    ids_clust_i = allSubmitObsToCluster(allSubmitObsToCluster(:,2) == i, 1);
    clusters{i, j} = submit_set(ismember(submit_set(:, 1), ids_clust_i(:, 1)), :);
end;
clearvars dataset_numeric_6 submit_set;

submit_clusters_1 = cell(50, 1);
submit_clusters_2 = cell(100, 1);

for i = 1 : 100
    num_rows = 1;
    for j = 1 : 6
        num_rows = num_rows + size(clusters{i, j}, 1);
    end;
    if i < 51
        submit_clusters_1{i, 1} = zeros(num_rows, 970);
    else
        submit_clusters_2{i, 1} = zeros(num_rows, 970);
    end;
    nextrow = 1;
    for j = 1 : 6
        lastrow = nextrow - 1 + size(clusters{i, j}, 1);
        if i < 51
            submit_clusters_1{i, 1}(nextrow : lastrow, :) = clusters{i, j};
        else
            submit_clusters_2{i, 2}(nextrow : lastrow, :) = clusters{i, j};
        end;
        nextrow = lastrow + 1;
    end;
end;

save('anomaly_submit.mat', 'submit_clusters_1', '-append');
save('anomaly_submit.mat', 'submit_clusters_2', '-append');
save('anomaly_submit.mat', 'allSubmitObsToCluster', '-append');
toc     % Elapsed time is 40.157580 seconds.)