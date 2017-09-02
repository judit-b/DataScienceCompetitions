function five_clusters = FindAndStoreFiveClusterData(data_source, cluster_cell, first_cluster, allObsToCluster)

for i = 1 : 5
    ids_clust_i = allObsToCluster(allObsToCluster(:,2) == first_cluster + i - 1, 1);
    clust_data = data_source(ismember(data_source(:, 1), ids_clust_i(:, 1)), :);
    nextrow = find(cluster_cell{i, 1} == 0, 1);
    cluster_cell{i, 1}(nextrow : nextrow - 1 + size(clust_data, 1), :) = clust_data;
end;

five_clusters = cluster_cell;

end