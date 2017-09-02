function [idx,C,sumd,D,midx,info,Sum] = CalculateKMedoidClusters(dataset, num_steps, step_size, distance, num_replicates)
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
    k = i * step_size;
    [idx_i,C_i,sumd_i,D_i,midx_i,info_i] = kmedoids(dataset, k, 'Distance', distance, 'Replicates', num_replicates);
    idx{i} = idx_i;
    C{i} = C_i;
    sumd{i} = sumd_i;
    D{i} = D_i;
    midx{i} = midx_i;
    info{i} = info_i;
    Sum(i) = sum(sumd{i});
end;

end