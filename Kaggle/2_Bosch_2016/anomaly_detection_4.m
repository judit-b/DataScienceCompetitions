%% Anomaly detection - PART 4 - Create 0-1 matrix from sample_10000
% 0 means NaN, 1 means number with double precision
% The first and last column isn't taken into account (ID and Response)
tic

load('anomaly_numeric.mat', 'sample_10000');
sample_01features_10000 = 1 - isnan(sample_10000(:, 2 : 969));

save('anomaly_numeric.mat', 'sample_01features_10000', '-append');

toc           % Elapsed time is 0.932303 seconds. (On Eszter's computer.)