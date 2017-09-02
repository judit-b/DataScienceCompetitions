i = 1;
j = 11;
dataset = valid_clusters_relev_feats{i, 1};
dataset_pos = dataset(dataset(:, end) == 1, :);
dataset_neg = dataset(dataset(:, end) == 0, :);

x = dataset_pos(:, j);
y = dataset_neg(:, j);
h1 = histogram(x,'Normalization','pdf', 'Binwidth', 0.005);
hold on
h2 = histogram(y,'Normalization','pdf', 'Binwidth', 0.005);