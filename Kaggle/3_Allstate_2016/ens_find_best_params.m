%% optimize hyperparameters automatically

tic
rng(1)

load('lin_regr.mat', 'sample_feats');
load('lin_regr.mat', 'sample_log_target');

Mdl = fitrensemble(sample_feats, sample_log_target,'NPrint', 50, 'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    'expected-improvement-plus'));

toc        % Elapsed time is 2685.634564 seconds.