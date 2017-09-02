function sym_cluster = TransformToSymmetricSample(dataset, best_transformations)
sym_cluster = zeros(size(dataset));
num_cols = size(dataset, 2);
sym_cluster(:, 1) = dataset(:, 1);
sym_cluster(:, end) = dataset(:, end);

for i = 2 : (num_cols - 1)     % for each column except for columns of ID and Response
    best_transf = best_transformations(1, i - 1);
    if best_transf == 1
        sym_cluster(:, i) = real(dataset(:, i));
    elseif best_transf == 2
        sym_cluster(:, i) = real(dataset(:, i) .* dataset(:, i));
    elseif best_transf == 3
        sym_cluster(:, i) = real(dataset(:, i) .* dataset(:, i) .* dataset(:, i));
    elseif best_transf == 4
        sym_cluster(:, i) = real(nthroot(dataset(:, i), 3));
    elseif best_transf == 5
        sym_cluster(:, i) = real(nthroot(dataset(:, i), 5));
    elseif best_transf == 6
        sym_cluster(:, i) = real(nthroot(dataset(:, i), 7));
    elseif best_transf == 7
        sym_cluster(:, i) = real(exp(dataset(:, i)));
    elseif best_transf == 8
        sym_cluster(:, i) = real(log(dataset(:, i) + min(dataset(:, i)) + 1));
    end;
end;
end