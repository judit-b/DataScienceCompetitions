rng(123);

i = 1;

% data_i = imputed_clusters_for_anomaly_1{i,1};
% valid_data_1 = anomaly_valid_clusters{1, 1};

data_i = all_sym_clusters_1{1, 1};
valid_data_1 = anomaly_final_valid_clusters{1, 1};

GMModel = fitgmdist(data_i(:,2:end-1), 3, 'RegularizationValue',0.001,'Replicates',10);
y = pdf(GMModel,valid_data_1(:, 2:end-1));
positive_valid = valid_data_1(:,end) == 1;
threshold = min(y(positive_valid == 1)) * 1000000000000000;
prediction = y < threshold;
label = valid_data_1(:,end);
[ TP, TN, FP, FN ] = evaluate( label, prediction );
metric = mcc( TP, TN, FP, FN )