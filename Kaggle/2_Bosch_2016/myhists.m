
i = 92;
x = mydataset_1_neg(:, i);
y = mydataset_1_pos(:, i);
h1 = histogram(x, 'Normalization', 'probability');
hold on
h2 = histogram(y, 'Normalization', 'probability');
