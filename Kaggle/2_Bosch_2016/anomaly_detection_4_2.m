%% Anomaly detection - after anomaly_detection_4.m

load('anomaly_numeric.mat', 'sample_01features_10000');

% Create a vector that counts the number of occurences of each features in
% the sample of 10000
ratio_feats_occur_insample = sum(sample_01features_10000) / 10000;

hist(ratio_feats_occur_insample, 50);
title('Anomaly detection - Number of features for each ranges of occurrences (Sample of 10,000 training data)');
xlabel('Number of occurrences');
ylabel('Number of features');

save('anomaly_numeric.mat', 'ratio_feats_occur_insample', '-append');