%% Exploratory data analysis

tic 

load('dataset.mat', 'dataset_matrix');

%% Create histograms of each features

% Histograms of categorical features
for i = 2 : 117
    hc(i - 1) = figure;
    histogram(dataset_matrix(:, i));
end;
savefig(hc, 'explore_cat_histograms.fig');
clearvars hc;

for i = 118 : 131
    hn(i - 117) = figure;
    histogram(dataset_matrix(:, i));
end;
savefig(hn, 'explore_num_histograms.fig');
clearvars hn;

ht = figure;
histogram(dataset_matrix(:, 132));
savefig(ht, 'explore_target_histogram.fig');
clearvars ht;

%% Create plots of target vs. features

% Plots of categorical features

for i = 2 : 117
    pc(i - 1) = figure;
    plot(dataset_matrix(:, i), dataset_matrix(:, 132), 'Marker', '.', 'LineStyle', 'none');
end;
savefig(pc, 'explore_cat_vs_target_plots.fig');
clearvars pc;

for i = 118 : 131
    pn(i - 117) = figure;
    plot(dataset_matrix(:, i), dataset_matrix(:, 132), 'Marker', '.', 'LineStyle', 'none');
end;
savefig(pn, 'explore_num_vs_target_plots.fig');
clearvars pn;

toc        % Elapsed time is 3137.010645 seconds.